import 'package:flutter/material.dart';
import '../theme/member_theme.dart';

class PurpleMemberDashboard extends StatefulWidget {
  const PurpleMemberDashboard({super.key});
  @override
  State<PurpleMemberDashboard> createState() => _PurpleMemberDashboardState();
}

class _PurpleMemberDashboardState extends State<PurpleMemberDashboard> {
  int selectedRail = 0;
  int selectedMetric = 0;
  bool frozen = false;
  final labels = const ['Home', 'Attend', 'Workout', 'Pay', 'Offers', 'History'];
  final icons = const [Icons.home_rounded, Icons.calendar_month_rounded, Icons.fitness_center,
    Icons.account_balance_wallet_rounded, Icons.sell_rounded, Icons.history_rounded];

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _brand(),
      const SizedBox(height: 7),
      _checkIn(),
      const SizedBox(height: 8),
      _memberHero(),
      const SizedBox(height: 8),
      _payment(),
      const SizedBox(height: 6),
      _membershipProgress(),
      const SizedBox(height: 9),
      _promo(),
      const SizedBox(height: 8),
      _metrics(),
      const SizedBox(height: 9),
      _intelligence(),
      const SizedBox(height: 10),
      _floorDecor(),
    ],
  );

  Widget _brand() => SizedBox(
    height: 48,
    child: Stack(children: [
      Positioned.fill(child: Align(alignment: Alignment.centerRight,
        child: Icon(Icons.fitness_center, size: 54, color: MemberTheme.purple.withValues(alpha: .22)))),
      Row(children: [
        const Icon(Icons.fitness_center, color: MemberTheme.purple, size: 29),
        const SizedBox(width: 6),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('BAD GYM', style: TextStyle(fontSize: 25, height: .95, fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic, color: Colors.black)),
            Text('FITNESS MANAGEMENT SYSTEM', style: TextStyle(fontSize: 8, letterSpacing: .65,
              fontWeight: FontWeight.w900, color: MemberTheme.ink)),
          ])),
        const SizedBox(width: 48),
      ]),
    ]),
  );

  Widget _checkIn() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
    decoration: MemberTheme.glass(radius: 24),
    child: Row(children: [
      _roundIcon(Icons.check_rounded, MemberTheme.green, 30),
      const SizedBox(width: 8),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('CHECK-IN', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.black)),
        Text('Completed · 07:12 AM', style: TextStyle(fontSize: 9, color: MemberTheme.ink)),
      ])),
      Container(width: 1, height: 32, color: MemberTheme.line),
      const SizedBox(width: 12),
      InkWell(
        onTap: () => setState(() => frozen = !frozen),
        borderRadius: BorderRadius.circular(12),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
          child: Row(children: [
            Icon(Icons.ac_unit, color: frozen ? MemberTheme.green : MemberTheme.purple, size: 22),
            const SizedBox(width: 5),
            Text(frozen ? 'FROZEN' : 'FREEZE', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: MemberTheme.ink)),
          ]),
        ),
      ),
      Container(width: 1, height: 32, color: MemberTheme.line),
      const SizedBox(width: 9),
      const Icon(Icons.notifications_none_rounded, color: MemberTheme.ink, size: 23),
      const SizedBox(width: 2),
    ]),
  );

  Widget _memberHero() => SizedBox(
    height: 150,
    child: Stack(children: [
      Positioned(right: -5, top: 0, child: Icon(Icons.fitness_center, size: 80, color: MemberTheme.violet.withValues(alpha: .12))),
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(width: 100, height: 130, decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(colors: [MemberTheme.violet, MemberTheme.purple]),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: const [BoxShadow(color: Color(0x667B00D2), blurRadius: 13, offset: Offset(0, 3))],
        ), child: ClipRRect(borderRadius: BorderRadius.circular(22),
          child: Image.asset('assets/images/member_portrait.png', fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 74, color: Colors.white)))),
        const SizedBox(width: 10),
        Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Welcome Back 👋', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w700, color: MemberTheme.purple)),
          const FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft,
            child: Text('Ashwani Kumar Singh', style: TextStyle(fontSize: 21, height: 1.1,
              fontWeight: FontWeight.w900, color: Colors.black))),
          const SizedBox(height: 6),
          const Wrap(spacing: 8, children: [
            _Meta(Icons.badge_outlined, 'BG215'), _Meta(Icons.person_outline, '28 Yrs'), _Meta(Icons.male, 'Male'),
          ]),
          const SizedBox(height: 9),
          Row(children: [
            Expanded(child: _pill('♛  Gold Plan', MemberTheme.gold, const Color(0xFF4D2800))),
            const SizedBox(width: 6),
            Expanded(child: _pill('✓  Active', MemberTheme.green, Colors.white)),
          ]),
        ])),
      ]),
    ]),
  );

  Widget _payment() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
    decoration: MemberTheme.glass(radius: 19),
    child: Row(children: [
      _roundIcon(Icons.account_balance_wallet_rounded, MemberTheme.purple, 30),
      const SizedBox(width: 7),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Payment', style: TextStyle(fontSize: 10, color: MemberTheme.ink)),
        Text('₹500 Due', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: MemberTheme.purple)),
      ])),
      Container(width: 1, height: 39, color: MemberTheme.line),
      const SizedBox(width: 8),
      const Icon(Icons.event_available_rounded, color: MemberTheme.purple, size: 25),
      const SizedBox(width: 6),
      const Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('8 Days Left', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: MemberTheme.purple)),
        Text('Expires: 24 Oct 2026', style: TextStyle(fontSize: 9, color: MemberTheme.ink)),
      ])),
      Container(width: 42, height: 42, decoration: BoxDecoration(border: Border.all(color: MemberTheme.line), borderRadius: BorderRadius.circular(5)),
        child: const Icon(Icons.qr_code_2_rounded, size: 39, color: Colors.black)),
    ]),
  );

  Widget _membershipProgress() => Column(children: [
    const Row(children: [
      Expanded(child: Text('Membership 22 / 30 Days', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.black))),
      Text('73%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.black)),
    ]),
    const SizedBox(height: 5),
    ClipRRect(borderRadius: BorderRadius.circular(20), child: Container(height: 10, color: Colors.white,
      child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: .73,
        child: DecoratedBox(decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [MemberTheme.violet, MemberTheme.neon]),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: MemberTheme.neon, blurRadius: 6)],
        ))))),
  ]);

  Widget _promo() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: MemberTheme.neonPanel(radius: 20),
    child: Row(children: [
      const Text('BAD\nGYM', style: TextStyle(fontSize: 19, height: .92, fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w900, color: Colors.white)),
      Container(height: 42, width: 1, margin: const EdgeInsets.symmetric(horizontal: 9), color: Colors.white70),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Big Billion Sale', maxLines: 1, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic, color: MemberTheme.gold)),
        Text('Up to 40% OFF · Fitness Gear', maxLines: 1, style: TextStyle(fontSize: 9, color: Colors.white)),
      ])),
      const Icon(Icons.fitness_center, color: Colors.white, size: 35),
      const SizedBox(width: 6),
      Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(color: MemberTheme.neon, borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white, width: 1)),
        child: const Text('Shop Now ›', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900))),
    ]),
  );

  Widget _metrics() => Row(children: [
    _metric('Attendance', '81%', Icons.calendar_month_rounded, MemberTheme.green, 0),
    const SizedBox(width: 5),
    _metric('Workout', '58 min', Icons.fitness_center, MemberTheme.purple, 1),
    const SizedBox(width: 5),
    _metric('Payment', '₹500 Due', Icons.account_balance_wallet_rounded, MemberTheme.red, 2),
    const SizedBox(width: 5),
    _metric('Body', '69.5 kg', Icons.monitor_weight_outlined, const Color(0xFF008DBB), 3),
  ]);

  Widget _metric(String title, String value, IconData icon, Color accent, int index) => Expanded(
    child: InkWell(onTap: () => setState(() => selectedMetric = index),
      borderRadius: BorderRadius.circular(17),
      child: AnimatedContainer(duration: const Duration(milliseconds: 180), padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: selectedMetric == index ? [accent.withValues(alpha: .22), Colors.white] : [Colors.white, accent.withValues(alpha: .10)]),
          borderRadius: BorderRadius.circular(17), border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: const [BoxShadow(color: Color(0x227B32B8), blurRadius: 9, offset: Offset(0, 3))],
        ),
        child: Column(children: [
          Icon(icon, color: accent, size: 22),
          const SizedBox(height: 3),
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: MemberTheme.ink)),
          FittedBox(fit: BoxFit.scaleDown, child: Text(value,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: index == 2 ? MemberTheme.red : MemberTheme.ink))),
        ]),
      ),
    ),
  );

  Widget _intelligence() => Container(
    padding: const EdgeInsets.all(9),
    decoration: MemberTheme.glass(radius: 24),
    child: Column(children: [
      Row(children: [
        _roundIcon(Icons.trending_up_rounded, MemberTheme.purple, 31),
        const SizedBox(width: 7),
        const Expanded(child: Text('Attendance Intelligence', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: MemberTheme.ink))),
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: const Color(0xFFFFE5F0), borderRadius: BorderRadius.circular(20), border: Border.all(color: MemberTheme.neon)),
          child: const Row(children: [Icon(Icons.circle, size: 7, color: MemberTheme.red), SizedBox(width: 4),
            Text('LIVE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: MemberTheme.red))])),
      ]),
      const SizedBox(height: 8),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 62, padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 3),
          decoration: MemberTheme.neonPanel(radius: 18),
          child: Column(children: List.generate(labels.length, (i) => _railItem(i))),
        ),
        const SizedBox(width: 8),
        Expanded(child: Container(
          padding: const EdgeInsets.fromLTRB(10, 9, 9, 8),
          decoration: MemberTheme.glass(radius: 20, tint: const Color(0xFFFFFCFF)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Home overview', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: MemberTheme.purple)),
            const Text('Check-in complete · 07:12 AM', style: TextStyle(fontSize: 10, color: MemberTheme.ink)),
            const SizedBox(height: 11),
            Row(children: [
              SizedBox(width: 83, height: 83, child: Stack(alignment: Alignment.center, children: [
                const SizedBox.expand(child: CircularProgressIndicator(value: .81, strokeWidth: 8, strokeCap: StrokeCap.round,
                  backgroundColor: Color(0xFFF0DDFB), valueColor: AlwaysStoppedAnimation(MemberTheme.green))),
                const Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('81%', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900, color: MemberTheme.ink)),
                  Text('25/31', style: TextStyle(fontSize: 9, color: MemberTheme.muted)),
                ]),
              ])),
              const SizedBox(width: 9),
              const Expanded(child: Column(children: [
                _StatRow(MemberTheme.green, 'Present', '25', '81%', .81),
                _StatRow(MemberTheme.red, 'Absent', '2', '6%', .06),
                _StatRow(MemberTheme.purple, 'Holiday', '4', '13%', .13),
                _StatRow(MemberTheme.gold, 'Payment', '1/1', '100%', 1),
              ])),
            ]),
            const SizedBox(height: 8),
            const Divider(height: 1, color: MemberTheme.line),
            const SizedBox(height: 7),
            const Row(children: [
              Expanded(child: _FootMetric(Icons.local_fire_department, '5d', MemberTheme.red)),
              Expanded(child: _FootMetric(Icons.emoji_events, '14d', MemberTheme.purple)),
              Expanded(child: _FootMetric(Icons.trending_up, '+6%', MemberTheme.green)),
            ]),
            const SizedBox(height: 5),
            const Text('Sample data · API connection required for live records',
              maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 7, color: MemberTheme.muted)),
          ]),
        )),
      ]),
    ]),
  );

  Widget _railItem(int i) => InkWell(onTap: () => setState(() => selectedRail = i),
    borderRadius: BorderRadius.circular(13),
    child: AnimatedContainer(duration: const Duration(milliseconds: 160), width: 51, margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
      decoration: BoxDecoration(
        color: selectedRail == i ? MemberTheme.gold : Colors.transparent,
        borderRadius: BorderRadius.circular(13),
        border: selectedRail == i ? Border.all(color: Colors.white, width: 1.2) : null,
      ),
      child: Column(children: [
        Icon(icons[i], size: 20, color: selectedRail == i ? MemberTheme.ink : Colors.white),
        const SizedBox(height: 2),
        Text(labels[i], maxLines: 1, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800,
          color: selectedRail == i ? MemberTheme.ink : Colors.white)),
      ]),
    ),
  );

  Widget _floorDecor() => Container(
    height: 63,
    decoration: BoxDecoration(
      gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
        colors: [Color(0xFFEEE1FF), Color(0xFFD8B8F4)]),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.white, width: 1.5),
    ),
    child: const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Icon(Icons.fitness_center, size: 39, color: Color(0xFF38214F)),
      Icon(Icons.sports_gymnastics, size: 34, color: MemberTheme.purple),
      Icon(Icons.water_drop, size: 33, color: Color(0xFF7654A3)),
      Icon(Icons.spa, size: 36, color: MemberTheme.green),
      Icon(Icons.fitness_center, size: 39, color: Color(0xFF38214F)),
    ]),
  );

  Widget _roundIcon(IconData icon, Color color, double size) => Container(width: size, height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [color, color.withValues(alpha: .72)]),
      boxShadow: [BoxShadow(color: color.withValues(alpha: .30), blurRadius: 8, offset: const Offset(0, 2))]),
    child: Icon(icon, color: Colors.white, size: size * .62));

  Widget _pill(String label, Color color, Color text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.white, width: 1), boxShadow: const [BoxShadow(color: Color(0x337B32B8), blurRadius: 5, offset: Offset(0, 2))]),
    child: FittedBox(fit: BoxFit.scaleDown, child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: text))),
  );
}

class _Meta extends StatelessWidget {
  final IconData icon; final String label;
  const _Meta(this.icon, this.label);
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Icon(icon, size: 13, color: MemberTheme.purple), const SizedBox(width: 3),
    Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: MemberTheme.ink)),
  ]);
}

class _StatRow extends StatelessWidget {
  final Color color; final String label; final String value; final String percent; final double progress;
  const _StatRow(this.color, this.label, this.value, this.percent, this.progress);
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 5),
      Expanded(child: Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: MemberTheme.ink))),
      SizedBox(width: 22, child: Text(value, textAlign: TextAlign.end, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: MemberTheme.ink))),
      const SizedBox(width: 5),
      Expanded(flex: 2, child: ClipRRect(borderRadius: BorderRadius.circular(8),
        child: LinearProgressIndicator(value: progress, minHeight: 7, backgroundColor: color.withValues(alpha: .16),
          valueColor: AlwaysStoppedAnimation(color)))),
      const SizedBox(width: 4),
      SizedBox(width: 26, child: Text(percent, textAlign: TextAlign.end, style: const TextStyle(fontSize: 8, color: MemberTheme.ink))),
    ]),
  );
}

class _FootMetric extends StatelessWidget {
  final IconData icon; final String value; final Color color;
  const _FootMetric(this.icon, this.value, this.color);
  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    Icon(icon, color: color, size: 17), const SizedBox(width: 4),
    Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: color)),
  ]);
}
