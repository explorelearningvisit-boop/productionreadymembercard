import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

class AppUpdate {
  final String versionName;
  final int versionCode;
  final String notes;
  final String apkUrl;
  final String sha256;
  const AppUpdate({required this.versionName, required this.versionCode, required this.notes, required this.apkUrl, required this.sha256});
}

class UpdateCenterService {
  static const _channel = MethodChannel('com.badgym/update_center');
  static const _releaseApi = 'https://api.github.com/repos/explorelearningvisit-boop/productionreadymembercard/releases/latest';

  Future<AppUpdate?> checkForUpdate() async {
    final client = HttpClient()..connectionTimeout = const Duration(seconds: 12);
    try {
      final request = await client.getUrl(Uri.parse(_releaseApi)).timeout(const Duration(seconds: 15));
      request.headers.set(HttpHeaders.acceptHeader, 'application/vnd.github+json');
      request.headers.set(HttpHeaders.userAgentHeader, 'BAD-GYM-UpdateCenter');
      final response = await request.close().timeout(const Duration(seconds: 20));
      if (response.statusCode == HttpStatus.notFound) return null;
      if (response.statusCode != HttpStatus.ok) throw HttpException('GitHub release check failed: HTTP ${response.statusCode}.');
      final body = await response.transform(utf8.decoder).join();
      final release = jsonDecode(body) as Map<String, dynamic>;
      if (release['draft'] == true || release['prerelease'] == true) return null;
      final assets = (release['assets'] as List<dynamic>? ?? const []);
      final apk = assets.cast<Map<String, dynamic>?>().whereType<Map<String, dynamic>>().firstWhere(
        (asset) => (asset['name'] as String? ?? '').toLowerCase().endsWith('.apk'),
        orElse: () => <String, dynamic>{},
      );
      if (apk.isEmpty) return null;
      final digest = (apk['digest'] as String? ?? '').replaceFirst('sha256:', '').toLowerCase();
      final url = apk['browser_download_url'] as String? ?? '';
      if (!RegExp(r'^[a-f0-9]{64}$').hasMatch(digest)) throw const FormatException('Release APK is missing a valid SHA-256 digest.');
      final parsedUrl = Uri.tryParse(url);
      if (parsedUrl == null || parsedUrl.scheme != 'https' || parsedUrl.host != 'github.com') throw const FormatException('Release APK URL is not an approved HTTPS GitHub URL.');
      final notes = release['body'] as String? ?? '';\n      final codeMatch = RegExp(r'versionCode:\\s*(\\d+)', caseSensitive: false).firstMatch(notes);\n      final versionCode = int.tryParse(codeMatch?.group(1) ?? '') ?? 0;
      final installed = await _channel.invokeMapMethod<String, dynamic>('getAppVersion') ?? const {};
      final installedCode = (installed['versionCode'] as num?)?.toInt() ?? 0;
      if (versionCode <= installedCode) return null;
      return AppUpdate(
        versionName: '${release['tag_name'] ?? 'Latest'}',
        versionCode: versionCode,
        notes: notes.trim(),
        apkUrl: url,
        sha256: digest,
      );
    } finally {
      client.close(force: true);
    }
  }

  Future<void> install(AppUpdate update) async {
    await _channel.invokeMethod<void>('installVerifiedApk', {'url': update.apkUrl, 'sha256': update.sha256});
  }
}
