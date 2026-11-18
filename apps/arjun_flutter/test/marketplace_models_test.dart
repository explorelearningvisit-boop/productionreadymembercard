import 'package:flutter_test/flutter_test.dart';
import 'package:arjun_app/domain/marketplace_models.dart';

void main() {
  test('job round-trips without losing work requirements', () {
    final original = WorkJob(
      id: 'job-1', ownerId: 'owner-1', title: 'Electrical wiring',
      description: 'First-floor conduit and wiring', category: 'Electrical',
      skills: const ['Electrician', 'Helper'], locationLabel: 'Varanasi',
      location: const GeoPoint(latitude: 25.3176, longitude: 82.9739),
      requiredWorkers: 2, ratePaise: 85000, unit: WorkUnit.day,
      status: JobStatus.published, createdAt: DateTime.utc(2026, 11, 18),
      safetyNotes: 'Isolate supply and verify dead before work',
      materialsProvided: true, isUrgent: true,
    );
    final decoded = WorkJob.fromJson(original.toJson());
    expect(decoded.title, original.title);
    expect(decoded.skills, original.skills);
    expect(decoded.ratePaise, 85000);
    expect(decoded.location?.latitude, closeTo(25.3176, 0.00001));
    expect(decoded.safetyNotes, contains('Isolate'));
    expect(decoded.isUrgent, isTrue);
  });

  test('milestone is not complete until evidence is verified', () {
    final milestone = WorkMilestone(
      id: 'm1', jobId: 'j1', title: 'Foundation excavation',
      acceptanceCriteria: 'Depth and dimensions approved by site engineer',
      targetCount: 1, completedCount: 1,
    );
    expect(milestone.isComplete, isFalse);
  });
}
