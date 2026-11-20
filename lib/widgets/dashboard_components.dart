import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/member_theme.dart';

enum MemberPlanTier { gold, silver, spark }

class MemberProfileCard extends StatelessWidget {
  final MemberPlanTier planTier;
  const MemberProfileCard({super.key, this.planTier = MemberPlanTier.gold});

  Color get _tierColor => switch (planTier) {
        MemberPlanTier.gold => MemberTheme.gold,
        MemberPlanTier.silver => const Color(0xFFE5EAF0),
        MemberPlanTier.spark => MemberTheme.emerald,
      };

  String get _tierLabel => switch (planTier) {
        MemberPlanTier.gold => '♛ Gold Plan',
        MemberPlanTier.silver => '◇ Silver Plan',
        MemberPlanTier.spark => '✦ Spark Plan',
      };

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(11, 9, 11, 11),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xF4FFFFFF), Color(0xD9E7FFFF), Color(0xE2E0F9F2)],
          ),
          borderRadius: BorderRadius.circular(27),
          border: Border.all(color: Colors.white, width: 1.8),
          boxShadow: const [
            BoxShadow(color: Color(0x33006451), blurRadius: 22, offset: Offset(0, 8)),
            BoxShadow(color: Color(0xBFFFFFFF), blurRadius: 5, offset: Offset(-2, -2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _CheckInFreezeActions(),
            const SizedBox(height: 9),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 76,
                  height: 84,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [MemberTheme.leaf, MemberTheme.mint],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: const [
                      BoxShadow(color: Color(0x4400B64B), blurRadius: 12, offset: Offset(0, 4)),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/images/member_portrait.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomCenter,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.fitness_center, size: 38, color: MemberTheme.forest,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Welcome Back 👋',
                        style: TextStyle(
                          color: MemberTheme.forest, fontSize: 12,
                          fontWeight: FontWeight.w800, fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text('Ashwani Kumar Singh',
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: MemberTheme.ink, fontWeight: FontWeight.w900,
                          fontSize: 18, height: 1.08,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Wrap(
                        spacing: 9, runSpacing: 3,
                        children: [
                          _Meta(Icons.badge_outlined, 'BG215'),
                          _Meta(Icons.person_outline, '28 Yrs'),
                          _Meta(Icons.male, 'Male'),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          Expanded(child: _PlanPill(
                            label: _tierLabel, color: _tierColor,
                            textColor: planTier == MemberPlanTier.spark
                                ? Colors.white : const Color(0xFF5A3500),
                          )),
                          const SizedBox(width: 6),
                          const Expanded(child: _PlanPill(
                            label: '✓ Active', color: MemberTheme.emerald,
                            textColor: Colors.white,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xEFFFFFFF),
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: Colors.white, width: 1.5),
                boxShadow: const [
                  BoxShadow(color: Color(0x18005243), blurRadius: 9, offset: Offset(0, 3)),
                ],
              ),
              child: Row(
                children: [
                  const _PaymentIcon(),
                  const SizedBox(width: 7),
                  const Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Payment', style: TextStyle(color: MemberTheme.muted, fontSize: 9)),
                      SizedBox(height: 1),
                      Text('₹500 Due', style: TextStyle(color: MemberTheme.red, fontSize: 16, fontWeight: FontWeight.w900)),
                    ],
                  )),
                  Container(width: 1, height: 38, color: MemberTheme.line),
                  const SizedBox(width: 9),
                  const Icon(Icons.event_available, color: MemberTheme.red, size: 22),
                  const SizedBox(width: 5),
                  const Expanded(flex: 2, child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('8 Days Left', style: TextStyle(color: MemberTheme.red, fontSize: 15, fontWeight: FontWeight.w900)),
                      Text('Expires: 24 Oct 2026', style: TextStyle(color: MemberTheme.ink, fontSize: 9)),
                    ],
                  )),
                  QrImageView(
                    data: 'BADGYM:BG215', version: QrVersions.auto, size: 49,
                    padding: const EdgeInsets.all(1),
                    errorCorrectionLevel: QrErrorCorrectLevel.H,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 9),
            const Row(
              children: [
                Expanded(child: Text('Membership 22 / 30 Days',
                  style: TextStyle(color: MemberTheme.ink, fontSize: 11, fontWeight: FontWeight.w900))),
                Text('73%', style: TextStyle(color: MemberTheme.ink, fontSize: 13, fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 1.4),
                ),
                child: const LinearProgressIndicator(
                  value: .73, minHeight: 9,
                  backgroundColor: Color(0xFFD5EDE7),
                  valueColor: AlwaysStoppedAnimation(MemberTheme.emerald),
                ),
              ),
            ),
          ],
        ),
      );
}

class _PaymentIcon extends StatelessWidget {
  const _PaymentIcon();
  @override
  Widget build(BuildContext context) => Container(
    width: 34, height: 34,
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [MemberTheme.leaf, MemberTheme.emerald]),
      borderRadius: BorderRadius.circular(10),
    ),
    child: const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 20),
  );
}

class _CheckInFreezeActions extends StatelessWidget {
  const _CheckInFreezeActions();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: const Color(0xDFFFFFFF),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: Colors.white, width: 1.5),
      boxShadow: const [BoxShadow(color: Color(0x1C005A4A), blurRadius: 10, offset: Offset(0, 3))],
    ),
    child: Row(
      children: [
        const CircleAvatar(
          radius: 14, backgroundColor: MemberTheme.emerald,
          child: Icon(Icons.check, color: Colors.white, size: 19),
        ),
        const SizedBox(width: 7),
        const Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CHECK-IN', style: TextStyle(color: MemberTheme.ink, fontSize: 11, fontWeight: FontWeight.w900)),
            Text('Completed · 07:12 AM', style: TextStyle(color: MemberTheme.muted, fontSize: 8)),
          ],
        )),
        Container(width: 1, height: 34, color: MemberTheme.line),
        const SizedBox(width: 10),
        const Icon(Icons.ac_unit, color: MemberTheme.forest, size: 20),
        const SizedBox(width: 5),
        const Text('FREEZE', style: TextStyle(color: MemberTheme.ink, fontWeight: FontWeight.w900, fontSize: 11)),
        const Spacer(),
        const Icon(Icons.notifications_none, color: MemberTheme.ink, size: 22),
      ],
    ),
  );
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Meta(this.icon, this.label);
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 14, color: MemberTheme.forest),
      const SizedBox(width: 3),
      Text(label, style: const TextStyle(color: MemberTheme.ink, fontSize: 10, fontWeight: FontWeight.w700)),
    ],
  );
}

class _PlanPill extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  const _PlanPill({required this.label, required this.color, required this.textColor});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [color, color.withValues(alpha: .78)]),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white.withValues(alpha: .95), width: 1.2),
      boxShadow: const [BoxShadow(color: Color(0x22004C32), blurRadius: 8, offset: Offset(0, 3))],
    ),
    child: Text(label, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis,
      style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.w900)),
  );
}

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF063F36), Color(0xFF087C53), Color(0xFFB5F52B)],
        begin: Alignment.centerLeft, end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(21),
      border: Border.all(color: Colors.white, width: 1.5),
      boxShadow: const [BoxShadow(color: Color(0x3300784E), blurRadius: 16, offset: Offset(0, 5))],
    ),
    child: Row(
      children: [
        const Text('BAD\nGYM', style: TextStyle(
          color: Colors.white, fontSize: 17, height: .95, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic,
        )),
        Container(width: 1, height: 43, margin: const EdgeInsets.symmetric(horizontal: 10), color: Colors.white70),
        const Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Big Billion Sale', style: TextStyle(color: MemberTheme.leaf, fontSize: 15, fontWeight: FontWeight.w900)),
            SizedBox(height: 3),
            Text('Up to 40% OFF – Fitness Gear', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w600)),
          ],
        )),
        const Icon(Icons.fitness_center_rounded, color: MemberTheme.leaf, size: 30),
        const SizedBox(width: 7),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
          decoration: BoxDecoration(color: MemberTheme.leaf, borderRadius: BorderRadius.circular(20)),
          child: const Text('Shop Now ›', style: TextStyle(color: Color(0xFF153B21), fontSize: 9, fontWeight: FontWeight.w900)),
        ),
      ],
    ),
  );
}

class QuickMetricRow extends StatelessWidget {
  const QuickMetricRow({super.key});
  @override
  Widget build(BuildContext context) => const Row(
    children: [
      Expanded(child: _Metric(Icons.calendar_month_rounded, 'Attendance', '81%', MemberTheme.emerald, Color(0xFFE7FFF0))),
      SizedBox(width: 6),
      Expanded(child: _Metric(Icons.fitness_center_rounded, 'Workout', '58 min', MemberTheme.purple, Color(0xFFF5E9FF))),
      SizedBox(width: 6),
      Expanded(child: _Metric(Icons.wallet_outlined, 'Payment', '₹500 Due', MemberTheme.red, Color(0xFFFFECE9))),
      SizedBox(width: 6),
      Expanded(child: _Metric(Icons.monitor_weight_outlined, 'Body', '69.5 kg', MemberTheme.teal, Color(0xFFE2FAFF))),
    ],
  );
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accent;
  final Color tint;
  const _Metric(this.icon, this.label, this.value, this.accent, this.tint);

  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(minHeight: 82),
    padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 3),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: [Colors.white, tint, Colors.white],
      ),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: Colors.white, width: 1.6),
      boxShadow: const [
        BoxShadow(color: Color(0x22005D4A), blurRadius: 12, offset: Offset(0, 5)),
        BoxShadow(color: Color(0xBFFFFFFF), blurRadius: 4, offset: Offset(-2, -2)),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: accent, size: 23),
        const SizedBox(height: 4),
        Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: MemberTheme.ink, fontSize: 9, fontWeight: FontWeight.w800)),
        const SizedBox(height: 2),
        FittedBox(fit: BoxFit.scaleDown, child: Text(value,
          style: TextStyle(color: accent == MemberTheme.red ? MemberTheme.red : MemberTheme.ink, fontSize: 15, fontWeight: FontWeight.w900))),
      ],
    ),
  );
}
