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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MemberTheme.canvas,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              margin: const EdgeInsets.fromLTRB(5, 5, 5, 6),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B0878), Color(0xFF6416B8), Color(0xFF26004F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: MemberTheme.gold, width: 2),
                boxShadow: const [
                  BoxShadow(color: Color(0xCCB12CFF), blurRadius: 22, spreadRadius: 2),
                  BoxShadow(color: Color(0x887A38FF), blurRadius: 8),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: constraints.maxWidth < 370 ? 48 : 56,
                    child: _navigationRail(),
                  ),
                  const SizedBox(width: 5),
                  Expanded(child: _dashboardContent()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _navigationRail() {
    const items = [
      (Icons.calendar_month_rounded, 'Attend'),
      (Icons.trending_up_rounded, 'Insights'),
      (Icons.date_range_rounded, 'Cal'),
      (Icons.history_rounded, 'History'),
      (Icons.show_chart_rounded, 'Trend'),
      (Icons.emoji_events_rounded, 'Goals'),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 3),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4B087F), Color(0xFF280052)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: MemberTheme.gold, width: 1.2),
        boxShadow: const [BoxShadow(color: Color(0x887F25FF), blurRadius: 9)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var i = 0; i < items.length; i++)
            Expanded(
              child: InkWell(
                key: ValueKey('navigation-${items[i].$2.toLowerCase()}'),
                borderRadius: BorderRadius.circular(13),
                onTap: () => setState(() => _selectedNavigation = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                  decoration: BoxDecoration(
                    color: _selectedNavigation == i
                        ? const Color(0xFFFFE77A)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(13),
                    border: _selectedNavigation == i
                        ? Border.all(color: Colors.white, width: 1)
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(items[i].$1,
                        color: _selectedNavigation == i ? MemberTheme.ink : Colors.white,
                        size: 21),
                      const SizedBox(height: 3),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(items[i].$2,
                          maxLines: 1,
                          style: TextStyle(
                            color: _selectedNavigation == i ? MemberTheme.ink : Colors.white,
                            fontSize: 9,
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

  Widget _dashboardContent() {
    return Column(
      children: [
        SizedBox(height: 50, child: _topActions()),
        const SizedBox(height: 5),
        SizedBox(height: 84, child: _memberIdentity()),
        const SizedBox(height: 5),
        SizedBox(height: 60, child: _paymentAndOffer()),
        const SizedBox(height: 5),
        SizedBox(height: 47, child: _membershipProgress()),
        const SizedBox(height: 5),
        SizedBox(height: 112, child: _metrics()),
        const SizedBox(height: 5),
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
                    radius: 16,
                    backgroundColor: MemberTheme.green,
                    child: Icon(Icons.check, color: Colors.white, size: 21),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_checkedIn ? 'CHECK-IN' : 'CHECK IN',
                          maxLines: 1,
                          style: const TextStyle(color: Colors.white, fontSize: 12,
                            height: 1, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 3),
                        const Text('07:12 AM', maxLines: 1,
                          style: TextStyle(color: Colors.white, fontSize: 10,
                            height: 1, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  Image.asset('assets/member_card/01_member_bodybuilder.webp',
                    width: 38, height: 39, fit: BoxFit.contain),
                  const SizedBox(width: 3),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: DashboardPanel(
            color: const Color(0xFFF8F3FF),
            borderColor: const Color(0xFFB5A7FF),
            radius: 15,
            child: Row(
              children: [
                const SizedBox(width: 5),
                Image.asset('assets/member_card/23_freeze_snowflake_graphic.webp',
                  width: 29, height: 32, fit: BoxFit.contain),
                const SizedBox(width: 3),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('FREEZE', maxLines: 1, style: TextStyle(
                        color: MemberTheme.ink, fontSize: 15, fontWeight: FontWeight.w900)),
                      Text('Stay Cool • Pause Plan', maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: MemberTheme.ink, fontSize: 8, fontWeight: FontWeight.w700)),
                      Text('UP TO 20% OFF', maxLines: 1, style: TextStyle(
                        color: Color(0xFFD20F45), fontSize: 9, fontWeight: FontWeight.w900)),
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

  Widget _memberIdentity() {
    const member = MemberSample.demo;
    return DashboardPanel(
      borderColor: MemberTheme.gold,
      radius: 19,
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            margin: const EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD76B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: MemberTheme.gold, width: 1.5),
              boxShadow: const [BoxShadow(color: Color(0xAAFFCA3A), blurRadius: 8)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset('assets/member_card/01_member_bodybuilder.webp',
                fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(member.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 16,
                      height: 1, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 5),
                  Text('▦ ${member.memberId}  •  ♟ ${member.age} Yrs  •  ♂ ${member.gender}',
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 9,
                      height: 1, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _statusPill('♙ ${member.plan}', const Color(0xFFFFC629), MemberTheme.ink),
                      const SizedBox(width: 5),
                      _statusPill('✓ Active', MemberTheme.green, Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  Widget _paymentAndOffer() {
    const member = MemberSample.demo;
    return Row(
      children: [
        Expanded(
          child: DashboardPanel(
            color: const Color(0xFFB80928),
            borderColor: const Color(0xFFFF5368),
            radius: 16,
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            child: Row(
              children: [
                const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 27),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('PAYMENT DUE  ⚠', maxLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900)),
                      Text('${member.paymentDue} Due', maxLines: 1,
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
                      Text('${member.daysRemaining} Days Left', maxLines: 1,
                        style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: DashboardPanel(
            color: const Color(0xFF6D1AA8),
            borderColor: const Color(0xFFE77CFF),
            radius: 16,
            child: Row(
              children: [
                const SizedBox(width: 3),
                Image.asset('assets/member_card/03_whey_protein_tub.webp',
                  width: 39, height: 50, fit: BoxFit.contain),
                const SizedBox(width: 3),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Whey Protein', maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: MemberTheme.gold, fontSize: 10, fontWeight: FontWeight.w900)),
                      Text('25% OFF', maxLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
                      Text('Buy Now  ›', maxLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800)),
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
      radius: 15,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Membership ${member.membershipDays} / ${member.membershipTotalDays} Days',
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 3),
              Text('⚠ ${member.daysRemaining} Days Left', maxLines: 1,
                style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900)),
              const SizedBox(width: 4),
              Text('${(member.membershipProgress * 100).round()}%',
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: member.membershipProgress.clamp(0.0, 1.0).toDouble(),
              minHeight: 8,
              backgroundColor: const Color(0xFFE7D9FF),
              valueColor: const AlwaysStoppedAnimation<Color>(MemberTheme.green),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metrics() {
    const member = MemberSample.demo;
    return Row(
      children: [
        Expanded(child: DashboardMetricTile(
          label: 'ATTENDA. +6%', value: member.attendance, note: 'Protein 10% OFF',
          color: const Color(0xFFFFE96A),
          asset: 'assets/member_card/01_member_bodybuilder.webp')),
        const SizedBox(width: 4),
        Expanded(child: DashboardMetricTile(
          label: 'WORKOUT', value: member.workout, note: 'Creatine 15% OFF',
          color: const Color(0xFFF2D7FF),
          asset: 'assets/member_card/06_creatine_tub.webp')),
        const SizedBox(width: 4),
        Expanded(child: DashboardMetricTile(
          label: 'PAYMENT', value: '${member.paymentDue} Due', note: 'Get 5% OFF',
          color: const Color(0xFFD9F1FF),
          asset: 'assets/member_card/29_sbi_payment_card_graphic.webp')),
        const SizedBox(width: 4),
        Expanded(child: DashboardMetricTile(
          label: 'BODY', value: member.bodyWeight, note: 'Fat Loss 20% OFF',
          color: const Color(0xFFD8FFE2),
          asset: 'assets/member_card/27_dumbbell_promo_graphic.webp')),
      ],
    );
  }

  Widget _statusPill(String label, Color color, Color foreground) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white70, width: 0.8),
          boxShadow: const [BoxShadow(color: Color(0x668F4DFF), blurRadius: 5)],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(label, maxLines: 1,
            style: TextStyle(color: foreground, fontSize: 10, fontWeight: FontWeight.w900)),
        ),
      ),
    );
  }
}
