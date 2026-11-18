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
