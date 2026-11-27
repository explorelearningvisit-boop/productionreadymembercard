import 'package:flutter/material.dart';

import '../theme/member_theme.dart';
import 'ad_motion.dart';


class DashboardPanel extends StatelessWidget {
  const DashboardPanel({
    required this.child,
    this.color = MemberTheme.glass,
    this.borderColor = MemberTheme.glassEdge,
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
        border: Border.all(color: borderColor.withOpacity(0.9), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x120F0B07),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            color: Color(0xBFFFFFFF),
            blurRadius: 1,
            offset: Offset(0, -1),
          ),
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
    this.compact = false,
    this.noteColor = const Color(0xCCFFFFFF),
    this.noteTextColor = MemberTheme.ink,
    this.motion = 0,
    this.selected = false,
    this.selectionColor = MemberTheme.purple,
    this.onTap,
    super.key,
  });

  final String label;
  final String value;
  final String note;
  final Color color;
  final String asset;
  final String? trend;
  final Color valueColor;
  final bool compact;
  final Color noteColor;
  final Color noteTextColor;
  final int motion;
  final bool selected;
  final Color selectionColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14);
    return Material(
      color: Colors.transparent,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          clipBehavior: Clip.antiAlias,
          padding: compact
              ? const EdgeInsets.fromLTRB(3, 3, 3, 2)
              : const EdgeInsets.fromLTRB(3, 4, 3, 3),
          decoration: BoxDecoration(
            color: color,
            borderRadius: radius,
            border: Border.all(
              color: selected ? selectionColor : Colors.white,
              width: selected ? 1.8 : 1.3,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0x160D0905),
                blurRadius: selected ? 5 : 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              _fit(label, compact ? 8.4 : 9.2, MemberTheme.ink),
              SizedBox(height: compact ? 1 : 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _fit(
                      value,
                      compact ? 17 : 20,
                      valueColor,
                    ),
                  ),
                  if (trend != null) ...[
                    const SizedBox(width: 2),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: compact ? 3 : 4,
                          vertical: compact ? 2 : 2.5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.78),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _fit(
                          trend!,
                          compact ? 8.4 : 9,
                          const Color(0xFF087E40),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: compact ? 2 : 3),
              Container(
                height: 1,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.95),
                      Colors.white.withOpacity(0.15),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: compact ? 0 : 1,
                    horizontal: 1,
                  ),
                  child: ArtworkEntrance(
                    motion: motion,
                    child: Image.asset(
                      asset,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 2,
                  vertical: compact ? 2 : 3,
                ),
                decoration: BoxDecoration(
                  color: noteColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white.withOpacity(0.76)),
                ),
                child: _fit(note, compact ? 8.6 : 9.5, noteTextColor),
              ),
            ],
          ),
        ),
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
            height: 1,
            fontWeight: FontWeight.w600,
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
      height: compact ? 17 : 20,
      child: Row(
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 45,
            child: Text(label, maxLines: 1, style: TextStyle(
              color: MemberTheme.ink, fontSize: compact ? 9 : 10.5, fontWeight: FontWeight.w600,
            )),
          ),
          SizedBox(
            width: 19,
            child: Text(count, textAlign: TextAlign.end, style: TextStyle(
              color: MemberTheme.ink, fontSize: compact ? 9 : 10, fontWeight: FontWeight.w600,
            )),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: value.clamp(0.0, 1.0).toDouble(),
                minHeight: compact ? 6 : 8,
                backgroundColor: const Color(0xFFE2D7EC),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 26,
            child: Text(percent, textAlign: TextAlign.end, style: TextStyle(
              color: MemberTheme.ink, fontSize: compact ? 8.5 : 9.5, fontWeight: FontWeight.w900,
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
        child: Text(label, style: TextStyle(
          color: MemberTheme.muted, fontSize: compact ? 9 : 10, fontWeight: FontWeight.w900,
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
    this.selectedColor = MemberTheme.purple,
    this.height = 25,
    this.compact = false,
    super.key,
  });

  final String day;
  final Color color;
  final bool selected;
  final bool off;
  final Color selectedColor;
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
          borderRadius: BorderRadius.circular(8),
          border: selected
              ? Border.all(color: selectedColor, width: 1.7)
              : Border.all(color: const Color(0xFFD7D0C6), width: 0.7),
          boxShadow: const [
            BoxShadow(
              color: Color(0x120D0905),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                day,
                style: TextStyle(
                  color: MemberTheme.ink,
                  fontSize: compact ? 12 : 13,
                  height: 1,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (off)
                Text('OFF', style: TextStyle(
                  color: Color(0xFF635B6B), fontSize: compact ? 7.5 : 8.5, fontWeight: FontWeight.w600,
                )),
            ],
          ),
        ),
      ),
    );
  }
}
