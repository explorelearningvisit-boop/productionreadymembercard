import 'package:flutter/material.dart';

import '../theme/member_theme.dart';

class DashboardPanel extends StatelessWidget {
  const DashboardPanel({
    required this.child,
    this.color = const Color(0xFF431078),
    this.borderColor = const Color(0xFFB56AFF),
    this.radius = 14,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  final Widget child;
  final Color color;
  final Color borderColor;
  final double radius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: const [
          BoxShadow(color: Color(0x667D26D9), blurRadius: 5),
        ],
      ),
      child: child,
    );
  }
}

class DashboardMetricTile extends StatelessWidget {
  const DashboardMetricTile({
    required this.label,
    required this.value,
    required this.note,
    required this.color,
    required this.asset,
    super.key,
  });

  final String label;
  final String value;
  final String note;
  final Color color;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 5, 4, 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.white, width: 1.2),
        boxShadow: const [BoxShadow(color: Color(0x667C31FF), blurRadius: 5)],
      ),
      child: Column(
        children: [
          _fit(label, 8, MemberTheme.ink),
          const SizedBox(height: 2),
          Expanded(child: Center(child: _fit(value, 16, MemberTheme.ink))),
          _fit(note, 7, MemberTheme.ink),
          const SizedBox(height: 2),
          Expanded(
            child: Image.asset(
              asset,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.medium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fit(String text, double size, Color color) {
    return SizedBox(
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          maxLines: 1,
          style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class AttendanceLegend extends StatelessWidget {
  const AttendanceLegend({
    required this.color,
    required this.label,
    required this.count,
    required this.percent,
    super.key,
  });

  final Color color;
  final String label;
  final String count;
  final String percent;

  @override
  Widget build(BuildContext context) {
    final value = (double.tryParse(percent.replaceAll('%', '')) ?? 0) / 100;
    return SizedBox(
      height: 16,
      child: Row(
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 43,
            child: Text(label, maxLines: 1, style: const TextStyle(
              color: MemberTheme.ink, fontSize: 8, fontWeight: FontWeight.w800,
            )),
          ),
          SizedBox(
            width: 17,
            child: Text(count, textAlign: TextAlign.end, style: const TextStyle(
              color: MemberTheme.ink, fontSize: 8, fontWeight: FontWeight.w900,
            )),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: value.clamp(0.0, 1.0),
                minHeight: 5,
                backgroundColor: const Color(0xFFE2D7EC),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 23,
            child: Text(percent, textAlign: TextAlign.end, style: const TextStyle(
              color: MemberTheme.ink, fontSize: 7, fontWeight: FontWeight.w900,
            )),
          ),
        ],
      ),
    );
  }
}

class WeekdayLabel extends StatelessWidget {
  const WeekdayLabel(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(label, style: const TextStyle(
          color: Color(0xFF4B3C5B), fontSize: 7, fontWeight: FontWeight.w800,
        )),
      ),
    );
  }
}

class AttendanceDayCell extends StatelessWidget {
  const AttendanceDayCell(
    this.day, {
    this.color = const Color(0xFFD7F8DF),
    this.selected = false,
    this.off = false,
    super.key,
  });

  final String day;
  final Color color;
  final bool selected;
  final bool off;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 22,
        margin: const EdgeInsets.symmetric(horizontal: 1),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: selected
              ? Border.all(color: MemberTheme.purple, width: 1.5)
              : null,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(day, style: const TextStyle(
                color: MemberTheme.ink, fontSize: 9, fontWeight: FontWeight.w900,
              )),
              if (off)
                const Text('OFF', style: TextStyle(
                  color: Color(0xFF635B6B), fontSize: 6, fontWeight: FontWeight.w800,
                )),
            ],
          ),
        ),
      ),
    );
  }
}
