import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../data/sample_member.dart';
import '../theme/member_theme.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) => const Row(
        children: [
          DumbbellMark(),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'BAD ', style: TextStyle(color: Colors.black)),
                      TextSpan(
                        text: 'GYM',
                        style: TextStyle(color: MemberTheme.purple),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: MemberTheme.display,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    height: 0.95,
                    letterSpacing: -0.4,
                  ),
                ),
                Text(
                  'FITNESS MANAGEMENT SYSTEM',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.w800,
                    color: MemberTheme.ink,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

class DumbbellMark extends StatelessWidget {
  const DumbbellMark({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(
        width: 42,
        height: 30,
        child: CustomPaint(painter: _DumbbellPainter()),
      );
}

class _DumbbellPainter extends CustomPainter {
  const _DumbbellPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final plate = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFD946EF), Color(0xFF6D28D9), Color(0xFF3B0764)],
      ).createShader(Offset.zero & size);
    final bar = Paint()..color = const Color(0xFF2A1240);
    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset(cx, cy), width: size.width * 0.42, height: 6),
        const Radius.circular(4),
      ),
      bar,
    );
    for (final dx in [-1.0, 1.0]) {
      final center = Offset(cx + dx * size.width * 0.32, cy);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
              center: center, width: 12, height: size.height * 0.92),
          const Radius.circular(4),
        ),
        plate,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(center.dx + dx * 6, cy),
            width: 7,
            height: size.height * 0.62,
          ),
          const Radius.circular(3),
        ),
        plate,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ActionStrip extends StatelessWidget {
  final bool frozen;
  final VoidCallback onFreeze;
  final VoidCallback onNotify;
  final VoidCallback onCheckIn;

  const ActionStrip({
    super.key,
    required this.frozen,
    required this.onFreeze,
    required this.onNotify,
    required this.onCheckIn,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFFFD76A), width: 1.2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x337A18D1),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onCheckIn,
                  borderRadius: BorderRadius.circular(22),
                  child: Ink(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF8B20D5),
                          Color(0xFF5B0B9A),
                          Color(0xFF3B0764),
                        ],
                      ),
                      border: Border.all(
                        color: const Color(0xFFFFD76A),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        const _CheckBadge(),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'CHECK-IN',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Completed · ${MemberSample.checkInTime}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFFF4E7FF),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: onFreeze,
              borderRadius: BorderRadius.circular(18),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/material_pack/attendance/23_freeze_snowflake_graphic.webp',
                      width: 19,
                      height: 19,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.ac_unit_rounded,
                        color: frozen ? MemberTheme.blue : MemberTheme.deepPurple,
                        size: 19,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      frozen ? 'FROZEN' : 'FREEZE',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: MemberTheme.ink,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: onNotify,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 28, height: 32),
              tooltip: 'Notifications',
              icon: const _Bell(),
            ),
          ],
        ),
      );
}

class _CheckBadge extends StatelessWidget {
  const _CheckBadge();

  @override
  Widget build(BuildContext context) => Container(
        width: 34,
        height: 30,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4ADE80), Color(0xFF16A34A)],
          ),
          boxShadow: [
            BoxShadow(
                color: Color(0x5522C55E), blurRadius: 8, offset: Offset(0, 3))
          ],
        ),
        child: const Icon(Icons.check_rounded, color: Colors.white, size: 22),
      );
}

class _Bell extends StatelessWidget {
  const _Bell();

  @override
  Widget build(BuildContext context) => const SizedBox(
        width: 28,
        height: 28,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.notifications_rounded, color: MemberTheme.ink, size: 24),
            Positioned(
              right: -1,
              top: -1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: MemberTheme.red, shape: BoxShape.circle),
                child: SizedBox(width: 9, height: 9),
              ),
            ),
          ],
        ),
      );
}

class MemberProfileCard extends StatelessWidget {
  const MemberProfileCard({super.key});

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _Portrait(),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  MemberSample.name,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                const Wrap(
                  spacing: 8,
                  runSpacing: 2,
                  children: [
                    _Meta(Icons.calendar_month_rounded, MemberSample.memberId),
                    _Meta(Icons.person_rounded, MemberSample.ageLabel),
                    _Meta(Icons.male_rounded, MemberSample.gender),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Expanded(child: _GoldPill()),
                    SizedBox(width: 6),
                    Expanded(child: _ActivePill()),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
}

class _Portrait extends StatelessWidget {
  const _Portrait();

  @override
  Widget build(BuildContext context) => Container(
        width: 88,
        height: 102,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF0ABFC), Color(0xFF7C3AED), Color(0xFF4C1D95)],
          ),
          image: const DecorationImage(
            image: AssetImage('assets/material_pack/membership/10_gold_photo_backplate.webp'),
            fit: BoxFit.contain,
          ),
          boxShadow: const [
            BoxShadow(
                color: Color(0x887C3AED), blurRadius: 16, offset: Offset(0, 6)),
          ],
        ),
        padding: const EdgeInsets.all(3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: Image.asset(
            'assets/material_pack/images/01_member_bodybuilder.webp',
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
            errorBuilder: (context, error, stackTrace) => const ColoredBox(
              color: MemberTheme.deepPurple,
              child: Icon(Icons.fitness_center, color: Colors.white, size: 36),
            ),
          ),
        ),
      );
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Meta(this.icon, this.text);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: MemberTheme.deepPurple),
          const SizedBox(width: 3),
          Text(
            text,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: MemberTheme.ink),
          ),
        ],
      );
}

class _GoldPill extends StatelessWidget {
  const _GoldPill();

  @override
  Widget build(BuildContext context) => Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              colors: [Color(0xFFFFE082), MemberTheme.gold, Color(0xFFF5B301)]),
          image: const DecorationImage(
            image: AssetImage('assets/material_pack/membership/21_gold_plan_badge_background.webp'),
            fit: BoxFit.contain,
          ),
          border: Border.all(color: Colors.white, width: 1.4),
          boxShadow: const [
            BoxShadow(
                color: Color(0x44E39B00), blurRadius: 8, offset: Offset(0, 3))
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.workspace_premium_rounded,
                size: 16, color: MemberTheme.deepPurple),
            SizedBox(width: 4),
            Flexible(
              child: Text(
                MemberSample.plan,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: MemberTheme.deepPurple),
              ),
            ),
          ],
        ),
      );
}

class _ActivePill extends StatelessWidget {
  const _ActivePill();

  @override
  Widget build(BuildContext context) => Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              colors: [Color(0xFF4ADE80), Color(0xFF16A34A)]),
          image: const DecorationImage(
            image: AssetImage('assets/material_pack/membership/22_green_active_badge_background.webp'),
            fit: BoxFit.contain,
          ),
          border: Border.all(color: Colors.white, width: 1.4),
          boxShadow: const [
            BoxShadow(
                color: Color(0x4416A34A), blurRadius: 8, offset: Offset(0, 3))
          ],
        ),
        child: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_rounded, size: 16, color: Colors.white),
              SizedBox(width: 4),
              Text(
                'Active',
                maxLines: 1,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      );
}

class PaymentStrip extends StatelessWidget {
  const PaymentStrip({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(8, 6, 6, 6),
        decoration: MemberTheme.glass(radius: 22),
        child: Row(
          children: [
            const _IconBlob(
                icon: Icons.account_balance_wallet_rounded,
                color: MemberTheme.purple),
            const SizedBox(width: 6),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Payment',
                      style: TextStyle(
                          fontSize: 10,
                          color: MemberTheme.muted,
                          fontWeight: FontWeight.w700)),
                  Text(
                    MemberSample.dueLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: MemberTheme.purple),
                  ),
                ],
              ),
            ),
            Container(width: 1, height: 36, color: MemberTheme.line),
            const SizedBox(width: 8),
            const Icon(Icons.calendar_month_rounded,
                color: MemberTheme.purple, size: 22),
            const SizedBox(width: 4),
            const Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MemberSample.daysLeftLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: MemberTheme.purple),
                  ),
                  Text(
                    'Expires: ${MemberSample.expiresLabel}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 10,
                        color: MemberTheme.muted,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: MemberTheme.line),
              ),
              child: QrImageView(
                data: MemberSample.qrPayload,
                version: QrVersions.auto,
                size: 40,
                padding: EdgeInsets.zero,
                eyeStyle: QrEyeStyle(
                    eyeShape: QrEyeShape.square, color: MemberTheme.ink),
                dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: MemberTheme.ink),
              ),
            ),
          ],
        ),
      );
}

class _IconBlob extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _IconBlob({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 22),
      );
}

class MembershipProgress extends StatelessWidget {
  const MembershipProgress({super.key});

  @override
  Widget build(BuildContext context) {
    const fraction = MemberSample.membershipDone / MemberSample.membershipTotal;
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: Text(
                'Membership ${MemberSample.membershipDone} / ${MemberSample.membershipTotal} Days',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: MemberTheme.ink),
              ),
            ),
            Text('73%',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: MemberTheme.ink)),
          ],
        ),
        const SizedBox(height: 6),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            height: 10,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: constraints.maxWidth * fraction,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFE879F9),
                      Color(0xFF8B5CF6),
                      Color(0xFF6D28D9)
                    ],
                  ),
                  boxShadow: const [
                    BoxShadow(color: Color(0xAA7C3AED), blurRadius: 8)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PromoBanner extends StatelessWidget {
  final VoidCallback onShop;
  const PromoBanner({super.key, required this.onShop});

  @override
  Widget build(BuildContext context) => Container(
        height: 86,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            colors: [Color(0xFFFFE9A6), Color(0xFFFFC928), Color(0xFF9B35E8)],
          ),
          border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: const [
            BoxShadow(color: Color(0x667A18D1), blurRadius: 12, offset: Offset(0, 4)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(17),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final narrow = constraints.maxWidth < 300;
              final compact = constraints.maxWidth < 330;
              return DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF3B0764), Color(0xFF7E22CE), Color(0xFF581C87)],
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: narrow ? 38 : compact ? 46 : 58,
                      child: Image.asset('assets/material_pack/illustrations/02_red_gold_gift_box.webp', fit: BoxFit.contain),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Big Billion Sale', maxLines: 1, overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontFamily: MemberTheme.sale, color: MemberTheme.gold, fontSize: narrow ? 15 : 19, height: 1.05)),
                            Text('Up to 40% OFF', maxLines: 1, overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white, fontSize: narrow ? 11 : 14, fontWeight: FontWeight.w900)),
                            if (!narrow)
                              const Text('Fitness Gear · Supplements · Nutrition', maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Color(0xFFF3E8FF), fontSize: 7, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ),
                    if (!narrow)
                      SizedBox(
                        width: compact ? 28 : 42,
                        child: Image.asset('assets/material_pack/offers-promotions/03_whey_protein_tub.webp', fit: BoxFit.contain),
                      ),
                    const SizedBox(width: 2),
                    FilledButton(
                      onPressed: onShop,
                      style: FilledButton.styleFrom(
                        backgroundColor: MemberTheme.pink,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: narrow ? 5 : compact ? 6 : 9, vertical: 7),
                        minimumSize: const Size(0, 32),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: const StadiumBorder(side: BorderSide(color: Colors.white, width: 1.1)),
                        textStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: narrow ? 8 : 10),
                      ),
                      child: const Text('Shop Now ›'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
}

class EquipmentFooter extends StatelessWidget {
  const EquipmentFooter({super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: 72,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/material_pack/backgrounds/09_footer_purple_gold_wave.webp'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _Kit(
                icon: Icons.sports_gymnastics_rounded,
                label: 'Yoga',
                color: Color(0xFF2A1240)),
            SizedBox(width: 10),
            _Kit(
                icon: Icons.water_drop_rounded,
                label: 'Bottle',
                color: Color(0xFF94A3B8)),
            SizedBox(width: 10),
            _Kit(
                icon: Icons.dry_cleaning_rounded,
                label: 'Travel',
                color: MemberTheme.violet),
            Spacer(),
            Icon(Icons.album_rounded, color: Color(0xFF1F2937), size: 42),
            Icon(Icons.album_rounded, color: Color(0xFF111827), size: 34),
          ],
        ),
      );
}

class _Kit extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _Kit({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 28),
          Text(label,
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: MemberTheme.muted)),
        ],
      );
}
