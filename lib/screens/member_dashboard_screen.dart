import 'package:flutter/material.dart';

import '../data/sample_member.dart';
import '../theme/member_theme.dart';
import '../widgets/ad_motion.dart';
import '../widgets/attendance_panel.dart';
import '../widgets/dashboard_primitives.dart';

class MemberDashboardScreen extends StatefulWidget {
  const MemberDashboardScreen({super.key});

  @override
  State<MemberDashboardScreen> createState() => _MemberDashboardScreenState();
}

class _MemberDashboardScreenState extends State<MemberDashboardScreen> {
  bool _checkedIn = true;
  int _selectedNavigation = 0;

  static const _navigation = <(IconData, String)>[
    (Icons.calendar_month_rounded, 'Attend'),
    (Icons.insights_rounded, 'Insights'),
    (Icons.date_range_rounded, 'Cal'),
    (Icons.history_rounded, 'History'),
    (Icons.show_chart_rounded, 'Trend'),
    (Icons.emoji_events_rounded, 'Goals'),
  ];

  @override
  Widget build(BuildContext context) {
    const member = MemberSample.demo;
    final palette = MemberPlanPalette.forPlan(member.plan);

    return MemberPlanTheme(
      palette: palette,
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
                  ? 46.0
                  : bounds.maxWidth < 380
                      ? 48.0
                      : 50.0;

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
                                        const Expanded(
                                          child: AttendancePanel(),
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
    );
  }

    Widget _navigationRail() {
    final palette = MemberPlanTheme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemHeight = constraints.maxHeight / _navigation.length;
        final iconSize = (itemHeight * 0.36).clamp(16.0, 21.0);
        final labelSize = (itemHeight * 0.18).clamp(9.0, 10.0);
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
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
                      margin: const EdgeInsets.symmetric(vertical: 1),
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
    // Interpolate compact proportions so short phones do not hit an abrupt
    // breakpoint or squeeze text-heavy modules.
    final topHeight = compact
        ? 48.0 + 4.0 * compactProgress
        : 60.0;
    final identityHeight = compact
        ? 70.0 + 10.0 * compactProgress
        : 98.0;
    final offerHeight = compact
        ? 44.0 + 10.0 * compactProgress
        : 68.0;
    final progressHeight = compact
        ? 38.0 + 7.0 * compactProgress
        : 54.0;
    final metricsHeight = compact
        ? 72.0 + 44.0 * compactProgress
        : 150.0;
    final sectionGap = compact ? 2.0 + compactProgress : 5.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: topHeight, child: _topActions()),
        SizedBox(height: sectionGap),
        SizedBox(
          height: identityHeight,
          child: _memberIdentity(
            compact: compact,
            compactProgress: compactProgress,
          ),
        ),
        SizedBox(height: sectionGap),
        SizedBox(height: offerHeight, child: _paymentAndOffer(compact: compact)),
        SizedBox(height: sectionGap),
        SizedBox(height: progressHeight, child: _membershipProgress(compact: compact)),
        SizedBox(height: sectionGap),
        SizedBox(height: metricsHeight, child: _metrics(compact: compact)),
      ],
    );
  }

  Widget _topActions() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            key: const ValueKey('check-in-button'),
            borderRadius: BorderRadius.circular(17),
            onTap: () => setState(() => _checkedIn = !_checkedIn),
            child: Container(
              key: const ValueKey('check-in-freeze-header-image'),
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF290052), Color(0xFF6D16B5), Color(0xFF28004F)],
                ),
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: const Color(0xFFE05BFF), width: 1.5),
                boxShadow: const [
                  BoxShadow(color: Color(0xB5AD4BFF), blurRadius: 10, spreadRadius: 0.5),
                  BoxShadow(color: Color(0x55FF67D8), blurRadius: 3),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 31,
                    height: 31,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF20F17A), Color(0xFF00B95A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xAAFFFFFF)),
                      boxShadow: const [
                        BoxShadow(color: Color(0x8847FF9B), blurRadius: 8),
                      ],
                    ),
                    child: Icon(
                      _checkedIn ? Icons.check_rounded : Icons.login_rounded,
                      color: Colors.white,
                      size: 22,
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
                          child: Text('CHECK-IN', maxLines: 1,
                            style: TextStyle(color: Colors.white, fontSize: 14,
                              height: 1, fontWeight: FontWeight.w900)),
                        ),
                        const SizedBox(height: 3),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(_checkedIn ? '07:12 AM' : 'TAP TO CHECK-IN',
                            maxLines: 1,
                            style: const TextStyle(color: Colors.white, fontSize: 10,
                              height: 1, fontWeight: FontWeight.w800)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 2),
                  Image.asset(
                    'assets/member_card/01_member_bodybuilder.webp',
                    width: 37,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFFFFF), Color(0xFFE8F2FF), Color(0xFFF3E7FF)],
              ),
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: const Color(0xFFC8B8F1), width: 1.5),
              boxShadow: const [
                BoxShadow(color: Color(0x887E30D7), blurRadius: 8),
              ],
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/member_card/23_freeze_snowflake_graphic.webp',
                  width: 29,
                  height: 31,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 4),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('FREEZE', maxLines: 1,
                        style: TextStyle(color: MemberTheme.ink, fontSize: 13,
                          height: 1, fontWeight: FontWeight.w900)),
                      SizedBox(height: 1),
                      Text('Stay Cool • Pause Plan', maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: MemberTheme.ink, fontSize: 6,
                          height: 1, fontWeight: FontWeight.w800)),
                      SizedBox(height: 2),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFFD71939),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          child: Text('UP TO 20% OFF',
                            style: TextStyle(color: Colors.white, fontSize: 6,
                              height: 1, fontWeight: FontWeight.w900)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 2),
                Image.asset(
                  'assets/member_card/04_purple_shaker.webp',
                  width: 28,
                  height: 38,
                  fit: BoxFit.contain,
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
    const member = MemberSample.demo;
    final portrait = compact
        ? 56.0 + 12.0 * compactProgress
        : 84.0;
    return DashboardPanel(
      color: const Color(0xFFFCF9FF),
      borderColor: const Color(0xFFFFD56A),
      radius: 20,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
      child: Row(
        children: [
          Container(
            width: portrait,
            height: portrait,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFE46E), Color(0xFFFFB51D), Color(0xFFFFF7C8)],
              ),
              image: const DecorationImage(
                image: AssetImage('assets/member_card/10_gold_photo_backplate.webp'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(19),
              border: Border.all(color: MemberTheme.gold, width: 1.8),
              boxShadow: const [BoxShadow(color: Color(0xAAFFCA3A), blurRadius: 8)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: Image.asset(
                'assets/member_card/01_member_bodybuilder.webp',
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(member.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: MemberTheme.ink,
                      fontSize: compact ? 17 : 20, height: 1,
                      fontWeight: FontWeight.w900)),
                  SizedBox(height: compact ? 3 : 6),
                  Text('▦  ${member.memberId}  |  ${member.age} Yrs  |  ♂ ${member.gender}',
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: const Color(0xFF5E2C87), fontSize: compact ? 9 : 10,
                      height: 1, fontWeight: FontWeight.w800)),
                  SizedBox(height: compact ? 4 : 7),
                  Row(
                    children: [
                      _statusPill('♙  ${member.plan}', const Color(0xFFFFC629), MemberTheme.ink),
                      const SizedBox(width: 5),
                      _statusPill('✓  Active', MemberTheme.green, Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 2),
        ],
      ),
    );
  }
  Widget _paymentAndOffer({required bool compact}) {
    const member = MemberSample.demo;
    return Row(
      children: [
        Expanded(
          child: PulseGlow(
            glowColor: const Color(0xFFFF415D),
            child: DashboardPanel(
              color: const Color(0xFFFFF8FC),
              borderColor: const Color(0xFFF0B9D0),
              radius: 18,
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              child: Row(
                children: [
                  Container(
                    width: compact ? 34 : 39,
                    height: compact ? 34 : 39,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF5E6FF), Color(0xFFE6D2FF)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFDCC0F4)),
                    ),
                    child: const Icon(Icons.account_balance_wallet_rounded,
                      color: MemberTheme.purple, size: 23),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('PAYMENT DUE  ⚠', maxLines: 1,
                          style: TextStyle(color: MemberTheme.ink, fontSize: 8,
                            height: 1, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 1),
                        Text('${member.paymentDue} Due', maxLines: 1,
                          style: TextStyle(color: MemberTheme.rose,
                            fontSize: compact ? 14 : 17, height: 1,
                            fontWeight: FontWeight.w900)),
                        const SizedBox(height: 3),
                        Text('${member.daysRemaining} Days Left', maxLines: 1,
                          style: const TextStyle(color: MemberTheme.muted, fontSize: 7,
                            height: 1, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: DashboardPanel(
            color: const Color(0xFF6310AE),
            borderColor: const Color(0xFFE47AFF),
            radius: 18,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: compact ? 2 : 5),
            child: Row(
              children: [
                Image.asset(
                  'assets/member_card/03_whey_protein_tub.webp',
                  width: compact ? 34 : 43,
                  height: compact ? 34 : 44,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 3),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Whey Protein', maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: MemberTheme.gold, fontSize: compact ? 7 : 9,
                          fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
                      SizedBox(height: compact ? 1 : 2),
                      Text('25% OFF', maxLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: compact ? 13 : 15,
                          height: 1, fontWeight: FontWeight.w900)),
                      SizedBox(height: compact ? 1 : 4),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Color(0xFFFFE56A), Color(0xFFFFBA22)]),
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7, vertical: compact ? 1 : 2),
                          child: Text('Buy Now ›', maxLines: 1,
                            style: TextStyle(color: MemberTheme.ink, fontSize: compact ? 6 : 7,
                              height: 1, fontWeight: FontWeight.w900)),
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
    const member = MemberSample.demo;
    return DashboardPanel(
      color: const Color(0xFFF5EDFF),
      borderColor: const Color(0xFFD9B9F2),
      radius: 16,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: compact ? 2 : 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Membership ${member.membershipDays} / ${member.membershipTotalDays} Days',
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: MemberTheme.ink, fontSize: compact ? 10 : 13,
                    height: 1, fontWeight: FontWeight.w900)),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: compact ? 2 : 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFD71939),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFFA5B2)),
                ),
                child: Text('⚠ ${member.daysRemaining} Days Left', maxLines: 1,
                  style: TextStyle(color: Colors.white, fontSize: compact ? 6 : 8,
                    height: 1, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 5),
              Text('${(member.membershipProgress * 100).round()}%',
                style: TextStyle(color: MemberTheme.purple, fontSize: compact ? 15 : 19,
                  height: 1, fontWeight: FontWeight.w900)),
            ],
          ),
          SizedBox(height: compact ? 2 : 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: compact ? 8 : 11,
              width: double.infinity,
              child: Stack(fit: StackFit.expand, children: [
                const ColoredBox(color: Color(0xFFDCCDF0)),
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: member.membershipProgress.clamp(0.0, 1.0).toDouble(),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF9B38F0), Color(0xFF6712C9), Color(0xFFB75BFF)],
                      ),
                      boxShadow: [BoxShadow(color: Color(0x887E25D2), blurRadius: 7)],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
  Widget _metrics({required bool compact}) {
    const member = MemberSample.demo;
    return Row(
      children: [
        Expanded(child: DashboardMetricTile(
          label: 'ATTENDANCE',
          compact: compact, value: member.attendance,
          trend: '↑ +6%', valueColor: const Color(0xFF0A8742),
          note: 'Protein 10% OFF',
          color: const Color(0xFFFFE96A),
          asset: 'assets/member_card/28_protinex_tub.webp',
          noteColor: const Color(0xFFE52B52), noteTextColor: Colors.white)),
        const SizedBox(width: 4),
        Expanded(child: DashboardMetricTile(
          label: 'WORKOUT',
          compact: compact, value: member.workout, trend: '↑ +12%',
          note: 'Creatine 15% OFF', color: const Color(0xFFF2D7FF),
          asset: 'assets/member_card/06_creatine_tub.webp',
          noteColor: const Color(0xFFB20BE4), noteTextColor: Colors.white)),
        const SizedBox(width: 4),
        Expanded(child: DashboardMetricTile(
          label: 'PAYMENT',
          compact: compact, value: '${member.paymentDue} Due',
          note: 'Get 5% OFF  ›', valueColor: const Color(0xFFD71939),
          color: const Color(0xFFD9F1FF),
          asset: 'assets/member_card/29_sbi_payment_card_graphic.webp',
          noteColor: const Color(0xFF1269DB), noteTextColor: Colors.white)),
        const SizedBox(width: 4),
        Expanded(child: DashboardMetricTile(
          label: '▣ BODY',
          compact: compact, value: member.bodyWeight, trend: '↓ -0.8 kg',
          note: 'Fat Loss 20% OFF', color: const Color(0xFFD8FFE2),
          asset: 'assets/member_card/fat_loss_support_tub.png',
          noteColor: const Color(0xFF0B9C4C), noteTextColor: Colors.white)),
      ],
    );
  }
  Widget _statusPill(String label, Color color, Color foreground) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.lerp(color, Colors.white, 0.22)!, color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: Colors.white70, width: 0.8),
          boxShadow: const [BoxShadow(color: Color(0x668F4DFF), blurRadius: 4)],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(label, maxLines: 1,
            style: TextStyle(color: foreground, fontSize: 10,
              fontWeight: FontWeight.w900)),
        ),
      ),
    );
  }
}
