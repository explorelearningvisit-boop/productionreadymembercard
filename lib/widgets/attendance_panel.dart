import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/sample_member.dart';
import '../data/dashboard_navigation.dart';
import '../data/dashboard_campaigns.dart';
import '../theme/member_theme.dart';
import 'dashboard_primitives.dart';
import 'module_dashboard_views.dart';
import 'sponsored_campaign.dart';

class AttendancePanel extends StatelessWidget {
  const AttendancePanel({
    required this.module,
    required this.sectionIndex,
    required this.member,
    super.key,
  });

  final DashboardModule module;
  final int sectionIndex;
  final MemberSample member;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final palette = MemberPlanTheme.of(context);
        const fullHeight = 370.0;
        // The compact canvas has extra internal room for the fixed chart,
        // calendar and legend rows. FittedBox scales it uniformly on short
        // phones instead of letting the panel's Column overflow.
        const compactHeight = 324.0;
        final availableHeight = constraints.maxHeight;
        if (availableHeight < compactHeight) {
          final scale = (availableHeight / compactHeight).clamp(0.01, 1.0);
          return FittedBox(
            key: const ValueKey('attendance-panel'),
            fit: BoxFit.scaleDown,
            alignment: Alignment.topCenter,
            child: SizedBox(
              // Compensate for FittedBox's uniform scale so the panel still
              // fills the rail's available content width on short screens.
              width: constraints.maxWidth / scale,
              height: compactHeight,
              child: _panel(context, compact: true, palette: palette, module: module, sectionIndex: sectionIndex, member: member),
            ),
          );
        }
        final compact = availableHeight < fullHeight;
        return SizedBox(
          key: const ValueKey('attendance-panel'),
          width: constraints.maxWidth,
          height: availableHeight,
          child: _panel(context, compact: compact, palette: palette, module: module, sectionIndex: sectionIndex, member: member),
        );
      },
    );
  }

  Widget _panel(
    BuildContext context, {
    bool compact = false,
    required MemberPlanPalette palette,
    required DashboardModule module,
    required int sectionIndex,
    required MemberSample member,
  }) {
    if (module != DashboardModule.attendance || sectionIndex != 0) {
      return _alternatePanel(
        context: context,
        module: module,
        sectionIndex: sectionIndex,
        compact: compact,
        palette: palette,
        member: member,
      );
    }
    final headerHeight = compact ? 28.0 : 36.0;
    final chartHeight = compact ? 68.0 : 82.0;
    final ringSize = compact ? 62.0 : 74.0;
    final recoveryHeight = compact ? 22.0 : 30.0;
    final calendarTitleHeight = compact ? 22.0 : 27.0;
    final cellHeight = compact ? 27.0 : 34.0;
    final summaryHeight = compact ? 14.0 : 18.0;

    return Container(
      padding: EdgeInsets.fromLTRB(7, compact ? 4 : 6, 7, compact ? 4 : 6),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.panelEdge, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x120F0B07),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        // Spread the analytics blocks through the available panel height.
        // This avoids the large dead zone below the calendar in tall layouts.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _header(
            context: context,
            compact: compact,
            height: headerHeight,
            palette: palette,
          ),
          SizedBox(height: compact ? 2 : 3),
          SizedBox(
            height: chartHeight,
            child: Row(
              children: [
                SizedBox(
                  width: compact ? 66 : 76,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: ringSize,
                        height: ringSize,
                        child: CustomPaint(
                          painter: const _AttendanceRingPainter(),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '81%',
                                  style: TextStyle(
                                    color: MemberTheme.ink,
                                    fontSize: compact ? 18 : 21,
                                    height: 1,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  '25/31',
                                  style: TextStyle(
                                    color: MemberTheme.ink,
                                    fontSize: compact ? 10.5 : 11.5,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: compact ? 2 : 4),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AttendanceLegend(
                        compact: compact,
                        color: const Color(0xFF0CCB60),
                        label: 'Present',
                        count: '23',
                        percent: '74%',
                      ),
                      AttendanceLegend(
                        compact: compact,
                        color: const Color(0xFFE52B52),
                        label: 'Absent',
                        count: '2',
                        percent: '6%',
                      ),
                      AttendanceLegend(
                        compact: compact,
                        color: const Color(0xFF8A35D5),
                        label: 'Holiday',
                        count: '4',
                        percent: '13%',
                      ),
                      AttendanceLegend(
                        compact: compact,
                        color: const Color(0xFFFFB21C),
                        label: 'Late',
                        count: '2',
                        percent: '6%',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: compact ? 1 : 2),
          const Divider(height: 1, color: Color(0xFFD8C6E9)),
          SizedBox(height: compact ? 1 : 2),
          SizedBox(
            height: recoveryHeight,
            child: Row(
              children: [
                Expanded(
                  child: _MiniStat(
                    icon: Icons.local_fire_department_rounded,
                    value: '5d',
                    label: 'Streak',
                    compact: compact,
                  ),
                ),
                Expanded(
                  child: _MiniStat(
                    icon: Icons.emoji_events_rounded,
                    value: '14d',
                    label: 'Best',
                    compact: compact,
                  ),
                ),
                Expanded(
                  child: _MiniStat(
                    icon: Icons.trending_up_rounded,
                    value: '+6%',
                    label: 'This Month',
                    compact: compact,
                  ),
                ),
                const SizedBox(width: 3),
                SponsoredCampaignBanner(
                  campaign: DashboardCampaigns.recoveryHydration,
                  onTap: () => CampaignPreviewSheet.show(
                    context,
                    DashboardCampaigns.recoveryHydration,
                    accent: palette.accent,
                  ),
                  width: compact ? 88 : 112,
                  height: recoveryHeight,
                  imageWidth: compact ? 18 : 22,
                  compact: true,
                ),
              ],
            ),
          ),
          SizedBox(height: compact ? 1 : 2),
          _calendarTitle(
            context: context,
            compact: compact,
            height: calendarTitleHeight,
            palette: palette,
          ),
          SizedBox(
            height: summaryHeight,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '23 present  •  2 late  •  2 absent  •  4 holiday',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: MemberTheme.ink,
                  fontSize: compact ? 10.5 : 11.5,
                  height: 1,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Row(
            children: [
              WeekdayLabel('Mon', compact: compact),
              WeekdayLabel('Tue', compact: compact),
              WeekdayLabel('Wed', compact: compact),
              WeekdayLabel('Thu', compact: compact),
              WeekdayLabel('Fri', compact: compact),
              WeekdayLabel('Sat', compact: compact),
              WeekdayLabel('Sun', compact: compact),
            ],
          ),
          Row(
            children: [
              AttendanceDayCell(
                '13',
                height: cellHeight,
                compact: compact,
                key: const ValueKey('attendance-day-13'),
              ),
              AttendanceDayCell('14', height: cellHeight, compact: compact),
              AttendanceDayCell('15', height: cellHeight, compact: compact),
              AttendanceDayCell(
                '16',
                selected: true,
                selectedColor: palette.accent,
                height: cellHeight,
                compact: compact,
              ),
              AttendanceDayCell(
                '17',
                color: const Color(0xFFFFDDE2),
                height: cellHeight,
                compact: compact,
              ),
              AttendanceDayCell(
                '18',
                color: const Color(0xFFE5E2E9),
                off: true,
                height: cellHeight,
                compact: compact,
              ),
              AttendanceDayCell('19', height: cellHeight, compact: compact),
            ],
          ),
          Row(
            children: [
              AttendanceDayCell('20', height: cellHeight, compact: compact),
              AttendanceDayCell(
                '21',
                color: const Color(0xFFFFEDC7),
                height: cellHeight,
                compact: compact,
              ),
              AttendanceDayCell('22', height: cellHeight, compact: compact),
              AttendanceDayCell(
                '23',
                color: const Color(0xFFFFDDE2),
                height: cellHeight,
                compact: compact,
              ),
              AttendanceDayCell('24', height: cellHeight, compact: compact),
              AttendanceDayCell(
                '25',
                color: const Color(0xFFE5E2E9),
                off: true,
                height: cellHeight,
                compact: compact,
              ),
              AttendanceDayCell('', height: cellHeight, compact: compact),
            ],
          ),
          Text(
            'Sample data • API connection required for live records',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: MemberTheme.muted,
              fontSize: compact ? 8.5 : 9.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }


  Widget _alternatePanel({
    required BuildContext context,
    required DashboardModule module,
    required int sectionIndex,
    required bool compact,
    required MemberPlanPalette palette,
    required MemberSample member,
  }) {
    final items = DashboardNavigation.itemsFor(module);
    final safeIndex = sectionIndex.clamp(0, items.length - 1).toInt();
    final item = items[safeIndex];



    return Container(
      key: ValueKey('member-detail-${module.name}-$sectionIndex'),
      padding: EdgeInsets.fromLTRB(8, compact ? 4 : 6, 8, compact ? 4 : 6),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.panelEdge, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x100D0905),
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: compact ? 24 : 28,
            child: Row(
              children: [
                Container(
                  width: compact ? 22 : 24,
                  height: compact ? 22 : 24,
                  decoration: BoxDecoration(
                    color: palette.accentSoft,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: palette.panelEdge),
                  ),
                  child: Icon(
                    item.icon,
                    color: palette.accent,
                    size: compact ? 14 : 16,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: MemberTheme.ink,
                      fontSize: compact ? 14 : 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: palette.accentSoft,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: palette.panelEdge),
                  ),
                  child: Text(
                    'Demo',
                    style: TextStyle(
                      color: palette.accent,
                      fontSize: compact ? 10.5 : 11.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: compact ? 4 : 7),
          Expanded(
            child: AnimatedSwitcher(
              duration: MediaQuery.maybeOf(context)?.disableAnimations == true
                  ? Duration.zero
                  : const Duration(milliseconds: 220),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.015, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: KeyedSubtree(
                key: ValueKey('${module.name}-$sectionIndex'),
                child: _sectionContent(
                  module: module,
                  sectionIndex: sectionIndex,
                  compact: compact,
                  palette: palette,
                  member: member,
                ),
              ),
            ),
          ),
          SizedBox(height: compact ? 2 : 4),
          Text(
            'Sample member data · Live sync not connected',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: MemberTheme.muted,
              fontSize: compact ? 10.5 : 11.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionContent({
    required DashboardModule module,
    required int sectionIndex,
    required bool compact,
    required MemberPlanPalette palette,
    required MemberSample member,
  }) => ModuleDashboardView(
    module: module,
    sectionIndex: sectionIndex,
    compact: compact,
    palette: palette,
    member: member,
  );
  Widget _header({
    required BuildContext context,
    required bool compact,
    required double height,
    required MemberPlanPalette palette,
  }) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Container(
            width: compact ? 20 : 24,
            height: compact ? 20 : 24,
            decoration: BoxDecoration(
              color: palette.accentSoft,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: palette.panelEdge),
            ),
            child: Icon(Icons.event_available_rounded, color: palette.accent, size: compact ? 14 : 17),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              'Attendance Analytics',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: MemberTheme.ink,
                fontSize: compact ? 12 : 14,
                height: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 3),
          SponsoredCampaignBanner(
            campaign: DashboardCampaigns.blinkitAttendance,
            onTap: () => CampaignPreviewSheet.show(context, DashboardCampaigns.blinkitAttendance, accent: palette.accent),
            width: compact ? 105 : 128,
            height: height - 2,
            imageWidth: compact ? 19 : 25,
            compact: true,
          ),
        ],
      ),
    );
  }

  Widget _calendarTitle({
    required BuildContext context,
    required bool compact,
    required double height,
    required MemberPlanPalette palette,
  }) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Image.asset(
            'assets/material_pack/inbox/PulseVault/25_calendar_graphic.webp',
            width: compact ? 20 : 23,
            height: compact ? 20 : 23,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              'October attendance',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: MemberTheme.ink,
                fontSize: compact ? 12.5 : 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 3),
          SponsoredCampaignBanner(
            campaign: DashboardCampaigns.trainMore,
            onTap: () => CampaignPreviewSheet.show(context, DashboardCampaigns.trainMore, accent: palette.accent),
            width: compact ? 100 : 120,
            height: height - 2,
            imageWidth: compact ? 18 : 22,
            compact: true,
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.compact,
  });

  final IconData icon;
  final String value;
  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final palette = MemberPlanTheme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: palette.accent,
          size: compact ? 10 : 12,
        ),
        const SizedBox(width: 2),
        Text(
          value,
          maxLines: 1,
          style: TextStyle(
            color: palette.accent,
            fontSize: compact ? 10 : 11,
            height: 1,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(width: 3),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: MemberTheme.muted,
              fontSize: compact ? 7.5 : 8.5,
              height: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _AttendanceRingPainter extends CustomPainter {
  const _AttendanceRingPainter();

  static const _segments = <(double, Color)>[
    (23, Color(0xFF13CA69)),
    (2, Color(0xFFE52B52)),
    (4, Color(0xFF8A35D5)),
    (2, Color(0xFFFFB21C)),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.width < 64 ? 8.0 : 9.5;
    final rect = Offset(stroke / 2, stroke / 2) &
        Size(size.width - stroke, size.height - stroke);
    final track = Paint()
      ..color = const Color(0xFFE3D7EC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    canvas.drawArc(rect, 0, math.pi * 2, false, track);

    var start = -math.pi / 2;
    const gap = 0.035;
    for (final segment in _segments) {
      final sweep = math.pi * 2 * segment.$1 / 31;
      final paint = Paint()
        ..color = segment.$2
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        rect,
        start + gap / 2,
        math.max(0.0, sweep - gap),
        false,
        paint,
      );
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _AttendanceRingPainter oldDelegate) => false;
}
