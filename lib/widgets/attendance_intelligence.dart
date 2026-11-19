import 'package:flutter/material.dart';
import '../theme/member_theme.dart';

class AttendanceIntelligence extends StatelessWidget {
  const AttendanceIntelligence({super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(9),
    decoration: MemberTheme.glassCard(radius: 25, bright: true),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: const [
        CircleAvatar(radius: 15, backgroundColor: MemberTheme.berry, child: Icon(Icons.bar_chart, color: Colors.white, size: 18)),
        SizedBox(width: 7),
        Expanded(child: Text('Attendance Intelligence', style: TextStyle(fontSize: 15, color: MemberTheme.ink, fontWeight: FontWeight.w900))),
        _PartnerTag(),
      ]),
      const SizedBox(height: 10),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        _AttendanceRail(),
        SizedBox(width: 8),
        Expanded(child: _AttendanceContent()),
      ]),
    ]),
  );
}

class _PartnerTag extends StatelessWidget {
  const _PartnerTag();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(color: const Color(0xFFFFE68A), borderRadius: BorderRadius.circular(14)),
    child: const Text('Co-powered by blinkit', style: TextStyle(fontSize: 9, color: MemberTheme.ink, fontWeight: FontWeight.w800)),
  );
}

class _AttendanceRail extends StatelessWidget {
  const _AttendanceRail();
  @override
  Widget build(BuildContext context) => Container(
    width: 45,
    padding: const EdgeInsets.symmetric(vertical: 7),
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [MemberTheme.berry, MemberTheme.wine]), borderRadius: BorderRadius.circular(22)),
    child: Column(children: const [
      _RailItem(Icons.dashboard, 'Home'),
      _RailItem(Icons.calendar_month, 'Attend', active: true),
      _RailItem(Icons.fitness_center, 'Workout'),
      _RailItem(Icons.wallet, 'Pay'),
      _RailItem(Icons.local_offer, 'Offers'),
      _RailItem(Icons.history, 'History'),
    ]),
  );
}

class _RailItem extends StatelessWidget {
  final IconData icon; final String label; final bool active;
  const _RailItem(this.icon, this.label, {this.active = false});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
      decoration: BoxDecoration(color: active ? MemberTheme.gold : Colors.transparent, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(icon, size: 18, color: active ? MemberTheme.ink : Colors.white),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 7, color: active ? MemberTheme.ink : Colors.white, fontWeight: FontWeight.w800)),
      ]),
    ),
  );
}

class _AttendanceContent extends StatelessWidget {
  const _AttendanceContent();
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: const [
    _SummaryPanel(),
    SizedBox(height: 8),
    _HorizontalMenu(),
    SizedBox(height: 8),
    _MonthSelector(),
    SizedBox(height: 7),
    _CalendarGrid(),
    SizedBox(height: 7),
    _Legend(),
    SizedBox(height: 8),
    _InsightRow(),
  ]);
}

class _SummaryPanel extends StatelessWidget {
  const _SummaryPanel();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), boxShadow: const [BoxShadow(color: Color(0x18000000), blurRadius: 8, offset: Offset(0, 3))]),
    child: Row(children: [
      SizedBox(width: 72, height: 72, child: Stack(alignment: Alignment.center, children: [
        const SizedBox.expand(child: CircularProgressIndicator(value: .81, strokeWidth: 9, backgroundColor: Color(0xFFFFD9E9), valueColor: AlwaysStoppedAnimation(MemberTheme.green))),
        Column(mainAxisSize: MainAxisSize.min, children: const [
          Text('81%', style: TextStyle(fontSize: 19, color: MemberTheme.ink, fontWeight: FontWeight.w900)),
          Text('25 / 31', style: TextStyle(fontSize: 8, color: MemberTheme.ink)),
          Text('Days', style: TextStyle(fontSize: 8, color: MemberTheme.ink)),
        ]),
      ])),
      const SizedBox(width: 8),
      const Expanded(child: Column(children: [
        _SummaryLine(MemberTheme.green, 'Present', '25', '81%'),
        _SummaryLine(MemberTheme.red, 'Absent', '2', '6%'),
        _SummaryLine(MemberTheme.purple, 'Holiday', '4', '13%'),
        _SummaryLine(MemberTheme.gold, 'Payment ✓', '1 / 1', '100%'),
      ])),
    ]),
  );
}

class _SummaryLine extends StatelessWidget {
  final Color color; final String title; final String count; final String percent;
  const _SummaryLine(this.color, this.title, this.count, this.percent);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 5),
      Expanded(child: Text(title, style: const TextStyle(fontSize: 9, color: MemberTheme.ink, fontWeight: FontWeight.w700))),
      Text(count, style: const TextStyle(fontSize: 9, color: MemberTheme.ink, fontWeight: FontWeight.w900)),
      const SizedBox(width: 5),
      SizedBox(width: 40, child: ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: title == 'Present' ? .81 : title == 'Absent' ? .06 : title == 'Holiday' ? .13 : 1, minHeight: 6, backgroundColor: const Color(0xFFF3DCE7), valueColor: AlwaysStoppedAnimation(color)))),
      const SizedBox(width: 4),
      SizedBox(width: 25, child: Text(percent, style: const TextStyle(fontSize: 8, color: MemberTheme.ink))),
    ]),
  );
}

class _HorizontalMenu extends StatelessWidget {
  const _HorizontalMenu();
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 27,
    child: ListView(scrollDirection: Axis.horizontal, children: const [
      _MenuChip('Overview', true), _MenuChip('Attendance', false), _MenuChip('Workout', false), _MenuChip('Payments', false),
    ]),
  );
}

class _MenuChip extends StatelessWidget {
  final String label; final bool selected;
  const _MenuChip(this.label, this.selected);
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(right: 5),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(color: selected ? MemberTheme.berry : const Color(0xFFFFE5F0), borderRadius: BorderRadius.circular(16)),
    child: Text(label, style: TextStyle(fontSize: 9, color: selected ? Colors.white : MemberTheme.ink, fontWeight: FontWeight.w800)),
  );
}

class _MonthSelector extends StatelessWidget {
  const _MonthSelector();
  @override
  Widget build(BuildContext context) => Row(children: const [
    _CircleButton(Icons.chevron_left),
    SizedBox(width: 6),
    Expanded(child: Center(child: Text('▦  October 2026  ▾', style: TextStyle(fontSize: 12, color: MemberTheme.ink, fontWeight: FontWeight.w900)))),
    SizedBox(width: 6),
    _CircleButton(Icons.calendar_month),
  ]);
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  const _CircleButton(this.icon);
  @override
  Widget build(BuildContext context) => Container(width: 30, height: 30, decoration: BoxDecoration(color: const Color(0xFFFFE5F0), shape: BoxShape.circle, border: Border.all(color: const Color(0xFFE6A7C5))), child: Icon(icon, color: MemberTheme.wine, size: 17));
}

class _CalendarGrid extends StatelessWidget {
  const _CalendarGrid();
  @override
  Widget build(BuildContext context) {
    final days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
    final status = <int, String>{3:'holiday',7:'absent',10:'payment',18:'holiday',24:'absent',28:'payment'};
    return Column(children: [
      Row(children: days.map((d) => Expanded(child: Center(child: Text(d, style: const TextStyle(fontSize: 8, color: MemberTheme.ink, fontWeight: FontWeight.w900))))).toList()),
      const SizedBox(height: 4),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 35,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 4, crossAxisSpacing: 3, childAspectRatio: 1.35),
        itemBuilder: (context, index) {
          final day = index - 2;
          if (day < 1 || day > 31) return const SizedBox.shrink();
          final kind = status[day] ?? (day == 22 ? 'selected' : 'present');
          final color = kind == 'absent' ? MemberTheme.red : kind == 'holiday' ? MemberTheme.purple : kind == 'payment' ? MemberTheme.gold : MemberTheme.green;
          return Container(
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(14), border: kind == 'selected' ? Border.all(color: MemberTheme.green, width: 2) : null),
            alignment: Alignment.center,
            child: kind == 'holiday' ? const Icon(Icons.calendar_month, color: Colors.white, size: 13) : kind == 'payment' ? const Icon(Icons.currency_rupee, color: MemberTheme.ink, size: 13) : Text('$day', style: TextStyle(color: kind == 'payment' ? MemberTheme.ink : Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
          );
        },
      ),
    ]);
  }
}

class _Legend extends StatelessWidget {
  const _Legend();
  @override
  Widget build(BuildContext context) => Wrap(spacing: 8, runSpacing: 4, children: const [
    _LegendDot(MemberTheme.green, 'Present'), _LegendDot(MemberTheme.red, 'Absent'), _LegendDot(MemberTheme.purple, 'Holiday'), _LegendDot(MemberTheme.gold, 'Payment'),
  ]);
}

class _LegendDot extends StatelessWidget {
  final Color color; final String label;
  const _LegendDot(this.color, this.label);
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    const SizedBox(width: 3),
    Text(label, style: const TextStyle(fontSize: 8, color: MemberTheme.ink, fontWeight: FontWeight.w700)),
  ]);
}

class _InsightRow extends StatelessWidget {
  const _InsightRow();
  @override
  Widget build(BuildContext context) => Row(children: const [
    Expanded(child: _Insight(Icons.local_fire_department, 'Streak', '5 Days', MemberTheme.red)),
    SizedBox(width: 6),
    Expanded(child: _Insight(Icons.emoji_events, 'Best', '14 Days', MemberTheme.gold)),
    SizedBox(width: 6),
    Expanded(child: _Insight(Icons.trending_up, 'Monthly', '+6%', MemberTheme.green)),
  ]);
}

class _Insight extends StatelessWidget {
  final IconData icon; final String title; final String value; final Color color;
  const _Insight(this.icon, this.title, this.value, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 5),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFF5C7DA))),
    child: Column(children: [
      Icon(icon, color: color, size: 17),
      Text(title, style: const TextStyle(fontSize: 8, color: MemberTheme.ink, fontWeight: FontWeight.w700)),
      Text(value, style: const TextStyle(fontSize: 11, color: MemberTheme.wine, fontWeight: FontWeight.w900)),
    ]),
  );
}
