enum DayKind { off, present, late, absent, holiday }

class WorkoutBlock {
  final String name;
  final int minutes;
  const WorkoutBlock(this.name, this.minutes);
}

class CheckInRecord {
  final String day;
  final String time;
  final String label;
  final DayKind kind;
  const CheckInRecord(this.day, this.time, this.label, this.kind);
}

class OfferItem {
  final String name;
  final String off;
  final String price;
  const OfferItem(this.name, this.off, this.price);
}

/// Sample presentation data taken from the approved purple dashboard.
/// Nothing here is a live gym record.
class MemberSample {
  static const name = 'Ashwani Kumar Singh';
  static const memberId = 'BG215';
  static const ageLabel = '28 Yrs';
  static const gender = 'Male';
  static const plan = 'Gold Plan';
  static const checkInTime = '07:12 AM';
  static const dueLabel = '₹500 Due';
  static const daysLeftLabel = '8 Days Left';
  static const expiresLabel = '24 Oct 2026';
  static const membershipDone = 22;
  static const membershipTotal = 30;
  static const attendancePercentLabel = '81%';
  static const attendanceFraction = 0.81;
  static const present = 23;
  static const late = 2;
  static const absent = 2;
  static const holiday = 4;
  static const monthDays = 31;
  static const attendedLabel = '25/31';
  static const workoutMinutes = 58;
  static const bodyLabel = '69.5 kg';
  static const streakLabel = '5d';
  static const trophyLabel = '14d';
  static const trendLabel = '+6%';
  static const sampleNote =
      'Sample data · API connection required for live records';
  static const today = 16;
  static const qrPayload = 'BADGYM:BG215:ASHWANI';

  static const absentDays = {17, 23};
  static const lateDays = {10, 21};
  static const offDays = <int>{};
  static const holidayDays = {4, 11, 18, 25};

  static const blocks = <WorkoutBlock>[
    WorkoutBlock('Warm-up', 8),
    WorkoutBlock('Strength', 32),
    WorkoutBlock('Cardio', 14),
    WorkoutBlock('Cooldown', 4),
  ];

  static const history = <CheckInRecord>[
    CheckInRecord('16 Oct', '07:12 AM', 'Check-in complete', DayKind.present),
    CheckInRecord('15 Oct', '06:58 AM', 'Check-in complete', DayKind.present),
    CheckInRecord('14 Oct', '07:21 AM', 'Check-in complete', DayKind.present),
    CheckInRecord('13 Oct', '—', 'Absent', DayKind.absent),
    CheckInRecord('12 Oct', '07:05 AM', 'Check-in complete', DayKind.present),
    CheckInRecord('11 Oct', '—', 'Holiday', DayKind.holiday),
  ];

  static const offers = <OfferItem>[
    OfferItem('Whey Protein', '25% OFF', '₹1,499'),
    OfferItem('Whey Protein Bundle', '25% OFF', '₹2,499'),
    OfferItem('Creatine Monohydrate', '20% OFF', '₹899'),
    OfferItem('Fat Loss Support', '15% OFF', '₹1,199'),
    OfferItem('Whey Recovery', '20% OFF', '₹1,299'),
    OfferItem('Purple Protein Bundle', '20% OFF', '₹1,699'),
    OfferItem('Blinkit Grocery Partner', 'Member Offer', 'Shop now'),
    OfferItem('Purple Shaker Bottle', '20% OFF', '₹399'),
  ];

  static int get workoutSum =>
      blocks.fold<int>(0, (sum, block) => sum + block.minutes);

  static DayKind kindFor(int day) {
    if (offDays.contains(day)) return DayKind.off;
    if (holidayDays.contains(day)) return DayKind.holiday;
    if (absentDays.contains(day)) return DayKind.absent;
    if (lateDays.contains(day)) return DayKind.late;
    return DayKind.present;
  }

  static int countKind(DayKind kind) {
    var total = 0;
    for (var day = 1; day <= monthDays; day++) {
      if (kindFor(day) == kind) total++;
    }
    return total;
  }
}
