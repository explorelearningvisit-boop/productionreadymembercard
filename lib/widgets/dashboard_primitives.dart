import 'package:flutter/material.dart';

import '../theme/member_theme.dart';


class PulseGlow extends StatefulWidget {
  const PulseGlow({required this.child, this.glowColor = const Color(0xFFFFD34E), super.key});
  final Widget child;
  final Color glowColor;

  @override
  State<PulseGlow> createState() => _PulseGlowState();
}

class _PulseGlowState extends State<PulseGlow> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.25, end: 1.0),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
      builder: (context, value, child) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(
            color: widget.glowColor.withOpacity(value * 0.55),
            blurRadius: 5 + value * 10,
            spreadRadius: value * 1.2,
          )],
        ),
        child: child,
      ),
      child: widget.child,
    );
  }
}

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
        gradient: LinearGradient(
          colors: [Color.lerp(color, Colors.white, 0.10)!, color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: const [
          BoxShadow(color: Color(0x887D26D9), blurRadius: 7, spreadRadius: 0.5),
          BoxShadow(color: Color(0x33FFFFFF), blurRadius: 2),
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
    this.trend,
    this.valueColor = MemberTheme.ink,
    super.key,
  });

  final String label;
  final String value;
  final String note;
  final Color color;
  final String asset;
  final String? trend;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(3, 4, 3, 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, Color.lerp(color, Colors.white, 0.22)!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white, width: 1.3),
        boxShadow: const [
          BoxShadow(color: Color(0x887C31FF), blurRadius: 7, spreadRadius: 0.5),
        ],
      ),
      child: Column(
        children: [
          _fit(label, 8, MemberTheme.ink),
          const SizedBox(height: 2),
          _fit(value, 17, valueColor),
          if (trend != null) ...[
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xAAFFFFFF),
                borderRadius: BorderRadius.circular(9),
              ),
              child: _fit(trend!, 8, const Color(0xFF078B46)),
            ),
          ],
          const SizedBox(height: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Image.asset(
                asset,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xAAFFFFFF),
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: const Color(0x66FFFFFF)),
            ),
            child: _fit(note, 7, MemberTheme.ink),
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
    this.compact = false,
    super.key,
  });

  final Color color;
  final String label;
  final String count;
  final String percent;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final value = (double.tryParse(percent.replaceAll('%', '')) ?? 0) / 100;
    return SizedBox(
      height: compact ? 14 : 17,
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
              color: MemberTheme.ink, fontSize: compact ? 7 : 8, fontWeight: FontWeight.w800,
            )),
          ),
          SizedBox(
            width: 17,
            child: Text(count, textAlign: TextAlign.end, style: const TextStyle(
              color: MemberTheme.ink, fontSize: compact ? 7 : 8, fontWeight: FontWeight.w900,
            )),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: value.clamp(0.0, 1.0).toDouble(),
                minHeight: compact ? 5 : 7,
                backgroundColor: const Color(0xFFE2D7EC),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 23,
            child: Text(percent, textAlign: TextAlign.end, style: const TextStyle(
              color: MemberTheme.ink, fontSize: compact ? 6 : 7, fontWeight: FontWeight.w900,
            )),
          ),
        ],
      ),
    );
  }
}

class WeekdayLabel extends StatelessWidget {
  const WeekdayLabel(this.label, {this.compact = false, super.key});
  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(label, style: const TextStyle(
          color: Color(0xFF4B3C5B), fontSize: compact ? 7 : 8, fontWeight: FontWeight.w800,
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
    this.height = 25,
    this.compact = false,
    super.key,
  });

  final String day;
  final Color color;
  final bool selected;
  final bool off;
  final double height;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 1.5),
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
                  color: Color(0xFF635B6B), fontSize: compact ? 6 : 7, fontWeight: FontWeight.w800,
                )),
            ],
          ),
        ),
      ),
    );
  }
}
