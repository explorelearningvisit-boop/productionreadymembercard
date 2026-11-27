import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/sample_member.dart';
import '../data/dashboard_navigation.dart';
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
  DashboardModule _activeModule = DashboardModule.attendance;
  int _selectedSubmenu = 0;

  void _selectModule(DashboardModule module) {
    if (_activeModule == module && _selectedSubmenu == 0) return;
    setState(() {
      _activeModule = module;
      _selectedSubmenu = 0;
    });
  }

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
                                            module: _activeModule,
                                            sectionIndex: _selectedSubmenu,
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
    final items = DashboardNavigation.itemsFor(_activeModule);
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemHeight = constraints.maxHeight / items.length;
        final iconSize = (itemHeight * 0.28).clamp(14.0, 18.0);
        final labelSize = (itemHeight * 0.15).clamp(8.0, 9.5);
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: palette.railGradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: palette.frameRim, width: 1.1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x180E0906),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: Semantics(
                    button: true,
                    selected: _selectedSubmenu == i,
                    label: '${DashboardNavigation.moduleLabels[_activeModule]} ${items[i].label}',
                    child: InkWell(
                      key: ValueKey(
                        DashboardNavigation.keyFor(_activeModule, i),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => setState(() => _selectedSubmenu = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOutCubic,
                        margin: const EdgeInsets.symmetric(vertical: 1),
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: _selectedSubmenu == i
                              ? palette.railSelected
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: _selectedSubmenu == i
                              ? Border.all(
                                  color: const Color(0xFFFFF7D9),
                                  width: 1,
                                )
                              : null,
                          boxShadow: _selectedSubmenu == i
                              ? const [
                                  BoxShadow(
                                    color: Color(0x260F0904),
                                    blurRadius: 3,
                                    offset: Offset(0, 1),
                                  ),
                                ]
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              items[i].icon,
                              color: _selectedSubmenu == i
                                  ? palette.planBadgeText
                                  : const Color(0xFFFFF8E9),
                              size: iconSize,
                            ),
                            const SizedBox(height: 3),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                items[i].label,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _selectedSubmenu == i
                                      ? palette.planBadgeText
                                      : const Color(0xFFFFF8E9),
                                  fontSize: labelSize,
                                  height: 1.05,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
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
    final topHeight = compact ? 44.0 + 4.0 * compactProgress : 58.0;
    final identityHeight = compact ? 76.0 + 6.0 * compactProgress : 100.0;
    final offerHeight = compact ? 44.0 + 4.0 * compactProgress : 62.0;
    final progressHeight = compact ? 38.0 + 4.0 * compactProgress : 52.0;
    final metricsHeight = compact ? 90.0 + 8.0 * compactProgress : 130.0;
    final sectionGap = compact ? 1.2 : 3.5;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: topHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: _topActions(compact: compact),
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

    Widget _topActions({required bool compact}) {
    final palette = MemberPlanPalette.forPlan(widget.member.plan);
    return Row(
      children: [
        Expanded(
          child: InkWell(
            key: const ValueKey('check-in-button'),
            borderRadius: BorderRadius.circular(16),
            onTap: () => setState(() => _checkedIn = !_checkedIn),
            child: Container(
              key: const ValueKey('check-in-freeze-header-image'),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: palette.checkInGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: palette.frameRim, width: 1.25),
                boxShadow: [
                  const BoxShadow(
                    color: Color(0x180B0905),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 29,
                    height: 29,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0EA86A),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.2),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x220B0905),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
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
                            'Check-in',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              height: 1,
                              fontWeight: FontWeight.w600,
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
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 3),
                  ArtworkEntrance(
                    motion: 3,
                    child: Image.asset(
                      'assets/material_pack/inbox/PulseVault/01_member_bodybuilder.webp',
                      width: compact ? 34 : 42,
                      height: compact ? 38 : 44,
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
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
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFEFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: palette.panelEdge, width: 1.2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x160B0905),
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
                    'assets/material_pack/inbox/PulseVault/23_freeze_snowflake_graphic.webp',
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
                        'Freeze',
                        maxLines: 1,
                        style: TextStyle(
                          color: MemberTheme.ink,
                          fontSize: 14,
                          height: 1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Pause plan · Stay flexible',
                        maxLines: 1,
                        style: TextStyle(
                          color: MemberTheme.muted,
                          fontSize: 8,
                          height: 1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: palette.railSelected,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(color: palette.frameRim, width: 0.7),
                        ),
                        child: Text(
                          '20% OFF • PAUSE PLAN',
                          maxLines: 1,
                          style: TextStyle(
                            color: palette.planBadgeText,
                            fontSize: 7,
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
                    'assets/material_pack/inbox/PulseVault/04_purple_shaker.webp',
                    width: compact ? 34 : 38,
                    height: compact ? 38 : 44,
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
                        'assets/material_pack/inbox/PulseVault/10_gold_photo_backplate.webp',
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
                  'assets/material_pack/inbox/PulseVault/01_member_bodybuilder.webp',
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: EdgeInsets.zero,
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
                  SizedBox(height: compact ? 1 : 5),
                  Row(
                    children: [
                      Icon(
                        Icons.badge_outlined,
                        size: 12,
                        color: palette.accent,
                      ),
                      const SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          member.memberId,
                          maxLines: 1,
                          style: TextStyle(
                            color: MemberTheme.ink,
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
                          fontWeight: FontWeight.w600,
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
                  SizedBox(height: compact ? 1 : 6),
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
                              backgroundAsset: palette.planName == 'Gold'
                                  ? 'assets/material_pack/inbox/PulseVault/21_gold_plan_badge_background.webp'
                                  : null,
                              compact: compact,
                            ),
                            SizedBox(height: compact ? 1 : 2),
                            Text(
                              '${palette.planName} member perks · Sample',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: palette.accent,
                                fontSize: compact ? 7.6 : 8.2,
                                height: 1,
                                fontWeight: FontWeight.w600,
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
                              backgroundAsset: 'assets/material_pack/inbox/PulseVault/22_green_active_badge_background.webp',
                              compact: compact,
                            ),
                            SizedBox(height: compact ? 1 : 2),
                            Text(
                              'Member rewards · Sample',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: const Color(0xFF23694E),
                                fontSize: compact ? 7.6 : 8.2,
                                height: 1,
                                fontWeight: FontWeight.w600,
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
                  width: compact ? 35 : 43,
                  height: compact ? 34 : 43,
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
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: constraints.maxWidth,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PAYMENT DUE',
                                maxLines: 1,
                                style: TextStyle(
                                  color: MemberTheme.ink,
                                  fontSize: compact ? 8.5 : 9.2,
                                  height: 1,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.15,
                                ),
                              ),
                              SizedBox(height: compact ? 1 : 3),
                              Text(
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
                              SizedBox(height: compact ? 1 : 3),
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
                      );
                    },
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
              vertical: compact ? 2 : 5,
            ),
            child: Row(
              children: [
                ArtworkEntrance(
                  motion: 1,
                  child: Image.asset(
                    'assets/material_pack/inbox/PulseVault/03_whey_protein_tub.webp',
                    width: compact ? 38 : 48,
                    height: compact ? 39 : 50,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: constraints.maxWidth,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                              SizedBox(height: compact ? 1 : 3),
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
                              SizedBox(height: compact ? 1 : 4),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: compact ? 6 : 8,
                                  vertical: compact ? 0 : 3,
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
                      );
                    },
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          return FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: SizedBox(
              width: constraints.maxWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: compact ? 2 : 3,
                        ),
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
                  SizedBox(height: compact ? 2 : 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: compact ? 7 : 12,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ColoredBox(
                            color: palette.panelEdge.withOpacity(0.34),
                          ),
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
            ),
          );
        },
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
            key: const ValueKey('metric-attendance'),
            label: 'Attendance',
            compact: compact,
            value: member.attendance,
            trend: '↑ +6%',
            valueColor: const Color(0xFF087E40),
            note: 'Protein 10% off',
            color: const Color(0xFFFFE96A),
            asset: 'assets/material_pack/inbox/PulseVault/28_protinex_tub.webp',
            motion: 0,
            noteColor: const Color(0xFFE52B52),
            noteTextColor: Colors.white,
            selectionColor: palette.accent,
            selected: _activeModule == DashboardModule.attendance,
            onTap: () => _selectModule(DashboardModule.attendance),
          ),
        ),
        const SizedBox(width: 3),
        Expanded(
          child: DashboardMetricTile(
            key: const ValueKey('metric-workout'),
            label: 'Workout',
            compact: compact,
            value: member.workout,
            trend: '↑ +12%',
            note: 'Creatine 15% off',
            color: const Color(0xFFF2D7FF),
            asset: 'assets/material_pack/inbox/PulseVault/06_creatine_tub.webp',
            motion: 1,
            noteColor: const Color(0xFFB20BE4),
            noteTextColor: Colors.white,
            selectionColor: palette.accent,
            selected: _activeModule == DashboardModule.workout,
            onTap: () => _selectModule(DashboardModule.workout),
          ),
        ),
        const SizedBox(width: 3),
        Expanded(
          child: DashboardMetricTile(
            key: const ValueKey('metric-payment'),
            label: 'Payment',
            compact: compact,
            value: '${member.paymentDue} Due',
            note: 'SBI 5% off',
            valueColor: const Color(0xFFD71939),
            color: const Color(0xFFD9F1FF),
            asset: 'assets/material_pack/inbox/PulseVault/29_sbi_payment_card_graphic.webp',
            motion: 2,
            noteColor: const Color(0xFF1269DB),
            noteTextColor: Colors.white,
            selectionColor: palette.accent,
            selected: _activeModule == DashboardModule.payment,
            onTap: () => _selectModule(DashboardModule.payment),
          ),
        ),
        const SizedBox(width: 3),
        Expanded(
          child: DashboardMetricTile(
            key: const ValueKey('metric-body'),
            label: 'Body',
            compact: compact,
            value: member.bodyWeight,
            trend: '↓ -0.8 kg',
            note: 'Fat loss 20% off',
            color: const Color(0xFFD8FFE2),
            asset: 'assets/material_pack/inbox/PulseVault/fat_loss_support_tub.png',
            motion: 3,
            noteColor: const Color(0xFF0B9C4C),
            noteTextColor: Colors.white,
            selectionColor: palette.accent,
            selected: _activeModule == DashboardModule.body,
            onTap: () => _selectModule(DashboardModule.body),
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
    String? backgroundAsset,
    bool compact = false,
  }) {
    return Container(
      height: compact ? 25 : 30,
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      decoration: BoxDecoration(
        gradient: backgroundAsset == null
            ? LinearGradient(
                colors: gradient ??
                    [Color.lerp(color, Colors.white, 0.22)!, color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        image: backgroundAsset == null
            ? null
            : DecorationImage(
                image: AssetImage(backgroundAsset),
                fit: BoxFit.fill,
              ),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.white.withOpacity(0.82), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x160C0905),
            blurRadius: 2,
            offset: Offset(0, 1),
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
