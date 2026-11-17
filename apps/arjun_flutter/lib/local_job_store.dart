import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Small offline-first cache for local job drafts/demo listings.
/// This is device-local storage, not a shared marketplace backend.
class LocalJobStore {
  static const _key = 'arjun.local_jobs.v1';

  Future<List<Map<String, dynamic>>> read() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return const [];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return const [];
      return decoded
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList(growable: false);
    } on FormatException {
      // Preserve the app session if a local cache was interrupted/corrupted.
      return const [];
    }
  }

  Future<void> write(List<Map<String, dynamic>> jobs) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(jobs));
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
