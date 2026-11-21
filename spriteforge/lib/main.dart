import 'dart:io';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

void main() => runApp(const SpriteForgeApp());

class SpriteForgeApp extends StatelessWidget {
  const SpriteForgeApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'SpriteForge',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff16a36a)), useMaterial3: true),
    home: const SpriteForgeHome(),
  );
}

class SpriteForgeHome extends StatefulWidget {
  const SpriteForgeHome({super.key});
  @override
  State<SpriteForgeHome> createState() => _SpriteForgeHomeState();
}

class _SpriteForgeHomeState extends State<SpriteForgeHome> {
  Uint8List? _sheetBytes;
  img.Image? _sheet;
  final _rows = TextEditingController(text: '4');
  final _cols = TextEditingController(text: '4');
  double _tolerance = 28;
  int _scale = 1;
  bool _busy = false;
  List<Uint8List> _results = [];
  String _status = 'Upload a sprite sheet to begin';

  Future<void> _pick() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;
    final bytes = await file.readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      setState(() => _status = 'Unsupported or damaged image');
      return;
    }
    setState(() {
      _sheetBytes = bytes;
      _sheet = decoded;
      _results = [];
      _status = 'Loaded ${decoded.width} × ${decoded.height} image';
    });
  }

  Future<void> _process() async {
    final source = _sheet;
    final rows = int.tryParse(_rows.text) ?? 0;
    final cols = int.tryParse(_cols.text) ?? 0;
    if (source == null || rows < 1 || cols < 1 || rows * cols > 400) {
      setState(() => _status = 'Choose an image and valid grid (maximum 400 cells)');
      return;
    }
    setState(() { _busy = true; _status = 'Processing sprites…'; _results = []; });
    await Future<void>.delayed(const Duration(milliseconds: 30));
    try {
      final output = <Uint8List>[];
      final cellW = source.width ~/ cols;
      final cellH = source.height ~/ rows;
      for (var r = 0; r < rows; r++) {
        for (var c = 0; c < cols; c++) {
          final x = c * cellW;
          final y = r * cellH;
          final w = c == cols - 1 ? source.width - x : cellW;
          final h = r == rows - 1 ? source.height - y : cellH;
          var tile = img.copyCrop(source, x: x, y: y, width: w, height: h);
          tile = _removeCornerBackground(tile, _tolerance);
          tile = _trimTransparent(tile);
          if (_scale > 1) {
            tile = img.copyResize(tile, width: tile.width * _scale, height: tile.height * _scale, interpolation: img.Interpolation.nearest);
          }
          output.add(Uint8List.fromList(img.encodePng(tile)));
        }
      }
      setState(() {
        _results = output;
        _busy = false;
        _status = 'Processed ${output.length} cells • transparent PNG';
      });
    } catch (e) {
      setState(() { _busy = false; _status = 'Processing failed: $e'; });
    }
  }

  img.Image _removeCornerBackground(img.Image tile, double tolerance) {
    final p = tile.getPixel(0, 0);
    final br = p.r.toDouble(), bg = p.g.toDouble(), bb = p.b.toDouble();
    final limit = tolerance * tolerance * 3;
    for (var y = 0; y < tile.height; y++) {
      for (var x = 0; x < tile.width; x++) {
        final q = tile.getPixel(x, y);
        final d = (q.r - br) * (q.r - br) + (q.g - bg) * (q.g - bg) + (q.b - bb) * (q.b - bb);
        if (d <= limit) tile.setPixelRgba(x, y, q.r, q.g, q.b, 0);
      }
    }
    return tile;
  }

  img.Image _trimTransparent(img.Image input) {
    var minX = input.width, minY = input.height, maxX = -1, maxY = -1;
    for (var y = 0; y < input.height; y++) {
      for (var x = 0; x < input.width; x++) {
        if (input.getPixel(x, y).a > 0) {
          if (x < minX) minX = x;
          if (y < minY) minY = y;
          if (x > maxX) maxX = x;
          if (y > maxY) maxY = y;
        }
      }
    }
    if (maxX < minX || maxY < minY) return input;
    return img.copyCrop(input, x: minX, y: minY, width: maxX - minX + 1, height: maxY - minY + 1);
  }

  Future<void> _exportZip() async {
    if (_results.isEmpty) return;
    setState(() { _busy = true; _status = 'Creating ZIP…'; });
    final archive = Archive();
    for (var i = 0; i < _results.length; i++) {
      archive.addFile(ArchiveFile('sprite_${(i + 1).toString().padLeft(3, '0')}.png', _results[i].length, _results[i]));
    }
    final bytes = ZipEncoder().encode(archive);
    if (bytes == null) {
      setState(() { _busy = false; _status = 'ZIP export failed'; });
      return;
    }
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/spriteforge_export.zip');
    await file.writeAsBytes(bytes, flush: true);
    setState(() { _busy = false; _status = 'ZIP ready • ${_results.length} PNG files'; });
    await Share.shareXFiles([XFile(file.path)], text: 'SpriteForge PNG export');
  }

  @override
  void dispose() { _rows.dispose(); _cols.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [Text('SpriteForge'), Text('Batch sprite sheet processor', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal))])),
      body: SafeArea(child: ListView(padding: const EdgeInsets.all(16), children: [
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Text('1. Sprite sheet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          OutlinedButton.icon(onPressed: _busy ? null : _pick, icon: const Icon(Icons.upload_file), label: const Text('Choose image')),
          if (_sheetBytes != null) ...[
            const SizedBox(height: 10),
            ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.memory(_sheetBytes!, height: 180, fit: BoxFit.contain)),
          ],
        ]))),
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Text('2. Split & process', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: TextField(controller: _rows, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Grid rows', border: OutlineInputBorder()))),
            const SizedBox(width: 12),
            Expanded(child: TextField(controller: _cols, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Grid columns', border: OutlineInputBorder()))),
          ]),
          const SizedBox(height: 12),
          Text('Background color tolerance: ${_tolerance.round()}'),
          Slider(value: _tolerance, min: 0, max: 100, divisions: 20, label: _tolerance.round().toString(), onChanged: (v) => setState(() => _tolerance = v)),
          const Text('Background is sampled from the top-left pixel of each cell. Best for flat/solid backgrounds.', style: TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 10),
          const Text('Upscale (nearest-neighbor pixel scaling)'),
          SegmentedButton<int>(segments: const [ButtonSegment(value: 1, label: Text('1×')), ButtonSegment(value: 2, label: Text('2×')), ButtonSegment(value: 4, label: Text('4×'))], selected: {_scale}, onSelectionChanged: (v) => setState(() => _scale = v.first)),
          const SizedBox(height: 14),
          FilledButton.icon(onPressed: _busy ? null : _process, icon: const Icon(Icons.auto_awesome), label: const Text('Process all sprites')),
        ]))),
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Text('3. Export', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(_status),
          if (_busy) const LinearProgressIndicator(),
          if (_results.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text('${_results.length} transparent PNGs generated'),
            SizedBox(height: 112, child: ListView.separated(scrollDirection: Axis.horizontal, itemCount: _results.length, separatorBuilder: (_, __) => const SizedBox(width: 8), itemBuilder: (_, i) => Container(width: 100, padding: const EdgeInsets.all(6), decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(10)), child: Image.memory(_results[i], fit: BoxFit.contain)))),
            const SizedBox(height: 12),
            FilledButton.icon(onPressed: _busy ? null : _exportZip, icon: const Icon(Icons.archive_outlined), label: const Text('Export all as ZIP')),
          ],
        ]))),
        const Padding(padding: EdgeInsets.all(8), child: Text('Note: This first build uses grid splitting and flat-color transparency, not AI subject segmentation or AI super-resolution. Original image stays on your phone.', style: TextStyle(fontSize: 12, color: Colors.black54))),
      ])),
    );
  }
}
