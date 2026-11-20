import 'package:flutter/material.dart';
import '../theme/member_theme.dart';

class AttendanceIntelligence extends StatefulWidget {
  const AttendanceIntelligence({super.key});

  @override
  State<AttendanceIntelligence> createState() => _AttendanceIntelligenceState();
}

class _AttendanceIntelligenceState extends State<AttendanceIntelligence> {
  int section = 0;
  DateTime month = DateTime.now();

  static const labels = ['Home', 'Attend', 'Workout', 'Pay', 'Offers', 'History'];
  static const icons = [
    Icons.grid_view_rounded,
    Icons.calendar_month_rounded,
    Icons.fitness_center_rounded,
    Icons.account_balance_wallet_outlined,
    Icons.local_offer_outlined,
    Icons.history_rounded,
  ];

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(9),
        decoration: MemberTheme.card(radius: 23),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 29,
                  height: 29,
                  decoration: BoxDecoration(
                    color: MemberTheme.mint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.insights_rounded,
                      color: MemberTheme.forest, size: 18),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Member Intelligence',
                    style: TextStyle(
                      fontSize: 13,
                      color: MemberTheme.ink,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: MemberTheme.mint,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.circle, color: MemberTheme.emerald, size: 6),
                      SizedBox(width: 4),
                      Text('LIVE',
                          style: TextStyle(
                              fontSize: 8,
                              color: MemberTheme.forest,
                              fontWeight: FontWeight.w900,
                              letterSpacing: .5)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _navigationRail(),
                const SizedBox(width: 8),
                Expanded(child: _selectedPage()),
              ],
            ),
          ],
        ),
      );

  Widget _navigationRail() => Container(
        width: 49,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [MemberTheme.forest, MemberTheme.emerald],
          ),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            labels.length,
            (i) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Material(
                color: section == i ? MemberTheme.leaf : Colors.transparent,
                borderRadius: BorderRadius.circular(11),
                child: InkWell(
                  onTap: () => setState(() => section = i),
                  borderRadius: BorderRadius.circular(11),
                  child: SizedBox(
                    width: 43,
                    height: 45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icons[i],
                          size: 17,
                          color: section == i ? MemberTheme.ink : Colors.white,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          labels[i],
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 7,
                            fontWeight: FontWeight.w900,
                            color:
                                section == i ? MemberTheme.ink : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _selectedPage() {
    switch (section) {
      case 1:
        return _attendancePage();
      case 2:
        return _detailPage(
          title: 'Workout intelligence',
          subtitle: 'Today’s training session',
          value: '58 min',
          detail: 'Strength training · 6 exercises',
          icon: Icons.fitness_center_rounded,
          accent: MemberTheme.blue,
          progress: .72,
          footer: 'Weekly goal · 4 of 5 sessions',
        );
      case 3:
        return _detailPage(
          title: 'Payment overview',
          subtitle: 'Outstanding balance',
          value: '₹500',
          detail: 'Due now · Membership expires in 8 days',
          icon: Icons.account_balance_wallet_outlined,
          accent: MemberTheme.red,
          progress: .73,
          footer: 'Membership progress · 22 of 30 days',
        );
      case 4:
        return _detailPage(
          title: 'Member offers',
          subtitle: 'Rewards available',
          value: '5% OFF',
          detail: 'Partner fitness benefits and member perks',
          icon: Icons.local_offer_outlined,
          accent: MemberTheme.purple,
          progress: .5,
          footer: 'Explore benefits available to your plan',
        );
      case 5:
        return _detailPage(
          title: 'Activity history',
          subtitle: 'Most recent activity',
          value: '07:12 AM',
          detail: 'Check-in completed · Today',
          icon: Icons.history_rounded,
          accent: MemberTheme.teal,
          progress: 1,
          footer: 'Sample activity · Live records require API connection',
        );
      default:
        return _homePage();
    }
  }

  Widget _homePage() => Container(
        padding: const EdgeInsets.all(11),
        decoration: MemberTheme.softSurface(radius: 17, tint: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text('Home overview',
                      style: TextStyle(
                          fontSize: 13,
                          color: MemberTheme.ink,
                          fontWeight: FontWeight.w900)),
                ),
                Text(_monthName(month.month).toUpperCase().substring(0, 3) +
                    ' ${month.year}',
                    style: const TextStyle(
                        fontSize: 8,
                        color: MemberTheme.muted,
                        fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Icon(Icons.check_circle,
                    color: MemberTheme.emerald, size: 12),
                SizedBox(width: 4),
                Text('Check-in complete · 07:12 AM',
                    style: TextStyle(
                        fontSize: 9,
                        color: MemberTheme.muted,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const SizedBox(
                  width: 82,
                  height: 82,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: .81,
                          strokeWidth: 8,
                          strokeCap: StrokeCap.round,
                          backgroundColor: MemberTheme.mint,
                          valueColor:
                              AlwaysStoppedAnimation(MemberTheme.emerald),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('81%',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: MemberTheme.ink,
                                  fontWeight: FontWeight.w900)),
                          Text('25 / 31 days',
                              style: TextStyle(
                                  fontSize: 7, color: MemberTheme.muted)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    children: [
                      _StatRow(MemberTheme.emerald, 'Present', '25', '81%', .81),
                      _StatRow(MemberTheme.red, 'Absent', '2', '6%', .06),
                      _StatRow(MemberTheme.purple, 'Holiday', '4', '13%', .13),
                      _StatRow(MemberTheme.gold, 'Payment', '1 / 1', '100%', 1),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11),
            const Divider(height: 1, color: MemberTheme.line),
            const SizedBox(height: 9),
            const Row(
              children: [
                Expanded(
                    child: _InsightPill(
                        Icons.local_fire_department_rounded, '5d', 'STREAK',
                        MemberTheme.red)),
                SizedBox(width: 5),
                Expanded(
                    child: _InsightPill(
                        Icons.emoji_events_rounded, '14d', 'BEST', MemberTheme.gold)),
                SizedBox(width: 5),
                Expanded(
                    child: _InsightPill(
                        Icons.trending_up_rounded, '+6%', 'TREND', MemberTheme.emerald)),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Attendance snapshot · Sample data',
                style: TextStyle(fontSize: 7, color: MemberTheme.muted)),
          ],
        ),
      );

  Widget _attendancePage() => Container(
        padding: const EdgeInsets.all(10),
        decoration: MemberTheme.softSurface(radius: 17, tint: Colors.white),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text('Attendance calendar',
                      style: TextStyle(
                          fontSize: 12,
                          color: MemberTheme.ink,
                          fontWeight: FontWeight.w900)),
                ),
                _monthButton(Icons.chevron_left,
                    () => setState(() => month = DateTime(month.year, month.month - 1))),
                Text(' ${_monthName(month.month).substring(0, 3)} ${month.year} ',
                    style: const TextStyle(
                        fontSize: 9,
                        color: MemberTheme.ink,
                        fontWeight: FontWeight.w800)),
                _monthButton(Icons.chevron_right,
                    () => setState(() => month = DateTime(month.year, month.month + 1))),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                  .map((d) => Expanded(
                        child: Center(
                          child: Text(d,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: MemberTheme.muted,
                                  fontWeight: FontWeight.w900)),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 5),
            _calendarGrid(),
            const SizedBox(height: 8),
            const Wrap(
              spacing: 9,
              runSpacing: 5,
              children: [
                _LegendDot(MemberTheme.emerald, 'Present'),
                _LegendDot(MemberTheme.red, 'Absent'),
                _LegendDot(MemberTheme.purple, 'Holiday'),
                _LegendDot(MemberTheme.gold, 'Payment'),
              ],
            ),
          ],
        ),
      );

  Widget _calendarGrid() {
    final offset = DateTime(month.year, month.month, 1).weekday - 1;
    final total = DateTime(month.year, month.month + 1, 0).day;
    final count = ((offset + total + 6) ~/ 7) * 7;
    const status = <int, String>{
      3: 'holiday',
      7: 'absent',
      10: 'payment',
      18: 'holiday',
      24: 'absent',
      28: 'payment',
    };
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, i) {
        final day = i - offset + 1;
        if (day < 1 || day > total) return const SizedBox.shrink();
        final kind = status[day] ?? 'present';
        final color = switch (kind) {
          'absent' => MemberTheme.red,
          'holiday' => MemberTheme.purple,
          'payment' => MemberTheme.gold,
          _ => MemberTheme.emerald,
        };
        final textColor = kind == 'payment' ? MemberTheme.ink : Colors.white;
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withValues(alpha: .13),
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: color.withValues(alpha: .35)),
          ),
          child: Text('$day',
              style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.w900)),
        );
      },
    );
  }

  Widget _detailPage({
    required String title,
    required String subtitle,
    required String value,
    required String detail,
    required IconData icon,
    required Color accent,
    required double progress,
    required String footer,
  }) =>
      Container(
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(minHeight: 240),
        decoration: MemberTheme.softSurface(radius: 17, tint: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 13,
                    color: MemberTheme.ink,
                    fontWeight: FontWeight.w900)),
            const SizedBox(height: 13),
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                  color: accent.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(13)),
              child: Icon(icon, color: accent, size: 23),
            ),
            const SizedBox(height: 10),
            Text(subtitle,
                style: const TextStyle(
                    fontSize: 9,
                    color: MemberTheme.muted,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(value,
                style: TextStyle(
                    fontSize: 23,
                    color: accent,
                    fontWeight: FontWeight.w900)),
            const SizedBox(height: 5),
            Text(detail,
                style: const TextStyle(
                    fontSize: 9,
                    color: MemberTheme.ink,
                    height: 1.35)),
            const SizedBox(height: 13),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 7,
                backgroundColor: accent.withValues(alpha: .12),
                valueColor: AlwaysStoppedAnimation(accent),
              ),
            ),
            const Spacer(),
            Text(footer,
                style: const TextStyle(
                    fontSize: 8,
                    color: MemberTheme.muted,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      );

  Widget _monthButton(IconData icon, VoidCallback onTap) => Material(
        color: MemberTheme.mint,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
            width: 22,
            height: 22,
            child: Icon(icon, size: 16, color: MemberTheme.forest),
          ),
        ),
      );

  String _monthName(int m) => const [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ][m - 1];
}

class _StatRow extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  final String percent;
  final double progress;

  const _StatRow(
      this.color, this.label, this.value, this.percent, this.progress);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Container(
                width: 7,
                height: 7,
                decoration:
                    BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 5),
            Expanded(
                child: Text(label,
                    style: const TextStyle(
                        fontSize: 8,
                        color: MemberTheme.ink,
                        fontWeight: FontWeight.w700))),
            Text(value,
                style: const TextStyle(
                    fontSize: 8,
                    color: MemberTheme.ink,
                    fontWeight: FontWeight.w900)),
            const SizedBox(width: 5),
            SizedBox(
              width: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 5,
                  backgroundColor: color.withValues(alpha: .12),
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 24,
              child: Text(percent,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      fontSize: 7, color: MemberTheme.muted)),
            ),
          ],
        ),
      );
}

class _InsightPill extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color accent;

  const _InsightPill(this.icon, this.value, this.label, this.accent);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: .08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: .18)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: accent, size: 12),
            const SizedBox(width: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: const TextStyle(
                        color: MemberTheme.ink,
                        fontSize: 9,
                        fontWeight: FontWeight.w900)),
                Text(label,
                    style: const TextStyle(
                        color: MemberTheme.muted,
                        fontSize: 6,
                        fontWeight: FontWeight.w800)),
              ],
            ),
          ],
        ),
      );
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot(this.color, this.label);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 7,
              height: 7,
              decoration:
                  BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 4),
          Text(label,
              style: const TextStyle(
                  fontSize: 7,
                  color: MemberTheme.muted,
                  fontWeight: FontWeight.w700)),
        ],
      );
}
