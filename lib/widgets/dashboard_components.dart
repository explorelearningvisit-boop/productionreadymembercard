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
                    fontSize: 28,
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
        padding: const EdgeInsets.fromLTRB(8, 7, 8, 7),
        decoration: MemberTheme.glass(radius: 28),
        child: Row(
          children: [
            const _CheckBadge(),
            const SizedBox(width: 6),
            Expanded(
              child: InkWell(
                onTap: onCheckIn,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CHECK-IN',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: MemberTheme.ink,
                      ),
                    ),
                    Text(
                      'Completed · ${MemberSample.checkInTime}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 9,
                        color: MemberTheme.muted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(width: 1, height: 32, color: MemberTheme.line),
            InkWell(
              onTap: onFreeze,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.ac_unit_rounded,
                      color: frozen ? MemberTheme.blue : MemberTheme.deepPurple,
                      size: 18,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      frozen ? 'FROZEN' : 'FREEZE',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: MemberTheme.ink,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(width: 1, height: 32, color: MemberTheme.line),
            IconButton(
              onPressed: onNotify,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 34, height: 34),
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
        height: 34,
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
                  'Welcome Back 👋',
                  style: TextStyle(
                    fontFamily: MemberTheme.script,
                    fontSize: 26,
                    color: MemberTheme.deepPurple,
                    height: 1,
                  ),
                ),
                const Text(
                  MemberSample.name,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.05,
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
        width: 102,
        height: 118,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF0ABFC), Color(0xFF7C3AED), Color(0xFF4C1D95)],
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
            'assets/images/member_portrait.png',
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
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
                fontSize: 11,
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
        height: 34,
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
        height: 34,
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_rounded, size: 16, color: Colors.white),
            SizedBox(width: 4),
            Text(
              'Active',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
          ],
        ),
      );
}

class PaymentStrip extends StatelessWidget {
  const PaymentStrip({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
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
                        fontSize: 16,
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
                        fontSize: 16,
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
                size: 46,
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
        width: 36,
        height: 36,
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
            height: 14,
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
              colors: [Color(0xFFF5D0FE), Color(0xFFC4B5FD), Colors.white]),
          boxShadow: const [
            BoxShadow(
                color: Color(0x667C3AED), blurRadius: 16, offset: Offset(0, 6))
          ],
        ),
        padding: const EdgeInsets.all(2),
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF3B0764), Color(0xFF7E22CE), Color(0xFF581C87)],
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BAD GYM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        height: 1,
                      ),
                    ),
                    Text(
                      'Big Billion Sale',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: MemberTheme.sale,
                        color: MemberTheme.gold,
                        fontSize: 20,
                        height: 1.15,
                      ),
                    ),
                    Text(
                      'Up to 40% OFF - Fitness Gear',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.fitness_center_rounded,
                  color: Color(0xFFF0ABFC), size: 28),
              const SizedBox(width: 6),
              FilledButton(
                onPressed: onShop,
                style: FilledButton.styleFrom(
                  backgroundColor: MemberTheme.pink,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: const Size(0, 34),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const StadiumBorder(
                      side: BorderSide(color: Colors.white, width: 1.2)),
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 12),
                ),
                child: const Text('Shop Now ›'),
              ),
            ],
          ),
        ),
      );
}

class EquipmentFooter extends StatelessWidget {
  const EquipmentFooter({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(
        height: 72,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _Kit(
                icon: Icons.sports_gymnastics_rounded,
                label: 'Kettle',
                color: Color(0xFF2A1240)),
            SizedBox(width: 10),
            _Kit(
                icon: Icons.water_drop_rounded,
                label: 'Bottle',
                color: Color(0xFF94A3B8)),
            SizedBox(width: 10),
            _Kit(
                icon: Icons.dry_cleaning_rounded,
                label: 'Towel',
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
