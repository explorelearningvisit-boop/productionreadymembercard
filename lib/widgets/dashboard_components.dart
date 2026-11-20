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
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Color(0xFFF0F8F1), Color(0xFFE5F3E8)],
          ),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white, width: 1.6),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1B164C32),
              blurRadius: 18,
              offset: Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _CheckInFreezeActions(),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 64,
                  height: 68,
                  decoration: BoxDecoration(
                    color: MemberTheme.mint,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/images/member_portrait.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomCenter,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.fitness_center,
                      size: 36,
                      color: MemberTheme.forest,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'WELCOME BACK 👋',
                        style: TextStyle(
                          color: MemberTheme.muted,
                          fontSize: 9,
                          letterSpacing: 1.05,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Ashwani Kumar Singh',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: MemberTheme.ink,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Wrap(
                        spacing: 9,
                        runSpacing: 3,
                        children: [
                          _Meta(Icons.badge_outlined, 'BG215'),
                          _Meta(Icons.person_outline, '28 Yrs'),
                          _Meta(Icons.male, 'Male'),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          Expanded(
                            child: _PlanPill(
                              label: _tierLabel,
                              color: _tierColor,
                              textColor: planTier == MemberPlanTier.spark
                                  ? Colors.white
                                  : MemberTheme.ink,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Expanded(
                            child: _PlanPill(
                              label: '✓ Active',
                              color: Color(0xFFDDF4E5),
                              textColor: MemberTheme.forest,
                            ),
                          ),
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
              decoration: MemberTheme.softSurface(radius: 16, tint: Colors.white),
              child: Row(
                children: [
                  const _PaymentIcon(),
                  const SizedBox(width: 7),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PAYMENT',
                            style: TextStyle(
                                color: MemberTheme.muted,
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                                letterSpacing: .6)),
                        SizedBox(height: 1),
                        Text('₹500 Due',
                            style: TextStyle(
                                color: MemberTheme.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 34, color: MemberTheme.line),
                  const SizedBox(width: 9),
                  const Icon(Icons.event_available,
                      color: MemberTheme.forest, size: 20),
                  const SizedBox(width: 5),
                  const Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('8 Days Left',
                            style: TextStyle(
                                color: MemberTheme.forest,
                                fontSize: 13,
                                fontWeight: FontWeight.w900)),
                        Text('Expires: 24 Oct 2026',
                            style: TextStyle(
                                color: MemberTheme.muted, fontSize: 8)),
                      ],
                    ),
                  ),
                  QrImageView(
                    data: 'BADGYM:BG215',
                    version: QrVersions.auto,
                    size: 42,
                    padding: const EdgeInsets.all(1),
                    errorCorrectionLevel: QrErrorCorrectLevel.H,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 9),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'MEMBERSHIP · 22 / 30 DAYS',
                    style: TextStyle(
                      color: MemberTheme.ink,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: .45,
                    ),
                  ),
                ),
                Text('73%',
                    style: TextStyle(
                        color: MemberTheme.forest,
                        fontSize: 12,
                        fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const LinearProgressIndicator(
                value: .73,
                minHeight: 7,
                backgroundColor: Color(0xFFDCE9DE),
                valueColor: AlwaysStoppedAnimation(MemberTheme.emerald),
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
        width: 31,
        height: 31,
        decoration: BoxDecoration(
          color: MemberTheme.mint,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.account_balance_wallet_outlined,
            color: MemberTheme.forest, size: 18),
      );
}

class _CheckInFreezeActions extends StatelessWidget {
  const _CheckInFreezeActions();

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFFDDF4E5),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 11,
                  backgroundColor: MemberTheme.forest,
                  child: Icon(Icons.check, color: Colors.white, size: 14),
                ),
                SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CHECK-IN',
                        style: TextStyle(
                            color: MemberTheme.forest,
                            fontSize: 10,
                            fontWeight: FontWeight.w900)),
                    Text('Completed · 07:12 AM',
                        style: TextStyle(
                            color: MemberTheme.muted, fontSize: 7)),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: MemberTheme.line),
            ),
            child: const Row(
              children: [
                Icon(Icons.ac_unit, color: MemberTheme.forest, size: 16),
                SizedBox(width: 5),
                Text('FREEZE',
                    style: TextStyle(
                        color: MemberTheme.forest,
                        fontWeight: FontWeight.w900,
                        fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.notifications_none,
              color: MemberTheme.forest, size: 21),
        ],
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
          Icon(icon, size: 12, color: MemberTheme.muted),
          const SizedBox(width: 3),
          Text(label,
              style: const TextStyle(
                  color: MemberTheme.muted,
                  fontSize: 9,
                  fontWeight: FontWeight.w700)),
        ],
      );
}

class _PlanPill extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  const _PlanPill(
      {required this.label, required this.color, required this.textColor});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Text(label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: textColor, fontSize: 10, fontWeight: FontWeight.w900)),
      );
}

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF174F37), Color(0xFF0B8F61)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(17),
          boxShadow: const [
            BoxShadow(
                color: Color(0x1D164C32),
                blurRadius: 12,
                offset: Offset(0, 4))
          ],
        ),
        child: const Row(
          children: [
            Icon(Icons.workspace_premium_outlined,
                color: MemberTheme.leaf, size: 25),
            SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('MEMBER PERKS',
                      style: TextStyle(
                          color: MemberTheme.leaf,
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1)),
                  Text('Train better. Get rewarded.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w900)),
                  Text('Exclusive fitness benefits & offers',
                      style: TextStyle(
                          color: Colors.white70, fontSize: 8)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_rounded,
                color: Colors.white, size: 20),
          ],
        ),
      );
}

class QuickMetricRow extends StatelessWidget {
  const QuickMetricRow({super.key});
  @override
  Widget build(BuildContext context) => const Row(
        children: [
          Expanded(
              child: _Metric(Icons.calendar_month_rounded, 'Attendance',
                  '81%', MemberTheme.forest)),
          SizedBox(width: 6),
          Expanded(
              child: _Metric(
                  Icons.fitness_center_rounded, 'Workout', '58 min',
                  MemberTheme.blue)),
          SizedBox(width: 6),
          Expanded(
              child: _Metric(Icons.wallet_outlined, 'Payment', '₹500 Due',
                  MemberTheme.red)),
          SizedBox(width: 6),
          Expanded(
              child: _Metric(Icons.monitor_weight_outlined, 'Body', '69.5 kg',
                  MemberTheme.purple)),
        ],
      );
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accent;
  const _Metric(this.icon, this.label, this.value, this.accent);

  @override
  Widget build(BuildContext context) => Container(
        constraints: const BoxConstraints(minHeight: 70),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
        decoration: MemberTheme.card(radius: 15, elevated: false).copyWith(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Icon(icon, color: accent, size: 18),
            const SizedBox(height: 4),
            Text(label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: MemberTheme.muted,
                    fontSize: 8,
                    fontWeight: FontWeight.w800)),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(value,
                  style: TextStyle(
                      color: accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      );
}
