import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:native_cutout/native_cutout.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'services/upscale_service.dart';

void main() => runApp(const SpriteForgeApp());

class SpriteForgeApp extends StatelessWidget {
  const SpriteForgeApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'SpriteForge',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff16865b)),
          useMaterial3: true,
        ),
        home: const SpriteForgeHome(),
      );
}

class _ImageAsset {
  _ImageAsset({required this.name, required this.path, required this.bytes});
  final String name;
  final String path;
  Uint8List bytes;
}

class _ExportAsset {
  _ExportAsset(this.name, this.bytes);
  final String name;
  final Uint8List bytes;
}

enum _BrushMode { none, erase, restore, magicWand, crop }

class SpriteForgeHome extends StatefulWidget {
  const SpriteForgeHome({super.key});

  @override
  State<SpriteForgeHome> createState() => _SpriteForgeHomeState();
}

class _SpriteForgeHomeState extends State<SpriteForgeHome> {
  final _picker = ImagePicker();
  final _rows = TextEditingController(text: '4');
  final _cols = TextEditingController(text: '4');
  double _brushSize = 28;
  double _magicTolerance = 34;
  final List<_ImageAsset> _images = [];
  final List<_ExportAsset> _exports = [];
  final List<Uint8List> _undo = [];
  int _selected = 0;
  int _scale = 4;
  bool _busy = false;
  bool _modelReady = false;
  String _status = 'Upload any image to start';
  _BrushMode _mode = _BrushMode.none;
  img.Image? _decoded;
  img.Image? _restoreSource;
  Offset? _gestureStart;
  Offset? _gestureEnd;
  Size _canvasSize = Size.zero;

  _ImageAsset? get _active => _images.isEmpty ? null : _images[_selected];

  Future<void> _pickImages() async {
    final picked = await _picker.pickMultiImage(imageQuality: 100);
    if (picked.isEmpty) return;
    setState(() { _busy = true; _status = 'Loading ${picked.length} image(s)…'; });
    try {
      final loaded = <_ImageAsset>[];
      for (final file in picked) {
        final bytes = await file.readAsBytes();
        final decoded = img.decodeImage(bytes);
        if (decoded != null) {
          final normalizedPng = Uint8List.fromList(img.encodePng(decoded));
          loaded.add(_ImageAsset(name: file.name, path: file.path, bytes: normalizedPng));
        }
      }
      setState(() {
        _images..clear()..addAll(loaded);
        _exports.clear();
        _selected = 0;
        _busy = false;
        _status = 'Loaded ${loaded.length} image(s). Choose an edit tool.';
      });
      _loadActive();
    } catch (e) {
      setState(() { _busy = false; _status = 'Could not load images: $e'; });
    }
  }

  void _loadActive() {
    final item = _active;
    if (item == null) return;
    _decoded = img.decodeImage(item.bytes);
    _restoreSource = _decoded == null ? null : img.decodeImage(item.bytes);
    _undo.clear();
    _gestureStart = null;
    _gestureEnd = null;
    _mode = _BrushMode.none;
  }

  Future<bool> _ensureCutoutModel() async {
    if (_modelReady) return true;
    setState(() => _status = 'Checking on-device background model…');
    try {
      if (!await NativeCutout.isModelAvailable()) {
        setState(() => _status = 'Downloading free on-device segmentation model…');
        if (!await NativeCutout.downloadModel()) {
          setState(() => _status = 'Model download failed. Check Google Play services and internet, then retry.');
          return false;
        }
      }
      _modelReady = true;
      return true;
    } catch (e) {
      setState(() => _status = 'Background model unavailable: $e');
      return false;
    }
  }

  Future<Uint8List> _cutout(_ImageAsset item) async {
    // Always give the native ML Kit plugin a stable, app-owned local PNG.
    // ImagePicker paths can point to provider/cache locations with short lifetimes.
    final tempDir = await getTemporaryDirectory();
    final inputFile = File('${tempDir.path}/cutout_input_${DateTime.now().microsecondsSinceEpoch}.png');
    await inputFile.writeAsBytes(item.bytes, flush: true);
    try {
      final result = await NativeCutout.removeBackground(
        inputFile.path,
        options: const CutoutOptions(cropToSubject: false, writeToCache: false),
      );
      if (result is CutoutBytesSuccess) return result.pngBytes;
      if (result is CutoutFileSuccess) return await File(result.path).readAsBytes();
      if (result is CutoutFailure) {
        throw Exception('${result.code.name}: ${result.message}');
      }
      throw Exception('Background removal returned an unsupported result.');
    } finally {
      if (await inputFile.exists()) await inputFile.delete();
    }
  }

  Future<void> _removeBackground({bool all = false}) async {
    if (_images.isEmpty || _busy) return;
    if (!await _ensureCutoutModel()) return;
    setState(() { _busy = true; _status = all ? 'Removing backgrounds from all images…' : 'Removing background…'; });
    try {
      final targets = all ? List<_ImageAsset>.from(_images) : <_ImageAsset>[_active!];
      var done = 0;
      for (final item in targets) {
        final output = await _cutout(item);
        item.bytes = output;
        done++;
        if (mounted) setState(() => _status = 'Background removal: $done/${targets.length}');
      }
      setState(() { _busy = false; _status = 'Background removal complete. Use Erase/Restore for manual touch-up.'; });
      _loadActive();
      setState(() {});
    } catch (e) {
      setState(() { _busy = false; _status = 'Background removal failed: $e'; });
    }
  }

  String _safeName(String name) {
    final base = name.replaceAll(RegExp(r'\.[^.]+$'), '').replaceAll(RegExp(r'[^a-zA-Z0-9_-]'), '_');
    return base.isEmpty ? 'image' : base;
  }

  void _recordUndo() {
    final bytes = _active?.bytes;
    if (bytes == null) return;
    _undo.add(Uint8List.fromList(bytes));
    if (_undo.length > 20) _undo.removeAt(0);
  }

  void _undoLast() {
    if (_undo.isEmpty || _active == null) return;
    setState(() { _active!.bytes = _undo.removeLast(); _loadActive(); _status = 'Last edit undone'; });
  }

  void _startGesture(DragStartDetails details) {
    if (_decoded == null) return;
    _recordUndo();
    _gestureStart = details.localPosition;
    _gestureEnd = details.localPosition;
    if (_mode == _BrushMode.erase || _mode == _BrushMode.restore) _paintAt(details.localPosition);
    if (_mode == _BrushMode.magicWand) _magicWandAt(details.localPosition);
    setState(() {});
  }

  void _updateGesture(DragUpdateDetails details) {
    if (_gestureStart == null) return;
    _gestureEnd = details.localPosition;
    if (_mode == _BrushMode.erase || _mode == _BrushMode.restore) {
      _paintAt(details.localPosition);
      if (_active != null && _decoded != null) {
        _active!.bytes = Uint8List.fromList(img.encodePng(_decoded!));
      }
    }
    setState(() {});
  }

  void _endGesture(DragEndDetails details) {
    if (_mode == _BrushMode.crop && _gestureStart != null && _gestureEnd != null) {
      _applyCrop(_gestureStart!, _gestureEnd!);
    }
    setState(() {
      _gestureStart = null;
      _gestureEnd = null;
      if (_active != null && _decoded != null) _active!.bytes = Uint8List.fromList(img.encodePng(_decoded!));
    });
  }


  void _magicWandAt(Offset point) {
    final image = _decoded;
    if (image == null || _canvasSize.isEmpty) return;
    final sx = (point.dx / _canvasSize.width * image.width).round().clamp(0, image.width - 1).toInt();
    final sy = (point.dy / _canvasSize.height * image.height).round().clamp(0, image.height - 1).toInt();
    final target = image.getPixel(sx, sy);
    final limit = _magicTolerance * _magicTolerance * 3;
    final visited = Uint8List(image.width * image.height);
    final stack = <int>[sy * image.width + sx];
    while (stack.isNotEmpty) {
      final index = stack.removeLast();
      if (index < 0 || index >= visited.length || visited[index] == 1) continue;
      visited[index] = 1;
      final x = index % image.width;
      final y = index ~/ image.width;
      final p = image.getPixel(x, y);
      final dr = p.r - target.r, dg = p.g - target.g, db = p.b - target.b;
      if (dr * dr + dg * dg + db * db > limit) continue;
      image.setPixelRgba(x, y, p.r, p.g, p.b, 0);
      if (x > 0) stack.add(index - 1);
      if (x + 1 < image.width) stack.add(index + 1);
      if (y > 0) stack.add(index - image.width);
      if (y + 1 < image.height) stack.add(index + image.width);
    }
    if (_active != null) _active!.bytes = Uint8List.fromList(img.encodePng(image));
    setState(() => _status = 'Magic wand erased connected color region');
  }

  void _paintAt(Offset point) {
    final image = _decoded;
    final original = _restoreSource;
    if (image == null || _canvasSize.isEmpty) return;
    final px = (point.dx / _canvasSize.width * image.width).round();
    final py = (point.dy / _canvasSize.height * image.height).round();
    final radius = (_brushSize / _canvasSize.width * image.width / 2).round().clamp(1, 300).toInt();
    final minY = (py - radius).clamp(0, image.height - 1).toInt();
    final maxY = (py + radius).clamp(0, image.height - 1).toInt();
    final minX = (px - radius).clamp(0, image.width - 1).toInt();
    final maxX = (px + radius).clamp(0, image.width - 1).toInt();
    for (var y = minY; y <= maxY; y++) {
      for (var x = minX; x <= maxX; x++) {
        final dx = x - px, dy = y - py;
        if (dx * dx + dy * dy > radius * radius) continue;
        if (_mode == _BrushMode.erase) {
          final p = image.getPixel(x, y);
          image.setPixelRgba(x, y, p.r, p.g, p.b, 0);
        } else if (_mode == _BrushMode.restore && original != null) {
          final p = original.getPixel(x.clamp(0, original.width - 1), y.clamp(0, original.height - 1));
          image.setPixelRgba(x, y, p.r, p.g, p.b, p.a);
        }
      }
    }
  }

  void _applyCrop(Offset a, Offset b) {
    final image = _decoded;
    if (image == null || _canvasSize.isEmpty) return;
    final left = (a.dx < b.dx ? a.dx : b.dx).clamp(0, _canvasSize.width);
    final top = (a.dy < b.dy ? a.dy : b.dy).clamp(0, _canvasSize.height);
    final right = (a.dx > b.dx ? a.dx : b.dx).clamp(0, _canvasSize.width);
    final bottom = (a.dy > b.dy ? a.dy : b.dy).clamp(0, _canvasSize.height);
    final x = (left / _canvasSize.width * image.width).floor();
    final y = (top / _canvasSize.height * image.height).floor();
    final w = ((right - left) / _canvasSize.width * image.width).round();
    final h = ((bottom - top) / _canvasSize.height * image.height).round();
    if (w < 8 || h < 8) { setState(() => _status = 'Crop area is too small'); return; }
    setState(() {
      _decoded = img.copyCrop(image, x: x, y: y, width: w.clamp(1, image.width - x).toInt(), height: h.clamp(1, image.height - y).toInt());
      _restoreSource = img.decodeImage(Uint8List.fromList(img.encodePng(_decoded!)));
      _active!.bytes = Uint8List.fromList(img.encodePng(_decoded!));
      _mode = _BrushMode.none;
      _status = 'Crop applied';
    });
  }

  void _trimTransparent() {
    final image = _decoded;
    if (image == null) return;
    _recordUndo();
    var minX = image.width, minY = image.height, maxX = -1, maxY = -1;
    for (var y = 0; y < image.height; y++) {
      for (var x = 0; x < image.width; x++) {
        if (image.getPixel(x, y).a > 0) {
          if (x < minX) minX = x;
          if (y < minY) minY = y;
          if (x > maxX) maxX = x;
          if (y > maxY) maxY = y;
        }
      }
    }
    if (maxX < minX || maxY < minY) return;
    setState(() {
      _decoded = img.copyCrop(image, x: minX, y: minY, width: maxX - minX + 1, height: maxY - minY + 1);
      _restoreSource = img.decodeImage(Uint8List.fromList(img.encodePng(_decoded!)));
      _active!.bytes = Uint8List.fromList(img.encodePng(_decoded!));
      _status = 'Transparent edges trimmed';
    });
  }

  Future<void> _aiUpscaleActive() async {
    final item = _active;
    if (item == null || _busy) return;
    if (_scale != 2 && _scale != 4) return;
    _recordUndo();
    setState(() { _busy = true; _status = 'Running on-device Real-ESRGAN AI upscale…'; });
    try {
      final dir = await getTemporaryDirectory();
      final input = File('${dir.path}/spriteforge_input.png');
      await input.writeAsBytes(item.bytes, flush: true);
      final output = await UpscaleService().upscaleImage(input, 'assets/models/Real-ESRGAN-General-x4v3_float.tflite', _scale == 2);
      if (output == null) throw Exception('Upscaler returned no output');
      final bytes = await output.readAsBytes();
      final decoded = img.decodeImage(bytes);
      if (decoded == null) throw Exception('Upscaled image could not be decoded');
      setState(() {
        item.bytes = bytes;
        _decoded = decoded;
        _restoreSource = img.decodeImage(bytes);
        _busy = false;
        _status = 'Real-ESRGAN AI upscale complete';
      });
    } catch (e) {
      setState(() { _busy = false; _status = 'AI upscale failed: $e'; });
    }
  }



  void _detectTransparentSprites() {
    final image = _decoded;
    if (image == null) return;
    final visited = Uint8List(image.width * image.height);
    final found = <Rect>[];
    for (var y = 0; y < image.height; y++) {
      for (var x = 0; x < image.width; x++) {
        final start = y * image.width + x;
        if (visited[start] == 1 || image.getPixel(x, y).a <= 12) continue;
        final stack = <int>[start];
        visited[start] = 1;
        var minX = x, maxX = x, minY = y, maxY = y, area = 0;
        while (stack.isNotEmpty) {
          final index = stack.removeLast();
          final px = index % image.width, py = index ~/ image.width;
          area++;
          if (px < minX) minX = px;
          if (px > maxX) maxX = px;
          if (py < minY) minY = py;
          if (py > maxY) maxY = py;
          final neighbors = <int>[
            if (px > 0) index - 1,
            if (px + 1 < image.width) index + 1,
            if (py > 0) index - image.width,
            if (py + 1 < image.height) index + image.width,
          ];
          for (final next in neighbors) {
            if (visited[next] == 0) {
              final nx = next % image.width, ny = next ~/ image.width;
              if (image.getPixel(nx, ny).a > 12) {
                visited[next] = 1;
                stack.add(next);
              }
            }
          }
        }
        if (area >= 24 && found.length < 400) {
          found.add(Rect.fromLTRB(minX.toDouble(), minY.toDouble(), (maxX + 1).toDouble(), (maxY + 1).toDouble()));
        }
      }
    }
    if (found.isEmpty) {
      setState(() => _status = 'No separate opaque objects found. Make the background transparent first.');
      return;
    }
    for (var i = 0; i < found.length; i++) {
      final rect = found[i];
      final tile = img.copyCrop(image, x: rect.left.toInt(), y: rect.top.toInt(), width: rect.width.toInt(), height: rect.height.toInt());
      _exports.add(_ExportAsset("auto_sprite_${(i + 1).toString().padLeft(3, '0')}", Uint8List.fromList(img.encodePng(tile))));
    }
    setState(() => _status = 'Detected ${found.length} separate transparent sprite object(s).');
  }

  void _splitSheet() {
    final image = _decoded;
    if (image == null) return;
    final rows = int.tryParse(_rows.text) ?? 0;
    final cols = int.tryParse(_cols.text) ?? 0;
    if (rows < 1 || cols < 1 || rows * cols > 400) { setState(() => _status = 'Enter valid rows and columns (maximum 400 cells)'); return; }
    final cellW = image.width ~/ cols, cellH = image.height ~/ rows;
    var count = 0;
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final x = c * cellW, y = r * cellH;
        final w = c == cols - 1 ? image.width - x : cellW;
        final h = r == rows - 1 ? image.height - y : cellH;
        final tile = img.copyCrop(image, x: x, y: y, width: w, height: h);
        _exports.add(_ExportAsset("sprite_${(++count).toString().padLeft(3, '0')}", Uint8List.fromList(img.encodePng(tile))));
      }
    }
    setState(() => _status = 'Split into $count grid cells.');
  }

  Future<void> _exportZip() async {
    if (_exports.isEmpty && _images.isEmpty) return;
    setState(() { _busy = true; _status = 'Preparing ZIP export…'; });
    try {
      final map = <String, Uint8List>{};
      for (final item in _images) { map[_safeName(item.name)] = item.bytes; }
      for (final item in _exports) { map[item.name] = item.bytes; }
      final archive = Archive();
      for (final entry in map.entries) {
        archive.addFile(ArchiveFile('${entry.key}.png', entry.value.length, entry.value));
      }
      final bytes = ZipEncoder().encode(archive);
      if (bytes == null) throw Exception('Could not encode ZIP');
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/spriteforge_export.zip');
      await file.writeAsBytes(bytes, flush: true);
      setState(() { _busy = false; _status = 'ZIP ready • ${map.length} PNG file(s)'; });
      await Share.shareXFiles([XFile(file.path)], text: 'SpriteForge image export');
    } catch (e) {
      setState(() { _busy = false; _status = 'Export failed: $e'; });
    }
  }

  @override
  void dispose() { _rows.dispose(); _cols.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final current = _active;
    final decoded = _decoded;
    return Scaffold(
      appBar: AppBar(
        title: const Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          Text('SpriteForge'),
          Text('Image Studio • offline-first', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
        ]),
        actions: [IconButton(onPressed: _busy ? null : _pickImages, icon: const Icon(Icons.add_photo_alternate_outlined), tooltip: 'Add images')],
      ),
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.all(14), children: [
          Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(children: [const Expanded(child: Text('Your images', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))), Text('${_images.length} selected')]),
            const SizedBox(height: 8),
            FilledButton.icon(onPressed: _busy ? null : _pickImages, icon: const Icon(Icons.upload_file), label: const Text('Upload any image(s)')),
            if (_images.isNotEmpty) ...[
              const SizedBox(height: 10),
              SizedBox(height: 78, child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _images.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) => InkWell(
                  onTap: () => setState(() { _selected = i; _loadActive(); }),
                  child: Container(width: 76, padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(border: Border.all(color: i == _selected ? Theme.of(context).colorScheme.primary : Colors.black12, width: i == _selected ? 2 : 1), borderRadius: BorderRadius.circular(10)),
                    child: Image.memory(_images[i].bytes, fit: BoxFit.contain)),
                ),
              )),
            ],
          ]))),
          if (current != null && decoded != null) ...[
            Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              const Text('Editor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(color: const Color(0xffeeeeee), borderRadius: BorderRadius.circular(12)),
                child: LayoutBuilder(builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final height = width * decoded.height / decoded.width;
                  _canvasSize = Size(width, height);
                  return GestureDetector(
                    // Magic wand is a point operation: it must respond to a tap,
                    // not require the user to drag far enough to start a pan gesture.
                    onTapDown: _mode == _BrushMode.magicWand
                        ? (details) {
                            _recordUndo();
                            _magicWandAt(details.localPosition);
                          }
                        : null,
                    onPanStart: _mode == _BrushMode.none || _mode == _BrushMode.magicWand ? null : _startGesture,
                    onPanUpdate: _mode == _BrushMode.none || _mode == _BrushMode.magicWand ? null : _updateGesture,
                    onPanEnd: _mode == _BrushMode.none || _mode == _BrushMode.magicWand ? null : _endGesture,
                    child: Stack(children: [
                      SizedBox(width: width, height: height, child: Image.memory(current.bytes, fit: BoxFit.fill)),
                      if (_mode == _BrushMode.crop && _gestureStart != null && _gestureEnd != null)
                        Positioned.fill(child: CustomPaint(painter: _CropOverlay(_gestureStart!, _gestureEnd!))),
                    ]),
                  );
                }),
              ),
              const SizedBox(height: 10),
              Wrap(spacing: 8, runSpacing: 8, children: [
                _toolButton('Erase', Icons.brush, _BrushMode.erase),
                _toolButton('Restore', Icons.restore, _BrushMode.restore),
                _toolButton('Magic wand', Icons.auto_fix_high, _BrushMode.magicWand),
                _toolButton('Crop', Icons.crop, _BrushMode.crop),
                OutlinedButton.icon(onPressed: _undo.isEmpty ? null : _undoLast, icon: const Icon(Icons.undo), label: const Text('Undo')),
                OutlinedButton.icon(onPressed: _trimTransparent, icon: const Icon(Icons.filter_center_focus), label: const Text('Trim alpha')),
              ]),
              if (_mode == _BrushMode.erase || _mode == _BrushMode.restore) ...[
                const SizedBox(height: 6),
                Text('Brush size: ${_brushSize.round()} px'),
                Slider(value: _brushSize, min: 4, max: 100, divisions: 24, onChanged: (v) => setState(() => _brushSize = v)),
              ],
              if (_mode == _BrushMode.magicWand) ...[
                const SizedBox(height: 6),
                Text('Color tolerance: ${_magicTolerance.round()}'),
                Slider(value: _magicTolerance, min: 0, max: 100, divisions: 20, onChanged: (v) => setState(() => _magicTolerance = v)),
              ],
              const SizedBox(height: 4),
              Text('Image: ${decoded.width} × ${decoded.height} px', style: const TextStyle(color: Colors.black54, fontSize: 12)),
            ]))),
            Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              const Text('Automatic tools', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              FilledButton.icon(onPressed: _busy ? null : () => _removeBackground(), icon: const Icon(Icons.auto_awesome), label: const Text('AI remove background')),
              OutlinedButton.icon(onPressed: _busy ? null : () => _removeBackground(all: true), icon: const Icon(Icons.layers), label: const Text('Remove background from all images')),
              const Text('Runs on-device with Google ML Kit subject segmentation. First use downloads its free model through Google Play services; internet is needed once.', style: TextStyle(fontSize: 12, color: Colors.black54)),
            ]))),
            Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              const Text('Resize & Sprite Sheet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SegmentedButton<int>(segments: const [ButtonSegment(value: 2, label: Text('2× AI')), ButtonSegment(value: 4, label: Text('4× AI'))], selected: {_scale}, onSelectionChanged: (v) => setState(() => _scale = v.first)),
              const SizedBox(height: 8),
              FilledButton.icon(onPressed: _busy ? null : _aiUpscaleActive, icon: const Icon(Icons.high_quality), label: Text('AI Upscale $_scale×')),
              const Text('On-device Real-ESRGAN model. 2× mode uses a half-size input followed by 4× inference; transparent alpha is preserved.', style: TextStyle(fontSize: 12, color: Colors.black54)),
              const Divider(),
              Row(children: [
                Expanded(child: TextField(controller: _rows, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Rows', border: OutlineInputBorder()))),
                const SizedBox(width: 10),
                Expanded(child: TextField(controller: _cols, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Columns', border: OutlineInputBorder()))),
              ]),
              const SizedBox(height: 8),
              OutlinedButton.icon(onPressed: _splitSheet, icon: const Icon(Icons.grid_view), label: const Text('Split as sprite sheet grid')),
              OutlinedButton.icon(onPressed: _detectTransparentSprites, icon: const Icon(Icons.auto_awesome_motion), label: const Text('Auto-detect transparent sprites')),
            ]))),
          ],
          Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Text('Export', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(_status),
            if (_busy) const Padding(padding: EdgeInsets.only(top: 8), child: LinearProgressIndicator()),
            const SizedBox(height: 8),
            FilledButton.icon(onPressed: _busy || (_images.isEmpty && _exports.isEmpty) ? null : _exportZip, icon: const Icon(Icons.archive_outlined), label: Text('Export ZIP (${_exports.isEmpty ? _images.length : _exports.length} items)')),
          ]))),
        ]),
      ),
    );
  }

  Widget _toolButton(String label, IconData icon, _BrushMode mode) {
    final selected = _mode == mode;
    return FilledButton.tonalIcon(
      onPressed: () => setState(() { _mode = selected ? _BrushMode.none : mode; _gestureStart = null; _gestureEnd = null; }),
      icon: Icon(icon),
      label: Text(selected ? '$label ✓' : label),
    );
  }
}

class _CropOverlay extends CustomPainter {
  const _CropOverlay(this.start, this.end);
  final Offset start;
  final Offset end;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromPoints(start, end);
    final fill = Paint()..color = Colors.green.withValues(alpha: 0.12);
    final stroke = Paint()..color = Colors.green..style = PaintingStyle.stroke..strokeWidth = 2;
    canvas.drawRect(rect, fill);
    canvas.drawRect(rect, stroke);
  }

  @override
  bool shouldRepaint(covariant _CropOverlay oldDelegate) => oldDelegate.start != start || oldDelegate.end != end;
}
