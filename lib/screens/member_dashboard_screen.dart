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
            final compact = bounds.maxHeight < 660;
            final railWidth = bounds.maxWidth < 350 ? 43.0 : 49.0;
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(width: railWidth, child: _navigationRail()),
                  const SizedBox(width: 4),
                  Expanded(child: _dashboardContent(compact: compact)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _navigationRail() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
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
                  margin: const EdgeInsets.symmetric(vertical: 2),
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
                    children: [
                      Icon(_navigation[i].$1,
                        color: _selectedNavigation == i ? MemberTheme.ink : Colors.white,
                        size: 19),
                      const SizedBox(height: 2),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(_navigation[i].$2,
                          maxLines: 1,
                          style: TextStyle(
                            color: _selectedNavigation == i ? MemberTheme.ink : Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                          )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _dashboardContent({required bool compact}) {
    final topHeight = compact ? 43.0 : 49.0;
    final identityHeight = compact ? 72.0 : 82.0;
    final offerHeight = compact ? 53.0 : 59.0;
    final progressHeight = compact ? 41.0 : 46.0;
    final metricsHeight = compact ? 99.0 : 111.0;
    return Column(
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
        const SizedBox(height: 4),
        const Expanded(child: AttendancePanel()),
      ],
    );
  }

  Widget _topActions() {
    return Row(
      children: [
        Expanded(
          child: DashboardPanel(
            borderColor: MemberTheme.gold,
            radius: 15,
            child: InkWell(
              key: const ValueKey('check-in-button'),
              borderRadius: BorderRadius.circular(15),
              onTap: () => setState(() => _checkedIn = true),
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: MemberTheme.green,
                    child: Icon(Icons.check, color: Colors.white, size: 21),
                  ),
                  const SizedBox(width: 5),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CHECK-IN', maxLines: 1,
                          style: TextStyle(color: Colors.white, fontSize: 11,
                            height: 1, fontWeight: FontWeight.w900)),
                        SizedBox(height: 3),
                        Text('07:12 AM', maxLines: 1,
                          style: TextStyle(color: Colors.white, fontSize: 9,
                            height: 1, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  Image.asset('assets/member_card/01_member_bodybuilder.webp',
                    width: 34, height: 36, fit: BoxFit.contain),
                  const SizedBox(width: 2),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: DashboardPanel(
            color: const Color(0xFFF8F3FF),
            borderColor: const Color(0xFFB5A7FF),
            radius: 15,
            child: Row(
              children: [
                const SizedBox(width: 4),
                Image.asset('assets/member_card/23_freeze_snowflake_graphic.webp',
                  width: 27, height: 29, fit: BoxFit.contain),
                const SizedBox(width: 3),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('FREEZE', maxLines: 1,
                        style: TextStyle(color: MemberTheme.ink, fontSize: 14,
                          height: 1, fontWeight: FontWeight.w900)),
                      Text('Stay Cool • Pause Plan', maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: MemberTheme.ink, fontSize: 7,
                          fontWeight: FontWeight.w700)),
                      Text('UP TO 20% OFF', maxLines: 1,
                        style: TextStyle(color: Color(0xFFD20F45), fontSize: 8,
                          fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
                const SizedBox(width: 2),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _memberIdentity({required bool compact}) {
    const member = MemberSample.demo;
    final portrait = compact ? 60.0 : 68.0;
    return DashboardPanel(
      borderColor: MemberTheme.gold,
      radius: 18,
      child: Row(
        children: [
          Container(
            width: portrait,
            height: portrait,
            margin: const EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD76B),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MemberTheme.gold, width: 1.5),
              boxShadow: const [BoxShadow(color: Color(0xAAFFCA3A), blurRadius: 7)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.asset('assets/member_card/01_member_bodybuilder.webp',
                fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(member.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white,
                      fontSize: compact ? 13 : 15, height: 1,
                      fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  Text('▦ ${member.memberId}  •  ${member.age} Yrs  •  ♂ ${member.gender}',
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 8,
                      height: 1, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      _statusPill('♙ ${member.plan}', const Color(0xFFFFC629), MemberTheme.ink),
                      const SizedBox(width: 4),
                      _statusPill('✓ Active', MemberTheme.green, Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }

  Widget _paymentAndOffer({required bool compact}) {
    const member = MemberSample.demo;
    return Row(
      children: [
        Expanded(
          child: DashboardPanel(
            color: const Color(0xFFB80928),
            borderColor: const Color(0xFFFF5368),
            radius: 15,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Row(
              children: [
                Icon(Icons.account_balance_wallet_rounded,
                  color: Colors.white, size: compact ? 23 : 26),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('PAYMENT DUE  ⚠', maxLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: 8,
                          fontWeight: FontWeight.w900)),
                      Text('${member.paymentDue} Due', maxLines: 1,
                        style: TextStyle(color: Colors.white,
                          fontSize: compact ? 14 : 16, fontWeight: FontWeight.w900)),
                      Text('${member.daysRemaining} Days Left', maxLines: 1,
                        style: const TextStyle(color: Colors.white, fontSize: 7,
                          fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: DashboardPanel(
            color: const Color(0xFF6D1AA8),
            borderColor: const Color(0xFFE77CFF),
            radius: 15,
            child: Row(
              children: [
                const SizedBox(width: 2),
                Image.asset('assets/member_card/03_whey_protein_tub.webp',
                  width: compact ? 34 : 39, height: 46, fit: BoxFit.contain),
                const SizedBox(width: 2),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Whey Protein', maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: MemberTheme.gold, fontSize: 9,
                          fontWeight: FontWeight.w900)),
                      Text('25% OFF', maxLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: 15,
                          fontWeight: FontWeight.w900)),
                      Text('Buy Now  ›', maxLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: 7,
                          fontWeight: FontWeight.w800)),
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
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Membership ${member.membershipDays} / ${member.membershipTotalDays} Days',
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 10,
                    fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 3),
              Text('⚠ ${member.daysRemaining} Days Left', maxLines: 1,
                style: const TextStyle(color: Colors.white, fontSize: 7,
                  fontWeight: FontWeight.w900)),
              const SizedBox(width: 3),
              Text('${(member.membershipProgress * 100).round()}%',
                style: const TextStyle(color: Colors.white, fontSize: 13,
                  fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: member.membershipProgress.clamp(0.0, 1.0).toDouble(),
              minHeight: 7,
              backgroundColor: const Color(0xFFE7D9FF),
              valueColor: const AlwaysStoppedAnimation<Color>(MemberTheme.green),
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
          note: 'Protein 10% OFF', color: const Color(0xFFFFE96A),
          asset: 'assets/member_card/01_member_bodybuilder.webp')),
        const SizedBox(width: 3),
        Expanded(child: DashboardMetricTile(
          label: 'WORKOUT', value: member.workout, note: 'Creatine 15% OFF',
          color: const Color(0xFFF2D7FF),
          asset: 'assets/member_card/06_creatine_tub.webp')),
        const SizedBox(width: 3),
        Expanded(child: DashboardMetricTile(
          label: 'PAYMENT', value: '${member.paymentDue} Due', note: 'Get 5% OFF',
          color: const Color(0xFFD9F1FF),
          asset: 'assets/member_card/29_sbi_payment_card_graphic.webp')),
        const SizedBox(width: 3),
        Expanded(child: DashboardMetricTile(
          label: '▣ BODY', value: member.bodyWeight, note: 'Fat Loss 20% OFF',
          color: const Color(0xFFD8FFE2),
          asset: 'assets/member_card/27_dumbbell_promo_graphic.webp')),
      ],
    );
  }

  Widget _statusPill(String label, Color color, Color foreground) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: Colors.white70, width: 0.8),
          boxShadow: const [BoxShadow(color: Color(0x668F4DFF), blurRadius: 4)],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(label, maxLines: 1,
            style: TextStyle(color: foreground, fontSize: 9,
              fontWeight: FontWeight.w900)),
        ),
      ),
    );
  }
}
