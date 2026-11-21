import 'dart:typed_data';

import 'package:local_rembg/local_rembg.dart';

/// On-device background removal for user-selected images.
///
/// This service is intentionally separate from the dashboard rendering path:
/// bundled RGBA assets should be used as-is, while RGB/checkerboard artwork
/// can be processed before it is promoted into the app asset library.
class BackgroundRemovalService {
  const BackgroundRemovalService();

  Future<Uint8List> removeFromFile(String imagePath) async {
    final result = await LocalRembg.removeBackground(
      imagePath: imagePath,
      cropTheImage: false,
    );
    if (result.status != 1 || result.imageBytes == null) {
      throw StateError(result.errorMessage ?? 'Background removal failed');
    }
    return Uint8List.fromList(result.imageBytes!);
  }
}
