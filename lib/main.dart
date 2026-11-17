import 'dart:math' as math;
import 'package:flutter/material.dart';

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
        scaffoldBackgroundColor: const Color(0xFFFFEAF5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE50062),
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
  static const _pink = Color(0xFFFFE8F4);
  static const _magenta = Color(0xFFD90058);
  static const _deep = Color(0xFF71002F);
  static const _green = Color(0xFF08B92B);
  static const _gold = Color(0xFFFFC928);
  int _activeSection = 1;
  int _month = 10;
  int _year = 2026;

  final Map<int, DayKind> _days = {
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

  String get _sectionTitle => const [
        'Dashboard',
        'Attendance Intelligence',
        'Workout Intelligence',
        'Payment Intelligence',
        'Offers & Rewards',
        'Member History',
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
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth - 16 < 540
                ? constraints.maxWidth - 16
                : 540.0;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 18),
              child: Center(
                child: SizedBox(
                  width: width,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF9B003F),
                          Color(0xFF69002F),
                          Color(0xFFB50050)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      border:
                          Border.all(color: const Color(0xFFFFB8DE), width: 2),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x66C00062),
                            blurRadius: 24,
                            offset: Offset(0, 10)),
                        BoxShadow(
                            color: Colors.white,
                            blurRadius: 2,
                            spreadRadius: 1),
                      ],
                    ),
                    padding: const EdgeInsets.all(9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _eventHeader(),
                        const SizedBox(height: 5),
                        _memberHero(),
                        const SizedBox(height: 10),
                        _paymentAndExpiry(),
                        const SizedBox(height: 8),
                        _membershipProgress(),
                        const SizedBox(height: 12),
                        _promotionBanner(),
                        const SizedBox(height: 10),
                        _quickMetrics(),
                        const SizedBox(height: 12),
                        _intelligenceWorkspace(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _eventHeader() {
    return SizedBox(
      height: 62,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFFFB006B), Color(0xFF8E003F)]),
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(22), right: Radius.circular(22)),
                border: Border.all(color: const Color(0xFFFFA5D1), width: 1.4),
                boxShadow: const [
                  BoxShadow(color: Color(0x99FF2D91), blurRadius: 12)
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Row(
                children: [
                  Container(
                    width: 39,
                    height: 39,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF05C72C),
                      boxShadow: [
                        BoxShadow(color: Color(0xAA00FF35), blurRadius: 13)
                      ],
                    ),
                    child: const Icon(Icons.check_rounded,
                        color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text('CHECK-IN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800,
                                    height: 1))),
                        SizedBox(height: 4),
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text('Completed · 07:12 AM',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w500))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFFFFE6F5), Color(0xFFFFB7DE)]),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFFFF3FA), width: 1.5),
                boxShadow: const [
                  BoxShadow(color: Color(0x88FF91C9), blurRadius: 12)
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                children: [
                  const Icon(Icons.ac_unit_rounded,
                      color: Color(0xFF850052), size: 31),
                  const SizedBox(width: 4),
                  const Expanded(
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text('FREEZE\nMEMBER',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF740044),
                                  fontSize: 17,
                                  height: 1.02,
                                  fontWeight: FontWeight.w800)))),
                  Container(
                    width: 37,
                    height: 37,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF850044),
                        boxShadow: [
                          BoxShadow(color: Color(0x66900050), blurRadius: 8)
                        ]),
                    child: const Icon(Icons.notifications_none_rounded,
                        color: Colors.white, size: 22),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _memberHero() {
    return SizedBox(
      height: 174,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 4,
            top: 13,
            bottom: 4,
            width: 142,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                border: Border.all(color: const Color(0xFFFF68B6), width: 1.4),
                boxShadow: const [
                  BoxShadow(color: Color(0x88FF3E9D), blurRadius: 14)
                ],
              ),
            ),
          ),
          Positioned(
            left: -2,
            bottom: 0,
            width: 154,
            height: 174,
            child: Image.asset(
              'assets/images/avatar_ashwani_hq.png',
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
              errorBuilder: (_, __, ___) => const Center(
                child: Icon(Icons.person, color: Colors.white70, size: 100),
              ),
            ),
          ),
          Positioned(
            left: 145,
            right: 7,
            top: 10,
            bottom: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Welcome Back 👋',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                const Text('Ashwani Kumar Singh',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        height: 1.08,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                const Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 7,
                  children: [
                    Icon(Icons.calendar_month_rounded,
                        color: Colors.white, size: 17),
                    Text('BG215',
                        style: TextStyle(color: Colors.white, fontSize: 11)),
                    Text('|', style: TextStyle(color: Colors.white70)),
                    Icon(Icons.person_outline_rounded,
                        color: Colors.white, size: 17),
                    Text('28 Yrs',
                        style: TextStyle(color: Colors.white, fontSize: 11)),
                    Text('|', style: TextStyle(color: Colors.white70)),
                    Icon(Icons.male_rounded,
                        color: Color(0xFF13D8FF), size: 20),
                    Text('Male',
                        style: TextStyle(color: Colors.white, fontSize: 11)),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    _pill('👑  Gold Plan', const Color(0xFFFFC928),
                        const Color(0xFF542300)),
                    const SizedBox(width: 7),
                    _pill('✓  Active', const Color(0xFF09C92D), Colors.white),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(String text, Color color, Color foreground) => Expanded(
        child: Container(
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: color.withOpacity(.35),
                  blurRadius: 9,
                  offset: const Offset(0, 3))
            ],
          ),
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(text,
                  style: TextStyle(
                      color: foreground,
                      fontSize: 12,
                      fontWeight: FontWeight.w800))),
        ),
      );

  Widget _paymentAndExpiry() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFFFFEAF5), Color(0xFFFFC9E5)]),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white, width: 1.3),
      ),
      child: Row(
        children: [
          const Icon(Icons.account_balance_wallet_rounded,
              color: Color(0xFFD90058), size: 29),
          const SizedBox(width: 6),
          const Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('Payment',
                    style: TextStyle(
                        color: Color(0xFF4C1730),
                        fontSize: 10,
                        fontWeight: FontWeight.w600)),
                Text('₹500 Due',
                    style: TextStyle(
                        color: Color(0xFFB00035),
                        fontSize: 16,
                        height: 1.1,
                        fontWeight: FontWeight.w800)),
              ])),
          Container(width: 1, height: 42, color: const Color(0xFFB96B91)),
          const SizedBox(width: 8),
          const Icon(Icons.event_available_rounded,
              color: Color(0xFFD90058), size: 29),
          const SizedBox(width: 6),
          const Expanded(
              flex: 2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('8 Days Left',
                        style: TextStyle(
                            color: Color(0xFFB00035),
                            fontSize: 15,
                            fontWeight: FontWeight.w800)),
                    Text('Expires: 24 Oct 2026',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color(0xFF321322),
                            fontSize: 9.5,
                            fontWeight: FontWeight.w500)),
                  ])),
          Container(width: 1, height: 42, color: const Color(0xFFB96B91)),
          const SizedBox(width: 7),
          const _QrMark(size: 42),
        ],
      ),
    );
  }

  Widget _membershipProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          const Expanded(
              child: Text('Membership 22 / 30 Days',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w800))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
                color: const Color(0xFFFFD4EC),
                borderRadius: BorderRadius.circular(22)),
            child: const Text('73%',
                style: TextStyle(
                    color: Color(0xFF72003C),
                    fontSize: 16,
                    fontWeight: FontWeight.w900)),
          ),
        ]),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 12,
            color: const Color(0xFFFFD9EF),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
                widthFactor: .73,
                child: Container(
                    decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFFF54B1), Color(0xFFE00075)]),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ))),
          ),
        ),
      ],
    );
  }

  Widget _promotionBanner() {
    return Container(
      height: 57,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFFFFD52B), Color(0xFFFFF4A6), Color(0xFFFFB900)]),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFFFF4C6), width: 1.6),
        boxShadow: const [
          BoxShadow(
              color: Color(0x88FFB800), blurRadius: 9, offset: Offset(0, 3))
        ],
      ),
      child: Row(children: [
        const Expanded(
            flex: 3,
            child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text('amazon',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.2)))),
        Container(width: 1, height: 37, color: const Color(0xFF8E5310)),
        const SizedBox(width: 8),
        const Expanded(
            flex: 5,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text('Big Billion Sale',
                          style: TextStyle(
                              color: Color(0xFF9B002E),
                              fontSize: 17,
                              fontWeight: FontWeight.w900))),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text('Up to 40% OFF · Fitness Gear',
                          style: TextStyle(
                              color: Color(0xFF301321),
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700))),
                ])),
        const Icon(Icons.fitness_center_rounded,
            color: Color(0xFF442331), size: 30),
        const SizedBox(width: 4),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
            decoration: BoxDecoration(
                color: const Color(0xFFCE003C),
                borderRadius: BorderRadius.circular(20)),
            child: const Text('Shop Now ›',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w800))),
      ]),
    );
  }

  Widget _quickMetrics() {
    final items = [
      (
        Icons.calendar_month_rounded,
        'Attendance',
        '81%',
        '+6%',
        const Color(0xFFFFC928),
        const Color(0xFF087F25)
      ),
      (
        Icons.fitness_center_rounded,
        'Workout',
        '58 min',
        '+12%',
        const Color(0xFFEA0068),
        Colors.white
      ),
      (
        Icons.account_balance_wallet_rounded,
        'Payment',
        '₹500 Due',
        'SBI offer',
        const Color(0xFFEA0068),
        Colors.white
      ),
      (
        Icons.monitor_weight_rounded,
        'Body',
        '69.5 kg',
        '−0.8 kg',
        const Color(0xFFEA0068),
        Colors.white
      ),
    ];
    return SizedBox(
      height: 61,
      child: Row(
        children: List.generate(items.length, (i) {
          final item = items[i];
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _activeSection = i == 0
                  ? 1
                  : i == 1
                      ? 2
                      : i == 2
                          ? 3
                          : 0),
              child: Container(
                margin: EdgeInsets.only(right: i == 3 ? 0 : 5),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: item.$5 == _gold
                          ? [const Color(0xFFFFE65B), const Color(0xFFFFBE16)]
                          : [const Color(0xFFE90068), const Color(0xFF9B004A)]),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFFFFA9D2), width: 1),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x7783003C),
                        blurRadius: 7,
                        offset: Offset(0, 3))
                  ],
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item.$1,
                          color: item.$5 == _gold
                              ? const Color(0xFF7D1634)
                              : Colors.white,
                          size: 17),
                      FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(item.$2,
                              style: TextStyle(
                                  color: item.$5 == _gold
                                      ? const Color(0xFF381321)
                                      : Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700))),
                      FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(item.$3,
                              style: TextStyle(
                                  color: item.$5 == _gold
                                      ? const Color(0xFF087F25)
                                      : Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900))),
                      FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(item.$4,
                              style: TextStyle(
                                  color: item.$5 == _gold
                                      ? const Color(0xFF087F25)
                                      : const Color(0xFFFFC4E2),
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700))),
                    ]),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _intelligenceWorkspace() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _verticalRail(),
        const SizedBox(width: 5),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFF4FA),
                    Color(0xFFFFDDED),
                    Color(0xFFFFF8FC)
                  ]),
              borderRadius: BorderRadius.circular(23),
              border: Border.all(color: const Color(0xFFFFB7D8), width: 1.4),
              boxShadow: const [
                BoxShadow(
                    color: Color(0x6695004A),
                    blurRadius: 10,
                    offset: Offset(0, 4))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _workspaceHeader(),
                const SizedBox(height: 8),
                if (_activeSection == 1 || _activeSection == 0)
                  _attendanceContent()
                else
                  _alternateContent(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _verticalRail() {
    const labels = [
      'Dashboard',
      'Attendance',
      'Workout',
      'Payments',
      'Offers',
      'History'
    ];
    const icons = [
      Icons.dashboard_rounded,
      Icons.calendar_month_rounded,
      Icons.fitness_center_rounded,
      Icons.account_balance_wallet_rounded,
      Icons.sell_rounded,
      Icons.history_rounded
    ];
    return Container(
      width: 61,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE60062), Color(0xFF870039), Color(0xFFC00055)]),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: const Color(0xFFFFA8D1), width: 1.4),
        boxShadow: const [
          BoxShadow(
              color: Color(0x77850042), blurRadius: 10, offset: Offset(0, 4))
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(labels.length, (i) {
          final active = _activeSection == i;
          return GestureDetector(
            onTap: () => setState(() => _activeSection = i),
            child: Container(
              height: 61,
              margin: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                color: active ? const Color(0xFFFFD12D) : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                border: active
                    ? Border.all(color: const Color(0xFFFFF1A8), width: 1.2)
                    : null,
                boxShadow: active
                    ? const [BoxShadow(color: Color(0xAAFFC928), blurRadius: 9)]
                    : null,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icons[i],
                        color: active ? const Color(0xFF7B1235) : Colors.white,
                        size: 21),
                    const SizedBox(height: 2),
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(labels[i],
                            style: TextStyle(
                                color: active
                                    ? const Color(0xFF421023)
                                    : Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w700))),
                  ]),
            ),
          );
        }),
      ),
    );
  }

  Widget _workspaceHeader() {
    return Row(children: [
      Container(
          width: 35,
          height: 35,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Color(0xFFFF2B85), Color(0xFF970047)]),
              boxShadow: [BoxShadow(color: Color(0x669D004C), blurRadius: 7)]),
          child: const Icon(Icons.bar_chart_rounded,
              color: Colors.white, size: 24)),
      const SizedBox(width: 6),
      Expanded(
          child: Text(_sectionTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Color(0xFF590027),
                  fontSize: 13,
                  height: 1.05,
                  fontWeight: FontWeight.w900))),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFFFFE36A), Color(0xFFFFC21A)]),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: const Column(children: [
          Text('Co-powered by',
              style: TextStyle(
                  color: Color(0xFF4B2410),
                  fontSize: 6.5,
                  fontWeight: FontWeight.w700)),
          Text('blinkit',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  height: 1,
                  fontWeight: FontWeight.w900)),
        ]),
      ),
    ]);
  }

  Widget _attendanceContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          SizedBox(
              width: 88,
              height: 88,
              child: CustomPaint(
                painter: _DonutPainter(value: 25 / 31),
                child: const Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('81%',
                      style: TextStyle(
                          color: Color(0xFF280B1B),
                          fontSize: 23,
                          fontWeight: FontWeight.w900)),
                  Text('25 / 31',
                      style: TextStyle(
                          color: Color(0xFF280B1B),
                          fontSize: 9,
                          fontWeight: FontWeight.w700)),
                  Text('Days',
                      style: TextStyle(color: Color(0xFF280B1B), fontSize: 9)),
                ])),
              )),
          const SizedBox(width: 8),
          Expanded(
              child: Column(children: [
            _progressLine('Present', '25', '81%', const Color(0xFF08B82B), .81),
            _progressLine('Absent', '2', '6%', const Color(0xFFE91D3D), .06),
            _progressLine('Holiday', '4', '13%', const Color(0xFFB100E8), .13),
            _progressLine(
                'Payment', '1 / 1', '100%', const Color(0xFFFFBD16), 1),
          ])),
        ]),
        const SizedBox(height: 8),
        _monthlyTrend(),
        const SizedBox(height: 8),
        _calendarCard(),
        const SizedBox(height: 7),
        _legend(),
      ],
    );
  }

  Widget _progressLine(
      String label, String count, String percent, Color color, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(children: [
        Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 5),
        SizedBox(
            width: 48,
            child: Text(label,
                style: const TextStyle(
                    color: Color(0xFF321222),
                    fontSize: 8.5,
                    fontWeight: FontWeight.w600))),
        SizedBox(
            width: 23,
            child: Text(count,
                textAlign: TextAlign.end,
                style: const TextStyle(
                    color: Color(0xFF321222),
                    fontSize: 9,
                    fontWeight: FontWeight.w800))),
        const SizedBox(width: 5),
        Expanded(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                    value: value,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFE9C8D9),
                    valueColor: AlwaysStoppedAnimation<Color>(color)))),
        const SizedBox(width: 4),
        SizedBox(
            width: 27,
            child: Text(percent,
                textAlign: TextAlign.end,
                style: const TextStyle(
                    color: Color(0xFF321222),
                    fontSize: 8.5,
                    fontWeight: FontWeight.w800))),
      ]),
    );
  }

  Widget _monthlyTrend() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.78),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFF4C4DE))),
      child: Row(children: [
        const Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Monthly Trend',
              style: TextStyle(
                  color: Color(0xFF870044),
                  fontSize: 10,
                  fontWeight: FontWeight.w800)),
          SizedBox(height: 2),
          Text('Attendance consistency',
              style: TextStyle(color: Color(0xFF7C6270), fontSize: 7.5)),
          Text('↑ 6%  vs last month',
              style: TextStyle(
                  color: Color(0xFF078C28),
                  fontSize: 8,
                  fontWeight: FontWeight.w800)),
        ])),
        SizedBox(
            width: 105,
            height: 43,
            child: CustomPaint(
                painter:
                    _BarsPainter(values: const [.25, .42, .5, .65, .77, .94]))),
      ]),
    );
  }

  Widget _calendarCard() {
    final first = DateTime(_year, _month, 1);
    final daysInMonth = DateTime(_year, _month + 1, 0).day;
    final offset = first.weekday - 1;
    final monthName = const [
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
      'December'
    ][_month - 1];
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.72),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFF0C2D9))),
      child: Column(children: [
        Row(children: [
          _monthButton(Icons.chevron_left_rounded, () => _changeMonth(-1)),
          Expanded(
              child: Center(
                  child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
            decoration: BoxDecoration(
                color: const Color(0xFFFFE6F3),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFEFB2D0))),
            child: Text('$monthName $_year',
                style: const TextStyle(
                    color: Color(0xFF5E1434),
                    fontSize: 10,
                    fontWeight: FontWeight.w800)),
          ))),
          _monthButton(Icons.chevron_right_rounded, () => _changeMonth(1)),
        ]),
        const SizedBox(height: 7),
        Row(
          children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
              .map((d) => Expanded(
                  child: Center(
                      child: Text(d,
                          style: const TextStyle(
                              color: Color(0xFF5A1A38),
                              fontSize: 8,
                              fontWeight: FontWeight.w800)))))
              .toList(),
        ),
        const SizedBox(height: 5),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ((offset + daysInMonth + 6) ~/ 7) * 7,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 3,
              childAspectRatio: 1.22),
          itemBuilder: (context, index) {
            final day = index - offset + 1;
            if (day < 1 || day > daysInMonth) return const SizedBox.shrink();
            final kind = _month == 10 && _year == 2026
                ? (_days[day] ?? DayKind.present)
                : DayKind.present;
            final color = switch (kind) {
              DayKind.present => const Color(0xFF08B72B),
              DayKind.absent => const Color(0xFFEF233C),
              DayKind.holiday => const Color(0xFFB000E8),
              DayKind.payment => const Color(0xFFFFBD16),
            };
            return Container(
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(18),
                  border: day == 22 && _month == 10
                      ? Border.all(color: const Color(0xFF078B25), width: 2)
                      : null,
                  boxShadow: [
                    BoxShadow(
                        color: color.withOpacity(.18),
                        blurRadius: 3,
                        offset: const Offset(0, 1))
                  ]),
              alignment: Alignment.center,
              child: kind == DayKind.holiday
                  ? const Icon(Icons.calendar_month_rounded,
                      color: Colors.white, size: 12)
                  : kind == DayKind.payment
                      ? const Icon(Icons.currency_rupee_rounded,
                          color: Color(0xFF553100), size: 12)
                      : Text('$day',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w900)),
            );
          },
        ),
      ]),
    );
  }

  Widget _monthButton(IconData icon, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
            width: 29,
            height: 29,
            decoration: BoxDecoration(
                color: const Color(0xFFFFE6F3),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFEFB2D0))),
            child: Icon(icon, color: const Color(0xFF8C0045), size: 20)),
      );

  Widget _legend() {
    final items = [
      (const Color(0xFF08B72B), 'Present'),
      (const Color(0xFFEF233C), 'Absent'),
      (const Color(0xFFB000E8), 'Holiday'),
      (const Color(0xFFFFBD16), 'Payment'),
    ];
    return Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 4,
        children: items
            .map((e) => Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                      width: 8,
                      height: 8,
                      decoration:
                          BoxDecoration(color: e.$1, shape: BoxShape.circle)),
                  const SizedBox(width: 3),
                  Text(e.$2,
                      style: const TextStyle(
                          color: Color(0xFF371426),
                          fontSize: 7.5,
                          fontWeight: FontWeight.w600)),
                ]))
            .toList());
  }

  Widget _alternateContent() {
    final title = _activeSection == 2
        ? 'Workout minutes · last 7 days'
        : _activeSection == 3
            ? 'Payment activity · last 6 months'
            : _activeSection == 4
                ? 'Member offers & rewards'
                : _activeSection == 5
                    ? 'Recent member activity'
                    : 'Member overview';
    return Container(
      constraints: const BoxConstraints(minHeight: 260),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.78),
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: const Color(0xFFF0C2D9))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(
                color: Color(0xFF69002F),
                fontSize: 12,
                fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        SizedBox(
            height: 105,
            child: CustomPaint(
                painter: _BarsPainter(
                    values: const [.35, .52, .42, .8, .62, .9, .72]))),
        const SizedBox(height: 12),
        Row(children: [
          _miniValue(
              'This month',
              _activeSection == 2
                  ? '58 min'
                  : _activeSection == 3
                      ? '₹4,500'
                      : '22 days',
              const Color(0xFF08A82B)),
          const SizedBox(width: 7),
          _miniValue('Change', '+12%', const Color(0xFFB000E8)),
        ]),
        const SizedBox(height: 12),
        const Text(
            'Detailed member insights are grouped here for quick review.',
            style: TextStyle(color: Color(0xFF604354), fontSize: 9)),
      ]),
    );
  }

  Widget _miniValue(String label, String value, Color color) => Expanded(
        child: Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
                color: const Color(0xFFFFEAF4),
                borderRadius: BorderRadius.circular(12)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(label,
                  style:
                      const TextStyle(color: Color(0xFF765467), fontSize: 8)),
              Text(value,
                  style: TextStyle(
                      color: color, fontSize: 16, fontWeight: FontWeight.w900)),
            ])),
      );
}

enum DayKind { present, absent, holiday, payment }

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

class _QrMark extends StatelessWidget {
  const _QrMark({this.size = 42});
  final double size;
  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: Size.square(size), painter: _QrPainter());
}

class _QrPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cell = size.width / 21;
    final fill = Paint()..color = const Color(0xFF160B10);
    final bg = Paint()..color = Colors.white;
    canvas.drawRect(Offset.zero & size, bg);
    final random = math.Random(215);
    final matrix =
        List.generate(21, (_) => List.generate(21, (_) => random.nextBool()));
    void finder(int x, int y) {
      for (var r = 0; r < 7; r++) {
        for (var c = 0; c < 7; c++) {
          final edge = r == 0 || c == 0 || r == 6 || c == 6;
          final center = r >= 2 && r <= 4 && c >= 2 && c <= 4;
          matrix[y + r][x + c] = edge || center;
        }
      }
    }

    finder(0, 0);
    finder(14, 0);
    finder(0, 14);
    for (var y = 0; y < 21; y++) {
      for (var x = 0; x < 21; x++) {
        if (matrix[y][x])
          canvas.drawRect(Rect.fromLTWH(x * cell, y * cell, cell, cell), fill);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
