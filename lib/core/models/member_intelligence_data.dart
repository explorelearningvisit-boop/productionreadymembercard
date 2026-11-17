enum DayAttendanceStatus {
  empty,
  present,
  late,
  absent,
  holiday,
}

class CalendarDayItem {
  final int day;
  final DayAttendanceStatus status;
  final bool isToday;

  const CalendarDayItem({
    required this.day,
    required this.status,
    this.isToday = false,
  }) : assert(day >= 1 && day <= 31);
}

class TrendDataPoint {
  final int day;
  final double percentage;
  final String? calloutText;
  final bool isCalloutGreen;

  const TrendDataPoint({
    required this.day,
    required this.percentage,
    this.calloutText,
    this.isCalloutGreen = false,
  })  : assert(day >= 1 && day <= 31),
        assert(percentage >= 0 && percentage <= 100);
}

class MemberIntelligenceData {
  final String name;
  final String memberId;
  final int age;
  final String gender;
  final String planName;
  final bool isActive;
  final int daysUsed;
  final int totalDays;

  /// Accepts either a fraction (0.73) or percentage (73.0) for legacy data.
  /// Prefer [membershipProgress] for all UI calculations.
  final double usedPercentage;

  final int daysLeft;
  final String renewDate;
  final int attendanceRate;
  final String attendanceFraction;
  final String workoutTime;
  final String paymentStatus;
  final String bodyWeight;
  final int presentCount;
  final int lateCount;
  final int absentCount;
  final int holidayCount;
  final String currentStreak;
  final String bestStreak;
  final List<CalendarDayItem> calendarDays;
  final List<TrendDataPoint> trendPoints;
  final int attendanceYear;
  final int attendanceMonth;

  // Header & Dashboard Fields
  final String checkInTime;
  final String checkInDate;
  final String checkInLocation;
  final String paymentAmount;
  final String paymentNextDue;
  final int notificationCount;

  const MemberIntelligenceData({
    required this.name,
    required this.memberId,
    required this.age,
    required this.gender,
    required this.planName,
    required this.isActive,
    required this.daysUsed,
    required this.totalDays,
    required this.usedPercentage,
    required this.daysLeft,
    required this.renewDate,
    required this.attendanceRate,
    required this.attendanceFraction,
    required this.workoutTime,
    required this.paymentStatus,
    required this.bodyWeight,
    required this.presentCount,
    required this.lateCount,
    required this.absentCount,
    required this.holidayCount,
    required this.currentStreak,
    required this.bestStreak,
    required this.calendarDays,
    required this.trendPoints,
    this.attendanceYear = 2026,
    this.attendanceMonth = 10,
    this.checkInTime = '07:12 AM',
    this.checkInDate = '16 Oct 2026',
    this.checkInLocation = 'Main Gym Floor',
    this.paymentAmount = '₹500 Due',
    this.paymentNextDue = '24 Oct 2026',
    this.notificationCount = 3,
  })  : assert(age >= 0),
        assert(daysUsed >= 0),
        assert(totalDays >= 0),
        assert(presentCount >= 0 && lateCount >= 0 && absentCount >= 0),
        assert(holidayCount >= 0),
        assert(attendanceMonth >= 1 && attendanceMonth <= 12);

  double get membershipProgress {
    if (totalDays <= 0) return 0;
    final raw = usedPercentage > 1 ? usedPercentage / 100 : usedPercentage;
    return raw.clamp(0.0, 1.0).toDouble();
  }

  int get membershipPercent => (membershipProgress * 100).round();

  int get calculatedDaysLeft => (totalDays - daysUsed).clamp(0, totalDays);

  String get membershipDaysLabel => 'Membership $daysUsed / $totalDays Days';

  String get attendanceMonthLabel {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[attendanceMonth - 1]} $attendanceYear';
  }

  static MemberIntelligenceData get ashwaniKumarSingh {
    final days = <CalendarDayItem>[
      const CalendarDayItem(day: 1, status: DayAttendanceStatus.empty),
      const CalendarDayItem(day: 2, status: DayAttendanceStatus.empty),
      const CalendarDayItem(day: 3, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 4, status: DayAttendanceStatus.holiday),
      const CalendarDayItem(day: 5, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 6, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 7, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 8, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 9, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 10, status: DayAttendanceStatus.late),
      const CalendarDayItem(day: 11, status: DayAttendanceStatus.holiday),
      const CalendarDayItem(day: 12, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 13, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 14, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 15, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 16, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 17, status: DayAttendanceStatus.absent),
      const CalendarDayItem(day: 18, status: DayAttendanceStatus.holiday),
      const CalendarDayItem(day: 19, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 20, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 21, status: DayAttendanceStatus.late),
      const CalendarDayItem(day: 22, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 23, status: DayAttendanceStatus.absent),
      const CalendarDayItem(day: 24, status: DayAttendanceStatus.absent),
      const CalendarDayItem(day: 25, status: DayAttendanceStatus.holiday),
      const CalendarDayItem(day: 26, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 27, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 28, status: DayAttendanceStatus.late),
      const CalendarDayItem(day: 29, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 30, status: DayAttendanceStatus.present),
      const CalendarDayItem(day: 31, status: DayAttendanceStatus.present),
    ];

    final trend = <TrendDataPoint>[
      const TrendDataPoint(day: 1, percentage: 70),
      const TrendDataPoint(
          day: 3,
          percentage: 97,
          calloutText: '97% (3 Oct)',
          isCalloutGreen: true),
      const TrendDataPoint(day: 5, percentage: 88),
      const TrendDataPoint(day: 8, percentage: 76),
      const TrendDataPoint(day: 11, percentage: 60),
      const TrendDataPoint(day: 13, percentage: 72),
      const TrendDataPoint(day: 15, percentage: 82),
      const TrendDataPoint(
          day: 17, percentage: 58, calloutText: '58% (17 Oct)'),
      const TrendDataPoint(day: 20, percentage: 85),
      const TrendDataPoint(day: 23, percentage: 72),
      const TrendDataPoint(day: 26, percentage: 86),
      const TrendDataPoint(day: 28, percentage: 74),
      const TrendDataPoint(day: 30, percentage: 78),
      const TrendDataPoint(
          day: 31, percentage: 81, calloutText: '81% (31 Oct)'),
    ];

    return MemberIntelligenceData(
      name: 'Ashwani Kumar Sharma Vishwakarma',
      memberId: 'BG215',
      age: 28,
      gender: 'Male',
      planName: 'Gold Plan',
      isActive: true,
      daysUsed: 22,
      totalDays: 30,
      usedPercentage: 73.0,
      daysLeft: 8,
      renewDate: '24 Oct 2026',
      attendanceRate: 81,
      attendanceFraction: '25 / 31 Days',
      workoutTime: '58 min',
      paymentStatus: 'Due',
      bodyWeight: '69.5 kg',
      presentCount: 23,
      lateCount: 2,
      absentCount: 2,
      holidayCount: 4,
      currentStreak: '5 Days',
      bestStreak: '14 Days',
      calendarDays: days,
      trendPoints: trend,
      attendanceYear: 2026,
      attendanceMonth: 10,
      checkInTime: '07:12 AM',
      checkInDate: '16 Oct 2026',
      checkInLocation: 'Main Gym Floor',
      paymentAmount: '₹500 Due',
      paymentNextDue: '24 Oct 2026',
      notificationCount: 3,
    );
  }
}
