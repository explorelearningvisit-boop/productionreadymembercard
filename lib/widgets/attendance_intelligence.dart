import 'package:flutter/material.dart';
import '../theme/member_theme.dart';

class AttendanceIntelligence extends StatefulWidget {
  const AttendanceIntelligence({super.key});
  @override
  State<AttendanceIntelligence> createState() => _AttendanceIntelligenceState();
}

class _AttendanceIntelligenceState extends State<AttendanceIntelligence> {
  int selectedSection = 1;
  int selectedTab = 0;
  DateTime month = DateTime(2026, 10);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(9),
    decoration: MemberTheme.glassCard(radius: 25, bright: true),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: const [
        CircleAvatar(radius: 15, backgroundColor: MemberTheme.berry, child: Icon(Icons.bar_chart, color: Colors.white, size: 18)),
        SizedBox(width: 7),
        Expanded(child: Text('Attendance Intelligence', style: TextStyle(fontSize: 14, color: MemberTheme.ink, fontWeight: FontWeight.w900))),
        _PartnerTag(),
      ]),
      const SizedBox(height: 6),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        _AttendanceRail(),
        SizedBox(width: 8),
        Expanded(child: selectedSection == 1 ? _AttendanceContent(month: month, selectedTab: selectedTab, onTab: (v) => setState(() => selectedTab = v), onMonth: (v) => setState(() => month = DateTime(month.year, month.month + v))) : _SectionPanel(section: selectedSection)),
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
  final int selected; final ValueChanged<int> onSelect;
  const _AttendanceRail({required this.selected, required this.onSelect});
  @override
  Widget build(BuildContext context) => Container(
    width: 45,
    padding: const EdgeInsets.symmetric(vertical: 7),
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [MemberTheme.berry, MemberTheme.wine]), borderRadius: BorderRadius.circular(22)),
    child: Column(children: [
      _RailItem(Icons.dashboard, 'Home', active: selected == 0, onTap: () => onSelect(0)),
      _RailItem(Icons.calendar_month, 'Attend', active: selected == 1, onTap: () => onSelect(1)),
      _RailItem(Icons.fitness_center, 'Workout', active: selected == 2, onTap: () => onSelect(2)),
      _RailItem(Icons.wallet, 'Pay', active: selected == 3, onTap: () => onSelect(3)),
      _RailItem(Icons.local_offer, 'Offers', active: selected == 4, onTap: () => onSelect(4)),
      _RailItem(Icons.history, 'History', active: selected == 5, onTap: () => onSelect(5)),
    ]),
  );
}

class _RailItem extends StatelessWidget {
  final IconData icon; final String label; final bool active; final VoidCallback onTap;
  const _RailItem(this.icon, this.label, {this.active = false, required this.onTap});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
    child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(12), child: Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      decoration: BoxDecoration(color: active ? MemberTheme.gold : Colors.transparent, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Icon(icon, size: 18, color: active ? MemberTheme.ink : Colors.white),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 7, color: active ? MemberTheme.ink : Colors.white, fontWeight: FontWeight.w800)),
      ]),
    )),
  );
}

class _AttendanceContent extends StatelessWidget {
  final DateTime month; final int selectedTab; final ValueChanged<int> onTab; final ValueChanged<int> onMonth;
  const _AttendanceContent({required this.month, required this.selectedTab, required this.onTab, required this.onMonth});
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
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), boxShadow: const [BoxShadow(color: Color(0x18000000), blurRadius: 8, offset: Offset(0, 3))]),
    child: Row(children: [
      SizedBox(width: 52, height: 52, child: Stack(alignment: Alignment.center, children: [
        const SizedBox.expand(child: CircularProgressIndicator(value: .81, strokeWidth: 5, backgroundColor: Color(0xFFFFD9E9), valueColor: AlwaysStoppedAnimation(MemberTheme.green))),
        Column(mainAxisSize: MainAxisSize.min, children: const [
          Text('81%', style: TextStyle(fontSize: 15, color: MemberTheme.ink, fontWeight: FontWeight.w900)),
          Text('25 / 31', style: TextStyle(fontSize: 7, color: MemberTheme.ink)),
          Text('Days', style: TextStyle(fontSize: 7, color: MemberTheme.ink)),
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
    padding: const EdgeInsets.symmetric(vertical: 1),
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
  final int selected; final ValueChanged<int> onSelect;
  const _HorizontalMenu({required this.selected, required this.onSelect});
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 25,
    child: ListView(scrollDirection: Axis.horizontal, children: [
      _MenuChip('Overview', selected == 0, () => onSelect(0)), _MenuChip('Attendance', selected == 1, () => onSelect(1)), _MenuChip('Workout', selected == 2, () => onSelect(2)), _MenuChip('Payments', selected == 3, () => onSelect(3)),
    ]),
  );
}

class _MenuChip extends StatelessWidget {
  final String label; final bool selected; final VoidCallback onTap;
  const _MenuChip(this.label, this.selected, this.onTap);
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(right: 5),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(color: selected ? MemberTheme.berry : const Color(0xFFFFE5F0), borderRadius: BorderRadius.circular(16)),
    child: Text(label, style: TextStyle(fontSize: 9, color: selected ? Colors.white : MemberTheme.ink, fontWeight: FontWeight.w800)),
  ));
}

class _MonthSelector extends StatelessWidget {
  final DateTime month; final ValueChanged<int> onChange;
  const _MonthSelector({required this.month, required this.onChange});
  @override
  Widget build(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => onChange(-1), child: const _CircleButton(Icons.chevron_left)),
    const SizedBox(width: 6),
    Expanded(child: Center(child: Text('▦  ${month.month}/${month.year}', style: const TextStyle(fontSize: 12, color: MemberTheme.ink, fontWeight: FontWeight.w900)))),
    const SizedBox(width: 6),
    GestureDetector(onTap: () => onChange(1), child: const _CircleButton(Icons.chevron_right)),
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
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 2, crossAxisSpacing: 3, childAspectRatio: 1.5),
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
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFF5C7DA))),
    child: Column(children: [
      Icon(icon, color: color, size: 17),
      Text(title, style: const TextStyle(fontSize: 8, color: MemberTheme.ink, fontWeight: FontWeight.w700)),
      Text(value, style: const TextStyle(fontSize: 11, color: MemberTheme.wine, fontWeight: FontWeight.w900)),
    ]),
  );
}

class _SectionPanel extends StatelessWidget {
  final int section;
  const _SectionPanel({required this.section});
  @override
  Widget build(BuildContext context) {
    const titles = ['Home overview','Attendance','Workout','Payments','Offers','History'];
    const details = ['Member status and today check-in','Monthly attendance calendar and summary','58 min workout · Strength training','₹500 due · Expires 24 Oct 2026','Member rewards and partner offers','Recent check-ins and payment events'];
    const icons = [Icons.home,Icons.calendar_month,Icons.fitness_center,Icons.wallet,Icons.local_offer,Icons.history];
    return Container(height: 230, padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(17)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Icon(icons[section],color: MemberTheme.berry), const SizedBox(width: 7), Expanded(child: Text(titles[section],style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w900,color: MemberTheme.ink)))]),
        const SizedBox(height: 14), Text(details[section],style: const TextStyle(fontSize: 11,color: MemberTheme.ink)),
        const SizedBox(height: 12),
        if(section == 0) const Text('Check-in completed · 07:12 AM\nGold Plan · Active',style: TextStyle(fontSize: 12,height: 1.8)),
        if(section == 2) const Text('Workout duration     58 min\nTraining focus           Strength',style: TextStyle(fontSize: 12,height: 1.8)),
        if(section == 3) const Text('Outstanding balance   ₹500\nMembership status       Active',style: TextStyle(fontSize: 12,height: 1.8)),
        if(section == 4) const Text('Partner offers\nMember reward benefits',style: TextStyle(fontSize: 12,height: 1.8)),
        if(section == 5) const Text('Today · Check-in 07:12 AM\nPrevious activity · Payment',style: TextStyle(fontSize: 12,height: 1.8)),
      ]));
  }
}
