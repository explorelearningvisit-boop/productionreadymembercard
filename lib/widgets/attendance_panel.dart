import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/sample_member.dart';
import '../data/dashboard_navigation.dart';
import '../theme/member_theme.dart';
import 'ad_motion.dart';
import 'dashboard_primitives.dart';

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
        const compactHeight = 310.0;
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
              child: _panel(compact: true, palette: palette, module: module, sectionIndex: sectionIndex, member: member),
            ),
          );
        }
        final compact = availableHeight < fullHeight;
        return SizedBox(
          key: const ValueKey('attendance-panel'),
          width: constraints.maxWidth,
          height: availableHeight,
          child: _panel(compact: compact, palette: palette, module: module, sectionIndex: sectionIndex, member: member),
        );
      },
    );
  }

  Widget _panel({
    bool compact = false,
    required MemberPlanPalette palette,
    required DashboardModule module,
    required int sectionIndex,
    required MemberSample member,
  }) {
    if (module != DashboardModule.attendance || sectionIndex != 0) {
      return _alternatePanel(
        module: module,
        sectionIndex: sectionIndex,
        compact: compact,
        palette: palette,
        member: member,
      );
    }
    final headerHeight = compact ? 22.0 : 26.0;
    final offerHeight = compact ? 24.0 : 30.0;
    final chartHeight = compact ? 70.0 : 82.0;
    final ringSize = compact ? 62.0 : 74.0;
    final recoveryHeight = compact ? 23.0 : 30.0;
    final calendarTitleHeight = compact ? 23.0 : 27.0;
    final cellHeight = compact ? 28.0 : 34.0;
    final summaryHeight = compact ? 15.0 : 18.0;

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
          _header(compact: compact, height: headerHeight, palette: palette),
          SizedBox(height: compact ? 2 : 3),
          _offerBanner(compact: compact, height: offerHeight),
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
                                    fontSize: compact ? 9 : 10,
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
          Row(
            children: [
              Expanded(child: _MiniStat(icon: '🔥', value: '5d', label: 'Streak', compact: compact)),
              Expanded(child: _MiniStat(icon: '🏆', value: '14d', label: 'Best', compact: compact)),
              Expanded(child: _MiniStat(icon: '↗', value: '+6%', label: 'This Month', compact: compact)),
            ],
          ),
          SizedBox(height: compact ? 1 : 2),
          _recoveryBanner(compact: compact, height: recoveryHeight),
          SizedBox(height: compact ? 1 : 2),
          _calendarTitle(compact: compact, height: calendarTitleHeight, palette: palette),
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
                  fontSize: compact ? 9 : 10,
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
              fontSize: compact ? 6.5 : 7.2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }


  Widget _alternatePanel({
    required DashboardModule module,
    required int sectionIndex,
    required bool compact,
    required MemberPlanPalette palette,
    required MemberSample member,
  }) {
    final items = DashboardNavigation.itemsFor(module);
    final safeIndex = sectionIndex.clamp(0, items.length - 1).toInt();
    final item = items[safeIndex];

    late final String offerAsset;
    late final String offerTitle;
    late final String offerSubtitle;
    late final Color offerSurface;
    switch (module) {
      case DashboardModule.attendance:
        offerAsset = 'assets/material_pack/inbox/PulseVault/05_blinkit_grocery_bag.webp';
        offerTitle = 'Healthy snacks & gym essentials';
        offerSubtitle = 'Sample member offer · Up to 30% off';
        offerSurface = const Color(0xFFFFF8E8);
      case DashboardModule.workout:
        offerAsset = 'assets/material_pack/inbox/PulseVault/06_creatine_tub.webp';
        offerTitle = 'Creatine & training essentials';
        offerSubtitle = 'Sample workout offer · 15% off';
        offerSurface = const Color(0xFFF5F0FA);
      case DashboardModule.payment:
        offerAsset = 'assets/material_pack/inbox/PulseVault/29_sbi_payment_card_graphic.webp';
        offerTitle = 'Member payment rewards';
        offerSubtitle = 'Sample reward preview · 5% off';
        offerSurface = const Color(0xFFEFF6FC);
      case DashboardModule.body:
        offerAsset = 'assets/material_pack/inbox/PulseVault/fat_loss_support_tub.png';
        offerTitle = 'Body & nutrition support';
        offerSubtitle = 'Sample wellness offer · 20% off';
        offerSurface = const Color(0xFFEDF7EF);
    }

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
                      fontSize: compact ? 13 : 15,
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
                      fontSize: compact ? 7 : 8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: compact ? 3 : 5),
          _smallBanner(
            compact: compact,
            height: compact ? 30 : 36,
            asset: offerAsset,
            assetWidth: compact ? 38 : 48,
            motion: 1,
            title: offerTitle,
            subtitle: offerSubtitle,
            colors: [offerSurface, Colors.white],
          ),
          SizedBox(height: compact ? 4 : 7),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
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
              fontSize: compact ? 7 : 8,
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
  }) {
    switch (module) {
      case DashboardModule.attendance:
        switch (sectionIndex) {
          case 1:
            return _calendarContent(compact: compact, palette: palette);
          case 2:
            return _historyContent(compact: compact, palette: palette, member: member);
          case 3:
            return _insightsContent(compact: compact, palette: palette, member: member);
          case 4:
            return _goalsContent(compact: compact, palette: palette);
          default:
            return const SizedBox.shrink();
        }
      case DashboardModule.workout:
        switch (sectionIndex) {
          case 0:
            return _workoutOverviewContent(compact: compact, palette: palette, member: member);
          case 1:
            return _workoutLogContent(compact: compact, palette: palette, member: member);
          case 2:
            return _trendContent(compact: compact, palette: palette, member: member);
          case 3:
            return _recoveryContent(compact: compact, palette: palette);
          case 4:
            return _workoutGoalsContent(compact: compact, palette: palette);
        }
      case DashboardModule.payment:
        switch (sectionIndex) {
          case 0:
            return _paymentOverviewContent(compact: compact, palette: palette, member: member);
          case 1:
            return _invoicesContent(compact: compact, palette: palette, member: member);
          case 2:
            return _paymentHistoryContent(compact: compact, palette: palette, member: member);
          case 3:
            return _paymentMethodsContent(compact: compact, palette: palette);
          case 4:
            return _paymentRewardsContent(compact: compact, palette: palette);
        }
      case DashboardModule.body:
        switch (sectionIndex) {
          case 0:
            return _bodyOverviewContent(compact: compact, palette: palette, member: member);
          case 1:
            return _weightTrendContent(compact: compact, palette: palette, member: member);
          case 2:
            return _measurementsContent(compact: compact, palette: palette, member: member);
          case 3:
            return _nutritionContent(compact: compact, palette: palette);
          case 4:
            return _bodyGoalsContent(compact: compact, palette: palette);
        }
    }
    return const SizedBox.shrink();
  }

  Widget _workoutOverviewContent({
    required bool compact,
    required MemberPlanPalette palette,
    required MemberSample member,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _dataCard(
                title: 'Workout average',
                value: member.workout,
                caption: 'Member sample',
                icon: Icons.timer_outlined,
                color: palette.accent,
                compact: compact,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: _dataCard(
                title: 'Monthly attendance',
                value: member.attendance,
                caption: 'Member sample',
                icon: Icons.event_available_rounded,
                color: const Color(0xFF13845A),
                compact: compact,
              ),
            ),
          ],
        ),
        SizedBox(height: compact ? 7 : 10),
        Text(
          'Workout minutes · Sample week',
          style: TextStyle(
            color: MemberTheme.ink,
            fontSize: compact ? 10 : 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: compact ? 4 : 7),
        Expanded(
          child: _weeklyBars(
            values: const [26, 42, 35, 61, 48, 78, 58],
            labels: const ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
            palette: palette,
            compact: compact,
          ),
        ),
        SizedBox(height: compact ? 4 : 6),
        _highlightStrip(
          icon: Icons.fitness_center_rounded,
          title: 'Workout summary',
          subtitle: 'Sample records · Live workout sync not connected',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _workoutLogContent({
    required bool compact,
    required MemberPlanPalette palette,
    required MemberSample member,
  }) {
    return Column(
      children: [
        _historyRow(
          icon: Icons.fitness_center_rounded,
          title: 'Latest workout summary',
          subtitle: 'Member sample · Workout log not connected',
          value: member.workout,
          tint: palette.accent,
          compact: compact,
        ),
        _historyRow(
          icon: Icons.list_alt_rounded,
          title: 'Exercise sets and reps',
          subtitle: 'No exercise records loaded',
          value: '—',
          tint: const Color(0xFF607D8B),
          compact: compact,
        ),
        _historyRow(
          icon: Icons.timer_outlined,
          title: 'Session duration',
          subtitle: 'Connect workout tracking to see history',
          value: member.workout,
          tint: const Color(0xFF9B6D27),
          compact: compact,
        ),
        const Spacer(),
        _highlightStrip(
          icon: Icons.info_outline_rounded,
          title: 'Workout log source not connected',
          subtitle: 'This preview uses the member sample record only',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _recoveryContent({
    required bool compact,
    required MemberPlanPalette palette,
  }) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: _dataCard(
                  title: 'Recovery products',
                  value: 'Sample',
                  caption: 'Offer preview',
                  icon: Icons.local_drink_outlined,
                  color: const Color(0xFF8B5AA5),
                  compact: compact,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _dataCard(
                  title: 'Rest planning',
                  value: 'Connect',
                  caption: 'Recovery log',
                  icon: Icons.spa_outlined,
                  color: const Color(0xFF4D8775),
                  compact: compact,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: compact ? 6 : 9),
        _smallBanner(
          compact: compact,
          height: compact ? 38 : 48,
          asset: 'assets/material_pack/inbox/PulseVault/03_whey_protein_tub.webp',
          assetWidth: compact ? 40 : 52,
          motion: 2,
          title: 'Recovery combo',
          subtitle: 'Sample supplement offer · Demo',
          colors: [palette.accentSoft, Colors.white],
        ),
        SizedBox(height: compact ? 6 : 9),
        _highlightStrip(
          icon: Icons.health_and_safety_outlined,
          title: 'Recovery information',
          subtitle: 'Sleep, hydration and rest data are not connected',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _workoutGoalsContent({
    required bool compact,
    required MemberPlanPalette palette,
  }) {
    return Column(
      children: [
        _goalProgress(
          title: 'Workout consistency',
          subtitle: 'Weekly training target · Sample',
          value: 0.72,
          color: palette.accent,
          compact: compact,
        ),
        _goalProgress(
          title: 'Session completion',
          subtitle: 'Workout plan target · Sample',
          value: 0.68,
          color: const Color(0xFF14845C),
          compact: compact,
        ),
        const Spacer(),
        _highlightStrip(
          icon: Icons.emoji_events_outlined,
          title: 'Workout goals',
          subtitle: 'Connect a workout plan to set personal targets',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _paymentOverviewContent({
    required bool compact,
    required MemberPlanPalette palette,
    required MemberSample member,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _dataCard(
                title: 'Payment due',
                value: member.paymentDue,
                caption: 'Current member record',
                icon: Icons.account_balance_wallet_rounded,
                color: MemberTheme.rose,
                compact: compact,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: _dataCard(
                title: 'Days remaining',
                value: '${member.daysRemaining}',
                caption: 'Membership period',
                icon: Icons.calendar_today_rounded,
                color: palette.accent,
                compact: compact,
              ),
            ),
          ],
        ),
        SizedBox(height: compact ? 8 : 11),
        _goalProgress(
          title: 'Membership period used',
          subtitle: '${member.membershipDays} of ${member.membershipTotalDays} days',
          value: member.membershipProgress.clamp(0.0, 1.0).toDouble(),
          color: palette.accent,
          compact: compact,
        ),
        const Spacer(),
        _highlightStrip(
          icon: Icons.info_outline_rounded,
          title: 'Payment data preview',
          subtitle: 'Transactions and receipts require a connected payment service',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _invoicesContent({
    required bool compact,
    required MemberPlanPalette palette,
    required MemberSample member,
  }) {
    return Column(
      children: [
        _historyRow(
          icon: Icons.receipt_long_rounded,
          title: 'Membership balance',
          subtitle: 'Due in ${member.daysRemaining} days',
          value: '${member.paymentDue} due',
          tint: MemberTheme.rose,
          compact: compact,
        ),
        _historyRow(
          icon: Icons.calendar_month_rounded,
          title: 'Membership period',
          subtitle: '${member.membershipDays} / ${member.membershipTotalDays} days used',
          value: '${(member.membershipProgress * 100).round()}%',
          tint: palette.accent,
          compact: compact,
        ),
        const Spacer(),
        _highlightStrip(
          icon: Icons.description_outlined,
          title: 'Invoice documents not connected',
          subtitle: 'Invoice numbers and downloadable receipts will appear here',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _paymentHistoryContent({
    required bool compact,
    required MemberPlanPalette palette,
    required MemberSample member,
  }) {
    return Column(
      children: [
        _historyRow(
          icon: Icons.pending_actions_rounded,
          title: 'Outstanding membership amount',
          subtitle: 'Current sample member balance',
          value: member.paymentDue,
          tint: MemberTheme.rose,
          compact: compact,
        ),
        const Spacer(),
        _emptyDetail(
          icon: Icons.receipt_long_outlined,
          title: 'No completed payments loaded',
          subtitle: 'Connect payment history to show transaction dates, amounts and receipts',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _paymentMethodsContent({
    required bool compact,
    required MemberPlanPalette palette,
  }) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Image.asset(
              'assets/material_pack/inbox/PulseVault/29_sbi_payment_card_graphic.webp',
              fit: BoxFit.contain,
              width: compact ? 150 : 210,
            ),
          ),
        ),
        _highlightStrip(
          icon: Icons.credit_card_rounded,
          title: 'Payment method preview',
          subtitle: 'No saved payment method is available in this sample',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _paymentRewardsContent({
    required bool compact,
    required MemberPlanPalette palette,
  }) {
    return Column(
      children: [
        _smallBanner(
          compact: compact,
          height: compact ? 40 : 50,
          asset: 'assets/material_pack/inbox/PulseVault/29_sbi_payment_card_graphic.webp',
          assetWidth: compact ? 48 : 64,
          motion: 1,
          title: 'Member reward preview',
          subtitle: 'Sample campaign · Not a live bank offer',
          colors: [const Color(0xFFEAF2FA), Colors.white],
        ),
        const Spacer(),
        _emptyDetail(
          icon: Icons.card_giftcard_rounded,
          title: 'No active reward campaign',
          subtitle: 'Eligible offers will appear when a real campaign is configured',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _bodyOverviewContent({
    required bool compact,
    required MemberPlanPalette palette,
    required MemberSample member,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _dataCard(
                title: 'Current weight',
                value: member.bodyWeight,
                caption: 'Member sample',
                icon: Icons.monitor_weight_outlined,
                color: const Color(0xFF168A79),
                compact: compact,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: _dataCard(
                title: 'Target weight',
                value: 'Not set',
                caption: 'Add a personal target',
                icon: Icons.flag_outlined,
                color: palette.accent,
                compact: compact,
              ),
            ),
          ],
        ),
        const Spacer(),
        _emptyDetail(
          icon: Icons.monitor_weight_outlined,
          title: 'Body tracking overview',
          subtitle: 'Add measurements to build a personal progress view',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _weightTrendContent({
    required bool compact,
    required MemberPlanPalette palette,
    required MemberSample member,
  }) {
    return Column(
      children: [
        _dataCard(
          title: 'Latest recorded weight',
          value: member.bodyWeight,
          caption: 'Member sample',
          icon: Icons.scale_rounded,
          color: const Color(0xFF168A79),
          compact: compact,
        ),
        const Spacer(),
        _emptyDetail(
          icon: Icons.show_chart_rounded,
          title: 'Weight trend is not available',
          subtitle: 'Add dated body measurements to display a real trend',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _measurementsContent({
    required bool compact,
    required MemberPlanPalette palette,
    required MemberSample member,
  }) {
    return Column(
      children: [
        _historyRow(
          icon: Icons.monitor_weight_outlined,
          title: 'Body weight',
          subtitle: 'Latest member sample',
          value: member.bodyWeight,
          tint: const Color(0xFF168A79),
          compact: compact,
        ),
        const Spacer(),
        _emptyDetail(
          icon: Icons.straighten_rounded,
          title: 'Other measurements not loaded',
          subtitle: 'Measurements such as waist and body fat need member records',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _nutritionContent({
    required bool compact,
    required MemberPlanPalette palette,
  }) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Image.asset(
                  'assets/material_pack/inbox/PulseVault/03_whey_protein_tub.webp',
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/material_pack/inbox/PulseVault/fat_loss_support_tub.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        _highlightStrip(
          icon: Icons.restaurant_outlined,
          title: 'Nutrition offer preview',
          subtitle: 'Personal nutrition logs are not connected',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _bodyGoalsContent({
    required bool compact,
    required MemberPlanPalette palette,
  }) {
    return Column(
      children: [
        const Spacer(),
        _emptyDetail(
          icon: Icons.flag_outlined,
          title: 'Set a body goal',
          subtitle: 'A target weight or measurement is needed before progress can be calculated',
          palette: palette,
          compact: compact,
        ),
        const Spacer(),
      ],
    );
  }

  Widget _emptyDetail({
    required IconData icon,
    required String title,
    required String subtitle,
    required MemberPlanPalette palette,
    required bool compact,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 9 : 13),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: palette.panelEdge),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: palette.accent, size: compact ? 22 : 27),
          SizedBox(height: compact ? 4 : 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MemberTheme.ink,
              fontSize: compact ? 10 : 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: compact ? 2 : 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MemberTheme.muted,
              fontSize: compact ? 8 : 9,
              height: 1.2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _insightsContent({
    required bool compact,
    required MemberPlanPalette palette,
    required MemberSample member,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _dataCard(
                title: 'Attendance',
                value: member.attendance,
                caption: 'This month',
                icon: Icons.event_available_rounded,
                color: const Color(0xFF0C9D5A),
                compact: compact,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: _dataCard(
                title: 'Workout',
                value: member.workout,
                caption: 'Daily average',
                icon: Icons.fitness_center_rounded,
                color: palette.accent,
                compact: compact,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: _dataCard(
                title: 'Body weight',
                value: member.bodyWeight,
                caption: 'Latest update',
                icon: Icons.monitor_weight_outlined,
                color: const Color(0xFF0A8A9E),
                compact: compact,
              ),
            ),
          ],
        ),
        SizedBox(height: compact ? 6 : 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'WEEKLY ACTIVITY',
            style: TextStyle(
              color: palette.accent,
              fontSize: compact ? 9 : 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.35,
            ),
          ),
        ),
        SizedBox(height: compact ? 4 : 7),
        Expanded(
          child: _weeklyBars(
            values: const [32, 48, 40, 68, 54, 88, 72],
            labels: const ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
            palette: palette,
            compact: compact,
          ),
        ),
        SizedBox(height: compact ? 4 : 6),
        _highlightStrip(
          icon: Icons.local_fire_department_rounded,
          title: '5-day streak',
          subtitle: 'You are building a consistent routine',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _calendarContent({
    required bool compact,
    required MemberPlanPalette palette,
  }) {
    const weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    const days = <int>[
      0, 0, 0, 1, 2, 3, 4,
      5, 6, 7, 8, 9, 10, 11,
      12, 13, 14, 15, 16, 17, 18,
      19, 20, 21, 22, 23, 24, 25,
      26, 27, 28, 29, 30, 31, 0,
    ];
    const present = Color(0xFFD9F8E4);
    const absent = Color(0xFFFFE3E7);
    const late = Color(0xFFFFEAC6);
    const off = Color(0xFFE7E3EA);
    const colors = <int, Color>{
      1: present, 2: present, 3: absent, 4: present,
      5: present, 6: off, 7: present, 8: present,
      9: late, 10: present, 11: present, 12: present,
      13: present, 14: present, 15: present, 16: present,
      17: absent, 18: off, 19: present, 20: present,
      21: late, 22: present, 23: absent, 24: present,
      25: off, 26: present, 27: present, 28: present,
      29: present, 30: present, 31: present,
    };
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'October 2026',
                style: TextStyle(
                  color: MemberTheme.ink,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            _calendarLegend(const Color(0xFF19B66A), 'Present', compact),
            _calendarLegend(const Color(0xFFE55268), 'Absent', compact),
            _calendarLegend(const Color(0xFFFFB52B), 'Late', compact),
          ],
        ),
        SizedBox(height: compact ? 5 : 8),
        Row(
          children: [
            for (final day in weekdays)
              Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      color: palette.accent,
                      fontSize: compact ? 8.5 : 10,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: compact ? 3 : 5),
        Expanded(
          child: Column(
            children: [
              for (var row = 0; row < 5; row++)
                Expanded(
                  child: Row(
                    children: [
                      for (var col = 0; col < 7; col++)
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(1.5),
                            decoration: BoxDecoration(
                              color: days[row * 7 + col] == 0
                                  ? Colors.transparent
                                  : colors[days[row * 7 + col]] ?? present,
                              borderRadius: BorderRadius.circular(8),
                              border: days[row * 7 + col] == 16
                                  ? Border.all(color: palette.accent, width: 1.8)
                                  : Border.all(color: Colors.white.withOpacity(0.85)),
                            ),
                            child: Center(
                              child: Text(
                                days[row * 7 + col] == 0
                                    ? ''
                                    : '${days[row * 7 + col]}',
                                style: TextStyle(
                                  color: MemberTheme.ink,
                                  fontSize: compact ? 10 : 12,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _historyContent({
    required bool compact,
    required MemberPlanPalette palette,
    required MemberSample member,
  }) {
    return Column(
      children: [
        _historyRow(
          icon: Icons.login_rounded,
          title: 'Gym check-in',
          subtitle: 'Today • 07:12 AM',
          value: 'Present',
          tint: const Color(0xFF0AA969),
          compact: compact,
        ),
        _historyRow(
          icon: Icons.payments_rounded,
          title: 'Membership payment',
          subtitle: 'Due in ${member.daysRemaining} days',
          value: member.paymentDue,
          tint: const Color(0xFFD92348),
          compact: compact,
        ),
        _historyRow(
          icon: Icons.fitness_center_rounded,
          title: 'Workout completed',
          subtitle: 'Yesterday • 58 minutes',
          value: 'Done',
          tint: palette.accent,
          compact: compact,
        ),
        _historyRow(
          icon: Icons.monitor_weight_outlined,
          title: 'Body measurement',
          subtitle: 'Last updated • 2 days ago',
          value: member.bodyWeight,
          tint: const Color(0xFF118D9A),
          compact: compact,
        ),
        const Spacer(),
        _highlightStrip(
          icon: Icons.verified_rounded,
          title: 'Account is up to date',
          subtitle: 'Your recent activity is listed above',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _trendContent({
    required bool compact,
    required MemberPlanPalette palette,
    required MemberSample member,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _dataCard(
                title: 'Workout avg.',
                value: member.workout,
                caption: 'Per session',
                icon: Icons.timer_outlined,
                color: palette.accent,
                compact: compact,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: _dataCard(
                title: 'Attendance',
                value: member.attendance,
                caption: 'Monthly',
                icon: Icons.event_available_rounded,
                color: const Color(0xFF0C9D5A),
                compact: compact,
              ),
            ),
          ],
        ),
        SizedBox(height: compact ? 7 : 10),
        Text(
          'WORKOUT MINUTES • LAST 7 DAYS',
          style: TextStyle(
            color: palette.accent,
            fontSize: compact ? 9 : 10,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: compact ? 4 : 7),
        Expanded(
          child: _weeklyBars(
            values: const [26, 42, 35, 61, 48, 78, 58],
            labels: const ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
            palette: palette,
            compact: compact,
          ),
        ),
        _highlightStrip(
          icon: Icons.trending_up_rounded,
          title: '+12% workout consistency',
          subtitle: 'Compared with the previous week',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _goalsContent({
    required bool compact,
    required MemberPlanPalette palette,
  }) {
    return Column(
      children: [
        _goalProgress(
          title: 'Monthly attendance',
          subtitle: 'Target: 24 visits',
          value: 0.81,
          color: const Color(0xFF0AA969),
          compact: compact,
        ),
        _goalProgress(
          title: 'Workout consistency',
          subtitle: 'Target: 5 sessions / week',
          value: 0.72,
          color: palette.accent,
          compact: compact,
        ),
        _goalProgress(
          title: 'Body progress',
          subtitle: 'Target: 2 kg milestone',
          value: 0.64,
          color: const Color(0xFF0D8B98),
          compact: compact,
        ),
        const Spacer(),
        _highlightStrip(
          icon: Icons.emoji_events_rounded,
          title: 'Next milestone is close',
          subtitle: 'Two more visits to reach your monthly target',
          palette: palette,
          compact: compact,
        ),
      ],
    );
  }

  Widget _dataCard({
    required String title,
    required String value,
    required String caption,
    required IconData icon,
    required Color color,
    required bool compact,
  }) {
    return Container(
      padding: EdgeInsets.all(compact ? 5 : 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.09),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: compact ? 14 : 17),
          SizedBox(height: compact ? 2 : 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                color: MemberTheme.ink,
                fontSize: compact ? 13 : 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontSize: compact ? 7.5 : 8.5,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: MemberTheme.muted,
              fontSize: compact ? 6.5 : 7.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _weeklyBars({
    required List<double> values,
    required List<String> labels,
    required MemberPlanPalette palette,
    required bool compact,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < values.length; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    values[i].round().toString(),
                    style: TextStyle(
                      color: MemberTheme.muted,
                      fontSize: compact ? 6.5 : 8,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: (values[i] / 100).clamp(0.1, 1.0).toDouble(),
                        widthFactor: 0.74,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: palette.accent,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: palette.accent.withOpacity(0.16),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: compact ? 3 : 5),
                  Text(
                    labels[i],
                    style: TextStyle(
                      color: MemberTheme.ink,
                      fontSize: compact ? 7.5 : 9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _historyRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required Color tint,
    required bool compact,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: compact ? 4 : 6),
      child: Row(
        children: [
          Container(
            width: compact ? 29 : 34,
            height: compact ? 29 : 34,
            decoration: BoxDecoration(
              color: tint.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: tint, size: compact ? 16 : 19),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MemberTheme.ink,
                    fontSize: compact ? 9.5 : 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MemberTheme.muted,
                    fontSize: compact ? 8 : 9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              color: tint,
              fontSize: compact ? 8.5 : 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _goalProgress({
    required String title,
    required String subtitle,
    required double value,
    required Color color,
    required bool compact,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: compact ? 4 : 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: MemberTheme.ink,
                    fontSize: compact ? 9.5 : 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                '${(value * 100).round()}%',
                style: TextStyle(
                  color: color,
                  fontSize: compact ? 10 : 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: MemberTheme.muted,
              fontSize: compact ? 7 : 8,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: compact ? 3 : 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: value,
              minHeight: compact ? 6 : 8,
              backgroundColor: color.withOpacity(0.12),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _highlightStrip({
    required IconData icon,
    required String title,
    required String subtitle,
    required MemberPlanPalette palette,
    required bool compact,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 7 : 9,
        vertical: compact ? 5 : 7,
      ),
      decoration: BoxDecoration(
        color: palette.accentSoft,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: palette.panelEdge),
      ),
      child: Row(
        children: [
          Icon(icon, color: palette.accent, size: compact ? 15 : 18),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MemberTheme.ink,
                    fontSize: compact ? 8.5 : 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MemberTheme.muted,
                    fontSize: compact ? 6.8 : 7.8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _calendarLegend(Color color, String label, bool compact) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 2),
          Text(
            label,
            style: TextStyle(
              color: MemberTheme.muted,
              fontSize: compact ? 6.5 : 7.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _header({required bool compact, required double height, required MemberPlanPalette palette}) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Container(
            width: compact ? 20 : 23,
            height: compact ? 20 : 23,
            decoration: BoxDecoration(
              color: palette.accent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.trending_up_rounded,
              color: Colors.white,
              size: compact ? 14 : 16,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              'Attendance Analytics',
              maxLines: 1,
              style: TextStyle(
                color: MemberTheme.ink,
                fontSize: compact ? 14.2 : 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Icon(
            Icons.notifications_active,
            color: palette.accent,
            size: compact ? 16 : 18,
          ),
          const SizedBox(width: 4),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 6 : 8,
              vertical: compact ? 2 : 3,
            ),
            decoration: BoxDecoration(
              color: palette.accentSoft,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: palette.panelEdge),
            ),
            child: Text(
              'Demo',
              style: TextStyle(
                color: palette.accent,
                fontSize: compact ? 8 : 9,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _offerBanner({required bool compact, required double height}) {
    return _smallBanner(
      compact: compact,
      height: height,
      asset: 'assets/material_pack/inbox/PulseVault/05_blinkit_grocery_bag.webp',
      assetWidth: compact ? 31 : 40,
      motion: 3,
      title: 'Healthy Snacks & Gym Essentials',
      subtitle: 'Member partner offer • Up to 30% OFF',
      colors: const [Color(0xFFFFF8E8), Color(0xFFFFFEFC)],
    );
  }

  Widget _recoveryBanner({required bool compact, required double height}) {
    return _smallBanner(
      compact: compact,
      height: height,
      asset: 'assets/material_pack/inbox/PulseVault/03_whey_protein_tub.webp',
      assetWidth: compact ? 25 : 31,
      motion: 2,
      title: 'Recovery Combo',
      subtitle: 'Up to 30% OFF',
      colors: const [Color(0xFFF5F0E8), Color(0xFFFFFEFC)],
    );
  }

  Widget _smallBanner({
    required bool compact,
    required double height,
    required String asset,
    required double assetWidth,
    required int motion,
    required String title,
    required String subtitle,
    required List<Color> colors,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: colors.first,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFE4D9C9), width: 1),
      ),
      child: Row(
        children: [
          ArtworkEntrance(
            motion: motion,
            child: Image.asset(
              asset,
              width: assetWidth,
              height: height - 4,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MemberTheme.ink,
                    fontSize: compact ? 9 : 10,
                    height: 1.05,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MemberTheme.muted,
                    fontSize: compact ? 7.5 : 8.5,
                    height: 1.05,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 3),
          Icon(
            Icons.chevron_right_rounded,
            color: MemberTheme.muted,
            size: compact ? 16 : 18,
          ),
        ],
      ),
    );
  }

  Widget _calendarTitle({required bool compact, required double height, required MemberPlanPalette palette}) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          ArtworkEntrance(
            motion: 1,
            child: Image.asset(
              'assets/material_pack/inbox/PulseVault/25_calendar_graphic.webp',
              width: compact ? 20 : 23,
              height: compact ? 20 : 23,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              'October attendance',
              maxLines: 1,
              style: TextStyle(
                color: MemberTheme.ink,
                fontSize: compact ? 14.3 : 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 5 : 7,
              vertical: compact ? 2 : 3,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [palette.accent, palette.railGradient.last],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ArtworkEntrance(
                  motion: 2,
                  child: Image.asset(
                    'assets/material_pack/inbox/PulseVault/27_dumbbell_promo_graphic.webp',
                    width: compact ? 18 : 22,
                    height: compact ? 18 : 22,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  'Train More • 15% OFF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: compact ? 7 : 8,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
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

  final String icon;
  final String value;
  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: TextStyle(fontSize: compact ? 10 : 12)),
            const SizedBox(width: 3),
            Text(
              value,
              style: TextStyle(
                color: MemberTheme.purple,
                fontSize: compact ? 10 : 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: TextStyle(
            color: MemberTheme.muted,
            fontSize: compact ? 5.5 : 6.5,
            fontWeight: FontWeight.w800,
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
