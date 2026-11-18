import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() => runApp(const BadGymApp());

class BadGymApp extends StatelessWidget {
  const BadGymApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'BAD GYM Member Intelligence',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: const Color(0xFF65000A),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB80D19)),
    ),
    home: const MemberDashboard(),
  );
}

class C {
  static const ruby = Color(0xFF71000A);
  static const red = Color(0xFFB50919);
  static const red2 = Color(0xFFE51B2A);
  static const gold = Color(0xFFFFC928);
  static const goldDark = Color(0xFFB77A0A);
  static const pearl = Color(0xFFFFF9F2);
  static const ink = Color(0xFF28191A);
  static const muted = Color(0xFF806C68);
  static const green = Color(0xFF16A34A);
  static const amber = Color(0xFFFFB900);
  static const purple = Color(0xFF8B22D8);
}

class MemberDashboard extends StatelessWidget {
  const MemberDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-.2, -.7), radius: 1.25,
            colors: [Color(0xFF9D0714), Color(0xFF610008), Color(0xFF2D0005)],
            stops: [0, .56, 1],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            final w = constraints.maxWidth;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(7, 5, 7, 12),
              child: Column(
                children: [
                  const BrandHeader(),
                  const SizedBox(height: 8),
                  const MemberPassCard(),
                  const SizedBox(height: 8),
                  const FestivalBanner(),
                  const SizedBox(height: 8),
                  const MetricRow(),
                  const SizedBox(height: 8),
                  AttendanceWorkspace(width: w),
                  const SizedBox(height: 8),
                  const ProteinBanner(),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class GoldFrame extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final bool dark;
  const GoldFrame({super.key, required this.child, this.padding = const EdgeInsets.all(8), this.radius = 22, this.dark = false});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(2.1),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      gradient: const LinearGradient(
        begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: [Color(0xFFFFF5B5), Color(0xFFFFC72C), Color(0xFFB66A08), Color(0xFFFFE99A), Color(0xFF9D4C00)],
        stops: [0, .22, .52, .78, 1],
      ),
      boxShadow: [
        BoxShadow(color: const Color(0xFFFFB51B).withOpacity(.28), blurRadius: 9, spreadRadius: 1),
        BoxShadow(color: Colors.black.withOpacity(.28), blurRadius: 9, offset: const Offset(0, 4)),
      ],
    ),
    child: Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius - 2),
        color: dark ? C.ruby : C.pearl,
        gradient: dark ? const LinearGradient(colors: [Color(0xFFB50919), Color(0xFF500008)], begin: Alignment.topLeft, end: Alignment.bottomRight) : const LinearGradient(colors: [Color(0xFFFFFFFF), Color(0xFFFFF8F0), Color(0xFFF7EDE5)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        border: Border.all(color: Colors.white.withOpacity(.9), width: .7),
      ),
      child: child,
    ),
  );
}

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 72,
    child: Stack(children: [
      Positioned.fill(child: CustomPaint(painter: HeaderRibbonPainter())),
      Row(children: [
        Container(
          width: 52, height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(colors: [Color(0xFFFFE9A0), Color(0xFFFFC31B), Color(0xFFB70A17)]),
            border: Border.all(color: Colors.white, width: 1.5),
            boxShadow: [BoxShadow(color: C.gold.withOpacity(.35), blurRadius: 8)],
          ),
          child: const Icon(Icons.fitness_center, color: Color(0xFFFFF2B6), size: 31),
        ),
        const SizedBox(width: 9),
        const Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text.rich(TextSpan(children: [TextSpan(text: 'BAD ', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)), TextSpan(text: 'GYM', style: TextStyle(color: C.gold, fontSize: 21, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic))])),
          FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text('Member Intelligence', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600))),
        ])),
        const HeaderAction(icon: Icons.search),
        const SizedBox(width: 5),
        const HeaderAction(icon: Icons.notifications_none, badge: '3'),
        const SizedBox(width: 5),
        const HeaderAction(icon: Icons.qr_code_2),
      ]),
    ]),
  );
}

class HeaderRibbonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..style = PaintingStyle.stroke..strokeWidth = 9..shader = const LinearGradient(colors: [Color(0xFFFFF3A0), Color(0xFFFFB900), Color(0xFFFFF6C9)]).createShader(Offset.zero & size);
    final path = Path()..moveTo(size.width * .45, size.height * .98)..cubicTo(size.width * .62, size.height * .96, size.width * .68, size.height * .12, size.width * .82, size.height * .02);
    canvas.drawPath(path, p);
    canvas.drawPath(path, Paint()..style = PaintingStyle.stroke..strokeWidth = 2..color = Colors.white.withOpacity(.85));
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HeaderAction extends StatelessWidget {
  final IconData icon; final String? badge;
  const HeaderAction({super.key, required this.icon, this.badge});
  @override
  Widget build(BuildContext context) => Stack(clipBehavior: Clip.none, children: [
    Container(width: 47, height: 47, decoration: BoxDecoration(
      color: const Color(0xFF8B0610), borderRadius: BorderRadius.circular(15),
      border: Border.all(color: const Color(0xFFFFE6A0), width: 1.5),
      boxShadow: [BoxShadow(color: C.red2.withOpacity(.55), blurRadius: 8)],
    ), child: Icon(icon, color: Colors.white, size: 25)),
    if (badge != null) Positioned(right: -2, top: -4, child: CircleAvatar(radius: 10, backgroundColor: C.red2, child: Text(badge!, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
  ]);
}

class MemberPassCard extends StatelessWidget {
  const MemberPassCard({super.key});
  @override
  Widget build(BuildContext context) => GoldFrame(
    radius: 23, padding: const EdgeInsets.all(9),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 75, height: 91, padding: const EdgeInsets.all(3), decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17), gradient: const LinearGradient(colors: [Color(0xFFFFF1A8), Color(0xFFFFBA14), Color(0xFF9A4A00)]),
          boxShadow: [BoxShadow(color: C.gold.withOpacity(.35), blurRadius: 5)],
        ), child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), gradient: const LinearGradient(colors: [Color(0xFF6B0610), Color(0xFFB30B1B)])),
          child: ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset('assets/images/member_ashwani.webp', fit: BoxFit.cover, errorBuilder: (context, error, stack) => const Center(child: Icon(Icons.person, size: 54, color: Color(0xFFFFD978))))),
        )),
        const SizedBox(width: 8),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(spacing: 5, runSpacing: 4, children: const [
            StatusPill(text: '✓ CHECKED-IN', color: C.green),
            SmallPill(icon: Icons.calendar_month, text: '16 Oct 2026 · 07:12 AM'),
          ]),
          const SizedBox(height: 5),
          const Text('Ashwani Kumar Sharma Vishwakarma', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.2, height: 1.04, fontWeight: FontWeight.w900, color: C.ink)),
          const SizedBox(height: 5),
          const Wrap(spacing: 9, children: [
            MetaItem(icon: Icons.badge_outlined, text: 'BG215'),
            MetaItem(icon: Icons.person_outline, text: '28 Yrs'),
            MetaItem(icon: Icons.male, text: 'Male'),
          ]),
          const SizedBox(height: 5),
          const Wrap(spacing: 5, children: [StatusPill(text: '✿ Active', color: C.green), StatusPill(text: '♛ Gold Plan', color: C.gold, darkText: true)]),
        ])),
        const SizedBox(width: 5),
        Container(width: 47, height: 47, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(7), border: Border.all(color: const Color(0xFFD7B36A))), child: QrImageView(data: 'BADGYM|BG215|Ashwani Kumar Sharma Vishwakarma', version: QrVersions.auto, padding: const EdgeInsets.all(3))),
      ]),
      const SizedBox(height: 8),
      Divider(color: C.goldDark.withOpacity(.4), height: 1),
      const SizedBox(height: 6),
      Row(children: [
        Expanded(child: DetailTile(icon: Icons.account_balance_wallet_outlined, label: 'Payment', value: '₹500 Due')),
        const SizedBox(width: 6),
        Expanded(child: DetailTile(icon: Icons.calendar_month, label: 'Expires: 24 Oct 2026', value: '(8 Days Left)')),
      ]),
      const SizedBox(height: 6),
      Row(children: [
        const Expanded(child: Text('Membership  22 / 30 Days', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: C.ink))),
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: const Color(0xFFFFF2C2), borderRadius: BorderRadius.circular(18), border: Border.all(color: C.gold)), child: const Text('73%', style: TextStyle(color: C.goldDark, fontWeight: FontWeight.w900, fontSize: 12))),
      ]),
      const SizedBox(height: 4),
      ClipRRect(borderRadius: BorderRadius.circular(10), child: const LinearProgressIndicator(value: .73, minHeight: 8, backgroundColor: Color(0xFF3A2020), color: C.gold)),
    ]),
  );
}

class StatusPill extends StatelessWidget {
  final String text; final Color color; final bool darkText;
  const StatusPill({super.key, required this.text, required this.color, this.darkText = false});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20), gradient: color == C.gold ? const LinearGradient(colors: [Color(0xFFFFE65C), Color(0xFFFFB900)]) : LinearGradient(colors: [color, color.withOpacity(.82)]), boxShadow: [BoxShadow(color: color.withOpacity(.22), blurRadius: 3, offset: const Offset(0, 1))]),
    child: Text(text, style: TextStyle(color: darkText ? const Color(0xFF4B2600) : Colors.white, fontSize: 9.5, fontWeight: FontWeight.w900)),
  );
}

class SmallPill extends StatelessWidget {
  final IconData icon; final String text;
  const SmallPill({super.key, required this.icon, required this.text});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFF4F4F4), borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFD8C8B2))), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 11, color: C.ink), const SizedBox(width: 3), Flexible(child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800, color: C.ink)))]));
}

class MetaItem extends StatelessWidget {
  final IconData icon; final String text;
  const MetaItem({super.key, required this.icon, required this.text});
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 13, color: C.red), const SizedBox(width: 2), Text(text, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: C.ink))]);
}

class DetailTile extends StatelessWidget {
  final IconData icon; final String label; final String value;
  const DetailTile({super.key, required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6), decoration: BoxDecoration(color: const Color(0xFFFFF3F0), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE3C38A))), child: Row(children: [
    Icon(icon, color: C.red, size: 19), const SizedBox(width: 5),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800, color: C.ink)), Text(value, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w900, color: C.red))])),
    const Icon(Icons.chevron_right, size: 17, color: C.red),
  ]));
}

class FestivalBanner extends StatelessWidget {
  const FestivalBanner({super.key});
  @override
  Widget build(BuildContext context) => GoldFrame(radius: 18, padding: EdgeInsets.zero, child: Container(
    height: 57, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: const LinearGradient(colors: [Color(0xFFFFD7E9), Color(0xFFD943B9), Color(0xFFFFB8C8)], begin: Alignment.centerLeft, end: Alignment.centerRight)),
    child: Stack(children: [
      Positioned(left: 8, top: 9, child: Container(width: 77, height: 39, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)), child: const Center(child: Text('amazon', style: TextStyle(color: Color(0xFF18263A), fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -1))))),
      const Positioned(left: 102, top: 17, child: Text('Great Indian\nFestival', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF7B164D), fontSize: 11, height: 1, fontWeight: FontWeight.w900))),
      const Positioned(right: 74, top: 12, child: Text('Up to 40% OFF', style: TextStyle(color: Color(0xFF4B164C), fontSize: 13, fontWeight: FontWeight.w900))),
      const Positioned(right: 73, bottom: 10, child: Text('Fitness & Wellness', style: TextStyle(color: Color(0xFF4B164C), fontSize: 9, fontWeight: FontWeight.w700))),
      const Positioned(right: 5, top: 15, child: Icon(Icons.fitness_center, size: 37, color: Color(0xFF7D0914))),
      Positioned(right: 6, top: 2, child: Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2), decoration: BoxDecoration(color: C.green, borderRadius: BorderRadius.circular(12)), child: const Text('Sponsored', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)))),
    ]),
  ));
}

class MetricRow extends StatelessWidget {
  const MetricRow({super.key});
  @override
  Widget build(BuildContext context) => Row(children: const [
    Expanded(child: MetricCard(title: 'Attendance', value: '81%', sub: '+6%', icon: Icons.calendar_month, accent: C.green)),
    SizedBox(width: 5), Expanded(child: MetricCard(title: 'Workout', value: '58 min', sub: '•••••', icon: Icons.fitness_center, accent: C.purple)),
    SizedBox(width: 5), Expanded(child: MetricCard(title: 'Payment', value: '₹500 Due', sub: 'SBI Card · 10% Cashback', icon: Icons.account_balance_wallet, accent: C.red)),
    SizedBox(width: 5), Expanded(child: MetricCard(title: 'Body', value: '69.5 kg', sub: '-0.8 kg', icon: Icons.monitor_weight_outlined, accent: C.purple)),
  ]);
}

class MetricCard extends StatelessWidget {
  final String title, value, sub; final IconData icon; final Color accent;
  const MetricCard({super.key, required this.title, required this.value, required this.sub, required this.icon, required this.accent});
  @override
  Widget build(BuildContext context) => GoldFrame(radius: 14, padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7), child: Column(children: [
    Icon(icon, size: 17, color: accent),
    const SizedBox(height: 2),
    Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: C.ink)),
    const SizedBox(height: 4),
    FittedBox(fit: BoxFit.scaleDown, child: Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: title == 'Payment' ? C.red : C.ink))),
    const SizedBox(height: 3),
    FittedBox(fit: BoxFit.scaleDown, child: Text(sub, style: TextStyle(fontSize: 7.5, fontWeight: FontWeight.w800, color: accent))),
  ]));
}

class AttendanceWorkspace extends StatelessWidget {
  final double width;
  const AttendanceWorkspace({super.key, required this.width});
  @override
  Widget build(BuildContext context) => SizedBox(height: 350, child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    SizedBox(width: 51, child: GoldFrame(dark: true, radius: 17, padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3), child: const Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      RailItem(icon: Icons.calendar_month, label: 'Cal', selected: true),
      RailItem(icon: Icons.bar_chart, label: 'Trend'),
      RailItem(icon: Icons.history, label: 'History'),
      RailItem(icon: Icons.auto_awesome, label: 'Insights'),
      RailItem(icon: Icons.track_changes, label: 'Goal'),
      RailItem(icon: Icons.more_horiz, label: 'More'),
    ]))),
    const SizedBox(width: 5),
    Expanded(child: GoldFrame(radius: 18, padding: const EdgeInsets.all(7), child: const AttendanceContent())),
  ]));
}

class RailItem extends StatelessWidget {
  final IconData icon; final String label; final bool selected;
  const RailItem({super.key, required this.icon, required this.label, this.selected = false});
  @override
  Widget build(BuildContext context) => Container(width: 43, padding: const EdgeInsets.symmetric(vertical: 5), decoration: selected ? BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFFFE66C), Color(0xFFFFB900)]), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white, width: 1)) : null, child: Column(children: [
    Icon(icon, size: 19, color: selected ? C.red : Colors.white),
    Text(label, style: TextStyle(fontSize: 8, color: selected ? C.red : Colors.white, fontWeight: FontWeight.w900)),
  ]));
}

class AttendanceContent extends StatelessWidget {
  const AttendanceContent({super.key});
  @override
  Widget build(BuildContext context) {
    final days = <int, int>{1:3,2:3,3:0,4:3,5:0,6:0,7:0,8:0,9:0,10:1,11:3,12:0,13:0,14:0,15:0,16:0,17:2,18:0,19:0,20:0,21:1,22:0,23:2,24:2,25:3,26:0,27:0,28:1,29:0,30:0,31:0};
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: const [Icon(Icons.calendar_month, color: C.red, size: 18), SizedBox(width: 5), Expanded(child: Text('Attendance Intelligence', maxLines: 1, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w900, color: C.ink))), MonthPill()]),
      const SizedBox(height: 7),
      Row(children: [
        const SizedBox(width: 79, height: 79, child: CustomPaint(painter: DonutPainter(), child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text('81%', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: C.ink)), Text('25 / 31 Days', style: TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold, color: C.ink))])))),
        const SizedBox(width: 7),
        const Expanded(child: Column(children: [
          AttendanceLegend(color: C.green, label: 'Present', count: '23', percent: '74%'),
          AttendanceLegend(color: C.amber, label: 'Late', count: '2', percent: '6%'),
          AttendanceLegend(color: C.red2, label: 'Absent', count: '2', percent: '6%'),
          AttendanceLegend(color: C.purple, label: 'Holiday', count: '4', percent: '13%'),
        ])),
      ]),
      const SizedBox(height: 7),
      Row(children: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'].map((e)=>Expanded(child: Center(child: Text(e, style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.w900, color: C.ink))))).toList()),
      const SizedBox(height: 4),
      GridView.builder(
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        itemCount: 35, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 3, crossAxisSpacing: 3, childAspectRatio: 1.55),
        itemBuilder: (context, index) {
          final day = index - 2;
          if (day < 1 || day > 31) return const SizedBox.shrink();
          final status = days[day] ?? 0;
          final color = status == 0 ? C.green : status == 1 ? C.amber : status == 2 ? C.red2 : C.purple;
          final neutral = day < 3;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: neutral ? const LinearGradient(colors: [Color(0xFFFFFFFF), Color(0xFFE6E6E6)]) : LinearGradient(colors: [color, Color.lerp(color, Colors.black, .18)!], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              border: Border.all(color: neutral ? const Color(0xFFD7B46B) : Colors.white.withOpacity(.7), width: 1),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(.10), blurRadius: 2, offset: const Offset(0, 1))],
            ),
            child: Center(child: Text('$day', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: neutral ? C.ink : Colors.white))),
          );
        },
      ),
      const SizedBox(height: 5),
      const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        LegendDot(color: C.green, label: 'Present'), SizedBox(width: 7), LegendDot(color: C.amber, label: 'Late'), SizedBox(width: 7), LegendDot(color: C.red2, label: 'Absent'), SizedBox(width: 7), LegendDot(color: C.purple, label: 'Holiday'),
      ]),
      const SizedBox(height: 6),
      Container(padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5), decoration: BoxDecoration(color: const Color(0xFFFFF5ED), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5CBA4))), child: const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Icon(Icons.local_fire_department, color: C.red, size: 18), Expanded(child: FittedBox(fit: BoxFit.scaleDown, child: Text('Streak  5 Days', style: TextStyle(color: C.red, fontSize: 9, fontWeight: FontWeight.w900)))),
        SizedBox(height: 18, child: VerticalDivider(color: C.red, width: 12)),
        Icon(Icons.emoji_events, color: C.goldDark, size: 18), Expanded(child: FittedBox(fit: BoxFit.scaleDown, child: Text('Best  14 Days', style: TextStyle(color: C.red, fontSize: 9, fontWeight: FontWeight.w900)))),
      ])),
    ]);
  }
}

class MonthPill extends StatelessWidget {
  const MonthPill({super.key});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFD7B46B)), boxShadow: [BoxShadow(color: C.gold.withOpacity(.2), blurRadius: 4)]), child: const Row(children: [Text('Oct 2026', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: C.ink)), Icon(Icons.keyboard_arrow_down, size: 14, color: C.ink)]));
}

class AttendanceLegend extends StatelessWidget {
  final Color color; final String label,count,percent;
  const AttendanceLegend({super.key, required this.color, required this.label, required this.count, required this.percent});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 2), child: Row(children: [Container(width: 9,height:9,decoration: BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [BoxShadow(color: color.withOpacity(.25), blurRadius: 3)])), const SizedBox(width: 4), Expanded(child: Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: C.ink))), SizedBox(width: 18, child: Text(count, textAlign: TextAlign.end, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: C.ink))), SizedBox(width: 28, child: Text(percent, textAlign: TextAlign.end, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: C.ink)))]));
}

class LegendDot extends StatelessWidget {
  final Color color; final String label;
  const LegendDot({super.key, required this.color, required this.label});
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 6,height:6,decoration: BoxDecoration(color: color,shape: BoxShape.circle)), const SizedBox(width: 2), Text(label, style: const TextStyle(fontSize: 7, color: C.muted, fontWeight: FontWeight.w700))]);
}

class DonutPainter extends CustomPainter {
  const DonutPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size; final stroke = size.width * .10;
    final base = Paint()..style = PaintingStyle.stroke..strokeWidth = stroke..color = const Color(0xFFE5D8D2);
    final fg = Paint()..style = PaintingStyle.stroke..strokeWidth = stroke..strokeCap = StrokeCap.round..shader = const SweepGradient(colors: [Color(0xFF16A34A), Color(0xFF6BEA73), Color(0xFF16A34A)]).createShader(rect);
    canvas.drawArc(rect.deflate(stroke/2), -math.pi/2, math.pi*2, false, base);
    canvas.drawArc(rect.deflate(stroke/2), -math.pi/2, math.pi*2*.81, false, fg);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ProteinBanner extends StatelessWidget {
  const ProteinBanner({super.key});
  @override
  Widget build(BuildContext context) => GoldFrame(radius: 18, dark: true, padding: const EdgeInsets.all(9), child: SizedBox(height: 100, child: Row(children: [
    const SizedBox(width: 47, child: Icon(Icons.fitness_center, size: 39, color: C.gold)),
    Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2), decoration: BoxDecoration(color: C.gold, borderRadius: BorderRadius.circular(8)), child: const Text('FITNESS NUTRITION', style: TextStyle(color: C.ink, fontSize: 7, fontWeight: FontWeight.w900))),
      const SizedBox(height: 3),
      FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text.rich(TextSpan(children: [TextSpan(text: 'PROTEIN ', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)), TextSpan(text: 'BURGER', style: TextStyle(color: C.gold, fontSize: 16, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic))]))),
      const FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text('High Protein  ·  Low Fat  ·  More Energy', style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.w700))),
    ])),
    const Text('🍔', style: TextStyle(fontSize: 37)),
    const SizedBox(width: 4),
    Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFFFE85C), Color(0xFFFFB900)]), borderRadius: BorderRadius.circular(13), boxShadow: [BoxShadow(color: C.gold.withOpacity(.35), blurRadius: 6)]), child: const Text('50% OFF\nOrder Now →', textAlign: TextAlign.center, style: TextStyle(color: C.ink, fontSize: 8, fontWeight: FontWeight.w900))),
  ])));
}
