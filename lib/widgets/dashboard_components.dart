import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/member_theme.dart';

enum MemberPlanTier { gold, silver, spark }

class MemberProfileCard extends StatelessWidget {
  final MemberPlanTier planTier;
  const MemberProfileCard({super.key, this.planTier = MemberPlanTier.gold});
  Color get _tierColor => switch (planTier) { MemberPlanTier.gold => MemberTheme.gold, MemberPlanTier.silver => const Color(0xFFD8DEE8), MemberPlanTier.spark => MemberTheme.green };
  String get _tierLabel => switch (planTier) { MemberPlanTier.gold => '👑 Gold Plan', MemberPlanTier.silver => '◇ Silver Plan', MemberPlanTier.spark => '✦ Spark Plan' };

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(7, 4, 7, 5),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFB90B60), Color(0xFF790039), Color(0xFF69002F)],
      ),
      borderRadius: BorderRadius.circular(26),
      border: Border.all(color: const Color(0xFFFF9DCE), width: 1.35),
      boxShadow: const [
        BoxShadow(color: Color(0x8875003D), blurRadius: 16, offset: Offset(0, 6)),
      ],
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const _CheckInFreezeActions(),
      const SizedBox(height: 4),
      Row(children: [
        SizedBox(
          width: 62,
          height: 66,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/member_portrait.png',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.fitness_center, size: 66, color: Colors.white70),
            ),
          ),
        ),
        const SizedBox(width: 9),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome Back 👋',
              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
            const SizedBox(height: 2),
            const Text('Ashwani Kumar Singh', maxLines: 2,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16, height: 1.0)),
            const SizedBox(height: 4),
            const Wrap(spacing: 8, runSpacing: 4, children: [
              _Meta(Icons.calendar_month, 'BG215'),
              _Meta(Icons.person_outline, '28 Yrs'),
              _Meta(Icons.male, 'Male'),
            ]),
            const SizedBox(height: 4),
            Row(children: [
              Expanded(child: _PlanPill(label: _tierLabel, color: _tierColor, textColor: planTier == MemberPlanTier.spark ? Colors.white : MemberTheme.ink)),
              SizedBox(width: 6),
              Expanded(child: _PlanPill(label: '✓ Active', color: MemberTheme.green, textColor: Colors.white)),
            ]),
          ],
        )),
      ]),
      const SizedBox(height: 3),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF4F9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: .85)),
        ),
        child: Row(children: [
          Icon(Icons.account_balance_wallet, color: MemberTheme.berry, size: 23),
          SizedBox(width: 6),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Payment', style: TextStyle(fontSize: 9, color: MemberTheme.ink)),
            Text('₹500 Due', style: TextStyle(fontSize: 14, color: MemberTheme.red, fontWeight: FontWeight.w900)),
          ])),
          SizedBox(width: 5),
          Icon(Icons.event_available, color: MemberTheme.berry, size: 22),
          SizedBox(width: 5),
          Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('8 Days Left', style: TextStyle(fontSize: 13, color: MemberTheme.red, fontWeight: FontWeight.w900)),
            Text('Expires: 24 Oct 2026', style: TextStyle(fontSize: 9, color: MemberTheme.ink)),
          ])),
          QrImageView(data: 'BADGYM:BG215', version: QrVersions.auto, size: 46, padding: const EdgeInsets.all(2), errorCorrectionLevel: QrErrorCorrectLevel.H),
        ]),
      ),
      const SizedBox(height: 5),
      Row(children: const [
        Expanded(child: Text('Membership 22 / 30 Days',
          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900))),
        Text('73%', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900)),
      ]),
      const SizedBox(height: 4),
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: const LinearProgressIndicator(
          value: .73, minHeight: 7,
          backgroundColor: Color(0xFFFFE8F3),
          valueColor: AlwaysStoppedAnimation(MemberTheme.pink),
        ),
      ),
    ]),
  );
}

class _CheckInFreezeActions extends StatelessWidget {
  const _CheckInFreezeActions();

  @override
  Widget build(BuildContext context) => SizedBox(height: 38, child: Row(children: [
    Expanded(child: Row(children: [
      const CircleAvatar(radius: 14, backgroundColor: MemberTheme.green,
        child: Icon(Icons.check, color: Colors.white, size: 18)),
      const SizedBox(width: 6),
      const Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('CHECK-IN', maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900)),
          Text('Completed · 07:12 AM', maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 8)),
        ])),
    ])),
    Container(width: 1, height: 30, color: Colors.white54),
    Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.ac_unit, color: Color(0xFFFFD6EC), size: 20),
      const SizedBox(width: 4),
      const Flexible(child: Text('FREEZE', maxLines: 1, overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11))),
    ])),
    const SizedBox(width: 4),
    const Icon(Icons.notifications_none, color: Colors.white, size: 19),
  ]));
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Meta(this.icon, this.label);

  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Icon(icon, size: 14, color: Colors.white),
    const SizedBox(width: 3),
    Text(label, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
  ]);
}

class _PlanPill extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  const _PlanPill({required this.label, required this.color, required this.textColor});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(22),
      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))]),
    child: Text(label, textAlign: TextAlign.center, maxLines: 1,
      style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.w900)),
  );
}

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFFFFF0A4), Color(0xFFFFC52C), Color(0xFFFFE88C)]),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white, width: 1.5),
      boxShadow: const [BoxShadow(color: Color(0x8875003D), blurRadius: 12, offset: Offset(0, 4))],
    ),
    child: Row(children: const [
      Text('amazon', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w900)),
      SizedBox(width: 10), SizedBox(height: 35, child: VerticalDivider(color: MemberTheme.ink, thickness: 1)),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Big Billion Sale', style: TextStyle(fontSize: 15, color: MemberTheme.red, fontWeight: FontWeight.w900)),
        Text('Up to 40% OFF · Fitness Gear', style: TextStyle(fontSize: 10, color: Colors.black87)),
      ])),
      Icon(Icons.fitness_center, color: MemberTheme.ink, size: 29),
      SizedBox(width: 6),
      DecoratedBox(decoration: BoxDecoration(color: MemberTheme.red, borderRadius: BorderRadius.all(Radius.circular(18))),
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Text('Shop Now ›', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)))),
    ]),
  );
}

class QuickMetricRow extends StatelessWidget {
  const QuickMetricRow({super.key});
  @override
  Widget build(BuildContext context) => Row(children: const [
    Expanded(child: _Metric(Icons.calendar_month, 'Attendance', '81%', MemberTheme.gold, MemberTheme.green)),
    SizedBox(width: 6),
    Expanded(child: _Metric(Icons.fitness_center, 'Workout', '58 min', MemberTheme.berry, Colors.white)),
    SizedBox(width: 6),
    Expanded(child: _Metric(Icons.wallet, 'Payment', '₹500 Due', MemberTheme.berry, Colors.white)),
    SizedBox(width: 6),
    Expanded(child: _Metric(Icons.monitor_weight, 'Body', '69.5 kg', MemberTheme.berry, Colors.white)),
  ]);
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color bg;
  final Color fg;
  const _Metric(this.icon, this.label, this.value, this.bg, this.fg);

  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(minHeight: 56),
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [bg, bg == MemberTheme.gold ? const Color(0xFFFFE68A) : const Color(0xFF8B0646)]),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.white, width: 1.2),
      boxShadow: const [BoxShadow(color: Color(0x66700034), blurRadius: 8, offset: Offset(0, 3))],
    ),
    child: Column(children: [
      Icon(icon, color: bg == MemberTheme.gold ? MemberTheme.ink : Colors.white, size: 19),
      Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,
        style: TextStyle(color: bg == MemberTheme.gold ? MemberTheme.ink : Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
      FittedBox(fit: BoxFit.scaleDown, child: Text(value, style: TextStyle(color: fg, fontSize: 14, fontWeight: FontWeight.w900))),
    ]),
  );
}
