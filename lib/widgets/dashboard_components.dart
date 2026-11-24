import 'package:flutter/material.dart';
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
  final VoidCallback onCheckIn;

  const ActionStrip({
    super.key,
    required this.frozen,
    required this.onFreeze,
    required this.onCheckIn,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: _ActionCard(
              onTap: onCheckIn,
              gradient: const [Color(0xFF8B20D5), Color(0xFF4C087E)],
              imageAsset: 'assets/material_pack/pulsevault/05_purple_gold_cta_background.png',
              child: Row(
                children: [
                  const _CheckBadge(),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('CHECK-IN',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Colors.white)),
                        Text(MemberSample.checkInTime,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFF4E7FF))),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/material_pack/pulsevault/10_member_bodybuilder_cutout.png',
                    width: 38,
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _ActionCard(
              onTap: onFreeze,
              gradient: const [Color(0xFFFFFFFF), Color(0xFFDCEBFF)],
              imageAsset: 'assets/material_pack/pulsevault/14_lavender_glass_cta_background.png',
              child: Row(
                children: [
                  const Icon(Icons.ac_unit_rounded,
                      color: Color(0xFF4F46E5), size: 31),
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(frozen ? 'FROZEN' : 'FREEZE',
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: MemberTheme.deepPurple)),
                        const Text('Stay Cool · Pause Plan',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                                color: MemberTheme.ink)),
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: const BoxDecoration(
                              color: Color(0xFFE11D48),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: const Text('UP TO 20% OFF',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/material_pack/pulsevault/08_purple_shaker_bottle_cutout.png',
                    width: 34,
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}

class _ActionCard extends StatelessWidget {
  final VoidCallback onTap;
  final List<Color> gradient;
  final String? imageAsset;
  final Widget child;

  const _ActionCard({
    required this.onTap,
    required this.gradient,
    this.imageAsset,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            height: 58,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradient),
                      fit: BoxFit.fill,
                      opacity: 0.94,
                    ),
              border: Border.all(color: const Color(0xFFFFD76A), width: 1.3),
              boxShadow: const [
                BoxShadow(
                    color: Color(0x447A18D1),
                    blurRadius: 9,
                    offset: Offset(0, 3)),
              ],
            ),
            child: child,
          ),
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
        width: 94,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          image: const DecorationImage(
            image: AssetImage('assets/material_pack/membership/10_gold_photo_backplate.webp'),
            fit: BoxFit.cover,
          ),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFE66D), Color(0xFFFFC928), Color(0xFF7C3AED)],
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
            'assets/material_pack/pulsevault/10_member_bodybuilder_cutout.png',
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

  void _showPaymentDue(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        icon: const CircleAvatar(radius: 26, backgroundColor: Color(0xFFF3E8FF),
          child: Icon(Icons.account_balance_wallet_rounded, color: MemberTheme.purple, size: 28)),
        title: const Text('Payment due', textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, color: MemberTheme.ink)),
        content: const Column(mainAxisSize: MainAxisSize.min, children: [
          Text(MemberSample.dueLabel, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: MemberTheme.purple)),
          SizedBox(height: 5),
          Text('Gold Plan renewal · ${MemberSample.expiresLabel}', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: MemberTheme.muted, fontWeight: FontWeight.w600)),
          SizedBox(height: 10),
          Text('Sample reminder only. Online payment is not connected yet.', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: MemberTheme.muted)),
        ]),
        actionsAlignment: MainAxisAlignment.center,
        actions: [FilledButton(onPressed: () => Navigator.pop(dialogContext),
          style: FilledButton.styleFrom(backgroundColor: MemberTheme.purple, foregroundColor: Colors.white,
            minimumSize: const Size(140, 42), shape: const StadiumBorder()), child: const Text('Got it'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Semantics(
          button: true,
          label: 'Payment due ${MemberSample.dueLabel}. Tap for reminder details.',
          child: GestureDetector(
            onTap: () => _showPaymentDue(context),
            child: Container(
              constraints: const BoxConstraints(minHeight: 72),
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              decoration: MemberTheme.glass(radius: 20),
              child: Row(
                children: [
                  const _IconBlob(
                    icon: Icons.account_balance_wallet_rounded,
                    color: MemberTheme.purple,
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PAYMENT DUE',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 9,
                            color: MemberTheme.muted,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.25,
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            MemberSample.dueLabel,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 18,
                              height: 1.05,
                              fontWeight: FontWeight.w900,
                              color: MemberTheme.purple,
                            ),
                          ),
                        ),
                        Text(
                          MemberSample.daysLeftLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 9,
                            color: MemberTheme.ink,
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: MemberTheme.ink),
              ),
            ),
            SizedBox(width: 5),
            Text('8 Days Left',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: MemberTheme.purple)),
            SizedBox(width: 6),
            Text('73%',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: MemberTheme.ink)),
          ],
        ),
        const SizedBox(height: 6),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: fraction),
          duration: const Duration(milliseconds: 850),
          curve: Curves.easeOutCubic,
          builder: (context, progress, child) => ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(height: 10, child: Stack(children: [
              Positioned.fill(child: ColoredBox(color: Colors.white.withValues(alpha: 0.85))),
              FractionallySizedBox(widthFactor: progress, alignment: Alignment.centerLeft,
                child: DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(
                  colors: [Color(0xFFE879F9), Color(0xFF8B5CF6), Color(0xFF6D28D9)],
                )))),
            ])),
          ),
        ),
      ],
    );
  }
}

class PromoBanner extends StatefulWidget {
  final VoidCallback onShop;
  const PromoBanner({super.key, required this.onShop});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1450),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _pulse,
        builder: (context, child) => Transform.scale(
          scale: 1 + (_pulse.value * 0.012),
          child: child,
        ),
        child: Container(
        height: 76,
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
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
                      width: narrow ? 60 : compact ? 66 : 72,
                      child: Image.asset('assets/material_pack/pulsevault/01_whey_protein_tub_cutout.png', fit: BoxFit.contain),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Whey Protein', maxLines: 1, overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontFamily: MemberTheme.sale, color: MemberTheme.gold, fontSize: narrow ? 16 : 20, height: 1.05)),
                            Text('25% OFF', maxLines: 1, overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white, fontSize: narrow ? 12 : 14, fontWeight: FontWeight.w900)),
                            if (!narrow)
                              const Text('Build · Recover · Grow', maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Color(0xFFF3E8FF), fontSize: 7, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    FilledButton(
                      onPressed: widget.onShop,
                      style: FilledButton.styleFrom(
                        backgroundColor: MemberTheme.pink,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: narrow ? 5 : compact ? 6 : 9, vertical: 7),
                        minimumSize: const Size(0, 32),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: const StadiumBorder(side: BorderSide(color: Colors.white, width: 1.1)),
                        textStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: narrow ? 8 : 10),
                      ),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 650),
                        opacity: _pulse.value > 0.5 ? 1 : 0.82,
                        child: const Text('Buy Now ›'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF35105B), Color(0xFF7A18D1), Color(0xFF35105B)],
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
