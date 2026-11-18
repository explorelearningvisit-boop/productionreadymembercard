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

  test('measurable task pays only accepted quantity', () {
    final task = WorkTask(
      id: 'task-16-pillars', jobId: 'site-1', title: 'Cast pillars',
      scope: 'Cast 16 approved pillars as per engineer drawings',
      unitLabel: 'pillar', targetQuantity: 16, acceptedQuantity: 4,
      ratePerUnitPaise: 125000, status: TaskStatus.partiallyAccepted,
      plannedStart: DateTime.utc(2026, 11, 18, 8),
      plannedEnd: DateTime.utc(2026, 11, 18, 18),
      qualityCriteria: const ['Rebar inspection passed', 'Dimensions checked', 'Concrete test recorded'],
    );
    expect(task.remainingQuantity, 12);
    expect(task.payableAcceptedValuePaise, 500000);
    expect(WorkTask.fromJson(task.toJson()).acceptedQuantity, 4);
  });

  test('weather delay is recorded separately from worker absence', () {
    final event = WorkDelayEvent(
      id: 'delay-1', taskId: 'task-16-pillars', reason: DelayReason.weather,
      startedAt: DateTime.utc(2026, 11, 18, 13), reportedBy: 'site-manager-1',
      notes: 'Heavy rain; safe concrete work paused',
    );
    final restored = WorkDelayEvent.fromJson(event.toJson());
    expect(restored.reason, DelayReason.weather);
    expect(restored.reportedBy, 'site-manager-1');
  });

  test('quality review requires explicit safety approval flag', () {
    final review = TaskQualityReview(
      id: 'review-1', taskId: 'task-16-pillars', reviewerId: 'engineer-1',
      decision: ReviewDecision.accepted, reviewedAt: DateTime.utc(2026, 11, 18, 18),
      acceptedQuantity: 4, reason: 'Inspection passed',
      safetyApproved: true, evidenceIds: const ['photo-1', 'report-1'],
    );
    final restored = TaskQualityReview.fromJson(review.toJson());
    expect(restored.safetyApproved, isTrue);
    expect(restored.acceptedQuantity, 4);
  });

}
