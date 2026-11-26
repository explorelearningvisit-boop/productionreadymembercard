import 'package:flutter/material.dart';

import '../data/sample_member.dart';
import '../theme/member_theme.dart';
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
    return Scaffold(
      backgroundColor: MemberTheme.canvas,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, bounds) {
            final compact = bounds.maxHeight < 760;
            final railWidth = bounds.maxWidth < 350 ? 48.0 : 52.0;
            return Container(
              margin: const EdgeInsets.fromLTRB(5, 4, 5, 5),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF25004D), Color(0xFF6415B4), Color(0xFF26004F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(27),
                border: Border.all(color: MemberTheme.gold, width: 2),
                boxShadow: const [
                  BoxShadow(color: Color(0xCCB12CFF), blurRadius: 20, spreadRadius: 1),
                  BoxShadow(color: Color(0x887A38FF), blurRadius: 7),
                ],
              ),
              child: Column(
                children: [
                  _dashboardTop(compact: compact),
                  const SizedBox(height: 5),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, contentBounds) {
                        // Keep the approved compact card proportions; scale down
                        // only when the available phone height is smaller.
                        final contentHeight = contentBounds.maxHeight;
                        return Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
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
                                const SizedBox(width: 3),
                                const Expanded(
                                  child: AttendancePanel(),
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
            );
          },
        ),
      ),
    );
  }

  Widget _navigationRail() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemHeight = constraints.maxHeight / _navigation.length;
        final iconSize = (itemHeight * 0.36).clamp(15.0, 20.0);
        final labelSize = (itemHeight * 0.18).clamp(8.0, 9.5);
        const verticalMargin = 0.5;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4B087F), Color(0xFF280052)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: MemberTheme.gold, width: 1.2),
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
                      duration: const Duration(milliseconds: 160),
                      margin: EdgeInsets.symmetric(vertical: verticalMargin),
                      decoration: BoxDecoration(
                        color: _selectedNavigation == i
                            ? const Color(0xFFFFE77A)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(11),
                        border: _selectedNavigation == i
                            ? Border.all(color: Colors.white, width: 1)
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
                          SizedBox(height: itemHeight < 34 ? 0 : 1),
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
                                height: 1,
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

  Widget _dashboardTop({required bool compact}) {
    final topHeight = compact ? 48.0 : 58.0;
    final identityHeight = compact ? 84.0 : 94.0;
    final offerHeight = compact ? 48.0 : 65.0;
    final progressHeight = compact ? 44.0 : 51.0;
    final metricsHeight = compact ? 104.0 : 140.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: topHeight, child: _topActions()),
        const SizedBox(height: 4),
        SizedBox(height: identityHeight, child: _memberIdentity(compact: compact)),
        const SizedBox(height: 4),
        SizedBox(height: offerHeight, child: _paymentAndOffer(compact: compact)),
        const SizedBox(height: 4),
        SizedBox(height: progressHeight, child: _membershipProgress()),
        const SizedBox(height: 4),
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
                border: Border.all(color: MemberTheme.gold, width: 1.5),
                boxShadow: const [
                  BoxShadow(color: Color(0xAAAD4BFF), blurRadius: 9, spreadRadius: 0.5),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 31,
                    height: 31,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0AD66B),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Color(0x8847FF9B), blurRadius: 7)],
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
                    'reference_library/recovered_from_history/assets/material_pack/pulsevault/10_member_bodybuilder_cutout.png',
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
                colors: [Color(0xFFF9F5FF), Color(0xFFE6D7FF), Color(0xFFFDFBFF)],
              ),
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: const Color(0xFFE5BFFF), width: 1.5),
              boxShadow: const [
                BoxShadow(color: Color(0x887E30D7), blurRadius: 8),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.ac_unit_rounded, color: Color(0xFF5526D5), size: 27),
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
                  'reference_library/recovered_from_history/assets/material_pack/pulsevault/08_purple_shaker_bottle_cutout.png',
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
  Widget _memberIdentity({required bool compact}) {
    const member = MemberSample.demo;
    final portrait = compact ? 72.0 : 80.0;
    return DashboardPanel(
      borderColor: MemberTheme.gold,
      radius: 20,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
      child: Row(
        children: [
          Container(
            width: portrait,
            height: portrait,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFEA91), Color(0xFFFFB51D), Color(0xFFFFF3B9)],
              ),
              borderRadius: BorderRadius.circular(19),
              border: Border.all(color: MemberTheme.gold, width: 1.8),
              boxShadow: const [BoxShadow(color: Color(0xAAFFCA3A), blurRadius: 8)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: Image.asset(
                'reference_library/recovered_from_history/assets/material_pack/pulsevault/10_member_bodybuilder_cutout.png',
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
                    style: TextStyle(color: Colors.white,
                      fontSize: compact ? 17 : 20, height: 1,
                      fontWeight: FontWeight.w900)),
                  const SizedBox(height: 6),
                  Text('▦  ${member.memberId}  |  ${member.age} Yrs  |  ♂ ${member.gender}',
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: compact ? 9 : 10,
                      height: 1, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 7),
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
              color: const Color(0xFFB80928),
              borderColor: const Color(0xFFFF7184),
              radius: 18,
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              child: Row(
                children: [
                  Container(
                    width: compact ? 34 : 39,
                    height: compact ? 34 : 39,
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.account_balance_wallet_rounded,
                      color: Color(0xFFE51B43), size: 23),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('PAYMENT DUE  ⚠', maxLines: 1,
                          style: TextStyle(color: Colors.white, fontSize: 8,
                            height: 1, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 1),
                        Text('${member.paymentDue} Due', maxLines: 1,
                          style: TextStyle(color: Colors.white,
                            fontSize: compact ? 14 : 17, height: 1,
                            fontWeight: FontWeight.w900)),
                        const SizedBox(height: 3),
                        Text('${member.daysRemaining} Days Left', maxLines: 1,
                          style: const TextStyle(color: Colors.white, fontSize: 7,
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
            color: const Color(0xFF6D1AA8),
            borderColor: const Color(0xFFE77CFF),
            radius: 18,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: compact ? 2 : 5),
            child: Row(
              children: [
                Image.asset(
                  'reference_library/recovered_from_history/assets/material_pack/pulsevault/01_whey_protein_tub_cutout.png',
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
                          gradient: LinearGradient(colors: [Color(0xFFFF53B5), Color(0xFFD20A85)]),
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7, vertical: compact ? 1 : 2),
                          child: Text('Buy Now ›', maxLines: 1,
                            style: TextStyle(color: Colors.white, fontSize: compact ? 6 : 7,
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
  Widget _membershipProgress() {
    const member = MemberSample.demo;
    return DashboardPanel(
      color: const Color(0xFF39116D),
      borderColor: const Color(0xFFE4C5FF),
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
                  style: TextStyle(color: Colors.white, fontSize: compact ? 10 : 13,
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
                style: TextStyle(color: Colors.white, fontSize: compact ? 15 : 19,
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
                        colors: [Color(0xFF19E65E), Color(0xFF00B84E), Color(0xFF45FA82)],
                      ),
                      boxShadow: [BoxShadow(color: Color(0xAA00FF68), blurRadius: 7)],
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
          label: '▦ ATTENDA. +6%', value: member.attendance,
          note: 'Protein 10% OFF',
          color: const Color(0xFFFFE96A),
          asset: 'reference_library/recovered_from_history/assets/material_pack/pulsevault/10_member_bodybuilder_cutout.png')),
        const SizedBox(width: 4),
        Expanded(child: DashboardMetricTile(
          label: 'WORKOUT', value: member.workout, trend: '↑ +12%',
          note: 'Creatine 15% OFF', color: const Color(0xFFF2D7FF),
          asset: 'reference_library/recovered_from_history/assets/material_pack/pulsevault/07_creatine_monohydrate_tub_cutout.png')),
        const SizedBox(width: 4),
        Expanded(child: DashboardMetricTile(
          label: 'PAYMENT', value: '${member.paymentDue} Due',
          note: 'Get 5% OFF  ›', valueColor: const Color(0xFFD71939),
          color: const Color(0xFFD9F1FF),
          asset: 'reference_library/recovered_from_history/assets/material_pack/pulsevault/11_sbi_payment_card_cutout.png')),
        const SizedBox(width: 4),
        Expanded(child: DashboardMetricTile(
          label: '▣ BODY', value: member.bodyWeight, trend: '↓ -0.8 kg',
          note: 'Fat Loss 20% OFF', color: const Color(0xFFD8FFE2),
          asset: 'reference_library/recovered_from_history/assets/material_pack/pulsevault/04_fat_loss_support_tub_cutout.png')),
      ],
    );
  }
  Widget _statusPill(String label, Color color, Color foreground) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        decoration: BoxDecoration(
          color: color,
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
