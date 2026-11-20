import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/member_theme.dart';

class MemberProfileCard extends StatelessWidget {
  const MemberProfileCard({super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(11, 9, 11, 10),
    decoration: MemberTheme.glass(radius: 25, tint: const Color(0xFFFFF9FF)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        const CircleAvatar(radius: 16, backgroundColor: MemberTheme.green,
          child: Icon(Icons.check_rounded, color: Colors.white, size: 23)),
        const SizedBox(width: 8),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('CHECK-IN', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: MemberTheme.ink)),
          Text('Completed · 07:12 AM', style: TextStyle(fontSize: 9, color: MemberTheme.muted)),
        ])),
        Container(width: 1, height: 35, color: MemberTheme.line),
        const SizedBox(width: 12),
        const Icon(Icons.ac_unit, color: MemberTheme.deepPurple, size: 22),
        const SizedBox(width: 5),
        const Text('FREEZE', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: MemberTheme.ink)),
        const Spacer(),
        const Icon(Icons.notifications_none_rounded, color: MemberTheme.ink, size: 23),
      ]),
      const SizedBox(height: 9),
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(width: 76, height: 86, decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [MemberTheme.violet, MemberTheme.deepPurple]),
          border: Border.all(color: Colors.white, width: 2),
        ), clipBehavior: Clip.antiAlias,
          child: Image.asset('assets/images/member_portrait.png', fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
            errorBuilder: (_, __, ___) => const Icon(Icons.fitness_center, color: Colors.white, size: 38))),
        const SizedBox(width: 10),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Welcome Back 👋', style: TextStyle(fontSize: 12, color: MemberTheme.deepPurple, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700)),
          SizedBox(height: 2),
          FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft,
            child: Text('Ashwani Kumar Singh', style: TextStyle(fontSize: 21, height: 1.1, fontWeight: FontWeight.w900, color: Colors.black))),
          SizedBox(height: 6),
          Wrap(spacing: 9, children: [
            _Meta(Icons.badge_outlined, 'BG215'),
            _Meta(Icons.person_outline, '28 Yrs'),
            _Meta(Icons.male, 'Male'),
          ]),
          SizedBox(height: 8),
          Row(children: [
            Expanded(child: _Pill('♛ Gold Plan', MemberTheme.gold, MemberTheme.deepPurple)),
            SizedBox(width: 6),
            Expanded(child: _Pill('✓ Active', MemberTheme.green, Colors.white)),
          ]),
        ])),
      ]),
      const SizedBox(height: 9),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
        decoration: MemberTheme.glass(radius: 16, tint: const Color(0xFFFFF7FF)),
        child: Row(children: [
          const Icon(Icons.account_balance_wallet_rounded, color: MemberTheme.purple, size: 27),
          const SizedBox(width: 7),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Payment', style: TextStyle(fontSize: 9, color: MemberTheme.muted)),
            Text('₹500 Due', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: MemberTheme.red)),
          ])),
          Container(width: 1, height: 38, color: MemberTheme.line),
          const SizedBox(width: 8),
          const Icon(Icons.event_available_rounded, color: MemberTheme.purple, size: 24),
          const SizedBox(width: 5),
          const Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('8 Days Left', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: MemberTheme.purple)),
            Text('Expires: 24 Oct 2026', style: TextStyle(fontSize: 9, color: MemberTheme.muted)),
          ])),
          QrImageView(data: 'BADGYM:BG215', version: QrVersions.auto, size: 48, padding: EdgeInsets.zero),
        ]),
      ),
      const SizedBox(height: 8),
      Row(children: const [
        Expanded(child: Text('Membership 22 / 30 Days', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: MemberTheme.ink))),
        Text('73%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: MemberTheme.ink)),
      ]),
      const SizedBox(height: 5),
      ClipRRect(borderRadius: BorderRadius.circular(20), child: const LinearProgressIndicator(
        value: .73, minHeight: 8, backgroundColor: Color(0xFFEADCF5),
        valueColor: AlwaysStoppedAnimation(MemberTheme.purple))),
    ]),
  );
}

class _Meta extends StatelessWidget {
  final IconData icon; final String text;
  const _Meta(this.icon, this.text);
  @override Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Icon(icon, size: 13, color: MemberTheme.deepPurple),
    const SizedBox(width: 3),
    Text(text, style: const TextStyle(fontSize: 10, color: MemberTheme.ink, fontWeight: FontWeight.w700)),
  ]);
}

class _Pill extends StatelessWidget {
  final String text; final Color bg; final Color fg;
  const _Pill(this.text, this.bg, this.fg);
  @override Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white, width: 1.5),
      boxShadow: const [BoxShadow(color: Color(0x337B12C8), blurRadius: 7, offset: Offset(0, 3))]),
    child: Center(child: FittedBox(child: Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: fg)))),
  );
}

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});
  @override Widget build(BuildContext context) => Container(
    height: 82, padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFF3D056B), Color(0xFF9A21D4), Color(0xFF4B087C)]),
      borderRadius: BorderRadius.circular(22), border: Border.all(color: Colors.white, width: 2),
      boxShadow: const [BoxShadow(color: Color(0x667B12C8), blurRadius: 15, offset: Offset(0, 5))]),
    child: Row(children: [
      const Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('BAD GYM', style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
        Text('Big Billion Sale', maxLines: 1, style: TextStyle(color: MemberTheme.gold, fontSize: 17, fontWeight: FontWeight.w900)),
        Text('Up to 40% OFF · Fitness Gear', style: TextStyle(color: Colors.white, fontSize: 9)),
      ])),
      const Icon(Icons.fitness_center_rounded, color: Color(0xFFFFD2FF), size: 40),
      const SizedBox(width: 8),
      Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(color: MemberTheme.pink, borderRadius: BorderRadius.circular(22), border: Border.all(color: Colors.white, width: 1.2)),
        child: const Text('Shop Now ›', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900))),
    ]),
  );
}

class QuickMetricRow extends StatelessWidget {
  const QuickMetricRow({super.key});
  @override Widget build(BuildContext context) => const Row(children: [
    Expanded(child: _Metric(Icons.calendar_month_rounded, 'Attendance', '81%', Color(0xFFE5FFE9), MemberTheme.green)),
    SizedBox(width: 6),
    Expanded(child: _Metric(Icons.fitness_center_rounded, 'Workout', '58 min', Color(0xFFF2E2FF), MemberTheme.purple)),
    SizedBox(width: 6),
    Expanded(child: _Metric(Icons.account_balance_wallet_rounded, 'Payment', '₹500 Due', Color(0xFFFFEBD9), MemberTheme.red)),
    SizedBox(width: 6),
    Expanded(child: _Metric(Icons.monitor_weight_outlined, 'Body', '69.5 kg', Color(0xFFDDF7FF), MemberTheme.blue)),
  ]);
}

class _Metric extends StatelessWidget {
  final IconData icon; final String label; final String value; final Color bg; final Color accent;
  const _Metric(this.icon, this.label, this.value, this.bg, this.accent);
  @override Widget build(BuildContext context) => Container(
    height: 78, padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(19),
      border: Border.all(color: Colors.white, width: 1.6),
      boxShadow: const [BoxShadow(color: Color(0x227B12C8), blurRadius: 9, offset: Offset(0, 4))]),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: accent, size: 23),
      const SizedBox(height: 2),
      FittedBox(child: Text(label, style: const TextStyle(fontSize: 10, color: MemberTheme.ink, fontWeight: FontWeight.w800))),
      FittedBox(child: Text(value, style: TextStyle(fontSize: 16, color: accent == MemberTheme.green ? const Color(0xFF087E28) : accent, fontWeight: FontWeight.w900))),
    ]),
  );
}
