import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/sample_member.dart';
import '../theme/member_theme.dart';
import '../widgets/ad_motion.dart';
import '../widgets/attendance_panel.dart';
import '../widgets/dashboard_primitives.dart';

class MemberDashboardScreen extends StatefulWidget {
  const MemberDashboardScreen({
    this.member = MemberSample.demo,
    super.key,
  });

  final MemberSample member;

  @override
  State<MemberDashboardScreen> createState() => _MemberDashboardScreenState();
}

class _MemberDashboardScreenState extends State<MemberDashboardScreen> {
  bool _checkedIn = true;
  int _selectedNavigation = 0;

  static const _navigation = <(IconData, String)>[
    (Icons.calendar_month_rounded, 'Attendance'),
    (Icons.insights_rounded, 'Insights'),
    (Icons.date_range_rounded, 'Calendar'),
    (Icons.history_rounded, 'History'),
    (Icons.show_chart_rounded, 'Trend'),
    (Icons.emoji_events_rounded, 'Goals'),
  ];

  @override
  Widget build(BuildContext context) {
    final member = widget.member;
    final palette = MemberPlanPalette.forPlan(member.plan);

    return MemberPlanTheme(
      palette: palette,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: palette.frameGradient.first,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: palette.canvasGradient.last,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: palette.panelEdge,
        ),
        child: Scaffold(
        // Keep the narrow area outside the rounded frame in the same deep
        // plan color. All gradients and highlights are clipped inside the rim.
        backgroundColor: palette.frameGradient.first,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, bounds) {
              final compact = bounds.maxHeight < 760;
              final compactProgress =
                  ((bounds.maxHeight - 600.0) / 100.0).clamp(0.0, 1.0);
              final railWidth = bounds.maxWidth < 340
                  ? 48.0
                  : bounds.maxWidth < 380
                      ? 50.0
                      : 52.0;

              return Container(
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: palette.frameGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: palette.frameRim, width: 2),
                  // No outward glow: the shell and its plan-colored canvas
                  // remain within the visible frame.
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(19),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: palette.canvasGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      Positioned(
                        top: -78,
                        left: -62,
                        child: IgnorePointer(
                          child: SizedBox(
                            width: 228,
                            height: 228,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.45),
                                    Colors.white.withOpacity(0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: -78,
                        bottom: -92,
                        child: IgnorePointer(
                          child: SizedBox(
                            width: 230,
                            height: 230,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    palette.accent.withOpacity(0.10),
                                    palette.accent.withOpacity(0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          _dashboardTop(
                            compact: compact,
                            compactProgress: compactProgress,
                          ),
                          const SizedBox(height: 4),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(3, 0, 3, 2),
                              child: LayoutBuilder(
                                builder: (context, contentBounds) {
                                  final contentHeight = contentBounds.maxHeight;
                                  return SizedBox(
                                    height: contentHeight,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          key: const ValueKey('navigation-rail'),
                                          width: railWidth,
                                          height: contentHeight,
                                          child: _navigationRail(),
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: AttendancePanel(
                                            sectionIndex: _selectedNavigation,
                                            member: widget.member,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        ),
      ),
    );
  }

  Widget _navigationRail() {
    final palette = MemberPlanPalette.forPlan(widget.member.plan);
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemHeight = constraints.maxHeight / _navigation.length;
        final iconSize = (itemHeight * 0.30).clamp(15.0, 19.0);
        final labelSize = (itemHeight * 0.15).clamp(7.2, 9.0);
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: palette.railGradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: palette.frameRim, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: palette.accent.withOpacity(0.15),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              for (var i = 0; i < _navigation.length; i++)
                Expanded(
                  child: InkWell(
                    key: ValueKey('navigation-${_navigation[i].$2.toLowerCase()}'),
                    borderRadius: BorderRadius.circular(11),
                    onTap: () => setState(() => _selectedNavigation = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.symmetric(vertical: 0.5),
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        gradient: _selectedNavigation == i
                            ? LinearGradient(
                                colors: [
                                  Color.lerp(palette.railSelected, Colors.white, 0.22)!,
                                  palette.railSelected,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(10),
                        border: _selectedNavigation == i
                            ? Border.all(color: Colors.white, width: 1)
                            : null,
                        boxShadow: _selectedNavigation == i
                            ? [
                                BoxShadow(
                                  color: palette.railSelected.withOpacity(0.24),
                                  blurRadius: 5,
                                  offset: const Offset(0, 1),
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _navigation[i].$1,
                            color: _selectedNavigation == i
                                ? MemberTheme.ink
                                : Colors.white,
                            size: iconSize,
                          ),
                          const SizedBox(height: 2),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              _navigation[i].$2,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _selectedNavigation == i
                                    ? MemberTheme.ink
                                    : Colors.white,
                                fontSize: labelSize,
                                height: 1.05,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

    Widget _dashboardTop({
    required bool compact,
    required double compactProgress,
  }) {
    // Recover height across every row rather than shrinking customer-critical
    // text. The short-phone baseline is 560 dp; larger screens expand gently.
    final topHeight = compact ? 46.0 + 4.0 * compactProgress : 58.0;
    final identityHeight = compact ? 78.0 + 6.0 * compactProgress : 100.0;
    final offerHeight = compact ? 44.0 + 4.0 * compactProgress : 62.0;
    final progressHeight = compact ? 40.0 + 4.0 * compactProgress : 52.0;
    final metricsHeight = compact ? 94.0 + 8.0 * compactProgress : 130.0;
    final sectionGap = compact ? 1.5 : 3.5;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: topHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: _topActions(),
          ),
        ),
        SizedBox(height: sectionGap),
        SizedBox(
          height: identityHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: _memberIdentity(
              compact: compact,
              compactProgress: compactProgress,
            ),
          ),
        ),
        SizedBox(height: sectionGap),
        SizedBox(
          height: offerHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: _paymentAndOffer(compact: compact),
          ),
        ),
        SizedBox(height: sectionGap),
        SizedBox(
          height: progressHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: _membershipProgress(compact: compact),
          ),
        ),
        SizedBox(height: sectionGap),
        SizedBox(
          height: metricsHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: _metrics(compact: compact),
          ),
        ),
      ],
    );
  }

    Widget _topActions() {
    final palette = MemberPlanPalette.forPlan(widget.member.plan);
    final isGold = palette.planName == 'Gold';
    return Row(
      children: [
        Expanded(
          child: InkWell(
            key: const ValueKey('check-in-button'),
            borderRadius: BorderRadius.circular(16),
            onTap: () => setState(() => _checkedIn = !_checkedIn),
            child: Container(
              key: const ValueKey('check-in-freeze-header-image'),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: palette.checkInGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: palette.frameRim, width: 1.25),
                boxShadow: [
                  BoxShadow(
                    color: palette.accent.withOpacity(0.16),
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 29,
                    height: 29,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF29EF83), Color(0xFF00B85D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xCCFFFFFF)),
                      boxShadow: const [
                        BoxShadow(color: Color(0x5547FF9B), blurRadius: 4),
                      ],
                    ),
                    child: Icon(
                      _checkedIn ? Icons.check_rounded : Icons.login_rounded,
                      color: Colors.white,
                      size: 21,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'CHECK-IN',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              height: 1,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _checkedIn ? '07:12 AM' : 'TAP TO CHECK-IN',
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              height: 1,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 3),
                  SizedBox(
                    width: 38,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ArtworkEntrance(
                          motion: 3,
                          child: Image.asset(
                            'assets/member_card/05_blinkit_grocery_bag.webp',
                            width: 35,
                            height: 27,
                            fit: BoxFit.contain,
                          ),
                        ),
                        RotatingAdMessage(
                          messages: isGold
                              ? const ['₹100 OFF', 'GOLD PERK', 'FREE DELIVERY']
                              : const ['MEMBER DEAL', 'SAVE 15%', 'GYM REWARD'],
                          alignment: Alignment.center,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFFFF1A8),
                            fontSize: 7.2,
                            height: 1,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFFFFF), Color(0xFFE8F2FF), Color(0xFFF7F1FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFC8B8F1), width: 1.2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x227E30D7),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                ArtworkEntrance(
                  motion: 1,
                  child: Image.asset(
                    'assets/member_card/23_freeze_snowflake_graphic.webp',
                    width: 23,
                    height: 27,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 3),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'FREEZE',
                        maxLines: 1,
                        style: TextStyle(
                          color: MemberTheme.ink,
                          fontSize: 14,
                          height: 1,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 2),
                      RotatingAdMessage(
                        messages: const [
                          'Pause plan • Stay flexible',
                          'Member offer • Save 20%',
                          'Freeze now • Train later',
                        ],
                        style: const TextStyle(
                          color: Color(0xFF45305D),
                          fontSize: 7.6,
                          height: 1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE52B52), Color(0xFFB71648)],
                          ),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: const Text(
                          '20% OFF • PAUSE PLAN',
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 6.8,
                            height: 1,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 2),
                ArtworkEntrance(
                  motion: 2,
                  child: Image.asset(
                    'assets/member_card/04_purple_shaker.webp',
                    width: 32,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

    Widget _memberIdentity({
    required bool compact,
    required double compactProgress,
  }) {
    final member = widget.member;
    final palette = MemberPlanPalette.forPlan(widget.member.plan);
    final portrait = compact ? 62.0 + 5.0 * compactProgress : 84.0;

    return DashboardPanel(
      color: palette.surface,
      borderColor: palette.panelEdge,
      radius: 19,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: Row(
        children: [
          Container(
            width: portrait,
            height: portrait,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: palette.planBadgeGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              image: palette.planName == 'Gold'
                  ? const DecorationImage(
                      image: AssetImage(
                        'assets/member_card/10_gold_photo_backplate.webp',
                      ),
                      fit: BoxFit.cover,
                    )
                  : null,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: palette.frameRim, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: palette.frameRim.withOpacity(0.28),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ArtworkEntrance(
                motion: 0,
                child: Image.asset(
                  'assets/member_card/01_member_bodybuilder.webp',
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: MemberTheme.ink,
                      fontSize: compact ? 17 : 21,
                      height: 1.03,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.25,
                    ),
                  ),
                  SizedBox(height: compact ? 2 : 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.badge_outlined,
                        size: 12,
                        color: Color(0xFF6B388B),
                      ),
                      const SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          member.memberId,
                          maxLines: 1,
                          style: TextStyle(
                            color: const Color(0xFF573274),
                            fontSize: compact ? 9 : 10.5,
                            height: 1,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Container(
                        width: 1,
                        height: 12,
                        color: palette.panelEdge,
                      ),
                      const SizedBox(width: 7),
                      const Icon(
                        Icons.cake_outlined,
                        size: 12,
                        color: Color(0xFF6B388B),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        member.age,
                        maxLines: 1,
                        style: TextStyle(
                          color: const Color(0xFF573274),
                          fontSize: compact ? 9.5 : 10.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Container(
                        width: 1,
                        height: 12,
                        color: palette.panelEdge,
                      ),
                      const SizedBox(width: 7),
                      const Icon(
                        Icons.person_outline_rounded,
                        size: 13,
                        color: Color(0xFF6B388B),
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          member.gender,
                          maxLines: 1,
                          style: TextStyle(
                            color: const Color(0xFF573274),
                            fontSize: compact ? 9.5 : 10.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: compact ? 3 : 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _statusPill(
                              member.plan,
                              palette.planBadgeGradient.first,
                              palette.planBadgeText,
                              icon: Icons.workspace_premium_rounded,
                              gradient: palette.planBadgeGradient,
                              compact: compact,
                            ),
                            SizedBox(height: compact ? 1 : 2),
                            RotatingAdMessage(
                              messages: palette.planName == 'Gold'
                                  ? const [
                                      'Gold member perk • ₹100 off',
                                      'Priority offer • save 15%',
                                      'Premium member pricing',
                                    ]
                                  : palette.planName == 'Spark'
                                      ? const [
                                          'Spark member deal • save 10%',
                                          'Daily essentials • member price',
                                          'Fresh-start reward',
                                        ]
                                      : const [
                                          'Silver member deal • save 8%',
                                          'Member pricing on essentials',
                                          'Wellness reward unlocked',
                                        ],
                              style: TextStyle(
                                color: palette.accent,
                                fontSize: compact ? 6.8 : 7.8,
                                height: 1,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _statusPill(
                              'Active',
                              MemberTheme.green,
                              Colors.white,
                              icon: Icons.check_circle_rounded,
                              gradient: const [
                                Color(0xFF2BE184),
                                Color(0xFF08B962),
                              ],
                              compact: compact,
                            ),
                            SizedBox(height: compact ? 1 : 2),
                            RotatingAdMessage(
                              messages: const [
                                'Active reward • 5% cashback',
                                'Training gear • member rate',
                                'Partner rewards • unlocked',
                              ],
                              style: TextStyle(
                                color: const Color(0xFF23694E),
                                fontSize: compact ? 6.8 : 7.8,
                                height: 1,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

    Widget _paymentAndOffer({required bool compact}) {
    final member = widget.member;
    return Row(
      children: [
        Expanded(
          child: DashboardPanel(
            color: const Color(0xFFFFFBFD),
            borderColor: const Color(0xFFE9C7D7),
            radius: 17,
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            child: Row(
              children: [
                Container(
                  width: compact ? 37 : 43,
                  height: compact ? 37 : 43,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF6E9FF), Color(0xFFE5D2FB)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFD8BCEB)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x22A06ACA),
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_rounded,
                    color: Color(0xFF7130A8),
                    size: 25,
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PAYMENT DUE',
                        maxLines: 1,
                        style: TextStyle(
                          color: MemberTheme.ink,
                          fontSize: 9.2,
                          height: 1,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.15,
                        ),
                      ),
                      SizedBox(height: compact ? 2 : 3),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${member.paymentDue} Due',
                          maxLines: 1,
                          style: TextStyle(
                            color: MemberTheme.rose,
                            fontSize: compact ? 16 : 20,
                            height: 1,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.35,
                          ),
                        ),
                      ),
                      SizedBox(height: compact ? 2 : 3),
                      Text(
                        '${member.daysRemaining} Days Left',
                        maxLines: 1,
                        style: TextStyle(
                          color: MemberTheme.muted,
                          fontSize: compact ? 7.5 : 8.5,
                          height: 1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 2),
                const Icon(
                  Icons.error_rounded,
                  color: Color(0xFFFFB629),
                  size: 15,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: DashboardPanel(
            color: const Color(0xFF6310AE),
            borderColor: const Color(0xFFE47AFF),
            radius: 17,
            padding: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: compact ? 3 : 5,
            ),
            child: Row(
              children: [
                ArtworkEntrance(
                  motion: 1,
                  child: Image.asset(
                    'assets/member_card/03_whey_protein_tub.webp',
                    width: compact ? 38 : 48,
                    height: compact ? 39 : 50,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Whey Protein',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: MemberTheme.gold,
                          fontSize: compact ? 8.5 : 9.5,
                          height: 1,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: compact ? 2 : 3),
                      Text(
                        '25% OFF',
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: compact ? 14.5 : 19,
                          height: 1,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: compact ? 2 : 4),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: compact ? 6 : 8,
                          vertical: compact ? 1 : 3,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFE56A), Color(0xFFFFBA22)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'BUY NOW ›',
                          maxLines: 1,
                          style: TextStyle(
                            color: MemberTheme.ink,
                            fontSize: compact ? 7 : 7.8,
                            height: 1,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _membershipProgress({required bool compact}) {
    final member = widget.member;
    final palette = MemberPlanPalette.forPlan(widget.member.plan);
    return DashboardPanel(
      color: palette.accentSoft,
      borderColor: palette.panelEdge,
      radius: 15,
      padding: EdgeInsets.symmetric(
        horizontal: 9,
        vertical: compact ? 3 : 5,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Membership ${member.membershipDays} / ${member.membershipTotalDays} Days',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MemberTheme.ink,
                    fontSize: compact ? 11.5 : 14,
                    height: 1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE63857), Color(0xFFB91F43)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFFA5B2)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22D71939),
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  '⚠ ${member.daysRemaining} Days Left',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: compact ? 8 : 9,
                    height: 1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '${(member.membershipProgress * 100).round()}%',
                style: TextStyle(
                  color: palette.accent,
                  fontSize: compact ? 18 : 22,
                  height: 1,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          SizedBox(height: compact ? 4 : 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: compact ? 9 : 12,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ColoredBox(color: palette.panelEdge.withOpacity(0.34)),
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: member.membershipProgress
                        .clamp(0.0, 1.0)
                        .toDouble(),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: palette.progressGradient,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: palette.accent.withOpacity(0.28),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

    Widget _metrics({required bool compact}) {
    final member = widget.member;
    final palette = MemberPlanPalette.forPlan(member.plan);
    return Row(
      children: [
        Expanded(
          child: DashboardMetricTile(
            label: 'ATTENDANCE',
            key: const ValueKey('metric-attendance'),
            compact: compact,
            value: member.attendance,
            trend: '↑ +6%',
            valueColor: const Color(0xFF087E40),
            note: 'PROTEIN 10% OFF',
            color: const Color(0xFFFFE96A),
            asset: 'assets/member_card/28_protinex_tub.webp',
            motion: 0,
            noteColor: const Color(0xFFE52B52),
            noteTextColor: Colors.white,
            selectionColor: palette.accent,
            selected: _selectedNavigation == 0,
            onTap: () => setState(() => _selectedNavigation = 0),
          ),
        ),
        const SizedBox(width: 3),
        Expanded(
          child: DashboardMetricTile(
            label: 'WORKOUT',
            key: const ValueKey('metric-workout'),
            compact: compact,
            value: member.workout,
            trend: '↑ +12%',
            note: 'CREATINE 15% OFF',
            color: const Color(0xFFF2D7FF),
            asset: 'assets/member_card/06_creatine_tub.webp',
            motion: 1,
            noteColor: const Color(0xFFB20BE4),
            noteTextColor: Colors.white,
            selectionColor: palette.accent,
            selected: _selectedNavigation == 4,
            onTap: () => setState(() => _selectedNavigation = 4),
          ),
        ),
        const SizedBox(width: 3),
        Expanded(
          child: DashboardMetricTile(
            label: 'PAYMENT',
            key: const ValueKey('metric-payment'),
            compact: compact,
            value: '${member.paymentDue} Due',
            note: 'SBI 5% OFF',
            valueColor: const Color(0xFFD71939),
            color: const Color(0xFFD9F1FF),
            asset: 'assets/member_card/29_sbi_payment_card_graphic.webp',
            motion: 2,
            noteColor: const Color(0xFF1269DB),
            noteTextColor: Colors.white,
            selectionColor: palette.accent,
            selected: _selectedNavigation == 3,
            onTap: () => setState(() => _selectedNavigation = 3),
          ),
        ),
        const SizedBox(width: 3),
        Expanded(
          child: DashboardMetricTile(
            label: 'BODY',
            key: const ValueKey('metric-body'),
            compact: compact,
            value: member.bodyWeight,
            trend: '↓ -0.8 kg',
            note: 'FAT LOSS 20% OFF',
            color: const Color(0xFFD8FFE2),
            asset: 'assets/member_card/fat_loss_support_tub.png',
            motion: 3,
            noteColor: const Color(0xFF0B9C4C),
            noteTextColor: Colors.white,
            selectionColor: palette.accent,
            selected: _selectedNavigation == 5,
            onTap: () => setState(() => _selectedNavigation = 5),
          ),
        ),
      ],
    );
  }

    Widget _statusPill(
    String label,
    Color color,
    Color foreground, {
    IconData? icon,
    List<Color>? gradient,
    bool compact = false,
  }) {
    return Container(
      height: compact ? 25 : 30,
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient ??
              [Color.lerp(color, Colors.white, 0.22)!, color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.white.withOpacity(0.92), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.20),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: foreground, size: compact ? 11 : 13),
            const SizedBox(width: 3),
          ],
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                style: TextStyle(
                  color: foreground,
                  fontSize: compact ? 10 : 11,
                  height: 1,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
