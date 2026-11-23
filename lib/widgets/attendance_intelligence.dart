import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../data/sample_member.dart';
import '../theme/member_theme.dart';

class AttendanceIntelligence extends StatelessWidget {
  final int section;
  final ValueChanged<int> onSelect;
  final VoidCallback onNotify;

  const AttendanceIntelligence({
    super.key,
    required this.section,
    required this.onSelect,
    required this.onNotify,
  });

  static const labels = ['Attend', 'Insights', 'Cal', 'History', 'Trend', 'Goals'];
  static const icons = <IconData>[
    Icons.calendar_month_rounded,
    Icons.insights_rounded,
    Icons.date_range_rounded,
    Icons.history_rounded,
    Icons.trending_up_rounded,
    Icons.emoji_events_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    // Reserve enough space for analytics while keeping short phones scroll-safe.\n    final panelHeight = (screenHeight * 0.46).clamp(340.0, 370.0);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _MetricRow(),
          const SizedBox(height: 7),
          SizedBox(
            height: panelHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: 62, child: _Rail(section: section, onSelect: onSelect)),
                const SizedBox(width: 6),
                Expanded(child: _Panel(section: section, onNotify: onNotify)),
              ],
            ),
          ),
        ],
      );
  }
}

class _Rail extends StatelessWidget {
  final int section;
  final ValueChanged<int> onSelect;

  const _Rail({required this.section, required this.onSelect});

  @override
  Widget build(BuildContext context) => Container(
        width: 58,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF9333EA), Color(0xFF6D28D9), Color(0xFF4C1D95)],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x886D28D9),
              blurRadius: 14,
              offset: Offset(0, 5),
            ),
          ],
          border: Border.all(color: const Color(0xFFFFD76A), width: 1.2),
        ),
        child: Column(
          children: List.generate(AttendanceIntelligence.labels.length, (index) {
            final selected = section == index;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    key: ValueKey('rail-${AttendanceIntelligence.labels[index]}'),
                    onTap: () => onSelect(index),
                    borderRadius: BorderRadius.circular(15),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: selected
                            ? const Color(0xFFFFF8E8)
                            : Colors.transparent,
                        border: selected
                            ? Border.all(
                                color: const Color(0xFFFFD76A), width: 1)
                            : null,
                        boxShadow: selected
                            ? const [
                                BoxShadow(
                                  color: Color(0x66FFFFFF),
                                  blurRadius: 8,
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            AttendanceIntelligence.icons[index],
                            size: 17,
                            color: selected
                                ? MemberTheme.deepPurple
                                : Colors.white,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            AttendanceIntelligence.labels[index],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w900,
                              color: selected
                                  ? MemberTheme.deepPurple
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      );
}

class _MetricRow extends StatelessWidget {
  const _MetricRow();

  @override
  Widget build(BuildContext context) => const Row(
        children: [
          Expanded(child: _MetricTile(
            icon: Icons.calendar_month_rounded,
            label: 'Attendance',
            value: MemberSample.attendancePercentLabel,
            detail: '↑ +6%',
            image: 'assets/material_pack/pulsevault/10_member_bodybuilder_cutout.png',
            background: Color(0xFFFFE66D),
            accent: MemberTheme.greenInk,
          )),
          SizedBox(width: 5),
          Expanded(child: _MetricTile(
            icon: Icons.fitness_center_rounded,
            label: 'Workout',
            value: '${MemberSample.workoutMinutes} min',
            detail: '↑ +12%',
            image: 'assets/material_pack/pulsevault/07_creatine_monohydrate_tub_cutout.png',
            background: Color(0xFFE7C7FF),
            accent: MemberTheme.deepPurple,
          )),
          SizedBox(width: 5),
          Expanded(child: _MetricTile(
            icon: Icons.account_balance_wallet_rounded,
            label: 'Payment',
            value: MemberSample.dueLabel,
            detail: 'SBI · 5% OFF',
            image: 'assets/material_pack/pulsevault/11_sbi_payment_card_cutout.png',
            background: Color(0xFF9DE7FF),
            accent: Color(0xFF075985),
          )),
          SizedBox(width: 5),
          Expanded(child: _MetricTile(
            icon: Icons.monitor_weight_rounded,
            label: 'Body',
            value: MemberSample.bodyLabel,
            detail: '↓ -0.8 kg',
            image: 'assets/material_pack/pulsevault/04_fat_loss_support_tub_cutout.png',
            background: Color(0xFFB8F1C8),
            accent: MemberTheme.greenInk,
          )),
        ],
      );
}

class _MetricTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String detail;
  final String? image;
  final Color background;
  final Color accent;
  const _MetricTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.detail,
    required this.image,
    required this.background,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 174,
        padding: const EdgeInsets.fromLTRB(4, 5, 4, 4),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: const [
            BoxShadow(color: Color(0x227A18D1), blurRadius: 9, offset: Offset(0, 3)),
            BoxShadow(color: Color(0x33FFD76A), blurRadius: 5, spreadRadius: 0.5),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: accent, size: 13),
                const SizedBox(width: 2),
                Flexible(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: MemberTheme.ink))),
                if (label == 'Attendance') ...[
                  const SizedBox(width: 2),
                  const Text('+6%', style: TextStyle(fontSize: 7, fontWeight: FontWeight.w900, color: MemberTheme.greenInk)),
                ],
              ],
            ),
            const SizedBox(height: 2),
            FittedBox(fit: BoxFit.scaleDown, child: Text(value, maxLines: 1,
              style: TextStyle(fontSize: 18, height: 1, fontWeight: FontWeight.w900, color: accent))),
            if (label != 'Attendance')
              SizedBox(
                width: double.infinity,
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(detail, maxLines: 1, style: TextStyle(
                      fontSize: 8, fontWeight: FontWeight.w900, color: accent,
                    )),
                  ),
                ),
              ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.98, end: 1.02),
                  duration: const Duration(milliseconds: 2200),
                  curve: Curves.easeInOut,
                  builder: (context, scale, child) => Transform.scale(
                    scale: scale,
                    child: child,
                  ),
                  child: image == null
                      ? Icon(icon, color: accent, size: 28)
                      : Image.asset(image!, fit: BoxFit.contain, height: 72,
                          errorBuilder: (_, __, ___) => Icon(icon, color: accent, size: 28)),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  accent,
                  Color.lerp(accent, Colors.black, 0.18)!,
                ]),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Text(
                switch (label) {
                  'Attendance' => 'Protein 10% OFF ›',
                  'Workout' => 'Creatine 15% OFF ›',
                  'Payment' => 'Get 5% OFF ›',
                  _ => 'Fat Loss 20% OFF ›',
                },
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
}

class _Panel extends StatelessWidget {
  final int section;
  final VoidCallback onNotify;
  const _Panel({required this.section, required this.onNotify});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
        decoration: MemberTheme.glass(radius: 24),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PanelHeader(onNotify: onNotify),
              if (section == 0) ...[
                const SizedBox(height: 5),
                const _PartnerBanner(),
              ],
              const SizedBox(height: 5),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 240),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.025, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: KeyedSubtree(
                  key: ValueKey<int>(section),
                  child: switch (section) {
                    0 => const _DefaultAnalyticsOverview(),
                    1 => const _MoreOverview(),
                    2 => const _AttendCalendar(),
                    3 => const _HistoryOverview(),
                    4 => const _HomeOverview(),
                    _ => const _GoalsOverview(),
                  },
                ),
              ),
            ],
          ),
        ),
      );
}


class _PartnerBanner extends StatelessWidget {
  const _PartnerBanner();

  @override
  Widget build(BuildContext context) => Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFFFF7C7), Color(0xFFFFFFFF), Color(0xFFEAD7FF)]),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: Colors.white, width: 1.2),
        ),
        child: Row(children: [
          Image.asset('assets/material_pack/pulsevault/13_blinkit_grocery_bag_cutout.png', width: 48, height: 40, fit: BoxFit.contain),
          const SizedBox(width: 6),
          const Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Healthy Snacks & Gym Essentials', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: MemberTheme.ink)),
            Text('Member partner offer · Up to 30% OFF', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: MemberTheme.deepPurple)),
          ])),
        ]),
      );
}

class _PanelHeader extends StatelessWidget {
  final VoidCallback onNotify;
  const _PanelHeader({required this.onNotify});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 28,
            height: 28,
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [MemberTheme.violet, MemberTheme.deepPurple]),
            ),
            child: const Icon(Icons.insights_rounded, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Attendance Analytics',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: MemberTheme.ink),
            ),
          ),
          IconButton(
            tooltip: 'Notifications',
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 28, height: 28),
            onPressed: onNotify,
            icon: const Icon(Icons.notifications_active_rounded,
                color: MemberTheme.deepPurple, size: 19),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1F2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFB7185)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      color: MemberTheme.red, shape: BoxShape.circle),
                  child: SizedBox(width: 7, height: 7),
                ),
                SizedBox(width: 4),
                Text('LIVE',
                    style: TextStyle(
                        color: MemberTheme.red,
                        fontSize: 10,
                        fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        ],
      );
}

class _DefaultAnalyticsOverview extends StatelessWidget {
  const _DefaultAnalyticsOverview();

  @override
  Widget build(BuildContext context) => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HomeOverview(),
          SizedBox(height: 8),
          Divider(height: 1, color: MemberTheme.line),
          SizedBox(height: 7),
          _RecoveryOffer(),
          SizedBox(height: 7),
          _AttendCalendar(),
        ],
      );
}

class _HomeOverview extends StatelessWidget {
  const _HomeOverview();

  @override
  Widget build(BuildContext context) => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _AttendanceDonut(),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    _StatLine(
                        color: MemberTheme.green,
                        label: 'Present',
                        count: '23',
                        percent: '74%',
                        value: 0.74),
                    _StatLine(
                        color: MemberTheme.red,
                        label: 'Absent',
                        count: '2',
                        percent: '6%',
                        value: 0.06),
                    _StatLine(
                        color: MemberTheme.purple,
                        label: 'Holiday',
                        count: '4',
                        percent: '13%',
                        value: 0.13),
                    _StatLine(
                        color: MemberTheme.goldDeep,
                        label: 'Late',
                        count: '2',
                        percent: '6%',
                        value: 0.06),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(height: 1, color: MemberTheme.line),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: _Foot(
                      icon: Icons.local_fire_department_rounded,
                      value: MemberSample.streakLabel,
                      color: MemberTheme.red)),
              Expanded(
                  child: _Foot(
                      icon: Icons.emoji_events_rounded,
                      value: MemberSample.trophyLabel,
                      color: MemberTheme.purple)),
              Expanded(
                  child: _Foot(
                      icon: Icons.trending_up_rounded,
                      value: MemberSample.trendLabel,
                      color: MemberTheme.greenInk)),
            ],
          ),
          SizedBox(height: 6),
          Text(MemberSample.sampleNote,
              style: TextStyle(
                  fontSize: 8,
                  color: MemberTheme.muted,
                  fontWeight: FontWeight.w600)),
        ],
      );
}

class _RecoveryOffer extends StatelessWidget {
  const _RecoveryOffer();

  @override
  Widget build(BuildContext context) => Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF5E9FF), Color(0xFFFFFFFF), Color(0xFFFFE9F5)],
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE7C8FF)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 42,
              height: 44,
              child: Image.asset(
                'assets/material_pack/pulsevault/06_whey_recovery_tub_cutout.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 5),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recovery Combo',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900)),
                  Text('Up to 30% OFF',
                      maxLines: 1,
                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900,
                          color: MemberTheme.red)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: MemberTheme.deepPurple, size: 22),
          ],
        ),
      );
}

class _AttendanceDonut extends StatelessWidget {
  const _AttendanceDonut();

  @override
  Widget build(BuildContext context) => const SizedBox(
        width: 78,
        height: 78,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(size: Size(78, 78), painter: _DonutPainter()),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('81%',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: MemberTheme.ink,
                        height: 1)),
                Text(MemberSample.attendedLabel,
                    style: TextStyle(
                        fontSize: 10,
                        color: MemberTheme.muted,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      );
}

class _DonutPainter extends CustomPainter {
  const _DonutPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 11
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect.deflate(6), 0, math.pi * 2, false,
        stroke..color = const Color(0xFFFCE7F3));
    stroke.color = MemberTheme.green;
    canvas.drawArc(
        rect.deflate(6), -math.pi / 2, math.pi * 2 * 0.81, false, stroke);
    stroke.color = const Color(0xFFF472B6);
    canvas.drawArc(rect.deflate(6), -math.pi / 2 + math.pi * 2 * 0.81,
        math.pi * 2 * 0.16, false, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StatLine extends StatelessWidget {
  final Color color;
  final String label;
  final String count;
  final String percent;
  final double value;
  const _StatLine({
    required this.color,
    required this.label,
    required this.count,
    required this.percent,
    required this.value,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: Row(
          children: [
            Container(
                width: 8,
                height: 8,
                decoration:
                    BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 4),
            SizedBox(
              width: 40,
              child: Text(label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w800)),
            ),
            SizedBox(
              width: 20,
              child: Text(count,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w900)),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 7,
                  backgroundColor: color.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 26,
              child: Text(percent,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      fontSize: 9,
                      color: MemberTheme.muted,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      );
}

class _Foot extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;
  const _Foot({required this.icon, required this.value, required this.color});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 3),
          Text(value,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w900, color: color)),
        ],
      );
}

class _AttendCalendar extends StatelessWidget {
  const _AttendCalendar();

  @override
  Widget build(BuildContext context) {
    const heads = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const firstVisibleDay = 13;
    const lastVisibleDay = 25;
    final cells = <Widget>[
      for (final head in heads)
        Center(
            child: Text(head,
                style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w800,
                    color: MemberTheme.muted))),
      for (var day = firstVisibleDay; day <= lastVisibleDay; day++)
        _DayCell(day: day),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('October attendance', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: MemberTheme.deepPurple)),
                  Text('23 present · 2 late · 2 absent · 4 holiday', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [MemberTheme.deepPurple, MemberTheme.purple]),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: const Row(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(width: 24, height: 24, child: Image(image: AssetImage('assets/material_pack/pulsevault/07_creatine_monohydrate_tub_cutout.png'), fit: BoxFit.contain)),
                SizedBox(width: 4),
                Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                  Text('Train More', style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w900)),
                  Text('Get 15% OFF', style: TextStyle(fontSize: 7, color: Color(0xFFFFE66D), fontWeight: FontWeight.w800)),
                ]),
              ]),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.05,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          children: cells,
        ),
        const SizedBox(height: 6),
        const Text(MemberSample.sampleNote,
            style: TextStyle(fontSize: 8, color: MemberTheme.muted)),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  final int day;
  const _DayCell({required this.day});

  @override
  Widget build(BuildContext context) {
    final kind = MemberSample.kindFor(day);
    final color = switch (kind) {
      DayKind.off => const Color(0xFFE5E7EB),
      DayKind.present => const Color(0xFFDCFCE7),
      DayKind.late => const Color(0xFFFEF3C7),
      DayKind.absent => const Color(0xFFFFE4E6),
      DayKind.holiday => const Color(0xFFE5E7EB),
    };
    final ink = switch (kind) {
      DayKind.off => const Color(0xFF6B7280),
      DayKind.present => MemberTheme.greenInk,
      DayKind.late => MemberTheme.goldDeep,
      DayKind.absent => MemberTheme.red,
      DayKind.holiday => const Color(0xFF6B7280),
    };
    final today = day == MemberSample.today;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: today ? MemberTheme.purple : Colors.white,
            width: today ? 1.6 : 1),
      ),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
          '$day',
          style:
              TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: ink),
        ),
        if (kind == DayKind.off || kind == DayKind.holiday) const Text('OFF', style: TextStyle(fontSize: 6, height: 0.9, fontWeight: FontWeight.w900, color: Color(0xFF6B7280))),
        ]),
      ),
    );
  }
}

class _PaymentOverview extends StatelessWidget {
  const _PaymentOverview();

  @override
  Widget build(BuildContext context) => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment overview',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: MemberTheme.deepPurple)),
          SizedBox(height: 6),
          Text(MemberSample.plan,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: MemberTheme.goldDeep)),
          Text(MemberSample.dueLabel,
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFEA580C),
                  height: 1.1)),
          Text('Due before ${MemberSample.expiresLabel}',
              style: TextStyle(
                  fontSize: 11,
                  color: MemberTheme.muted,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text('8 days left on the 30-day Gold cycle.',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: MemberTheme.ink)),
          SizedBox(height: 8),
          Text(MemberSample.sampleNote,
              style: TextStyle(fontSize: 8, color: MemberTheme.muted)),
        ],
      );
}

class _OffersOverview extends StatelessWidget {
  const _OffersOverview();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Member offers',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: MemberTheme.deepPurple)),
          const Text('Big Billion Sale gear locker',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          for (final offer in MemberSample.offers)
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F1FF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 42,
                    height: 42,
                    child: switch (offer.name) {
                      'Whey Protein' => Image.asset(
                          'assets/material_pack/pulsevault/01_whey_protein_tub_cutout.png', fit: BoxFit.contain),
                      'Whey Protein Bundle' => Image.asset(
                          'assets/material_pack/pulsevault/02_whey_protein_bundle_cutout.png', fit: BoxFit.contain),
                      'Creatine Monohydrate' => Image.asset(
                          'assets/material_pack/pulsevault/07_creatine_monohydrate_tub_cutout.png', fit: BoxFit.contain),
                      'Fat Loss Support' => Image.asset(
                          'assets/material_pack/pulsevault/04_fat_loss_support_tub_cutout.png', fit: BoxFit.contain),
                      'Whey Recovery' => Image.asset(
                          'assets/material_pack/pulsevault/06_whey_recovery_tub_cutout.png', fit: BoxFit.contain),
                      'Purple Protein Bundle' => Image.asset(
                          'assets/material_pack/pulsevault/03_purple_protein_product_bundle_cutout.png', fit: BoxFit.contain),
                      'Blinkit Grocery Partner' => Image.asset(
                          'assets/material_pack/pulsevault/13_blinkit_grocery_bag_cutout.png', fit: BoxFit.contain),
                      'Purple Shaker Bottle' => Image.asset(
                          'assets/material_pack/pulsevault/08_purple_shaker_bottle_cutout.png', fit: BoxFit.contain),
                      _ => const Icon(
                          Icons.fitness_center_rounded,
                          color: MemberTheme.deepPurple,
                          size: 28,
                        ),
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(offer.name,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w900)),
                        Text(offer.off,
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: MemberTheme.purple)),
                      ],
                    ),
                  ),
                  Text(offer.price,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
          const Text(MemberSample.sampleNote,
              style: TextStyle(fontSize: 8, color: MemberTheme.muted)),
        ],
      );
}

class _MoreOverview extends StatelessWidget {
  const _MoreOverview();

  @override
  Widget build(BuildContext context) => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'More member insights',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: MemberTheme.deepPurple,
            ),
          ),
          SizedBox(height: 8),
          _AttendCalendar(),
          SizedBox(height: 12),
          Divider(height: 1, color: MemberTheme.line),
          SizedBox(height: 10),
          _PaymentOverview(),
          SizedBox(height: 12),
          Divider(height: 1, color: MemberTheme.line),
          SizedBox(height: 10),
          _OffersOverview(),
        ],
      );
}

class _HistoryOverview extends StatelessWidget {
  const _HistoryOverview();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Check-in history',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: MemberTheme.deepPurple)),
          const SizedBox(height: 6),
          for (final record in MemberSample.history)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: switch (record.kind) {
                        DayKind.off => MemberTheme.muted,
                        DayKind.present => MemberTheme.green,
                        DayKind.late => MemberTheme.goldDeep,
                        DayKind.absent => MemberTheme.red,
                        DayKind.holiday => MemberTheme.purple,
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                      width: 52,
                      child: Text(record.day,
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w800))),
                  Expanded(
                      child: Text(record.label,
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w600))),
                  Text(record.time,
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: MemberTheme.muted)),
                ],
              ),
            ),
          const SizedBox(height: 4),
          const Text(MemberSample.sampleNote,
              style: TextStyle(fontSize: 8, color: MemberTheme.muted)),
        ],
      );
}

class _GoalsOverview extends StatelessWidget {
  const _GoalsOverview();

  @override
  Widget build(BuildContext context) => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Member goals', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: MemberTheme.deepPurple)),
          SizedBox(height: 8),
          _GoalLine(label: 'Monthly check-ins', value: '25 / 30', progress: 0.83),
          SizedBox(height: 8),
          _GoalLine(label: 'Workout consistency', value: '4 / 5 days', progress: 0.80),
          SizedBox(height: 8),
          _GoalLine(label: 'Strength sessions', value: '3 / 5', progress: 0.60),
          SizedBox(height: 8),
          Text(MemberSample.sampleNote, style: TextStyle(fontSize: 8, color: MemberTheme.muted)),
        ],
      );
}

class _GoalLine extends StatelessWidget {
  final String label;
  final String value;
  final double progress;
  const _GoalLine({required this.label, required this.value, required this.progress});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Expanded(child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800))), Text(value, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: MemberTheme.purple))]),
          const SizedBox(height: 4),
          ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: progress, minHeight: 7, backgroundColor: const Color(0xFFF3E8FF), valueColor: const AlwaysStoppedAnimation(MemberTheme.purple))),
        ],
      );
}
