import 'package:flutter/material.dart';
import '../theme/member_theme.dart';

class AttendanceIntelligence extends StatefulWidget {
  const AttendanceIntelligence({super.key});
  @override State<AttendanceIntelligence> createState() => _AttendanceIntelligenceState();
}

class _AttendanceIntelligenceState extends State<AttendanceIntelligence> {
  int selected = 0;
  static const labels = ['Home', 'Attend', 'Workout', 'Pay', 'Offers', 'History'];
  static const icons = [Icons.home_rounded, Icons.calendar_month_rounded, Icons.fitness_center_rounded,
    Icons.account_balance_wallet_rounded, Icons.sell_rounded, Icons.history_rounded];

  @override Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(9),
    decoration: MemberTheme.glass(radius: 24, tint: const Color(0xFFFFF9FF)),
    child: Column(children: [
      Row(children: [
        const Icon(Icons.insights_rounded, color: MemberTheme.purple, size: 25),
        const SizedBox(width: 7),
        const Expanded(child: Text('Attendance Intelligence', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: MemberTheme.ink))),
        Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
          decoration: BoxDecoration(color: const Color(0xFFFFE6F0), borderRadius: BorderRadius.circular(18), border: Border.all(color: MemberTheme.pink)),
          child: const Text('● LIVE', style: TextStyle(color: MemberTheme.red, fontSize: 10, fontWeight: FontWeight.w900))),
      ]),
      const SizedBox(height: 8),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 49, padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
          decoration: BoxDecoration(gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [MemberTheme.deepPurple, MemberTheme.purple]), borderRadius: BorderRadius.circular(18)),
          child: Column(mainAxisSize: MainAxisSize.min, children: List.generate(labels.length, (i) =>
            Padding(padding: const EdgeInsets.symmetric(vertical: 2), child: InkWell(
              onTap: () => setState(() => selected = i),
              borderRadius: BorderRadius.circular(11),
              child: Container(width: 43, height: 47,
                decoration: BoxDecoration(color: selected == i ? MemberTheme.gold : Colors.transparent, borderRadius: BorderRadius.circular(11)),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(icons[i], size: 19, color: selected == i ? MemberTheme.deepPurple : Colors.white),
                  const SizedBox(height: 2),
                  Text(labels[i], style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900,
                    color: selected == i ? MemberTheme.deepPurple : Colors.white)),
                ]),
              ),
            )),
          )),
        ),
        const SizedBox(width: 8),
        Expanded(child: _content()),
      ]),
    ]),
  );

  Widget _content() {
    if (selected != 0) {
      final title = ['Home overview','Attendance calendar','Workout overview','Payment overview','Offers','History'][selected];
      final icon = icons[selected];
      final value = ['81%','25 / 31','58 min','₹500 Due','Special offer','07:12 AM'][selected];
      return Container(padding: const EdgeInsets.all(11), constraints: const BoxConstraints(minHeight: 280),
        decoration: MemberTheme.glass(radius: 18, tint: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: MemberTheme.deepPurple)),
          const SizedBox(height: 14),
          Icon(icon, color: MemberTheme.purple, size: 32),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: MemberTheme.ink)),
          const Text('Member snapshot · Sample data', style: TextStyle(fontSize: 9, color: MemberTheme.muted)),
        ]),
      );
    }
    return Container(padding: const EdgeInsets.all(11),
      decoration: MemberTheme.glass(radius: 18, tint: Colors.white),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Home overview', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: MemberTheme.deepPurple)),
        const SizedBox(height: 3),
        const Text('Check-in complete · 07:12 AM', style: TextStyle(fontSize: 10, color: MemberTheme.ink)),
        const SizedBox(height: 14),
        Row(children: [
          SizedBox(width: 88, height: 88, child: Stack(alignment: Alignment.center, children: [
            const SizedBox.expand(child: CircularProgressIndicator(value: .81, strokeWidth: 9,
              backgroundColor: Color(0xFFF4DDFD), valueColor: AlwaysStoppedAnimation(MemberTheme.green))),
            Column(mainAxisSize: MainAxisSize.min, children: const [
              Text('81%', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: MemberTheme.ink)),
              Text('25/31', style: TextStyle(fontSize: 9, color: MemberTheme.muted)),
            ]),
          ])),
          const SizedBox(width: 10),
          const Expanded(child: Column(children: [
            _AttendanceStat(MemberTheme.green, 'Present', '25', '81%', .81),
            _AttendanceStat(MemberTheme.red, 'Absent', '2', '6%', .06),
            _AttendanceStat(MemberTheme.purple, 'Holiday', '4', '13%', .13),
            _AttendanceStat(MemberTheme.gold, 'Payment', '1/1', '100%', 1),
          ])),
        ]),
        const SizedBox(height: 12),
        const Divider(height: 1, color: MemberTheme.line),
        const SizedBox(height: 9),
        const Row(children: [
          Expanded(child: _FootMetric(Icons.local_fire_department_rounded, '5d', MemberTheme.red)),
          Expanded(child: _FootMetric(Icons.emoji_events_rounded, '14d', MemberTheme.purple)),
          Expanded(child: _FootMetric(Icons.trending_up_rounded, '+6%', MemberTheme.green)),
        ]),
        const SizedBox(height: 8),
        const Text('Sample data · API connection required for live records',
          style: TextStyle(fontSize: 8, color: MemberTheme.muted)),
      ]),
    );
  }
}

class _AttendanceStat extends StatelessWidget {
  final Color color; final String label, count, percent; final double value;
  const _AttendanceStat(this.color, this.label, this.count, this.percent, this.value);
  @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(children: [
      Container(width: 9, height: 9, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 5),
      Expanded(child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: MemberTheme.ink))),
      Text(count, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: MemberTheme.ink)),
      const SizedBox(width: 6),
      SizedBox(width: 54, child: ClipRRect(borderRadius: BorderRadius.circular(8),
        child: LinearProgressIndicator(value: value, minHeight: 7, backgroundColor: const Color(0xFFF0DDED),
          valueColor: AlwaysStoppedAnimation(color)))),
      const SizedBox(width: 4),
      SizedBox(width: 28, child: Text(percent, textAlign: TextAlign.end, style: const TextStyle(fontSize: 8, color: MemberTheme.muted))),
    ]),
  );
}

class _FootMetric extends StatelessWidget {
  final IconData icon; final String value; final Color color;
  const _FootMetric(this.icon, this.value, this.color);
  @override Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    Icon(icon, size: 18, color: color), const SizedBox(width: 4),
    Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: color)),
  ]);
}
