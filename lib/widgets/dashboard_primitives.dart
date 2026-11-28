import 'package:flutter/material.dart';

import '../theme/member_theme.dart';
import '../data/dashboard_campaigns.dart';
import 'ad_motion.dart';
import 'sponsored_campaign.dart';


class DashboardPanel extends StatelessWidget {
  const DashboardPanel({
    required this.child,
    this.color = MemberTheme.glass,
    this.borderColor = MemberTheme.glassEdge,
    this.radius = 14,
    this.padding = EdgeInsets.zero,
    this.onTap,
    super.key,
  });

  final Widget child;
  final Color color;
  final Color borderColor;
  final double radius;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final panel = Container(
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
    if (onTap == null) return panel;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        mouseCursor: SystemMouseCursors.click,
        hoverColor: Colors.white.withOpacity(0.10),
        focusColor: Colors.white.withOpacity(0.14),
        child: panel,
      ),
    );
  }
}

class DashboardMetricTile extends StatelessWidget {
  const DashboardMetricTile({
    required this.label,
    required this.value,
    required this.note,
    required this.color,
    required this.campaign,
    required this.onCampaignTap,
    required this.asset,
    this.trend,
    this.trendColor,
    this.valueColor = MemberTheme.ink,
    this.compact = false,
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
  final DashboardCampaign campaign;
  final VoidCallback onCampaignTap;
  final String? trend;
  final Color? trendColor;
  final Color valueColor;
  final bool compact;
  final bool selected;
  final Color selectionColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14);
    return Material(
      key: super.key,
      color: Colors.transparent,
      borderRadius: radius,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.fromLTRB(3, compact ? 3 : 4, 3, 3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: radius,
          border: Border.all(
            color: selected ? selectionColor : Colors.white,
            width: selected ? 1.8 : 1.1,
          ),
          boxShadow: const [
            BoxShadow(color: Color(0x160D0905), blurRadius: 3, offset: Offset(0, 1)),
            BoxShadow(color: Color(0xBFFFFFFF), blurRadius: 1, offset: Offset(0, -1)),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  key: ValueKey('metric-${label.toLowerCase()}-menu'),
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(10),
                  mouseCursor: SystemMouseCursors.click,
                  hoverColor: Colors.white.withOpacity(0.16),
                  focusColor: Colors.white.withOpacity(0.20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                    child: Column(
                      children: [
                        _fit(label, compact ? 11.5 : 12.5, MemberTheme.ink),
                        SizedBox(height: compact ? 1 : 2),
                        _fit(value, compact ? 21 : 24, valueColor),
                        if (trend != null) ...[
                          const SizedBox(height: 1),
                          _fit(trend!, compact ? 9 : 10, trendColor ?? MemberTheme.green),
                        ],
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: ArtworkEntrance(
                              key: ValueKey('artwork-$label'),
                              motion: label == 'Attendance'
                                  ? 0
                                  : label == 'Workout'
                                      ? 1
                                      : label == 'Payment'
                                          ? 2
                                          : 3,
                              child: Image.asset(
                                asset,
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Open',
                          maxLines: 1,
                          style: TextStyle(
                            color: MemberTheme.ink.withOpacity(0.72),
                            fontSize: compact ? 8 : 8.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),
            CampaignFooterButton(
              campaign: campaign,
              compact: compact,
              onTap: onCampaignTap,
            ),
          ],
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
            fontWeight: FontWeight.w700,
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
              color: MemberTheme.ink, fontSize: compact ? 10.5 : 11.5, fontWeight: FontWeight.w600,
            )),
          ),
          SizedBox(
            width: 19,
            child: Text(count, textAlign: TextAlign.end, style: TextStyle(
              color: MemberTheme.ink, fontSize: compact ? 10.5 : 11.5, fontWeight: FontWeight.w600,
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
              color: MemberTheme.ink, fontSize: compact ? 10 : 11, fontWeight: FontWeight.w900,
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
          color: MemberTheme.muted, fontSize: compact ? 10.5 : 11.5, fontWeight: FontWeight.w900,
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
