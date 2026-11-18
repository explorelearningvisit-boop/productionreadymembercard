enum MarketplaceRole { worker, customer, contractor, siteManager, company, supplier, admin }

enum JobStatus { draft, published, assigned, inProgress, review, completed, cancelled, disputed }
enum ApplicationStatus { submitted, shortlisted, accepted, rejected, withdrawn }
enum AttendanceStatus { present, late, absent, excused }
enum PaymentStatus { pending, approved, paid, disputed, reversed }
enum WorkUnit { hour, day, piece, task, squareFoot, kilogram, trip, fixed }

class GeoPoint {
  const GeoPoint({required this.latitude, required this.longitude});
  final double latitude;
  final double longitude;
  Map<String, Object?> toJson() => {'latitude': latitude, 'longitude': longitude};
  factory GeoPoint.fromJson(Map<String, Object?> json) => GeoPoint(
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
  );
}

class WorkJob {
  const WorkJob({
    required this.id, required this.ownerId, required this.title,
    required this.description, required this.category, required this.skills,
    required this.locationLabel, this.location, required this.requiredWorkers,
    required this.ratePaise, required this.unit, required this.status,
    required this.createdAt, this.startAt, this.endAt, this.safetyNotes = '',
    this.materialsProvided = false, this.isUrgent = false,
  });
  final String id, ownerId, title, description, category, locationLabel, safetyNotes;
  final List<String> skills;
  final GeoPoint? location;
  final int requiredWorkers, ratePaise;
  final WorkUnit unit;
  final JobStatus status;
  final DateTime createdAt;
  final DateTime? startAt, endAt;
  final bool materialsProvided, isUrgent;

  Map<String, Object?> toJson() => {
    'id': id, 'ownerId': ownerId, 'title': title, 'description': description,
    'category': category, 'skills': skills, 'locationLabel': locationLabel,
    'location': location?.toJson(), 'requiredWorkers': requiredWorkers,
    'ratePaise': ratePaise, 'unit': unit.name, 'status': status.name,
    'createdAt': createdAt.toIso8601String(), 'startAt': startAt?.toIso8601String(),
    'endAt': endAt?.toIso8601String(), 'safetyNotes': safetyNotes,
    'materialsProvided': materialsProvided, 'isUrgent': isUrgent,
  };
  factory WorkJob.fromJson(Map<String, Object?> j) => WorkJob(
    id: j['id'] as String, ownerId: j['ownerId'] as String,
    title: j['title'] as String, description: j['description'] as String,
    category: j['category'] as String, skills: (j['skills'] as List).cast<String>(),
    locationLabel: j['locationLabel'] as String,
    location: j['location'] == null ? null : GeoPoint.fromJson((j['location'] as Map).cast<String,Object?>()),
    requiredWorkers: j['requiredWorkers'] as int, ratePaise: j['ratePaise'] as int,
    unit: WorkUnit.values.byName(j['unit'] as String),
    status: JobStatus.values.byName(j['status'] as String),
    createdAt: DateTime.parse(j['createdAt'] as String),
    startAt: j['startAt'] == null ? null : DateTime.parse(j['startAt'] as String),
    endAt: j['endAt'] == null ? null : DateTime.parse(j['endAt'] as String),
    safetyNotes: (j['safetyNotes'] as String?) ?? '',
    materialsProvided: (j['materialsProvided'] as bool?) ?? false,
    isUrgent: (j['isUrgent'] as bool?) ?? false,
  );
}

class JobApplication {
  const JobApplication({required this.id, required this.jobId, required this.workerId,
    required this.status, required this.appliedAt, this.note = ''});
  final String id, jobId, workerId, note;
  final ApplicationStatus status;
  final DateTime appliedAt;
  Map<String,Object?> toJson()=>{'id':id,'jobId':jobId,'workerId':workerId,'status':status.name,'appliedAt':appliedAt.toIso8601String(),'note':note};
  factory JobApplication.fromJson(Map<String,Object?> j)=>JobApplication(
    id:j['id'] as String, jobId:j['jobId'] as String, workerId:j['workerId'] as String,
    status:ApplicationStatus.values.byName(j['status'] as String),
    appliedAt:DateTime.parse(j['appliedAt'] as String), note:(j['note'] as String?)??'');
}

class WorkerProfile {
  const WorkerProfile({required this.userId, required this.displayName, required this.phone,
    required this.skills, required this.languages, required this.homeArea,
    this.experienceYears = 0, this.kycVerified = false, this.available = true});
  final String userId, displayName, phone, homeArea;
  final List<String> skills, languages;
  final int experienceYears;
  final bool kycVerified, available;
  Map<String,Object?> toJson()=>{'userId':userId,'displayName':displayName,'phone':phone,
    'skills':skills,'languages':languages,'homeArea':homeArea,'experienceYears':experienceYears,
    'kycVerified':kycVerified,'available':available};
  factory WorkerProfile.fromJson(Map<String,Object?> j)=>WorkerProfile(
    userId:j['userId'] as String,displayName:j['displayName'] as String,
    phone:j['phone'] as String,skills:(j['skills'] as List).cast<String>(),
    languages:(j['languages'] as List).cast<String>(),homeArea:j['homeArea'] as String,
    experienceYears:(j['experienceYears'] as int?)??0,
    kycVerified:(j['kycVerified'] as bool?)??false,available:(j['available'] as bool?)??true);
}

class AttendanceRecord {
  const AttendanceRecord({required this.id,required this.jobId,required this.workerId,
    required this.checkInAt,required this.status,this.checkOutAt,this.evidenceUri});
  final String id,jobId,workerId;
  final DateTime checkInAt;
  final DateTime? checkOutAt;
  final AttendanceStatus status;
  final String? evidenceUri;
  Map<String,Object?> toJson()=>{'id':id,'jobId':jobId,'workerId':workerId,
    'checkInAt':checkInAt.toIso8601String(),'checkOutAt':checkOutAt?.toIso8601String(),
    'status':status.name,'evidenceUri':evidenceUri};
  factory AttendanceRecord.fromJson(Map<String,Object?> j)=>AttendanceRecord(
    id:j['id'] as String,jobId:j['jobId'] as String,workerId:j['workerId'] as String,
    checkInAt:DateTime.parse(j['checkInAt'] as String),
    checkOutAt:j['checkOutAt']==null?null:DateTime.parse(j['checkOutAt'] as String),
    status:AttendanceStatus.values.byName(j['status'] as String),
    evidenceUri:j['evidenceUri'] as String?);
}

class PaymentEntry {
  const PaymentEntry({required this.id,required this.jobId,required this.workerId,
    required this.amountPaise,required this.status,required this.createdAt,
    this.approvedAt,this.reference = ''});
  final String id,jobId,workerId,reference;
  final int amountPaise;
  final PaymentStatus status;
  final DateTime createdAt;
  final DateTime? approvedAt;
  Map<String,Object?> toJson()=>{'id':id,'jobId':jobId,'workerId':workerId,
    'amountPaise':amountPaise,'status':status.name,'createdAt':createdAt.toIso8601String(),
    'approvedAt':approvedAt?.toIso8601String(),'reference':reference};
  factory PaymentEntry.fromJson(Map<String,Object?> j)=>PaymentEntry(
    id:j['id'] as String,jobId:j['jobId'] as String,workerId:j['workerId'] as String,
    amountPaise:j['amountPaise'] as int,status:PaymentStatus.values.byName(j['status'] as String),
    createdAt:DateTime.parse(j['createdAt'] as String),
    approvedAt:j['approvedAt']==null?null:DateTime.parse(j['approvedAt'] as String),
    reference:(j['reference'] as String?)??'');
}

class WorkMilestone {
  const WorkMilestone({required this.id,required this.jobId,required this.title,
    required this.acceptanceCriteria,required this.targetCount,this.completedCount=0,
    this.verifiedAt,this.verifiedBy});
  final String id,jobId,title,acceptanceCriteria;
  final int targetCount,completedCount;
  final DateTime? verifiedAt;
  final String? verifiedBy;
  bool get isComplete => completedCount >= targetCount && verifiedAt != null;
  Map<String,Object?> toJson()=>{'id':id,'jobId':jobId,'title':title,
    'acceptanceCriteria':acceptanceCriteria,'targetCount':targetCount,
    'completedCount':completedCount,'verifiedAt':verifiedAt?.toIso8601String(),
    'verifiedBy':verifiedBy};
  factory WorkMilestone.fromJson(Map<String,Object?> j)=>WorkMilestone(
    id:j['id'] as String,jobId:j['jobId'] as String,title:j['title'] as String,
    acceptanceCriteria:j['acceptanceCriteria'] as String,targetCount:j['targetCount'] as int,
    completedCount:(j['completedCount'] as int?)??0,
    verifiedAt:j['verifiedAt']==null?null:DateTime.parse(j['verifiedAt'] as String),
    verifiedBy:j['verifiedBy'] as String?);
}


enum TaskStatus { planned, ready, inProgress, blocked, submitted, accepted, partiallyAccepted, rejected }
enum DelayReason { weather, materials, designChange, equipmentFailure, workerAbsent, siteAccess, ownerHold, safetyHold, other }
enum EvidenceKind { beforePhoto, progressPhoto, completionPhoto, document, voiceNote }
enum ReviewDecision { pending, accepted, partiallyAccepted, rejected, reworkRequired }

/// A measurable unit of work. Presence/time alone never marks this task complete.
class WorkTask {
  const WorkTask({
    required this.id, required this.jobId, required this.title,
    required this.scope, required this.unitLabel, required this.targetQuantity,
    required this.ratePerUnitPaise, required this.status,
    required this.plannedStart, required this.plannedEnd,
    this.acceptedQuantity = 0, this.safetyChecklistRequired = true,
    this.qualityCriteria = const [], this.leadWorkerId,
  });
  final String id, jobId, title, scope, unitLabel;
  final num targetQuantity, acceptedQuantity;
  final int ratePerUnitPaise;
  final TaskStatus status;
  final DateTime plannedStart, plannedEnd;
  final bool safetyChecklistRequired;
  final List<String> qualityCriteria;
  final String? leadWorkerId;
  num get remainingQuantity => (targetQuantity - acceptedQuantity).clamp(0, targetQuantity);
  int get payableAcceptedValuePaise => (acceptedQuantity * ratePerUnitPaise).round();
  Map<String,Object?> toJson()=>{
    'id':id,'jobId':jobId,'title':title,'scope':scope,'unitLabel':unitLabel,
    'targetQuantity':targetQuantity,'acceptedQuantity':acceptedQuantity,
    'ratePerUnitPaise':ratePerUnitPaise,'status':status.name,
    'plannedStart':plannedStart.toIso8601String(),'plannedEnd':plannedEnd.toIso8601String(),
    'safetyChecklistRequired':safetyChecklistRequired,'qualityCriteria':qualityCriteria,
    'leadWorkerId':leadWorkerId,
  };
  factory WorkTask.fromJson(Map<String,Object?> j)=>WorkTask(
    id:j['id'] as String,jobId:j['jobId'] as String,title:j['title'] as String,
    scope:j['scope'] as String,unitLabel:j['unitLabel'] as String,
    targetQuantity:j['targetQuantity'] as num,acceptedQuantity:(j['acceptedQuantity'] as num?)??0,
    ratePerUnitPaise:j['ratePerUnitPaise'] as int,
    status:TaskStatus.values.byName(j['status'] as String),
    plannedStart:DateTime.parse(j['plannedStart'] as String),
    plannedEnd:DateTime.parse(j['plannedEnd'] as String),
    safetyChecklistRequired:(j['safetyChecklistRequired'] as bool?)??true,
    qualityCriteria:(j['qualityCriteria'] as List? ?? const []).cast<String>(),
    leadWorkerId:j['leadWorkerId'] as String?,
  );
}

/// Who contributed to an accepted task quantity and what share was approved.
class ContributorAllocation {
  const ContributorAllocation({required this.id,required this.taskId,
    required this.workerId,required this.acceptedQuantity,
    required this.amountPaise,required this.approvedBy,required this.approvedAt});
  final String id,taskId,workerId,approvedBy;
  final num acceptedQuantity;
  final int amountPaise;
  final DateTime approvedAt;
  Map<String,Object?> toJson()=>{'id':id,'taskId':taskId,'workerId':workerId,
    'acceptedQuantity':acceptedQuantity,'amountPaise':amountPaise,
    'approvedBy':approvedBy,'approvedAt':approvedAt.toIso8601String()};
  factory ContributorAllocation.fromJson(Map<String,Object?> j)=>ContributorAllocation(
    id:j['id'] as String,taskId:j['taskId'] as String,workerId:j['workerId'] as String,
    acceptedQuantity:j['acceptedQuantity'] as num,amountPaise:j['amountPaise'] as int,
    approvedBy:j['approvedBy'] as String,approvedAt:DateTime.parse(j['approvedAt'] as String));
}

/// Delay events explain variance without automatically blaming a worker.
class WorkDelayEvent {
  const WorkDelayEvent({required this.id,required this.taskId,required this.reason,
    required this.startedAt,required this.reportedBy,this.endedAt,this.notes = ''});
  final String id,taskId,reportedBy,notes;
  final DelayReason reason;
  final DateTime startedAt;
  final DateTime? endedAt;
  Map<String,Object?> toJson()=>{'id':id,'taskId':taskId,'reason':reason.name,
    'startedAt':startedAt.toIso8601String(),'endedAt':endedAt?.toIso8601String(),
    'reportedBy':reportedBy,'notes':notes};
  factory WorkDelayEvent.fromJson(Map<String,Object?> j)=>WorkDelayEvent(
    id:j['id'] as String,taskId:j['taskId'] as String,
    reason:DelayReason.values.byName(j['reason'] as String),
    startedAt:DateTime.parse(j['startedAt'] as String),
    endedAt:j['endedAt']==null?null:DateTime.parse(j['endedAt'] as String),
    reportedBy:j['reportedBy'] as String,notes:(j['notes'] as String?)??'');
}

class TaskEvidence {
  const TaskEvidence({required this.id,required this.taskId,required this.uploaderId,
    required this.kind,required this.storagePath,required this.capturedAt,
    this.latitude,this.longitude,this.caption = ''});
  final String id,taskId,uploaderId,storagePath,caption;
  final EvidenceKind kind;
  final DateTime capturedAt;
  final double? latitude,longitude;
  Map<String,Object?> toJson()=>{'id':id,'taskId':taskId,'uploaderId':uploaderId,
    'kind':kind.name,'storagePath':storagePath,'capturedAt':capturedAt.toIso8601String(),
    'latitude':latitude,'longitude':longitude,'caption':caption};
  factory TaskEvidence.fromJson(Map<String,Object?> j)=>TaskEvidence(
    id:j['id'] as String,taskId:j['taskId'] as String,uploaderId:j['uploaderId'] as String,
    kind:EvidenceKind.values.byName(j['kind'] as String),storagePath:j['storagePath'] as String,
    capturedAt:DateTime.parse(j['capturedAt'] as String),
    latitude:(j['latitude'] as num?)?.toDouble(),longitude:(j['longitude'] as num?)?.toDouble(),
    caption:(j['caption'] as String?)??'');
}

class TaskQualityReview {
  const TaskQualityReview({required this.id,required this.taskId,required this.reviewerId,
    required this.decision,required this.reviewedAt,required this.acceptedQuantity,
    required this.reason,this.safetyApproved = false,this.evidenceIds = const []});
  final String id,taskId,reviewerId,reason;
  final ReviewDecision decision;
  final DateTime reviewedAt;
  final num acceptedQuantity;
  final bool safetyApproved;
  final List<String> evidenceIds;
  Map<String,Object?> toJson()=>{'id':id,'taskId':taskId,'reviewerId':reviewerId,
    'decision':decision.name,'reviewedAt':reviewedAt.toIso8601String(),
    'acceptedQuantity':acceptedQuantity,'reason':reason,
    'safetyApproved':safetyApproved,'evidenceIds':evidenceIds};
  factory TaskQualityReview.fromJson(Map<String,Object?> j)=>TaskQualityReview(
    id:j['id'] as String,taskId:j['taskId'] as String,reviewerId:j['reviewerId'] as String,
    decision:ReviewDecision.values.byName(j['decision'] as String),
    reviewedAt:DateTime.parse(j['reviewedAt'] as String),
    acceptedQuantity:j['acceptedQuantity'] as num,reason:j['reason'] as String,
    safetyApproved:(j['safetyApproved'] as bool?)??false,
    evidenceIds:(j['evidenceIds'] as List? ?? const []).cast<String>());
}
