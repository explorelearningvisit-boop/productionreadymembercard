import 'dart:io';
import 'dart:typed_data';

import 'package:native_cutout/native_cutout.dart';

/// On-device background removal powered by Android ML Kit Subject Segmentation.
/// Generated transparent PNGs stay in app cache, outside the asset bundle.
class BackgroundRemovalService {
  const BackgroundRemovalService();

  Future<bool> isModelAvailable() => NativeCutout.isModelAvailable();

  /// Downloads the Android model when needed. Observe NativeCutout.downloadProgress
  /// to display download progress in an editor or asset-preparation screen.
  Future<bool> prepareModel() async {
    if (await NativeCutout.isModelAvailable()) return true;
    return NativeCutout.downloadModel();
  }

  Future<String> removeFromFile(
    String imagePath, {
    bool cropToSubject = false,
  }) async {
    if (!await prepareModel()) {
      throw StateError('Google ML Kit segmentation model unavailable. Check internet and Google Play services, then retry.');
    }
    final result = await NativeCutout.removeBackground(
      imagePath,
      options: CutoutOptions(cropToSubject: cropToSubject, writeToCache: true),
    );
    switch (result) {
      case CutoutFileSuccess(:final path):
        return path;
      case CutoutBytesSuccess(:final pngBytes):
        throw StateError('Unexpected in-memory result: ${pngBytes.length} bytes.');
      case CutoutFailure(:final code, :final message):
        throw StateError('Background removal failed (${code.name}): $message');
    }
  }

  Future<Uint8List> removeToBytes(
    String imagePath, {
    bool cropToSubject = false,
  }) async {
    if (!await prepareModel()) {
      throw StateError('Google ML Kit segmentation model unavailable. Check internet and Google Play services, then retry.');
    }
    final result = await NativeCutout.removeBackground(
      imagePath,
      options: CutoutOptions(cropToSubject: cropToSubject, writeToCache: false),
    );
    switch (result) {
      case CutoutBytesSuccess(:final pngBytes):
        return pngBytes;
      case CutoutFileSuccess(:final path):
        return File(path).readAsBytes();
      case CutoutFailure(:final code, :final message):
        throw StateError('Background removal failed (${code.name}): $message');
    }
  }

  Future<bool> clearGeneratedCache() => NativeCutout.clearCache();
}
