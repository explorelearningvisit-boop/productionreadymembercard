import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/marketplace_models.dart';

/// Device-local cache for the offline-first MVP.
/// This is deliberately NOT represented as a cloud-synced or multi-user backend.
class MarketplaceStore {
  MarketplaceStore(this._preferences);
  final SharedPreferences _preferences;
  static const _jobsKey = 'marketplace.jobs.v1';
  static const _applicationsKey = 'marketplace.applications.v1';
  static const _workersKey = 'marketplace.workers.v1';
  static const _attendanceKey = 'marketplace.attendance.v1';
  static const _paymentsKey = 'marketplace.payments.v1';
  static const _milestonesKey = 'marketplace.milestones.v1';

  static Future<MarketplaceStore> open() async =>
      MarketplaceStore(await SharedPreferences.getInstance());

  List<T> _read<T>(String key, T Function(Map<String,Object?>) decode) {
    final raw = _preferences.getString(key);
    if (raw == null || raw.isEmpty) return <T>[];
    try {
      final values = (jsonDecode(raw) as List).cast<Map>();
      return values.map((e) => decode(e.cast<String,Object?>())).toList();
    } on FormatException {
      return <T>[];
    } on TypeError {
      return <T>[];
    }
  }

  Future<void> _write<T>(String key, List<T> values, Map<String,Object?> Function(T) encode) async {
    await _preferences.setString(key, jsonEncode(values.map(encode).toList()));
  }

  List<WorkJob> get jobs => _read(_jobsKey, WorkJob.fromJson);
  List<JobApplication> get applications => _read(_applicationsKey, JobApplication.fromJson);
  List<WorkerProfile> get workers => _read(_workersKey, WorkerProfile.fromJson);
  List<AttendanceRecord> get attendance => _read(_attendanceKey, AttendanceRecord.fromJson);
  List<PaymentEntry> get payments => _read(_paymentsKey, PaymentEntry.fromJson);
  List<WorkMilestone> get milestones => _read(_milestonesKey, WorkMilestone.fromJson);

  Future<void> saveJob(WorkJob job) async {
    final values = jobs.where((e) => e.id != job.id).toList()..insert(0, job);
    await _write(_jobsKey, values, (e) => e.toJson());
  }
  Future<void> saveApplication(JobApplication value) async {
    final values = applications.where((e) => e.id != value.id).toList()..insert(0, value);
    await _write(_applicationsKey, values, (e) => e.toJson());
  }
  Future<void> saveWorker(WorkerProfile value) async {
    final values = workers.where((e) => e.userId != value.userId).toList()..insert(0, value);
    await _write(_workersKey, values, (e) => e.toJson());
  }
  Future<void> saveAttendance(AttendanceRecord value) async {
    final values = attendance.where((e) => e.id != value.id).toList()..insert(0, value);
    await _write(_attendanceKey, values, (e) => e.toJson());
  }
  Future<void> savePayment(PaymentEntry value) async {
    final values = payments.where((e) => e.id != value.id).toList()..insert(0, value);
    await _write(_paymentsKey, values, (e) => e.toJson());
  }
  Future<void> saveMilestone(WorkMilestone value) async {
    final values = milestones.where((e) => e.id != value.id).toList()..insert(0, value);
    await _write(_milestonesKey, values, (e) => e.toJson());
  }
}
