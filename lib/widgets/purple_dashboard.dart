import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  bool notificationRead = false;

  static const labels = ['Home', 'Attend', 'Workout', 'Pay', 'Offers', 'History'];
  static const spriteIcons = [0, 1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _brand(),
        const SizedBox(height: 6),
        _checkInBar(),
        const SizedBox(height: 7),
        _memberHero(),
        const SizedBox(height: 7),
        _paymentStrip(),
        const SizedBox(height: 5),
        _membershipProgress(),
        const SizedBox(height: 8),
        _saleBanner(),
        const SizedBox(height: 7),
        _metricStrip(),
        const SizedBox(height: 8),
        _attendanceIntelligence(),
        const SizedBox(height: 5),
        _gymFloor(),
      ],
    );
  }

  Widget _brand() => SizedBox(
    height: 46,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        Positioned(
          right: 2, top: -9,
          child: Transform.rotate(
            angle: -.16,
            child: Icon(Icons.fitness_center_rounded, size: 64,
              color: MemberTheme.purple.withValues(alpha: .19)),
          ),
        ),
        Row(children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [Color(0xFFE9B9FF), MemberTheme.purple]),
              boxShadow: const [BoxShadow(color: Color(0x667900C8), blurRadius: 9, offset: Offset(0, 3))],
              border: Border.all(color: Colors.white, width: 1.4),
            ),
            child: const AssetSprite(index: 2, size: 25),
          ),
          const SizedBox(width: 7),
          const Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('BAD GYM', style: TextStyle(fontSize: 25, height: .91,
                fontWeight: FontWeight.w900, fontStyle: FontStyle.italic,
                letterSpacing: -.9, color: Colors.black)),
              SizedBox(height: 3),
              Text('FITNESS MANAGEMENT SYSTEM', style: TextStyle(fontSize: 8.3,
                height: 1, letterSpacing: .65, fontWeight: FontWeight.w900, color: MemberTheme.ink)),
            ],
          )),
          const SizedBox(width: 62),
        ]),
      ],
    ),
  );

  Widget _checkInBar() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: MemberTheme.glass(radius: 24),
    child: Row(children: [
      _roundIcon(Icons.check_rounded, MemberTheme.green, 34),
      const SizedBox(width: 8),
      const Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('CHECK-IN', style: TextStyle(fontSize: 15, height: 1,
            fontWeight: FontWeight.w900, color: Colors.black)),
          SizedBox(height: 3),
          Text('Completed  ·  07:12 AM', style: TextStyle(fontSize: 9.5,
            height: 1, fontWeight: FontWeight.w600, color: MemberTheme.ink)),
        ],
      )),
      _verticalDivider(34),
      const SizedBox(width: 7),
      InkWell(
        onTap: () => setState(() => frozen = !frozen),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(children: [
            AssetSprite(index: 7, size: 25),
            const SizedBox(width: 4),
            Text(frozen ? 'FROZEN' : 'FREEZE', style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w900, color: MemberTheme.ink)),
          ]),
        ),
      ),
      const SizedBox(width: 6),
      _verticalDivider(34),
      const SizedBox(width: 7),
      InkWell(
        onTap: () {
          setState(() => notificationRead = true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You are all caught up'), duration: Duration(seconds: 2)),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Stack(clipBehavior: Clip.none, children: [
          const Padding(padding: EdgeInsets.all(3),
            child: AssetSprite(index: 6, size: 27)),
          if (!notificationRead)
            Positioned(right: 0, top: 0, child: Container(
              width: 10, height: 10,
              decoration: BoxDecoration(color: MemberTheme.red, shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.2)),
            )),
        ]),
      ),
    ]),
  );

  Widget _memberHero() => SizedBox(
    height: 139,
    child: Stack(children: [
      Positioned(right: -8, top: 0, child: Icon(Icons.fitness_center_rounded,
        size: 86, color: MemberTheme.violet.withValues(alpha: .10))),
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          width: 111, height: 132,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [Color(0xFFDB8CFF), MemberTheme.purple, Color(0xFF3A006E)]),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: const [
              BoxShadow(color: Color(0x777900C8), blurRadius: 15, offset: Offset(0, 4)),
              BoxShadow(color: Color(0x99FFFFFF), blurRadius: 3, offset: Offset(-2, -2)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: Image.asset('assets/images/member_portrait.png', fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorBuilder: (_, __, ___) => const Center(
                child: Icon(Icons.person_rounded, size: 76, color: Colors.white))),
          ),
        ),
        const SizedBox(width: 9),
        Expanded(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome Back 👋', maxLines: 1,
              style: TextStyle(fontSize: 19, height: 1.1, fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700, color: MemberTheme.purple)),
            const FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft,
              child: Text('Ashwani Kumar Singh', style: TextStyle(fontSize: 21.5,
                height: 1.05, letterSpacing: -.55, fontWeight: FontWeight.w900, color: Colors.black))),
            const SizedBox(height: 7),
            const Wrap(spacing: 8, runSpacing: 3, children: [
              _Meta(Icons.calendar_month_rounded, 'BG215'),
              _Meta(Icons.person_outline_rounded, '28 Yrs'),
              _Meta(Icons.male_rounded, 'Male'),
            ]),
            const SizedBox(height: 9),
            Row(children: [
              Expanded(child: _statusPill('Gold Plan', MemberTheme.gold, const Color(0xFF593000), 11)),
              const SizedBox(width: 6),
              Expanded(child: _statusPill('Active', MemberTheme.green, Colors.white, 15)),
            ]),
          ],
        )),
      ]),
    ]),
  );

  Widget _paymentStrip() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: MemberTheme.glass(radius: 20),
    child: Row(children: [
      _roundIcon(Icons.account_balance_wallet_rounded, MemberTheme.purple, 34),
      const SizedBox(width: 7),
      const Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment', style: TextStyle(fontSize: 10.5, height: 1.1, color: MemberTheme.ink)),
          Text('₹500 Due', style: TextStyle(fontSize: 18, height: 1.1,
            fontWeight: FontWeight.w900, color: MemberTheme.purple)),
        ],
      )),
      _verticalDivider(41),
      const SizedBox(width: 8),
      const Icon(Icons.event_available_rounded, color: MemberTheme.purple, size: 28),
      const SizedBox(width: 5),
      const Expanded(flex: 2, child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('8 Days Left', style: TextStyle(fontSize: 17, height: 1.1,
            fontWeight: FontWeight.w900, color: MemberTheme.purple)),
          Text('Expires: 24 Oct 2026', style: TextStyle(fontSize: 9.5, color: MemberTheme.ink)),
        ],
      )),
      Container(
        width: 43, height: 43,
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: MemberTheme.line),
          borderRadius: BorderRadius.circular(5)),
        child: QrImageView(
          data: 'BADGYM|MEMBER:BG215|NAME:ASHWANI KUMAR SINGH|PLAN:GOLD',
          size: 41,
          padding: const EdgeInsets.all(2),
          backgroundColor: Colors.white,
          eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.black),
          dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Colors.black),
        ),
      ),
    ]),
  );

  Widget _membershipProgress() => Column(children: [
    const Row(children: [
      Expanded(child: Text('Membership 22 / 30 Days', style: TextStyle(fontSize: 14,
        height: 1, fontWeight: FontWeight.w900, color: Colors.black))),
      Text('73%', style: TextStyle(fontSize: 15, height: 1,
        fontWeight: FontWeight.w900, color: Colors.black)),
    ]),
    const SizedBox(height: 5),
    Container(
      height: 13, padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 1.4),
        boxShadow: const [BoxShadow(color: Color(0x337900C8), blurRadius: 6, offset: Offset(0, 2))]),
      child: ClipRRect(borderRadius: BorderRadius.circular(18),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: .7333),
          duration: const Duration(milliseconds: 850),
          curve: Curves.easeOutCubic,
          builder: (_, value, __) => Align(alignment: Alignment.centerLeft,
            child: FractionallySizedBox(widthFactor: value,
              child: DecoratedBox(decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [MemberTheme.violet, MemberTheme.neon]),
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [BoxShadow(color: MemberTheme.neon, blurRadius: 7)],
              )))),
        ),
      ),
    ),
  ]);

  Widget _saleBanner() => Container(
    height: 76,
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
    decoration: MemberTheme.neonPanel(radius: 22).copyWith(
      boxShadow: const [BoxShadow(color: Color(0x887900C8), blurRadius: 16, offset: Offset(0, 4))],
    ),
    child: Stack(children: [
      Positioned(right: -4, top: -8, bottom: -8,
        child: Icon(Icons.fitness_center_rounded, size: 82, color: Colors.white.withValues(alpha: .18))),
      Row(children: [
        const Text('BAD\nGYM', style: TextStyle(fontSize: 22, height: .88,
          fontStyle: FontStyle.italic, fontWeight: FontWeight.w900, color: Colors.white)),
        Container(height: 49, width: 1.2, margin: const EdgeInsets.symmetric(horizontal: 9),
          color: Colors.white70),
        const Expanded(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft,
              child: Text('Big Billion Sale', style: TextStyle(fontSize: 19,
                fontStyle: FontStyle.italic, fontWeight: FontWeight.w900, color: MemberTheme.gold))),
            SizedBox(height: 3),
            Text('Up to 40% OFF · Fitness Gear', maxLines: 1,
              style: TextStyle(fontSize: 9.5, color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        )),
        const SizedBox(width: 5),
        if (MediaQuery.sizeOf(context).width >= 350) ...[
          SizedBox(
            width: 58, height: 54,
            child: Image.asset('assets/images/gym_interior.webp',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.fitness_center_rounded, size: 34, color: Color(0xFFFFD7FF)),
            ),
          ),
          const SizedBox(width: 5),
        ],
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width < 350 ? 7 : 10,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [MemberTheme.neon, Color(0xFF7D00D8)]),
            borderRadius: BorderRadius.circular(22), border: Border.all(color: Colors.white, width: 1.2),
            boxShadow: const [BoxShadow(color: Color(0x99FF00FF), blurRadius: 9)],
          ),
          child: const Text('Shop Now ›', style: TextStyle(fontSize: 10,
            fontWeight: FontWeight.w900, color: Colors.white)),
        ),
      ]),
    ]),
  ).animate().fadeIn(duration: 360.ms).slideY(begin: .06, end: 0);

  Widget _metricStrip() => Row(children: [
    _metricTile('Attendance', '81%', Icons.calendar_month_rounded, MemberTheme.green, 0),
    const SizedBox(width: 5),
    _metricTile('Workout', '58 min', Icons.fitness_center_rounded, MemberTheme.purple, 1),
    const SizedBox(width: 5),
    _metricTile('Payment', '₹500 Due', Icons.account_balance_wallet_rounded, MemberTheme.red, 2),
    const SizedBox(width: 5),
    _metricTile('Body', '69.5 kg', Icons.monitor_weight_outlined, const Color(0xFF007DB5), 3),
  ]);

  Widget _metricTile(String title, String value, IconData icon, Color accent, int index) {
    return Expanded(child: InkWell(
      onTap: () => setState(() => selectedMetric = index),
      borderRadius: BorderRadius.circular(17),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        height: 89,
        padding: const EdgeInsets.fromLTRB(3, 7, 3, 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: selectedMetric == index
              ? [accent.withValues(alpha: .23), Colors.white, accent.withValues(alpha: .10)]
              : [Colors.white, accent.withValues(alpha: .11)]),
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: [
            BoxShadow(color: accent.withValues(alpha: selectedMetric == index ? .22 : .12),
              blurRadius: 10, offset: const Offset(0, 3)),
          ],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (index == 0) const AssetSprite(index: 1, size: 25)
          else if (index == 1) const AssetSprite(index: 2, size: 25)
          else if (index == 2) const AssetSprite(index: 3, size: 25)
          else Icon(icon, color: accent, size: 23),
          const SizedBox(height: 3),
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 9.2, height: 1,
              fontWeight: FontWeight.w800, color: MemberTheme.ink)),
          const SizedBox(height: 3),
          FittedBox(fit: BoxFit.scaleDown, child: Text(value,
            style: TextStyle(fontSize: 15, height: 1, fontWeight: FontWeight.w900,
              color: index == 2 ? MemberTheme.red : MemberTheme.ink))),
        ]),
      ),
    ));
  }

  Widget _attendanceIntelligence() => Container(
    padding: const EdgeInsets.all(8),
    decoration: MemberTheme.glass(radius: 23),
    child: Column(children: [
      Row(children: [
        const AssetSprite(index: 13, size: 31),
        const SizedBox(width: 7),
        const Expanded(child: Text('Attendance Intelligence', maxLines: 1,
          style: TextStyle(fontSize: 15.5, height: 1, fontWeight: FontWeight.w900, color: MemberTheme.ink))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: const Color(0xFFFFE5F0),
            borderRadius: BorderRadius.circular(20), border: Border.all(color: MemberTheme.neon)),
          child: const Row(children: [
            Icon(Icons.circle, size: 7, color: MemberTheme.red),
            SizedBox(width: 4),
            Text('LIVE', style: TextStyle(fontSize: 10, height: 1,
              fontWeight: FontWeight.w900, color: MemberTheme.red)),
          ]),
        ),
      ]),
      const SizedBox(height: 7),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _verticalRail(),
        const SizedBox(width: 7),
        Expanded(child: _attendanceOverview()),
      ]),
    ]),
  );

  Widget _verticalRail() => Container(
    width: 54,
    height: 192,
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
    decoration: MemberTheme.neonPanel(radius: 17),
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(labels.length, _railItem)),
  );

  Widget _railItem(int i) => InkWell(
    onTap: () => setState(() => selectedRail = i),
    borderRadius: BorderRadius.circular(12),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 47,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
      decoration: BoxDecoration(
        color: selectedRail == i ? Colors.white.withValues(alpha: .97) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: selectedRail == i ? Border.all(color: const Color(0xFFFFC8FF), width: 1.2) : null,
        boxShadow: selectedRail == i ? const [BoxShadow(color: Color(0x66FF00FF), blurRadius: 8)] : null,
      ),
      child: Column(children: [
        AssetSprite(index: spriteIcons[i], size: 22),
        const SizedBox(height: 0.5),
        Text(labels[i], maxLines: 1,
          style: TextStyle(fontSize: 6.8, height: 1,
            fontWeight: FontWeight.w800,
            color: selectedRail == i ? MemberTheme.purple : Colors.white)),
      ]),
    ),
  );

  Widget _attendanceOverview() => Container(
    padding: const EdgeInsets.fromLTRB(9, 8, 8, 7),
    decoration: MemberTheme.glass(radius: 19, tint: const Color(0xFFFFFCFF)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Home overview', style: TextStyle(fontSize: 16, height: 1,
        fontWeight: FontWeight.w900, color: MemberTheme.purple)),
      const SizedBox(height: 3),
      const Text('Check-in complete  ·  07:12 AM',
        style: TextStyle(fontSize: 9.5, height: 1, color: MemberTheme.ink)),
      const SizedBox(height: 9),
      Row(children: [
        SizedBox(width: 83, height: 83,
          child: Stack(alignment: Alignment.center, children: [
            const SizedBox.expand(child: CircularProgressIndicator(
              value: .81, strokeWidth: 8, strokeCap: StrokeCap.round,
              backgroundColor: Color(0xFFEADCF7),
              valueColor: AlwaysStoppedAnimation(MemberTheme.green))),
            Container(width: 64, height: 64,
              decoration: BoxDecoration(shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFEADCF7), width: 1))),
            const Column(mainAxisSize: MainAxisSize.min, children: [
              Text('81%', style: TextStyle(fontSize: 21, height: 1,
                fontWeight: FontWeight.w900, color: MemberTheme.ink)),
              SizedBox(height: 2),
              Text('25/31', style: TextStyle(fontSize: 9, color: MemberTheme.muted)),
            ]),
          ]),
        ),
        const SizedBox(width: 8),
        const Expanded(child: Column(children: [
          _StatRow(MemberTheme.green, 'Present', '25', '81%', .81),
          _StatRow(MemberTheme.red, 'Absent', '2', '6%', .06),
          _StatRow(MemberTheme.purple, 'Holiday', '4', '13%', .13),
          _StatRow(MemberTheme.gold, 'Payment', '1/1', '100%', 1),
        ])),
      ]),
      const SizedBox(height: 7),
      const Divider(height: 1, color: MemberTheme.line),
      const SizedBox(height: 6),
      const Row(children: [
        Expanded(child: _FootMetric(12, '5d', MemberTheme.red)),
        Expanded(child: _FootMetric(11, '14d', MemberTheme.purple)),
        Expanded(child: _FootMetric(13, '+6%', MemberTheme.purple)),
      ]),
      const SizedBox(height: 4),
      const Text('Sample data  ·  API connection required for live records',
        maxLines: 1, overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 7.2, height: 1, color: MemberTheme.muted)),
    ]),
  );

  Widget _gymFloor() => SizedBox(
    height: 76,
    child: Stack(children: [
      Positioned.fill(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset('assets/images/gym_interior.webp',
            fit: BoxFit.cover, alignment: Alignment.bottomCenter),
        ),
      ),
      Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [
                const Color(0x227900C8),
                const Color(0xAA260044),
              ],
            ),
          ),
        ),
      ),
      Positioned.fill(child: CustomPaint(painter: _NeonFloorPainter())),
      const Positioned(left: 58, bottom: 5, child: EquipmentSprite(index: 1, size: 38)),
      const Positioned(left: 112, bottom: 3, child: EquipmentSprite(index: 2, size: 34)),
      const Positioned(right: 55, bottom: 4, child: EquipmentSprite(index: 3, size: 42)),
      Positioned(
        left: 0, right: 0, bottom: 0, height: 42,
        child: IgnorePointer(
          child: Image.asset('assets/images/gym_plants.webp',
            fit: BoxFit.contain, alignment: Alignment.bottomCenter),
        ),
      ),
    ]),
  );

  Widget _verticalDivider(double height) => Container(width: 1, height: height, color: const Color(0xFFBDA8D2));

  Widget _roundIcon(IconData icon, Color color, double size) => Container(
    width: size, height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: [Color.lerp(color, Colors.white, .22)!, color]),
      border: Border.all(color: Colors.white.withValues(alpha: .9), width: 1.2),
      boxShadow: [BoxShadow(color: color.withValues(alpha: .34), blurRadius: 9, offset: const Offset(0, 3))],
    ),
    child: Icon(icon, color: Colors.white, size: size * .64),
  );

  Widget _statusPill(String label, Color color, Color textColor, int spriteIndex) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
    decoration: BoxDecoration(
      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: [Color.lerp(color, Colors.white, .25)!, color]),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white, width: 1.2),
      boxShadow: const [BoxShadow(color: Color(0x337B32B8), blurRadius: 5, offset: Offset(0, 2))],
    ),
    child: FittedBox(fit: BoxFit.scaleDown,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        AssetSprite(index: spriteIndex, size: 17),
        const SizedBox(width: 3),
        Text(label, style: TextStyle(fontSize: 12, height: 1,
          fontWeight: FontWeight.w900, color: textColor)),
      ])),
  );
}



class EquipmentSprite extends StatelessWidget {
  final int index;
  final double size;
  const EquipmentSprite({super.key, required this.index, this.size = 40});

  static final Future<ui.Image> _atlas = _loadAtlas();

  static Future<ui.Image> _loadAtlas() async {
    final data = await rootBundle.load('assets/images/badgym_equipment_sprites.webp');
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<ui.Image>(
    future: _atlas,
    builder: (context, snapshot) {
      if (!snapshot.hasData) return SizedBox(width: size, height: size);
      return CustomPaint(
        size: Size.square(size),
        painter: _EquipmentSpritePainter(snapshot.data!, index),
      );
    },
  );
}

class _EquipmentSpritePainter extends CustomPainter {
  final ui.Image image;
  final int index;
  const _EquipmentSpritePainter(this.image, this.index);

  @override
  void paint(Canvas canvas, Size size) {
    const cell = 48.0;
    final source = Rect.fromLTWH(index * cell, 0, cell, cell);
    canvas.drawImageRect(
      image,
      source,
      Offset.zero & size,
      Paint()..filterQuality = FilterQuality.high,
    );
  }

  @override
  bool shouldRepaint(covariant _EquipmentSpritePainter oldDelegate) =>
    oldDelegate.image != image || oldDelegate.index != index;
}
class AssetSprite extends StatelessWidget {
  final int index;
  final double size;
  const AssetSprite({super.key, required this.index, this.size = 24});

  static final Future<ui.Image> _atlas = _loadAtlas();

  static Future<ui.Image> _loadAtlas() async {
    final data = await rootBundle.load('assets/images/badgym_ui_sprites.webp');
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<ui.Image>(
    future: _atlas,
    builder: (context, snapshot) {
      if (!snapshot.hasData) return SizedBox(width: size, height: size);
      return CustomPaint(
        size: Size.square(size),
        painter: _AssetSpritePainter(snapshot.data!, index),
      );
    },
  );
}

class _AssetSpritePainter extends CustomPainter {
  final ui.Image image;
  final int index;
  const _AssetSpritePainter(this.image, this.index);

  @override
  void paint(Canvas canvas, Size size) {
    const cell = 28.0;
    const columns = 5;
    final source = Rect.fromLTWH(
      (index % columns) * cell,
      (index ~/ columns) * cell,
      cell,
      cell,
    );
    canvas.drawImageRect(
      image,
      source,
      Offset.zero & size,
      Paint()..filterQuality = FilterQuality.high,
    );
  }

  @override
  bool shouldRepaint(covariant _AssetSpritePainter oldDelegate) =>
    oldDelegate.image != image || oldDelegate.index != index;
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Meta(this.icon, this.label);

  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Icon(icon, size: 14, color: MemberTheme.purple),
    const SizedBox(width: 3),
    Text(label, style: const TextStyle(fontSize: 10.5, height: 1,
      fontWeight: FontWeight.w700, color: MemberTheme.ink)),
  ]);
}

class _StatRow extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  final String percent;
  final double progress;
  const _StatRow(this.color, this.label, this.value, this.percent, this.progress);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(children: [
      Container(width: 8, height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 4),
      Expanded(child: Text(label, maxLines: 1,
        style: const TextStyle(fontSize: 9.5, height: 1,
          fontWeight: FontWeight.w800, color: MemberTheme.ink))),
      SizedBox(width: 22, child: Text(value, textAlign: TextAlign.end,
        style: const TextStyle(fontSize: 9.5, height: 1,
          fontWeight: FontWeight.w900, color: MemberTheme.ink))),
      const SizedBox(width: 5),
      Expanded(flex: 2, child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: LinearProgressIndicator(value: progress, minHeight: 7,
          backgroundColor: color.withValues(alpha: .17),
          valueColor: AlwaysStoppedAnimation(color)))),
      const SizedBox(width: 4),
      SizedBox(width: 26, child: Text(percent, textAlign: TextAlign.end,
        style: const TextStyle(fontSize: 8.5, height: 1, color: MemberTheme.ink))),
    ]),
  );
}

class _FootMetric extends StatelessWidget {
  final int spriteIndex;
  final String value;
  final Color color;
  const _FootMetric(this.spriteIndex, this.value, this.color);

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AssetSprite(index: spriteIndex, size: 18),
      const SizedBox(width: 4),
      Text(value, style: TextStyle(fontSize: 15, height: 1,
        fontWeight: FontWeight.w900, color: color)),
    ],
  );
}

class _NeonFloorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final floor = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter, end: Alignment.bottomCenter,
        colors: [Color(0x00A500FF), Color(0x55A500FF), Color(0x22FFFFFF)],
      ).createShader(Offset.zero & size);
    canvas.drawRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(15)), floor);
    final glow = Paint()
      ..color = const Color(0xAAE400FF)
      ..strokeWidth = 1.1
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    final line = Paint()..color = const Color(0x558900D0)..strokeWidth = .7;
    for (var i = 0; i < 5; i++) {
      final y = size.height * (.25 + i * .16);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), i == 1 ? glow : line);
    }
    for (var i = -3; i <= 3; i++) {
      final x = size.width / 2 + i * size.width * .18;
      canvas.drawLine(Offset(size.width / 2, size.height * .18),
        Offset(x, size.height), line);
    }
    final flare = Paint()
      ..shader = RadialGradient(colors: [
        const Color(0x66F000FF), const Color(0x00F000FF),
      ]).createShader(Rect.fromCircle(center: Offset(size.width * .5, size.height * .55), radius: size.width * .45));
    canvas.drawRect(Offset.zero & size, flare);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
