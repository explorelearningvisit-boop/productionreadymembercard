import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/sample_member.dart';
import '../data/dashboard_navigation.dart';
import '../data/dashboard_campaigns.dart';
import '../theme/member_theme.dart';
import '../widgets/ad_motion.dart';
import '../widgets/attendance_panel.dart';
import '../widgets/dashboard_primitives.dart';
import '../widgets/sponsored_campaign.dart';

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

    final appTheme = Theme.of(context);
    final planTheme = appTheme.copyWith(
      colorScheme: appTheme.colorScheme.copyWith(
        primary: palette.accent,
        secondary: palette.railSelected,
      ),
    );

    return MemberPlanTheme(
      palette: palette,
      child: Theme(
        data: planTheme,
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
                  ? 58.0
                  : bounds.maxWidth < 380
                      ? 62.0
                      : 66.0;

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
                                          child: AnimatedSwitcher(
                                            duration: MediaQuery.of(context)
                                                    .disableAnimations
                                                ? Duration.zero
                                                : const Duration(milliseconds: 240),
                                            switchInCurve: Curves.easeOutCubic,
                                            switchOutCurve: Curves.easeInCubic,
                                            transitionBuilder: (child, animation) {
                                              final position = Tween<Offset>(
                                                begin: const Offset(0, 0.025),
                                                end: Offset.zero,
                                              ).animate(animation);
                                              return FadeTransition(
                                                opacity: animation,
                                                child: SlideTransition(
                                                  position: position,
                                                  child: child,
                                                ),
                                              );
                                            },
                                            child: AttendancePanel(
                                              key: ValueKey(
                                                'detail-${_activeModule.name}-$_selectedSubmenu',
                                              ),
                                              module: _activeModule,
                                              sectionIndex: _selectedSubmenu,
                                              member: widget.member,
                                            ),
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
      ),
    );
  }

  Widget _navigationRail() {
    final palette = MemberPlanPalette.forPlan(widget.member.plan);
    final items = DashboardNavigation.itemsFor(_activeModule);
    return LayoutBuilder(
      builder: (context, constraints) {
        final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
        final itemHeight = constraints.maxHeight / items.length;
        // Very short phones need a denser rail; keep every label visible rather
        // than letting the icon/label stack overflow its six equal slots.
        final tightRail = itemHeight < 39;
        final iconSize = tightRail
            ? (itemHeight * 0.46).clamp(15.0, 18.0)
            : (itemHeight * 0.32).clamp(20.0, 24.0);
        final labelSize = tightRail
            ? (itemHeight * 0.29).clamp(9.0, 11.0)
            : (itemHeight * 0.19).clamp(12.0, 13.5);
        final iconLabelGap = tightRail ? 2.0 : 3.0;
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
                      mouseCursor: SystemMouseCursors.click,
                      hoverColor: Colors.white.withOpacity(0.12),
                      focusColor: Colors.white.withOpacity(0.16),
                      onTap: () => setState(() => _selectedSubmenu = i),
                      child: AnimatedContainer(
                        duration: reduceMotion ? Duration.zero : const Duration(milliseconds: 180),
                        curve: Curves.easeOutCubic,
                        margin: const EdgeInsets.symmetric(vertical: 1),
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: _selectedSubmenu == i
                              ? palette.railSelected
                              : Colors.transparent,
                          gradient: _selectedSubmenu == i
                              ? const LinearGradient(
                                  colors: [Color(0xFFE7F9ED), Color(0xFFCBEED8)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(10),
                          border: _selectedSubmenu == i
                              ? Border.all(
                                  color: const Color(0xFFEAF8EF),
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
                                  ? const Color(0xFF154A35)
                                  : const Color(0xFFFFF8E9),
                              size: iconSize,
                            ),
                            SizedBox(height: iconLabelGap),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                items[i].label,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _selectedSubmenu == i
                                      ? const Color(0xFF452900)
                                      : const Color(0xFFFFF8E9),
                                  fontSize: labelSize,
                                  height: 1.05,
                                  fontWeight: FontWeight.w800,
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
    final topHeight = compact ? 42.0 + 3.0 * compactProgress : 58.0;
    final identityHeight = compact ? 72.0 + 5.0 * compactProgress : 100.0;
    final offerHeight = compact ? 42.0 + 3.0 * compactProgress : 62.0;
    final progressHeight = compact ? 36.0 + 3.0 * compactProgress : 52.0;
    final metricsHeight = compact ? 86.0 + 6.0 * compactProgress : 130.0;
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
                            _checkedIn ? '07:12 AM' : 'TAP TO PREVIEW',
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
          child: InkWell(
            key: const ValueKey('freeze-preview-button'),
            onTap: () => _showFreezeDetails(context),
            borderRadius: BorderRadius.circular(16),
            mouseCursor: SystemMouseCursors.click,
            hoverColor: palette.accent.withOpacity(0.06),
            focusColor: palette.accent.withOpacity(0.10),
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
                      const SizedBox(height: 1),
                      const Text(
                        'Stay Cool · Pause Plan',
                        maxLines: 1,
                        style: TextStyle(
                          color: MemberTheme.muted,
                          fontSize: 8,
                          height: 1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: palette.railSelected,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(color: palette.frameRim, width: 0.7),
                        ),
                        child: Text(
                          'UP TO 20% OFF',
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
    final portrait = compact ? 60.0 + 4.0 * compactProgress : 84.0;

    return DashboardPanel(
      color: palette.surface,
      borderColor: palette.panelEdge,
      radius: 19,
      padding: EdgeInsets.symmetric(
        vertical: compact ? 2 : 3,
        horizontal: 5,
      ),
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
                      fontSize: compact ? 18.5 : 22,
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
                            fontSize: compact ? 11 : 12,
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
                      Icon(
                        Icons.cake_outlined,
                        size: 12,
                        color: palette.accent,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        member.age,
                        maxLines: 1,
                        style: TextStyle(
                          color: palette.accent,
                          fontSize: compact ? 10.5 : 11.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Container(
                        width: 1,
                        height: 12,
                        color: palette.panelEdge,
                      ),
                      const SizedBox(width: 7),
                      Icon(
                        Icons.person_outline_rounded,
                        size: 13,
                        color: palette.accent,
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          member.gender,
                          maxLines: 1,
                          style: TextStyle(
                            color: palette.accent,
                            fontSize: compact ? 10.5 : 11.5,
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
                              backgroundAsset: null,
                              compact: compact,
                            ),
                            SizedBox(height: compact ? 1 : 2),
                            Text(
                              '${palette.planName} member perks · Sample',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: palette.accent,
                                fontSize: compact ? 9 : 9.5,
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
                                Color(0xFF2BBE79),
                                Color(0xFF0D925D),
                              ],
                              backgroundAsset: null,
                              compact: compact,
                            ),
                            SizedBox(height: compact ? 1 : 2),
                            Text(
                              'Member rewards · Sample',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: const Color(0xFF23694E),
                                fontSize: compact ? 9 : 9.5,
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
          IconButton(
            key: const ValueKey('member-profile-button'),
            tooltip: 'Open member profile preview',
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 26, height: 30),
            onPressed: () => _showMemberProfile(context),
            icon: Icon(Icons.chevron_right_rounded, color: palette.accent, size: 22),
          ),
        ],
      ),
    );
  }

    Widget _paymentAndOffer({required bool compact}) {
    final member = widget.member;
    final palette = MemberPlanPalette.forPlan(member.plan);
    final dueValue = double.tryParse(
      member.paymentDue.replaceAll(RegExp(r'[^0-9.]'), ''),
    );
    final paymentIsDue = dueValue == null || dueValue > 0;
    final paymentLabel = paymentIsDue ? 'PAYMENT DUE' : 'PAYMENT STATUS';
    final paymentValue = paymentIsDue ? member.paymentDue : 'Paid';
    final paymentColor = paymentIsDue ? MemberTheme.rose : MemberTheme.green;
    final paymentIcon = paymentIsDue
        ? Icons.error_rounded
        : Icons.check_circle_rounded;
    return Row(
      children: [
        Expanded(
          child: DashboardPanel(
            color: palette.surface,
            borderColor: palette.panelEdge,
            radius: 17,
            onTap: () => _selectModule(DashboardModule.payment),
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            child: Row(
              children: [
                Container(
                  width: compact ? 35 : 43,
                  height: compact ? 34 : 43,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [palette.accentSoft, palette.panelEdge],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: palette.panelEdge),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x180B0905),
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.account_balance_wallet_rounded,
                    color: palette.accent,
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
                                paymentLabel,
                                maxLines: 1,
                                style: TextStyle(
                                  color: MemberTheme.ink,
                                  fontSize: compact ? 11.5 : 12.5,
                                  height: 1,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.15,
                                ),
                              ),
                              SizedBox(height: compact ? 1 : 3),
                              Text(
                                paymentValue,
                                maxLines: 1,
                                style: TextStyle(
                                  color: paymentColor,
                                  fontSize: compact ? 18 : 22,
                                  height: 1,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.35,
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
                Icon(
                  paymentIcon,
                  color: paymentIsDue
                      ? const Color(0xFFFFB629)
                      : MemberTheme.green,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: DashboardPanel(
            key: const ValueKey('whey-offer-preview'),
            color: const Color(0xFF07533E),
            borderColor: const Color(0xFF78B99A),
            radius: 17,
            onTap: () => CampaignPreviewSheet.show(
              context,
              DashboardCampaigns.wheyTop,
              accent: palette.accent,
            ),
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
                                  fontSize: compact ? 10 : 11,
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
                                  'BUY NOW',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: MemberTheme.ink,
                                    fontSize: compact ? 8.5 : 9.5,
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.schedule_rounded, color: Colors.white, size: 10),
                            const SizedBox(width: 3),
                            Text(
                              '${member.daysRemaining} Days Left',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: compact ? 9.5 : 10.5,
                                height: 1,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
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
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(
                              begin: 0,
                              end: member.membershipProgress.clamp(0.0, 1.0).toDouble(),
                            ),
                            duration: MediaQuery.maybeOf(context)?.disableAnimations == true
                                ? Duration.zero
                                : const Duration(milliseconds: 360),
                            curve: Curves.easeOutCubic,
                            builder: (context, progress, child) => FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress,
                              child: child,
                            ),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFC27AF5),
                                    Color(0xFF8A2BE2),
                                    Color(0xFF5A0DAA),
                                  ],
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
            trendColor: MemberTheme.green,
            valueColor: const Color(0xFF087E40),
            note: 'Protinex',
            color: MemberTheme.mint,
            asset: 'assets/material_pack/inbox/PulseVault/28_protinex_tub.webp',
            campaign: DashboardCampaigns.protinexAttendance,
            onCampaignTap: () => CampaignPreviewSheet.show(context, DashboardCampaigns.protinexAttendance, accent: palette.accent),
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
            trendColor: MemberTheme.green,
            note: 'Creatine',
            color: MemberTheme.lavender,
            asset: 'assets/material_pack/inbox/PulseVault/06_creatine_tub.webp',
            campaign: DashboardCampaigns.creatineWorkout,
            onCampaignTap: () => CampaignPreviewSheet.show(context, DashboardCampaigns.creatineWorkout, accent: palette.accent),
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
            note: 'SBI',
            valueColor: const Color(0xFFD71939),
            color: MemberTheme.sky,
            asset: 'assets/material_pack/inbox/PulseVault/29_sbi_payment_card_graphic.webp',
            campaign: DashboardCampaigns.sbiPayment,
            onCampaignTap: () => CampaignPreviewSheet.show(context, DashboardCampaigns.sbiPayment, accent: palette.accent),
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
            trendColor: MemberTheme.green,
            note: 'Fat Loss',
            color: MemberTheme.mint,
            asset: 'assets/material_pack/inbox/PulseVault/fat_loss_support_tub.png',
            campaign: DashboardCampaigns.fatLossBody,
            onCampaignTap: () => CampaignPreviewSheet.show(context, DashboardCampaigns.fatLossBody, accent: palette.accent),
            selectionColor: palette.accent,
            selected: _activeModule == DashboardModule.body,
            onTap: () => _selectModule(DashboardModule.body),
          ),
        ),
      ],
    );
  }

  
  void _showFreezeDetails(BuildContext context) {
    final palette = MemberPlanPalette.forPlan(widget.member.plan);
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(color: palette.panelEdge),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Plan freeze',
                style: TextStyle(
                  color: palette.accent,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Freeze request preview',
                style: TextStyle(
                  color: MemberTheme.ink,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Demo preview only. No freeze request has been submitted and no membership dates have changed.',
                style: TextStyle(color: MemberTheme.muted, fontSize: 13),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: palette.accent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.of(sheetContext).pop(),
                  child: const Text('Close preview'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMemberProfile(BuildContext context) {
    final member = widget.member;
    final palette = MemberPlanPalette.forPlan(member.plan);
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        key: const ValueKey('member-profile-preview'),
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          border: Border.all(color: palette.panelEdge),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(member.name, style: const TextStyle(color: MemberTheme.ink, fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Text('${member.memberId} · ${member.age} · ${member.gender}', style: const TextStyle(color: MemberTheme.muted, fontSize: 13)),
            const SizedBox(height: 4),
            Text('${member.plan} · Active', style: TextStyle(color: palette.accent, fontSize: 13, fontWeight: FontWeight.w700)),
            const SizedBox(height: 14),
            SizedBox(width: double.infinity, child: FilledButton(onPressed: () => Navigator.of(sheetContext).pop(), child: const Text('Close profile'))),
          ],
        ),
      ),
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
      height: compact ? 20 : 30,
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
                  fontSize: compact ? 11.5 : 12.5,
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
