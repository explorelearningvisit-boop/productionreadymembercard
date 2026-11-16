import 'package:flutter/material.dart';

void main() => runApp(const BadGymDesignLab());

class BadGymDesignLab extends StatelessWidget {
  const BadGymDesignLab({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'BAD GYM Design Lab',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFFF8D9),
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF4C400)),
    ),
    home: const MemberIntelligenceDashboard(),
  );
}

abstract final class C {
  static const ink = Color(0xFF211D16);
  static const muted = Color(0xFF777166);
  static const yellow = Color(0xFFFFD21A);
  static const gold = Color(0xFFE7A900);
  static const green = Color(0xFF168B35);
  static const red = Color(0xFFD92D2D);
  static const purple = Color(0xFF913BE0);
  static const blue = Color(0xFF1688D4);
  static const ivory = Color(0xFFFFFEF9);
  static const line = Color(0xFFE9DCA9);
  static const canvas = Color(0xFFFFF8D9);
}

class MemberIntelligenceDashboard extends StatefulWidget {
  const MemberIntelligenceDashboard({super.key});
  @override
  State<MemberIntelligenceDashboard> createState() => _MemberIntelligenceDashboardState();
}

class _MemberIntelligenceDashboardState extends State<MemberIntelligenceDashboard> {
  int tab = 0;
  int rail = 0;
  int monthOffset = 0;
  final tabs = const ['Attendance', 'Workout', 'Payment', 'Body'];
  final rails = const ['Calendar', 'Trend', 'Record', 'Insight', 'Goal', 'More'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, bounds) {
          final compact = bounds.maxWidth < 380;
          final pad = compact ? 9.0 : 13.0;
          return Padding(
            padding: EdgeInsets.fromLTRB(pad, 5, pad, 7),
            child: Column(
              children: [
                _header(compact),
                const SizedBox(height: 7),
                _memberCard(compact),
                const SizedBox(height: 7),
                _sponsor(compact),
                const SizedBox(height: 7),
                _metricTabs(compact),
                const SizedBox(height: 7),
                Expanded(child: _workspace(compact)),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _header(bool compact) => SizedBox(
    height: compact ? 39 : 45,
    child: Row(children: [
      Container(
        width: compact ? 34 : 40, height: compact ? 34 : 40,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFFFE56B), C.gold]),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: const [BoxShadow(color: Color(0x33B58A00), blurRadius: 5, offset: Offset(0, 2))],
        ),
        child: const Icon(Icons.fitness_center, color: C.ink, size: 21),
      ),
      const SizedBox(width: 8),
      Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
        RichText(text: const TextSpan(style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w900, fontSize: 20, height: 1), children: [
          TextSpan(text: 'BAD ', style: TextStyle(color: C.ink)),
          TextSpan(text: 'GYM', style: TextStyle(color: C.red)),
        ])),
        const Text('MEMBER INTELLIGENCE', style: TextStyle(fontSize: 8, letterSpacing: 1.2, fontWeight: FontWeight.w700, color: C.muted)),
      ])),
      _headerAction(Icons.search),
      const SizedBox(width: 5),
      _headerAction(Icons.notifications_none, dot: true),
      const SizedBox(width: 5),
      _headerAction(Icons.qr_code_scanner),
    ]),
  );

  Widget _headerAction(IconData icon, {bool dot = false}) => Stack(clipBehavior: Clip.none, children: [
    Container(width: 34, height: 34, decoration: BoxDecoration(
      color: C.ivory, borderRadius: BorderRadius.circular(12), border: Border.all(color: C.line),
      boxShadow: const [BoxShadow(color: Color(0x1A806600), blurRadius: 4, offset: Offset(0, 2))],
    ), child: Icon(icon, color: C.ink, size: 19)),
    if (dot) Positioned(right: -2, top: -3, child: Container(width: 11, height: 11, decoration: BoxDecoration(color: C.red, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5)))),
  ]);

  Widget _memberCard(bool compact) => Container(
    padding: EdgeInsets.all(compact ? 9 : 12),
    decoration: BoxDecoration(
      color: C.ivory, borderRadius: BorderRadius.circular(19),
      border: Border.all(color: C.gold, width: 1.2),
      boxShadow: const [BoxShadow(color: Color(0x26A77D00), blurRadius: 8, offset: Offset(0, 3))],
    ),
    child: Column(children: [
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(width: compact ? 61 : 70, height: compact ? 61 : 70,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFFFE7A1), Color(0xFFEAC044)]),
            borderRadius: BorderRadius.circular(16), border: Border.all(color: C.gold, width: 1.5)),
          child: const Icon(Icons.person, size: 43, color: Color(0xFF7A4A23))),
        const SizedBox(width: 9),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(spacing: 5, runSpacing: 4, crossAxisAlignment: WrapCrossAlignment.center, children: [
            _pill('✓ CHECKED-IN', C.green, Colors.white),
            const Text('16 Oct · 07:12 AM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: C.muted)),
          ]),
          const SizedBox(height: 4),
          const Text('Ashwani Kumar Sharma Vishwakarma', maxLines: 2, overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, height: 1.12, fontWeight: FontWeight.w900, color: C.ink)),
          const SizedBox(height: 3),
          const Text('BG215  ·  28 Yrs  ·  ♂ Male', style: TextStyle(fontSize: 9, color: C.muted, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Wrap(spacing: 5, children: [_pill('✓ Active', C.green, Colors.white), _pill('♛ Gold Plan', C.yellow, C.ink)]),
        ])),
        const SizedBox(width: 4),
        const Icon(Icons.qr_code_2, size: 28, color: C.ink),
      ]),
      const SizedBox(height: 8),
      Container(height: 1, color: C.line),
      const SizedBox(height: 6),
      Row(children: [
        const Expanded(flex: 4, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Membership  22 / 30 Days', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: C.ink)),
          SizedBox(height: 4),
          ClipRRect(borderRadius: BorderRadius.all(Radius.circular(20)), child: LinearProgressIndicator(value: .73, minHeight: 6, backgroundColor: Color(0xFFE8E3D6), valueColor: AlwaysStoppedAnimation(C.green))),
        ])),
        const SizedBox(width: 7),
        _pill('73%', const Color(0xFFFFE58A), C.ink),
        const SizedBox(width: 7),
        Container(width: 1, height: 28, color: C.line),
        const SizedBox(width: 7),
        const Icon(Icons.event, size: 17, color: C.red),
        const SizedBox(width: 4),
        const Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('24 Oct 2026', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: C.red)),
          Text('Expires · 8 days left', style: TextStyle(fontSize: 8, color: C.muted)),
        ])),
      ]),
    ]),
  );

  Widget _pill(String text, Color bg, Color fg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white, width: .8)),
    child: Text(text, style: TextStyle(fontSize: 8, height: 1.1, fontWeight: FontWeight.w800, color: fg)),
  );

  Widget _sponsor(bool compact) => Container(
    height: compact ? 47 : 56,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFFFFE875), Color(0xFFFFC400), Color(0xFFFFF1A9)]),
      borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white, width: 1.5),
      boxShadow: const [BoxShadow(color: Color(0x2AA77D00), blurRadius: 5, offset: Offset(0, 2))],
    ),
    child: Row(children: [
      const Expanded(flex: 3, child: Text('amazon', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: C.ink))),
      Container(width: 1, height: 27, color: Color(0x668C6800)),
      const SizedBox(width: 7),
      const Expanded(flex: 4, child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('GREAT INDIAN FESTIVAL', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: C.red)),
        Text('Up to 40% OFF · Fitness', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: C.ink)),
      ])),
      _pill('SPONSORED', C.green, Colors.white),
    ]),
  );

  Widget _metricTabs(bool compact) {
    final data = [
      (Icons.calendar_month, 'Attendance', '81%', '+6%', C.green),
      (Icons.fitness_center, 'Workout', '58 min', '+12%', C.purple),
      (Icons.account_balance_wallet, 'Payment', '₹500 Due', 'SBI offer', C.red),
      (Icons.monitor_weight, 'Body', '69.5 kg', '-0.8 kg', C.blue),
    ];
    return SizedBox(height: compact ? 70 : 78, child: Row(children: List.generate(data.length, (i) {
      final d = data[i];
      final selected = tab == i;
      return Expanded(child: Padding(padding: EdgeInsets.only(right: i == 3 ? 0 : 5), child: InkWell(
        borderRadius: BorderRadius.circular(13), onTap: () => setState(() { tab = i; rail = 0; }),
        child: AnimatedContainer(duration: const Duration(milliseconds: 180), padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          decoration: BoxDecoration(
            gradient: selected ? const LinearGradient(colors: [Color(0xFFFFF1B0), Color(0xFFFFD84A)]) : const LinearGradient(colors: [Colors.white, Color(0xFFFFFCF2)]),
            borderRadius: BorderRadius.circular(13), border: Border.all(color: selected ? C.gold : C.line, width: selected ? 1.4 : .8),
            boxShadow: const [BoxShadow(color: Color(0x18866A00), blurRadius: 4, offset: Offset(0, 2))]),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(d.$1, color: d.$5, size: 17),
            const SizedBox(height: 2),
            Text(d.$2, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: C.ink)),
            FittedBox(fit: BoxFit.scaleDown, child: Text(d.$3, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: d.$5))),
            Text(d.$4, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 7, fontWeight: FontWeight.w800, color: d.$5)),
          ]),
        ),
      )));
    })));
  }

  Widget _workspace(bool compact) {
    final titles = ['Attendance Intelligence', 'Workout Intelligence', 'Payment Intelligence', 'Body Intelligence'];
    final activeRails = tab == 0 ? rails : (tab == 1 ? ['Sessions', 'Volume', 'History', 'Goals'] : tab == 2 ? ['Due', 'Payments', 'Offers', 'History'] : ['Weight', 'Measures', 'Progress', 'Goals']);
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(color: C.ivory, borderRadius: BorderRadius.circular(17), border: Border.all(color: C.gold, width: 1.1),
        boxShadow: const [BoxShadow(color: Color(0x22A77D00), blurRadius: 7, offset: Offset(0, 3))]),
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SizedBox(width: 48, child: Container(
          decoration: BoxDecoration(color: const Color(0xFFFFF6D7), borderRadius: BorderRadius.circular(12), border: Border.all(color: C.line)),
          child: Column(children: List.generate(activeRails.length, (i) => Expanded(child: InkWell(
            onTap: () => setState(() => rail = i),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
              decoration: BoxDecoration(
                color: rail == i ? C.yellow : Colors.transparent,
                borderRadius: BorderRadius.circular(9),
                border: rail == i ? Border.all(color: C.gold, width: .8) : null),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(_railIcon(i), size: 15, color: C.ink),
                const SizedBox(height: 1),
                Text(activeRails[i], maxLines: 1, overflow: TextOverflow.clip, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.w700, color: C.ink)),
              ]),
            ),
          )))),
        )),
        const SizedBox(width: 6),
        Expanded(child: Column(children: [
          Row(children: [
            Expanded(child: Text(titles[tab], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: C.ink))),
            if (tab == 0 && rail == 0) InkWell(onTap: () => setState(() => monthOffset++), child: Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFFFF2C4), borderRadius: BorderRadius.circular(12), border: Border.all(color: C.line)), child: Text(_monthLabel(), style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w800)))),
          ]),
          const SizedBox(height: 5),
          Expanded(child: _selectedContent(compact)),
        ])),
      ]),
    );
  }

  IconData _railIcon(int i) => switch (i) { 0 => Icons.calendar_month, 1 => Icons.query_stats, 2 => Icons.history, 3 => Icons.auto_awesome, 4 => Icons.track_changes, _ => Icons.more_horiz };

  String _monthLabel() {
    final date = DateTime(2026, 10 + monthOffset, 1);
    const names = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${names[date.month - 1]} ${date.year}  ›';
  }

  Widget _selectedContent(bool compact) {
    if (tab != 0 || rail != 0) {
      final label = tab == 0 ? ['Calendar','Attendance Trend','Attendance History','Attendance Insights','Attendance Goals','More Attendance'][rail] : tabs[tab];
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(tab == 0 ? _railIcon(rail) : [Icons.fitness_center, Icons.account_balance_wallet, Icons.monitor_weight][tab - 1], size: 30, color: C.gold),
        const SizedBox(height: 7),
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900)),
        const Text('Compact analytics workspace', style: TextStyle(fontSize: 9, color: C.muted)),
      ]));
    }
    return Column(children: [
      SizedBox(height: compact ? 57 : 66, child: Row(children: [
        Expanded(flex: 3, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(width: compact ? 54 : 62, height: compact ? 54 : 62, child: CustomPaint(painter: _RingPainter(.81), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text('81%', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: C.ink)),
            Text('25 / 31', style: TextStyle(fontSize: 7, fontWeight: FontWeight.w700, color: C.muted)),
          ])))),
        ])),
        Expanded(flex: 4, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _legendRow(C.green, 'Present', '23', .81),
          _legendRow(C.gold, 'Late', '2', .07),
          _legendRow(C.red, 'Absent', '2', .07),
          _legendRow(C.purple, 'Holiday', '4', .13),
        ])),
        Expanded(flex: 3, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Icon(Icons.local_fire_department, color: C.red, size: 21),
          Text('5 Days', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: C.red)),
          Text('Current streak', style: TextStyle(fontSize: 7, color: C.muted)),
          SizedBox(height: 3),
          Icon(Icons.emoji_events, color: C.gold, size: 18),
          Text('14 Days Best', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: C.ink)),
        ])),
      ])),
      const SizedBox(height: 4),
      Expanded(child: _calendar()),
    ]);
  }

  Widget _legendRow(Color color, String label, String count, double progress) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(children: [
      Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 4),
      Expanded(child: Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: C.ink))),
      Text(count, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w900)),
      const SizedBox(width: 4),
      SizedBox(width: 27, child: ClipRRect(borderRadius: BorderRadius.circular(9), child: LinearProgressIndicator(value: progress, minHeight: 4, backgroundColor: const Color(0xFFECE8DD), valueColor: AlwaysStoppedAnimation(color)))),
    ]),
  );

  Widget _calendar() {
    const weekdays = ['M','T','W','T','F','S','S'];
    final states = <int, int>{1:0,2:0,3:1,4:0,5:1,6:1,7:1,8:1,9:1,10:2,11:0,12:1,13:1,14:1,15:1,16:1,17:3,18:1,19:1,20:1,21:2,22:1,23:3,24:3,25:4,26:1,27:1,28:2,29:1,30:1,31:1};
    final firstWeekday = DateTime(2026, 10 + monthOffset, 1).weekday - 1;
    final days = DateTime(2026, 10 + monthOffset + 1, 0).day;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(color: const Color(0xFFFFFCF3), borderRadius: BorderRadius.circular(11), border: Border.all(color: C.line)),
      child: Column(children: [
        Row(
          children: [
            for (var i = 0; i < 7; i++)
              Expanded(
                child: Center(
                  child: Text(
                    weekdays[i],
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      color: i > 4 ? C.red : C.muted,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Expanded(child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 3, crossAxisSpacing: 3, childAspectRatio: 1.55),
          itemCount: firstWeekday + days,
          itemBuilder: (context, index) {
            if (index < firstWeekday) return const SizedBox.shrink();
            final day = index - firstWeekday + 1;
            final state = states[day] ?? 0;
            final color = switch (state) { 1 => C.green, 2 => C.gold, 3 => C.red, 4 => C.purple, _ => const Color(0xFFE4E5E8) };
            final textColor = state == 0 ? C.muted : Colors.white;
            return Container(
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20), border: day == 16 ? Border.all(color: C.ink, width: 1.2) : null,
                boxShadow: state == 0 ? null : const [BoxShadow(color: Color(0x18000000), blurRadius: 2, offset: Offset(0, 1))]),
              alignment: Alignment.center,
              child: Text('$day', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: textColor)),
            );
          },
        )),
      ]),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double value;
  const _RingPainter(this.value);
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final p = Paint()..style = PaintingStyle.stroke..strokeWidth = 6..strokeCap = StrokeCap.round;
    p.color = const Color(0xFFE7E4DA);
    canvas.drawArc(rect.deflate(4), -1.5708, 6.2832, false, p);
    p.shader = const SweepGradient(colors: [C.green, Color(0xFF8BD34B), C.green]).createShader(rect);
    canvas.drawArc(rect.deflate(4), -1.5708, 6.2832 * value, false, p);
  }
  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) => oldDelegate.value != value;
}
