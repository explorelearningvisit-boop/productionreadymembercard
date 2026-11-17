import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() => runApp(const MemberIntelligenceApp());

class MemberIntelligenceApp extends StatelessWidget {
  const MemberIntelligenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Member Intelligence',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF6EAF1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFCF0055),
          brightness: Brightness.light,
        ),
      ),
      home: const MemberDashboardPage(),
    );
  }
}

class MemberDashboardPage extends StatefulWidget {
  const MemberDashboardPage({super.key});

  @override
  State<MemberDashboardPage> createState() => _MemberDashboardPageState();
}

class _MemberDashboardPageState extends State<MemberDashboardPage> {
  int _activeSection = 1;
  int _activeSubSection = 0;
  // Demo fixture dates are derived from the device's local date so the
  // preview never shows expired dates or a stale calendar month.
  late final DateTime _today = DateUtils.dateOnly(DateTime.now());
  late final DateTime _paymentDueDate = _today.add(const Duration(days: 4));
  late final DateTime _membershipExpiryDate = _today.add(const Duration(days: 8));
  static const double _paymentDueAmount = 500;
  int get _paymentDueInDays => _paymentDueDate.difference(_today).inDays;
  int get _membershipDaysLeft => _membershipExpiryDate.difference(_today).inDays;
  int get _membershipDaysUsed => (30 - _membershipDaysLeft).clamp(0, 30).toInt();
  double get _membershipProgressValue => _membershipDaysUsed / 30;
  double get _earlyPaymentRate {
    if (_paymentDueInDays >= 7) return .02;
    if (_paymentDueInDays >= 3) return .01;
    if (_paymentDueInDays >= 1) return .005;
    return 0;
  }
  double get _earlyPaymentSavings => _paymentDueAmount * _earlyPaymentRate;
  late int _month = _today.month;
  late int _year = _today.year;

  // Demo-only attendance fixture for the current month. Live attendance
  // should replace this map when the member data API is connected.
  Map<int, DayKind> get _currentMonthDays {
    final days = <int, DayKind>{};
    for (var day = 1; day <= _today.day; day++) {
      if (day == 4 || day == 16) {
        days[day] = DayKind.holiday;
      } else if (day == 7 || day == 14) {
        days[day] = DayKind.absent;
      } else if (day == 10) {
        days[day] = DayKind.payment;
      } else {
        days[day] = DayKind.present;
      }
    }
    return days;
  }

  final Map<int, DayKind> _octoberDays = {
    1: DayKind.present,
    2: DayKind.present,
    3: DayKind.holiday,
    4: DayKind.present,
    5: DayKind.present,
    6: DayKind.present,
    7: DayKind.absent,
    8: DayKind.present,
    9: DayKind.present,
    10: DayKind.payment,
    11: DayKind.present,
    12: DayKind.present,
    13: DayKind.present,
    14: DayKind.absent,
    15: DayKind.present,
    16: DayKind.present,
    17: DayKind.present,
    18: DayKind.holiday,
    19: DayKind.present,
    20: DayKind.present,
    21: DayKind.present,
    22: DayKind.present,
    23: DayKind.present,
    24: DayKind.absent,
    25: DayKind.present,
    26: DayKind.present,
    27: DayKind.present,
    28: DayKind.payment,
    29: DayKind.present,
    30: DayKind.present,
    31: DayKind.present,
  };

  Map<int, DayKind> get _days {
    if (_month == _today.month && _year == _today.year) {
      return _currentMonthDays;
    }
    if (_month == 10 && _year == 2026) return _octoberDays;
    return const {};
  }

  int get _presentDays => _days.values
      .where((kind) => kind == DayKind.present || kind == DayKind.payment)
      .length;
  int get _absentDays =>
      _days.values.where((kind) => kind == DayKind.absent).length;
  int get _holidayDays =>
      _days.values.where((kind) => kind == DayKind.holiday).length;
  int get _trackedAttendanceDays => _presentDays + _absentDays;
  int get _elapsedCalendarDays => _days.length;
  double get _attendanceRate => _trackedAttendanceDays == 0
      ? 0
      : _presentDays / _trackedAttendanceDays;
  String get _attendancePercent => '${(_attendanceRate * 100).round()}%';

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String get _sectionTitle => const [
        'Dashboard',
        'Attendance Intelligence',
        'Workout Intelligence',
        'Payment Intelligence',
        'Offers & Rewards',
        'Member History',
        'Body Intelligence',
      ][_activeSection];

  void _changeMonth(int delta) {
    setState(() {
      _month += delta;
      if (_month < 1) {
        _month = 12;
        _year--;
      }
      if (_month > 12) {
        _month = 1;
        _year++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final height = constraints.maxHeight;
      final gap = height < 720 ? 3.0 : 4.0;
      return Center(child: SizedBox(
        width: (constraints.maxWidth - 8).clamp(0.0, 540.0), height: height,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [Color(0xFF68002F), Color(0xFFB00052), Color(0xFF6D0037)]),
            borderRadius: BorderRadius.circular(27),
            border: Border.all(color: const Color(0xFFFFB7DA), width: 1.4),
            boxShadow: const [
              BoxShadow(color: Color(0x66F50078), blurRadius: 22, spreadRadius: 1),
              BoxShadow(color: Color(0x663D001F), blurRadius: 12, offset: Offset(0, 5)),
            ],
          ),
          child: Stack(children: [
            Positioned.fill(child: IgnorePointer(child: DecoratedBox(
              decoration: BoxDecoration(gradient: RadialGradient(
                center: const Alignment(0, -.82), radius: 1.25,
                colors: [Color(0x55FF68B5), Color(0x00FF68B5)],
              )),
            ))),
            Padding(padding: const EdgeInsets.all(6), child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                _eventHeader(), SizedBox(height: gap),
                _memberHero(), SizedBox(height: gap),
                _paymentAndExpiry(), SizedBox(height: gap),
                _earlyPaymentOffer(), SizedBox(height: gap),
                _membershipProgressBar(), SizedBox(height: gap),
                _promotionBanner(), SizedBox(height: gap),
                _quickMetrics(), SizedBox(height: gap),
                Expanded(child: _intelligenceWorkspace()),
              ],
            )),
          ]),
        ),
      ));
    })));
  }

  Widget _eventHeader() {
    return SizedBox(height: 44, child: Row(children: [
      Expanded(flex: 6, child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFFF1677), Color(0xFFB00050), Color(0xFF780039)]),
          borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFFFF9CCB), width: 1.2),
          boxShadow: const [BoxShadow(color: Color(0x88FF1677), blurRadius: 12)]),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: [
          Container(width: 30, height: 30,
            decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF08C83D),
              border: Border.all(color: const Color(0xFFB8FFC9), width: 1.2),
              boxShadow: const [BoxShadow(color: Color(0xAA00FF54), blurRadius: 9)]),
            child: const Icon(Icons.check_rounded, color: Colors.white, size: 22)),
          const SizedBox(width: 7),
          const Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('CHECK-IN', style: TextStyle(color: Colors.white, fontSize: 14, height: 1, fontWeight: FontWeight.w900, letterSpacing: .3)),
            SizedBox(height: 3),
            Text('Completed · 07:12 AM', maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color(0xFFFFE8F3), fontSize: 8.5, fontWeight: FontWeight.w600)),
          ])),
        ]),
      )),
      const SizedBox(width: 5),
      Expanded(flex: 5, child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFFFF6FB), Color(0xFFFFDCEB)]),
          borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFFFFB9D8), width: 1.1),
          boxShadow: const [BoxShadow(color: Color(0x66FF8DC1), blurRadius: 8)]),
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Row(children: [
          const Icon(Icons.ac_unit_rounded, color: Color(0xFF9A0060), size: 23),
          const SizedBox(width: 3),
          const Expanded(child: Text('FREEZE MEMBER', maxLines: 1, overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF771044), fontSize: 8.5, fontWeight: FontWeight.w900))),
          Container(width: 27, height: 27,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF850044)),
            child: const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 18)),
        ]),
      )),
    ]));
  }

  Widget _memberHero() {
    return SizedBox(height: 88, child: Stack(children: [
      Positioned(left: 2, top: 2, width: 84, height: 84,
        child: DecoratedBox(decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(colors: [Color(0xFFFFD6EC), Color(0xFFED4F9B), Color(0xFFFFB4D9)]),
          boxShadow: const [BoxShadow(color: Color(0xCCFF4DAD), blurRadius: 15, spreadRadius: 1),
            BoxShadow(color: Color(0x77FFB9DF), blurRadius: 4)]))),
      Positioned(left: 6, top: 6, width: 76, height: 76,
        child: Container(padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFFF3FA)),
          child: ClipOval(child: Image.asset('assets/images/avatar_ashwani_hq.png',
            fit: BoxFit.cover, alignment: Alignment.topCenter,
            errorBuilder: (_, __, ___) => const ColoredBox(color: Color(0xFFFFD7EA),
              child: Icon(Icons.person, color: Color(0xFF80355F), size: 42)))))),
      Positioned(left: 96, right: 3, top: 4, bottom: 3,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Welcome Back 👋', style: TextStyle(color: Color(0xFFFFDCEC), fontSize: 9, fontWeight: FontWeight.w600)),
          const SizedBox(height: 1),
          const Text('Ashwani Kumar Singh', maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 15, height: 1.05, fontWeight: FontWeight.w900)),
          const SizedBox(height: 3),
          const Text('BG215   |   28 Yrs   |   Male', maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Color(0xFFFFE8F3), fontSize: 8.5, fontWeight: FontWeight.w600)),
          const Spacer(),
          Row(children: [
            _pill('♛  Gold Plan', const Color(0xFFFFC928), const Color(0xFF59300B)),
            const SizedBox(width: 5),
            _pill('✓  Active', const Color(0xFF08B947), Colors.white),
          ]),
        ])),
    ]));
  }

  Widget _pill(String text, Color color, Color foreground) => Expanded(
        child: Container(
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: color.withOpacity(.28),
                  blurRadius: 5,
                  offset: const Offset(0, 2))
            ],
          ),
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(text,
                  style: TextStyle(
                      color: foreground,
                      fontSize: 10,
                      fontWeight: FontWeight.w800))),
        ),
      );

  Widget _paymentAndExpiry() {
    return Container(height: 54, padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFF7FB), Color(0xFFFFE6F1)]),
        borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFFFC0DD)),
        boxShadow: const [BoxShadow(color: Color(0x55FF9BC8), blurRadius: 8, offset: Offset(0, 2))]),
      child: Row(children: [
        const Icon(Icons.account_balance_wallet_rounded, color: Color(0xFFB9005A), size: 23),
        const SizedBox(width: 5),
        const Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('PAYMENT DUE', style: TextStyle(color: Color(0xFF7D3155), fontSize: 7.5, fontWeight: FontWeight.w800)),
          Text('₹500', style: TextStyle(color: Color(0xFFB00045), fontSize: 17, height: 1, fontWeight: FontWeight.w900)),
        ])),
        Container(width: 1, height: 36, color: const Color(0xFFDFA9C4)),
        const SizedBox(width: 6),
        const Icon(Icons.event_available_rounded, color: Color(0xFFB9005A), size: 22),
        const SizedBox(width: 4),
        Expanded(flex: 2, child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('$_membershipDaysLeft DAYS LEFT', maxLines: 1, overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFF9C0049), fontSize: 11, fontWeight: FontWeight.w900)),
          Text('Expires ' + _formatDate(_membershipExpiryDate), maxLines: 1, overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFF70445A), fontSize: 7.5)),
        ])),
        const SizedBox(width: 5),
        Container(width: 1, height: 36, color: const Color(0xFFDFA9C4)),
        const SizedBox(width: 5),
        QrImageView(data: 'BADGYM:MEMBER:BG215', version: QrVersions.auto, size: 40,
          padding: const EdgeInsets.all(2), backgroundColor: Colors.white,
          eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Color(0xFF17000D)),
          dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Color(0xFF17000D))),
      ]));
  }

  Widget _earlyPaymentOffer() {
    final rate = _earlyPaymentRate;
    final savingsText = _earlyPaymentSavings == _earlyPaymentSavings.roundToDouble()
        ? _earlyPaymentSavings.toStringAsFixed(0) : _earlyPaymentSavings.toStringAsFixed(2);
    final message = rate > 0
        ? 'DUE SOON  ·  Pay in $_paymentDueInDays days  ·  Save ' + (rate * 100).toStringAsFixed(rate == .005 ? 1 : 0) + '%  (₹' + savingsText + ')'
        : _paymentDueInDays == 0 ? 'DUE TODAY  ·  Pay now to avoid late fees' : 'OVERDUE  ·  Late fee policy may apply';
    return Container(height: 28, padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFF7FB), Color(0xFFFFE0EF)]),
        borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFFFB7D6)),
        boxShadow: const [BoxShadow(color: Color(0x55FF8FC1), blurRadius: 6)]),
      child: Row(children: [
        const Icon(Icons.sell_rounded, color: Color(0xFFB50058), size: 14),
        const SizedBox(width: 5),
        Expanded(child: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Color(0xFF782347), fontSize: 7.5, fontWeight: FontWeight.w900))),
      ]));
  }

  Widget _membershipProgressBar() {
    return SizedBox(height: 34, child: Row(children: [
      Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('MEMBERSHIP  $_membershipDaysUsed / 30 DAYS',
          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: .25)),
        const SizedBox(height: 4),
        ClipRRect(borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(value: _membershipProgressValue, minHeight: 7,
            backgroundColor: const Color(0xFFFFD5E9), valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF1B8D)))),
      ])),
      const SizedBox(width: 8),
      Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFFFF8FC), Color(0xFFFFDDEB)]),
          borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFFFB6D8))),
        child: Text((_membershipProgressValue * 100).round().toString() + '%',
          style: const TextStyle(color: Color(0xFF8C0044), fontSize: 12, fontWeight: FontWeight.w900))),
    ]));
  }

  Widget _promotionBanner() {
    return Container(height: 46, padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFF18B), Color(0xFFFFD34B), Color(0xFFFFB91F)]),
        borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFFFF8C9), width: 1.3),
        boxShadow: const [BoxShadow(color: Color(0x88FFCE3D), blurRadius: 9, offset: Offset(0, 2))]),
      child: Row(children: [
        const Text('amazon', style: TextStyle(color: Color(0xFF20151B), fontSize: 19, fontWeight: FontWeight.w900, letterSpacing: -1.4)),
        const SizedBox(width: 6),
        Container(width: 1, height: 30, color: const Color(0xFFB58B3D)),
        const SizedBox(width: 7),
        const Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Big Billion Sale', maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Color(0xFF8D164B), fontSize: 12, fontWeight: FontWeight.w900)),
          Text('Up to 40% OFF · Fitness Gear', maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Color(0xFF49313A), fontSize: 7.5, fontWeight: FontWeight.w800)),
        ])),
        const Icon(Icons.fitness_center_rounded, color: Color(0xFF5D3545), size: 23),
        const SizedBox(width: 5),
        Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFB90050), Color(0xFF780035)]),
            borderRadius: BorderRadius.circular(18), boxShadow: const [BoxShadow(color: Color(0x668D003F), blurRadius: 5)]),
          child: const Text('Shop Now ›', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900))),
      ]));
  }

  Widget _quickMetrics() {
    final items = [
      (Icons.calendar_month_rounded, 'Attendance', _attendancePercent, 1),
      (Icons.fitness_center_rounded, 'Workout', '58 min', 2),
      (Icons.account_balance_wallet_rounded, 'Payment', '₹500 Due', 3),
      (Icons.monitor_weight_rounded, 'Body', '69.5 kg', 6),
    ];
    return SizedBox(height: 48, child: Row(children: List.generate(items.length, (i) {
      final item = items[i];
      final active = _activeSection == item.$4;
      return Expanded(child: GestureDetector(
        onTap: () => setState(() { _activeSection = item.$4; _activeSubSection = 0; }),
        child: Container(
          margin: EdgeInsets.only(right: i == 3 ? 0 : 4),
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
          decoration: BoxDecoration(
            gradient: active ? const LinearGradient(colors: [Color(0xFFFFF0A2), Color(0xFFFFC928)])
                : const LinearGradient(colors: [Color(0xFFE32A83), Color(0xFF970047)]),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: active ? const Color(0xFFFFF7C9) : const Color(0xFFFF9AC8)),
            boxShadow: [BoxShadow(color: active ? const Color(0x77FFCC35) : const Color(0x55FF2C91), blurRadius: 7)]),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(item.$1, color: active ? const Color(0xFF762B45) : Colors.white, size: 15),
            Text(item.$2, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(color: active ? const Color(0xFF762B45) : Colors.white, fontSize: 7, fontWeight: FontWeight.w800)),
            Text(item.$3, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(color: active ? const Color(0xFF138A3C) : Colors.white, fontSize: 9, fontWeight: FontWeight.w900)),
          ]),
        ),
      ));
    })));
  }

  Widget _intelligenceWorkspace() {
    return LayoutBuilder(builder: (context, constraints) {
      final tileHeight = ((constraints.maxHeight - 10) / 7).clamp(33.0, 57.0);
      return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _verticalRail(tileHeight: tileHeight),
        const SizedBox(width: 4),
        Expanded(child: SizedBox(height: constraints.maxHeight, child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [Color(0xFFFFFBFE), Color(0xFFFFEAF4), Color(0xFFFFF8FC)]),
            borderRadius: BorderRadius.circular(19), border: Border.all(color: const Color(0xFFFFB8D9), width: 1.2),
            boxShadow: const [BoxShadow(color: Color(0x77FF9BC8), blurRadius: 10, offset: Offset(0, 2))]),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(height: 30, child: _workspaceHeader()),
            const SizedBox(height: 4),
            SizedBox(height: 27, child: _sectionSubnav()),
            const SizedBox(height: 4),
            Expanded(child: ClipRect(child: _sectionContent())),
          ]),
        ))),
      ]);
    });
  }

  Widget _verticalRail({required double tileHeight}) {
    const labels = ['Dashboard', 'Attendance', 'Workout', 'Payments', 'Offers', 'History', 'Body'];
    const icons = [Icons.bar_chart_rounded, Icons.calendar_month_rounded, Icons.fitness_center_rounded,
      Icons.account_balance_wallet_rounded, Icons.sell_rounded, Icons.history_rounded, Icons.monitor_weight_rounded];
    return Container(width: 48, height: tileHeight * 7 + 10,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Color(0xFFB60055), Color(0xFF79003B), Color(0xFF4E0029)]),
        borderRadius: BorderRadius.circular(17), border: Border.all(color: const Color(0xFFFFA4D0), width: 1.1),
        boxShadow: const [BoxShadow(color: Color(0x88FF4CA8), blurRadius: 9, offset: Offset(0, 2))]),
      child: Column(children: List.generate(labels.length, (i) {
        final active = _activeSection == i;
        return SizedBox(height: tileHeight, child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => setState(() { _activeSection = i; _activeSubSection = 0; }),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 1.5),
            decoration: BoxDecoration(
              gradient: active ? const LinearGradient(colors: [Color(0xFFFFF0A1), Color(0xFFFFC928)]) : null,
              color: active ? null : Colors.transparent, borderRadius: BorderRadius.circular(11),
              border: active ? Border.all(color: const Color(0xFFFFF6C8)) : null,
              boxShadow: active ? const [BoxShadow(color: Color(0x88FFD34B), blurRadius: 7)] : null),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(icons[i], color: active ? const Color(0xFF762B45) : const Color(0xFFFFF5FA), size: 17),
              const SizedBox(height: 2),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 1),
                child: FittedBox(fit: BoxFit.scaleDown, child: Text(labels[i],
                  style: TextStyle(color: active ? const Color(0xFF762B45) : Colors.white, fontSize: 7.2, fontWeight: FontWeight.w900)))),
            ]),
          ),
        ));
      })),
    );
  }

  Widget _workspaceHeader() {
    return Row(children: [
      Container(width: 27, height: 27,
        decoration: BoxDecoration(shape: BoxShape.circle,
          gradient: const LinearGradient(colors: [Color(0xFFFF5AAB), Color(0xFF9A004D)]),
          boxShadow: const [BoxShadow(color: Color(0x66FF4BA2), blurRadius: 7)]),
        child: const Icon(Icons.insights_rounded, color: Colors.white, size: 17)),
      const SizedBox(width: 6),
      Expanded(child: Text(_sectionTitle, maxLines: 1, overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Color(0xFF4D0D30), fontSize: 10.5, fontWeight: FontWeight.w900))),
      Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFFFEBA1), Color(0xFFFFD24B)]),
          borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFFFF4C7)),
          boxShadow: const [BoxShadow(color: Color(0x66F0C044), blurRadius: 5)]),
        child: const Text('Co-powered by\nblinkit', textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF61243E), fontSize: 5.5, height: 1, fontWeight: FontWeight.w900))),
    ]);
  }

  Widget _sectionSubnav() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: _subSections.length,
      separatorBuilder: (_, __) => const SizedBox(width: 4),
      itemBuilder: (context, index) {
        final active = _activeSubSection == index;
        return GestureDetector(
          onTap: () => setState(() => _activeSubSection = index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: active ? const Color(0xFFFFE18A) : const Color(0xFFF8EAF1),
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: active ? const Color(0xFFE9C66D) : const Color(0xFFE8C7D8))),
            child: Text(_subSections[index], style: TextStyle(
              color: active ? const Color(0xFF67324E) : const Color(0xFF82506A),
              fontSize: 7, fontWeight: FontWeight.w800)),
          ),
        );
      },
    );
  }

  Widget _attendanceContent() {
    final present = _presentDays, absent = _absentDays, holiday = _holidayDays;
    final tracked = _trackedAttendanceDays;
    final rate = _attendanceRate;
    final holidayRate = _elapsedCalendarDays == 0 ? 0.0 : holiday / _elapsedCalendarDays;
    return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(flex: 7, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(color: const Color(0xFFFFF8FC), borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0xFFF2C9DC)), boxShadow: const [BoxShadow(color: Color(0x44E99ABC), blurRadius: 6)]),
          child: Row(children: [
            SizedBox(width: 66, height: 66, child: CustomPaint(painter: _DonutPainter(value: rate),
              child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(_attendancePercent, style: const TextStyle(color: Color(0xFF3B0D28), fontSize: 17, fontWeight: FontWeight.w900)),
                Text('$present / $tracked', style: const TextStyle(color: Color(0xFF77516A), fontSize: 7, fontWeight: FontWeight.w700)),
                const Text('Days', style: TextStyle(color: Color(0xFF77516A), fontSize: 6)),
              ])))),
            const SizedBox(width: 5),
            Expanded(child: Column(children: [
              _progressLine('Present', '$present', _attendancePercent, const Color(0xFF08A82E), rate),
              _progressLine('Absent', '$absent', tracked == 0 ? '0%' : ((absent / tracked * 100).round().toString() + '%'),
                const Color(0xFFE91E43), tracked == 0 ? 0 : absent / tracked),
              _progressLine('Holiday', '$holiday', _elapsedCalendarDays == 0 ? '0%' : ((holidayRate * 100).round().toString() + '%'),
                const Color(0xFFB000D8), holidayRate),
              _progressLine('Payment', '1 / 1', '100%', const Color(0xFFFFB900), 1),
            ])),
          ]),
        ),
        const SizedBox(height: 5),
        Expanded(child: _calendarCard(fill: true)),
        const SizedBox(height: 3),
        _legend(),
      ])),
      const SizedBox(width: 5),
      SizedBox(width: 78, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _sideInsightCard(icon: Icons.query_stats_rounded, title: 'Monthly Trend',
          child: Column(children: [
            SizedBox(height: 28, child: CustomPaint(painter: _BarsPainter(values: const [.25, .4, .48, .64, .8, .95]))),
            const Text('+6% this month', style: TextStyle(color: Color(0xFF16843B), fontSize: 6, fontWeight: FontWeight.w900)),
          ])),
        const SizedBox(height: 4),
        _sideInsightCard(icon: Icons.local_fire_department_rounded, title: 'Streak',
          child: const Text('5 Days', textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF97004C), fontSize: 11, fontWeight: FontWeight.w900))),
        const SizedBox(height: 4),
        _sideInsightCard(icon: Icons.emoji_events_rounded, title: 'Best',
          child: const Text('14 Days', textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF97004C), fontSize: 10, fontWeight: FontWeight.w900))),
        const Spacer(),
        const Icon(Icons.fitness_center_rounded, color: Color(0xFFEC62A4), size: 25),
      ])),,
    ]);
  }

  Widget _sideInsightCard({required IconData icon, required String title, required Widget child}) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFF9FC), Color(0xFFFFEAF4)]),
        borderRadius: BorderRadius.circular(11), border: Border.all(color: const Color(0xFFF0C5D9)),
        boxShadow: const [BoxShadow(color: Color(0x33E88DB6), blurRadius: 5)]),
      child: Column(children: [
        Icon(icon, color: const Color(0xFFB00059), size: 14),
        const SizedBox(height: 2),
        Text(title, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Color(0xFF6C2949), fontSize: 6.5, fontWeight: FontWeight.w900)),
        const SizedBox(height: 4),
        child,
      ]));
  }

  Widget _progressLine(String label, String count, String percent, Color color, double value) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 2.5), child: Row(children: [
      Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 3),
      SizedBox(width: 31, child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Color(0xFF321222), fontSize: 7, fontWeight: FontWeight.w700))),
      SizedBox(width: 15, child: Text(count, textAlign: TextAlign.end,
        style: const TextStyle(color: Color(0xFF321222), fontSize: 7, fontWeight: FontWeight.w900))),
      const SizedBox(width: 4),
      Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(9),
        child: LinearProgressIndicator(value: value, minHeight: 7,
          backgroundColor: const Color(0xFFE9C8D9), valueColor: AlwaysStoppedAnimation<Color>(color)))),
      const SizedBox(width: 3),
      SizedBox(width: 22, child: Text(percent, textAlign: TextAlign.end,
        style: const TextStyle(color: Color(0xFF321222), fontSize: 6.5, fontWeight: FontWeight.w900))),
    ]));
  }

  Widget _monthlyTrend() {
    return Container(height: 31, padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(color: const Color(0xFFFFF0F6), borderRadius: BorderRadius.circular(9),
        border: Border.all(color: const Color(0xFFEED1DF))),
      child: Row(children: [
        const Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Monthly attendance trend', style: TextStyle(color: Color(0xFF75405D), fontSize: 7, fontWeight: FontWeight.w800)),
            Text('Improving consistency', style: TextStyle(color: Color(0xFF927488), fontSize: 6)),
          ])),
        SizedBox(width: 72, height: 22, child: CustomPaint(
          painter: _BarsPainter(values: const [.25, .42, .5, .65, .77, .94]))),
      ]));
  }

  Widget _calendarCard({bool fill = false}) {
    final first = DateTime(_year, _month, 1);
    final daysInMonth = DateTime(_year, _month + 1, 0).day;
    final offset = first.weekday - 1;
    final monthName = const ['January','February','March','April','May','June','July','August','September','October','November','December'][_month - 1];
    final grid = GridView.builder(
      shrinkWrap: !fill, physics: const NeverScrollableScrollPhysics(), itemCount: 42,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, mainAxisSpacing: 3, crossAxisSpacing: 3, childAspectRatio: 1.28),
      itemBuilder: (context, index) {
        final day = index - offset + 1;
        if (day < 1 || day > daysInMonth) return const SizedBox.shrink();
        final isFuture = _year > _today.year || (_year == _today.year && _month == _today.month && day > _today.day);
        final kind = _days[day] ?? (isFuture ? DayKind.off : DayKind.present);
        final color = switch (kind) {
          DayKind.present => const Color(0xFF08A82E), DayKind.absent => const Color(0xFFE91E43),
          DayKind.holiday => const Color(0xFFB000D8), DayKind.payment => const Color(0xFFFFBB18),
          DayKind.off => const Color(0xFFEAE3E8),
        };
        return Container(
          decoration: BoxDecoration(
            gradient: kind == DayKind.present ? const LinearGradient(colors: [Color(0xFF12BC42), Color(0xFF078D2B)]) : null,
            color: kind == DayKind.present ? null : color, borderRadius: BorderRadius.circular(8),
            border: day == _today.day && _month == _today.month && _year == _today.year
              ? Border.all(color: const Color(0xFF1D743A), width: 1.5) : null,
            boxShadow: kind == DayKind.present ? const [BoxShadow(color: Color(0x3311A93A), blurRadius: 3, offset: Offset(0, 1))] : null),
          alignment: Alignment.center,
          child: kind == DayKind.holiday ? const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 10)
            : kind == DayKind.payment ? const Icon(Icons.currency_rupee_rounded, color: Color(0xFF67450B), size: 10)
            : Text('$day', style: TextStyle(color: kind == DayKind.off ? const Color(0xFF948A91) : Colors.white, fontSize: 7.5, fontWeight: FontWeight.w900)),
        );
      },
    );
    return Container(padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFFCFE), Color(0xFFFFF0F7)]),
        borderRadius: BorderRadius.circular(13), border: Border.all(color: const Color(0xFFF0C8DA)),
        boxShadow: const [BoxShadow(color: Color(0x33E88DB6), blurRadius: 5)]),
      child: Column(children: [
        SizedBox(height: 24, child: Row(children: [
          _monthButton(Icons.chevron_left_rounded, () => _changeMonth(-1)),
          Expanded(child: Center(child: Text(monthName + ' ' + _year.toString(),
            style: const TextStyle(color: Color(0xFF5D1239), fontSize: 8.5, fontWeight: FontWeight.w900)))),
          _monthButton(Icons.chevron_right_rounded, () => _changeMonth(1)),
        ])),
        const SizedBox(height: 2),
        Row(children: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'].map((d) => Expanded(
          child: Center(child: Text(d, style: const TextStyle(color: Color(0xFF805C71), fontSize: 6.5, fontWeight: FontWeight.w900))),
        )).toList()),
        const SizedBox(height: 3),
        if (fill) Expanded(child: grid) else SizedBox(height: 142, child: grid),
      ]));
  }

  Widget _monthButton(IconData icon, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
                color: const Color(0xFFFFE6F3),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFEFB2D0))),
            child: Icon(icon, color: const Color(0xFF8C0045), size: 15)),
      );

  Widget _legend() {
    final items = [
      (const Color(0xFF08A82E), 'Present'), (const Color(0xFFE91E43), 'Absent'),
      (const Color(0xFFB000D8), 'Holiday'), (const Color(0xFFFFBB18), 'Payment'),
    ];
    return Padding(padding: const EdgeInsets.only(top: 2, bottom: 1), child: Wrap(
      alignment: WrapAlignment.center, spacing: 7, runSpacing: 2,
      children: items.map((e) => Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 7, height: 7, decoration: BoxDecoration(color: e.$1, shape: BoxShape.circle)),
        const SizedBox(width: 3),
        Text(e.$2, style: const TextStyle(color: Color(0xFF371426), fontSize: 6.5, fontWeight: FontWeight.w800)),
      ])).toList(),
    ));
  }

  Widget _sectionContent() {
    if (_activeSection == 0) return _activeSubSection == 1 ? _dashboardActivityContent() : _attendanceContent();
    if (_activeSection == 1) return _attendanceSubContent();
    return _alternateContent();
  }

  Widget _dashboardActivityContent() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _sectionCard('Today · member activity', Column(children: [
        _metricRow('Check-in', '07:12 AM · Completed', const Color(0xFF16A653)),
        _metricRow('Workout', '58 min · Completed', const Color(0xFF9860C5)),
        _metricRow('Payment', '₹500 · Due soon', const Color(0xFFE0A52D)),
        _metricRow('Membership', '$_membershipDaysLeft days left', const Color(0xFFB84E80)),
      ])),
      const SizedBox(height: 5),
      _sectionCard('This month at a glance', Row(children: [
        _miniValue('Attendance', _attendancePercent, const Color(0xFF16A653)),
        const SizedBox(width: 5),
        _miniValue('Sessions', '18', const Color(0xFF9860C5)),
        const SizedBox(width: 5),
        _miniValue('Streak', '5 days', const Color(0xFFB84E80)),
      ])),
    ]);
  }

  List<String> get _subSections => const [
        ['Overview', 'Activity'],
        ['Overview', 'Calendar', 'Trends', 'Streak'],
        ['Overview', 'Last 7 days', 'Muscle groups', 'Consistency'],
        ['Overview', 'Transactions', 'Due & Offers'],
        ['Available', 'Early-pay', 'Rewards'],
        ['Timeline', 'Check-ins', 'Payments'],
        ['Overview', 'Composition', 'Measurements', 'Progress'],
      ][_activeSection];

  Widget _attendanceSubContent() {
    switch (_activeSubSection) {
      case 1:
        return Column(children: [_calendarCard(), const SizedBox(height: 6), _legend()]);
      case 2:
        return Column(children: [
          _attendanceAnalytics(),
          _monthlyTrend(),
        ]);
      case 3:
        return _sectionCard('Attendance streaks', Column(children: [
          _metricRow('Current streak', '5 days', const Color(0xFF08B72B)),
          _metricRow('Best streak', '14 days', const Color(0xFFB000E8)),
          _metricRow('Present this month', '$_presentDays of $_trackedAttendanceDays days', const Color(0xFF08B72B)),
          _metricRow('Late arrivals', '2 this month', const Color(0xFFFFBD16)),
        ]));
      default:
        return _attendanceContent();
    }
  }

  Widget _attendanceAnalytics() {
    final present = _presentDays;
    final absent = _absentDays;
    final holiday = _holidayDays;
    final tracked = _trackedAttendanceDays;
    final rate = _attendanceRate;
    final holidayRate = _elapsedCalendarDays == 0
        ? 0.0
        : holiday / _elapsedCalendarDays;
    return Row(children: [
      SizedBox(
        width: 82,
        height: 82,
        child: CustomPaint(
          painter: _DonutPainter(value: rate),
          child: Center(
            child: Text(_attendancePercent,
                style: const TextStyle(
                    color: Color(0xFF280B1B),
                    fontSize: 21,
                    fontWeight: FontWeight.w900)),
          ),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(child: Column(children: [
        _progressLine('Present', '$present', _attendancePercent,
            const Color(0xFF08B82B), rate),
        _progressLine(
            'Absent',
            '$absent',
            tracked == 0 ? '0%' : '${(absent / tracked * 100).round()}%',
            const Color(0xFFE91D3D),
            tracked == 0 ? 0 : absent / tracked),
        _progressLine(
            'Holiday',
            '$holiday',
            _elapsedCalendarDays == 0
                ? '0%'
                : '${(holidayRate * 100).round()}%',
            const Color(0xFFB100E8),
            holidayRate),
        _progressLine('Payment', '1 / 1', '100%',
            const Color(0xFFFFBD16), 1),
      ])),
    ]);
  }

  Widget _sectionCard(String title, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8FC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEED1DF)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(
              color: Color(0xFF67324E), fontSize: 8, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }

  Widget _metricRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(
            color: color, shape: BoxShape.circle)),
        const SizedBox(width: 7),
        Expanded(child: Text(label, style: const TextStyle(
            color: Color(0xFF4D2639), fontSize: 9, fontWeight: FontWeight.w600))),
        Text(value, style: TextStyle(
            color: color, fontSize: 10, fontWeight: FontWeight.w900)),
      ]),
    );
  }

  Widget _barChart(List<double> values, {double height = 86}) {
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: values.map((value) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: ((height - 8) * value.clamp(.05, 1)).toDouble(),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xFFE50062), Color(0xFFFF8BC2)],
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _alternateContent() {
    switch (_activeSection) {
      case 2:
        return _workoutContent();
      case 3:
        return _paymentContent();
      case 4:
        return _offersContent();
      case 5:
        return _historyContent();
      case 6:
        return _bodyContent();
      default:
        return _attendanceContent();
    }
  }

  Widget _workoutContent() {
    final titles = ['Workout performance','Workout minutes · last 7 days','Muscle group balance','Workout consistency · 30 days'];
    final values = switch (_activeSubSection) {
      1 => const [.35, .52, .42, .8, .62, .9, .72],
      2 => const [.8, .55, .9, .65, .72, .45, .84],
      3 => const [.45, .55, .62, .58, .72, .82, .9],
      _ => const [.35, .52, .42, .8, .62, .9, .72],
    };
    final metric = switch (_activeSubSection) {
      1 => ('Last 7 days', '406 min', 'Daily average', '58 min'),
      2 => ('Top muscle group', 'Legs', 'Balance score', '82%'),
      3 => ('Active days', '18 / 30', 'Current streak', '5 days'),
      _ => ('Today', '58 min', 'Change', '+12%'),
    };
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _sectionCard(titles[_activeSubSection], Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          _miniValue(metric.$1, metric.$2, const Color(0xFF16A653)),
          const SizedBox(width: 5),
          _miniValue(metric.$3, metric.$4, const Color(0xFF9860C5)),
        ]),
        const SizedBox(height: 4),
        _barChart(values, height: 48),
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('M', style: TextStyle(color: Color(0xFF765467), fontSize: 6)),
          Text('T', style: TextStyle(color: Color(0xFF765467), fontSize: 6)),
          Text('W', style: TextStyle(color: Color(0xFF765467), fontSize: 6)),
          Text('T', style: TextStyle(color: Color(0xFF765467), fontSize: 6)),
          Text('F', style: TextStyle(color: Color(0xFF765467), fontSize: 6)),
          Text('S', style: TextStyle(color: Color(0xFF765467), fontSize: 6)),
          Text('S', style: TextStyle(color: Color(0xFF765467), fontSize: 6)),
        ]),
      ])),
      const SizedBox(height: 5),
      _sectionCard('Training summary', Column(children: [
        _metricRow('Strength training', '4 sessions', const Color(0xFFB84E80)),
        _metricRow('Cardio', '2 sessions', const Color(0xFF16A653)),
        _metricRow('Rest / recovery', '1 day', const Color(0xFF9860C5)),
      ])),
    ]);
  }

  Widget _paymentContent() {
    final dueLabel = _paymentDueInDays > 0 ? 'Due in $_paymentDueInDays days'
        : _paymentDueInDays == 0 ? 'Due today' : 'Overdue by ' + (-_paymentDueInDays).toString() + ' days';
    final savingsText = _earlyPaymentSavings == _earlyPaymentSavings.roundToDouble()
        ? _earlyPaymentSavings.toStringAsFixed(0) : _earlyPaymentSavings.toStringAsFixed(2);
    final overdueDays = (-_paymentDueInDays).clamp(0, 999);
    final lateFee = overdueDays <= 3 ? 0 : overdueDays <= 10 ? 10 : overdueDays <= 20 ? 20 : 30;
    if (_activeSubSection == 1) {
      return _sectionCard('Recent transactions', Column(children: [
        _metricRow(_formatDate(_today.subtract(const Duration(days: 15))) + ' · Membership', '₹4,500 paid', const Color(0xFF08A82E)),
        _metricRow(_formatDate(_today) + ' · Monthly fee', '₹500 due', const Color(0xFFE91E43)),
        _metricRow('Next reminder · ' + _formatDate(_paymentDueDate), dueLabel, const Color(0xFF9B0050)),
      ]));
    }
    if (_activeSubSection == 2) {
      return Column(children: [
        _sectionCard('Due date & early-pay offer', Column(children: [
          Row(children: [
            _miniValue('Outstanding', '₹500', const Color(0xFFE91E43)),
            const SizedBox(width: 5),
            _miniValue('Potential saving', '₹' + savingsText, const Color(0xFF08A82E)),
          ]),
          const SizedBox(height: 4),
          _metricRow('Due date', _formatDate(_paymentDueDate), const Color(0xFF9B0050)),
          _metricRow('Status', dueLabel, const Color(0xFFE0A52D)),
          _metricRow('Current late fee', '₹' + lateFee.toString(), lateFee == 0 ? const Color(0xFF08A82E) : const Color(0xFFE91E43)),
        ])),
        const SizedBox(height: 5),
        _sectionCard('Transparent payment policy', Column(children: [
          _metricRow('7+ days early', '2% OFF', const Color(0xFF08A82E)),
          _metricRow('3–6 days early', '1% OFF', const Color(0xFF08A82E)),
          _metricRow('1–2 days early', '0.5% OFF', const Color(0xFFE0A52D)),
          _metricRow('Due date', 'No discount', const Color(0xFF9B0050)),
          _metricRow('1–3 days late', 'Grace period', const Color(0xFF08A82E)),
          _metricRow('4–10 days late', '₹10 fee', const Color(0xFFE0A52D)),
          _metricRow('11–20 days late', '₹20 fee', const Color(0xFFE91E43)),
          _metricRow('21+ days late', '₹30 fee', const Color(0xFFE91E43)),
        ])),
        const Padding(padding: EdgeInsets.only(top: 3),
          child: Text('Illustrative policy · Gym owner can configure or disable late fees',
            textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF805C71), fontSize: 6))),
      ]);
    }
    return Column(children: [
      _sectionCard('Payment overview', Column(children: [
        Row(children: [
          _miniValue('Outstanding', '₹500', const Color(0xFFE91E43)),
          const SizedBox(width: 5),
          _miniValue('Last payment', '₹4,500', const Color(0xFF08A82E)),
        ]),
        const SizedBox(height: 4),
        _metricRow('Next payment', dueLabel, const Color(0xFFE91E43)),
        _metricRow('Early-pay reward', _earlyPaymentRate > 0 ? 'Save ₹' + savingsText : 'No discount', const Color(0xFF08A82E)),
        _metricRow('Late fee', lateFee == 0 ? '₹0 · Grace period' : '₹' + lateFee.toString(), lateFee == 0 ? const Color(0xFF08A82E) : const Color(0xFFE91E43)),
      ])),
      const SizedBox(height: 5),
      _sectionCard('Early payment rewards', Column(children: [
        _metricRow('7+ days early', '2% · ₹10', const Color(0xFF08A82E)),
        _metricRow('3–6 days early', '1% · ₹5', const Color(0xFF08A82E)),
        _metricRow('1–2 days early', '0.5% · ₹2.50', const Color(0xFFE0A52D)),
      ])),
    ]);
  }

  Widget _offersContent() {
    final title = _activeSubSection == 1 ? 'Pay early, save more' : _activeSubSection == 2 ? 'Member rewards' : 'Available member offers';
    if (_activeSubSection == 2) {
      return _sectionCard(title, Column(children: [
        _metricRow('Current reward tier', 'Gold', const Color(0xFFE0A52D)),
        _metricRow('Reward points', '420 pts', const Color(0xFF9860C5)),
        _metricRow('Next reward', '500 pts', const Color(0xFF16A653)),
        const SizedBox(height: 5),
        LinearProgressIndicator(value: .84, minHeight: 6, borderRadius: BorderRadius.circular(8),
          backgroundColor: const Color(0xFFEEDDE6),
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE0B443))),
      ]));
    }
    return _sectionCard(title, Column(children: [
      _metricRow('7+ days before due date', '2% OFF', const Color(0xFF16A653)),
      _metricRow('3–6 days before due date', '1% OFF', const Color(0xFF16A653)),
      _metricRow('1–2 days before due date', '0.5% OFF', const Color(0xFFE0A52D)),
      _metricRow('On / after due date', '0% OFF', const Color(0xFFE34D65)),
      const SizedBox(height: 5),
      Container(width: double.infinity, padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: const Color(0xFFFFEAF3), borderRadius: BorderRadius.circular(8)),
        child: Text(_activeSubSection == 1
          ? 'Current offer: pay in $_paymentDueInDays days and save ₹${_earlyPaymentSavings.toStringAsFixed(0)}'
          : 'Offers available with your active Gold membership',
          style: const TextStyle(color: Color(0xFF75405D), fontSize: 7, fontWeight: FontWeight.w800))),
    ]));
  }

  Widget _bodyContent() {
    if (_activeSubSection == 2) {
      return _sectionCard('Measurement tracking', Column(children: [
        _metricRow('Chest', '98 cm  ·  +2 cm', const Color(0xFF16A653)),
        _metricRow('Waist', '82 cm  ·  −1 cm', const Color(0xFF16A653)),
        _metricRow('Arms', '34 cm  ·  +1 cm', const Color(0xFF9860C5)),
        _metricRow('Thigh', '56 cm  ·  +1 cm', const Color(0xFFB84E80)),
      ]));
    }
    if (_activeSubSection == 3) {
      return _sectionCard('Body progress · 90 days', Column(children: [
        Row(children: [
          _miniValue('Weight change', '−1.8 kg', const Color(0xFF16A653)),
          const SizedBox(width: 5),
          _miniValue('Body fat', '−1.2%', const Color(0xFF9860C5)),
        ]),
        const SizedBox(height: 5),
        _barChart(const [.92, .88, .82, .79, .73, .69, .62], height: 58),
        const Text('Trend across the last 7 check-ins', style: TextStyle(color: Color(0xFF765467), fontSize: 7)),
      ]));
    }
    return _sectionCard(_activeSubSection == 1 ? 'Body composition' : 'Body intelligence',
      Column(children: [
        Row(children: [
          _miniValue('Weight', '69.5 kg', const Color(0xFF16A653)),
          const SizedBox(width: 5),
          _miniValue('Body fat', '18.4%', const Color(0xFFB84E80)),
        ]),
        const SizedBox(height: 5),
        Row(children: [
          _miniValue('Muscle mass', '54.2 kg', const Color(0xFF9860C5)),
          const SizedBox(width: 5),
          _miniValue('BMI', '23.4', const Color(0xFF16A653)),
        ]),
        const SizedBox(height: 5),
        _barChart(const [.82, .78, .75, .72, .69, .66, .62], height: 44),
      ]));
  }

  Widget _historyContent() {
    final lastPaymentDate = _formatDate(_today.subtract(const Duration(days: 15)));
    final paymentDueDate = _formatDate(_paymentDueDate);
    final membershipExpiry = _formatDate(_membershipExpiryDate);
    final events = _activeSubSection == 1
        ? [
            ('Check-in', 'Today · 07:12 AM', 'Completed'),
            ('Check-out', 'Yesterday · 08:05 AM', 'Completed'),
          ]
        : _activeSubSection == 2
            ? [
                ('Payment', lastPaymentDate, '₹4,500 received'),
                ('Payment due', paymentDueDate, '₹500 pending'),
              ]
            : [
                ('Check-in', 'Today · 07:12 AM', 'Completed'),
                ('Workout', 'Today · 07:50 AM', '58 minutes'),
                ('Payment', lastPaymentDate, '₹4,500 received'),
                ('Membership', membershipExpiry, 'Expires'),
              ];
    return _sectionCard(
      'Member activity timeline',
      Column(
        children: events
            .map((event) => _metricRow(
                '${event.$1} · ${event.$2}',
                event.$3,
                const Color(0xFF08A82B)))
            .toList(),
      ),
    );
  }

  Widget _miniValue(String label, String value, Color color) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEDF4),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFF765467), fontSize: 7)),
          Text(value, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w900)),
        ],
      ),
    ),
  );

}

enum DayKind { present, absent, holiday, payment, off }

class _DonutPainter extends CustomPainter {
  _DonutPainter({required this.value});
  final double value;
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final stroke = size.width * .105;
    final base = Paint()
      ..color = const Color(0xFFFFCDE5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    final progress = Paint()
      ..shader =
          const SweepGradient(colors: [Color(0xFF00C92B), Color(0xFF078E25)])
              .createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    final r = (size.width - stroke) / 2;
    canvas.drawCircle(size.center(Offset.zero), r, base);
    canvas.drawArc(Rect.fromCircle(center: size.center(Offset.zero), radius: r),
        -math.pi / 2, math.pi * 2 * value, false, progress);
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) =>
      oldDelegate.value != value;
}

class _BarsPainter extends CustomPainter {
  _BarsPainter({required this.values});
  final List<double> values;
  @override
  void paint(Canvas canvas, Size size) {
    final gap = size.width * .035;
    final barWidth = (size.width - gap * (values.length - 1)) / values.length;
    final paint = Paint()
      ..shader = const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xFF0AB52D), Color(0xFF70E65B)])
          .createShader(Offset.zero & size);
    for (var i = 0; i < values.length; i++) {
      final height = size.height * values[i];
      final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(
              i * (barWidth + gap), size.height - height, barWidth, height),
          const Radius.circular(3));
      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BarsPainter oldDelegate) =>
      oldDelegate.values != values;
}
