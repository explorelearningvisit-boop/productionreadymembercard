import 'package:flutter/material.dart';

import '../data/sample_member.dart';
import '../theme/member_theme.dart';

class MemberDashboardScreen extends StatefulWidget {
  const MemberDashboardScreen({super.key});

  @override
  State<MemberDashboardScreen> createState() => _MemberDashboardScreenState();
}

class _MemberDashboardScreenState extends State<MemberDashboardScreen> {
  bool _checkedIn = true;

  static const _purple = Color(0xFF26004F);
  static const _violet = Color(0xFF6416B8);
  static const _gold = Color(0xFFFFD34E);
  static const _green = Color(0xFF12D56A);
  static const _ink = Color(0xFF250B46);

  void _checkIn() {
    if (_checkedIn) return;
    setState(() => _checkedIn = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _purple,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: 360,
                  height: 640,
                  child: _dashboardCard(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _dashboardCard() {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2C075B), Color(0xFF4A0B86), Color(0xFF230044)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(27),
        border: Border.all(color: _gold, width: 2),
        boxShadow: const [
          BoxShadow(color: Color(0xAA9A32FF), blurRadius: 18, spreadRadius: 2),
          BoxShadow(color: Color(0x887A38FF), blurRadius: 5),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 38, child: _topActions()),
          const SizedBox(height: 5),
          SizedBox(height: 72, child: _memberIdentity()),
          const SizedBox(height: 5),
          SizedBox(height: 54, child: _paymentAndOffer()),
          const SizedBox(height: 5),
          SizedBox(height: 42, child: _membershipProgress()),
          const SizedBox(height: 5),
          SizedBox(height: 88, child: _metricTiles()),
          const SizedBox(height: 5),
          Expanded(child: _attendancePanel()),
        ],
      ),
    );
  }

  Widget _topActions() {
    return Row(
      children: [
        Expanded(
          child: _glassPanel(
            radius: 14,
            border: _gold,
            child: Row(
              children: [
                const SizedBox(width: 7),
                Container(
                  width: 27,
                  height: 27,
                  decoration: const BoxDecoration(
                    color: _green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: GestureDetector(
                    key: const ValueKey('check-in-button'),
                    behavior: HitTestBehavior.opaque,
                    onTap: _checkIn,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _checkedIn ? 'CHECK-IN' : 'CHECK IN',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text(
                          '07:12 AM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Image.asset(
                  'assets/member_card/01_member_bodybuilder.webp',
                  width: 37,
                  height: 34,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: _glassPanel(
            radius: 14,
            border: const Color(0xFFB5A7FF),
            fill: const Color(0xFFF8F3FF),
            child: Row(
              children: [
                const SizedBox(width: 7),
                Image.asset(
                  'assets/member_card/23_freeze_snowflake_graphic.webp',
                  width: 27,
                  height: 29,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 4),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('FREEZE', style: TextStyle(color: _ink, fontSize: 14, fontWeight: FontWeight.w900)),
                      Text('Stay Cool • Pause Plan', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: _ink, fontSize: 8, fontWeight: FontWeight.w700)),
                      Text('UP TO 20% OFF', style: TextStyle(color: Color(0xFFD20F45), fontSize: 8, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _memberIdentity() {
    return _glassPanel(
      radius: 18,
      border: _gold,
      child: Row(
        children: [
          Container(
            width: 65,
            height: 62,
            margin: const EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD76B),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: _gold, width: 1.5),
              boxShadow: const [BoxShadow(color: Color(0x99FFB900), blurRadius: 8)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.asset(
                'assets/member_card/01_member_bodybuilder.webp',
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    MemberSample.name,
                    maxLines: 1,
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '▦ BG215  •  ♟ 28 Yrs  •  ♂ Male',
                  maxLines: 1,
                  style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    _statusPill('✪ Gold Plan', const Color(0xFFFFC629), _ink),
                    const SizedBox(width: 5),
                    _statusPill('✓ Active', _green, Colors.white),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  Widget _paymentAndOffer() {
    return Row(
      children: [
        Expanded(
          child: _glassPanel(
            radius: 15,
            border: const Color(0xFFFF5368),
            fill: const Color(0xFFB80928),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.account_balance_wallet, color: Colors.white, size: 24),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PAYMENT DUE  ⚠', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900)),
                        Text('₹500 Due', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w900)),
                        Text('8 Days Left', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: _glassPanel(
            radius: 15,
            border: const Color(0xFFE77CFF),
            fill: const Color(0xFF6D1AA8),
            child: Row(
              children: [
                const SizedBox(width: 4),
                Image.asset('assets/member_card/03_whey_protein_tub.webp', width: 38, height: 45, fit: BoxFit.contain),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Whey Protein', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: _gold, fontSize: 10, fontWeight: FontWeight.w900)),
                      Text('25% OFF', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900)),
                      Text('Buy Now  ›', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800)),
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
    return _glassPanel(
      radius: 14,
      border: const Color(0xFFE4C5FF),
      fill: const Color(0xFF39116D),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text('Membership 22 / 30 Days', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(color: const Color(0xFFE21E38), borderRadius: BorderRadius.circular(12)),
                  child: const Text('⚠ 8 Days Left', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900)),
                ),
                const SizedBox(width: 6),
                const Text('73%', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const LinearProgressIndicator(
                value: 22 / 30,
                minHeight: 9,
                backgroundColor: Color(0xFFE7D9FF),
                valueColor: AlwaysStoppedAnimation<Color>(_green),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _metricTiles() {
    return Row(
      children: [
        Expanded(child: _metricTile('ATTEND.', '81%', '+6%', const Color(0xFFFFE96A), 'assets/member_card/01_member_bodybuilder.webp')),
        const SizedBox(width: 4),
        Expanded(child: _metricTile('WORKOUT', '58 min', '↑12%', const Color(0xFFF2D7FF), 'assets/member_card/06_creatine_tub.webp')),
        const SizedBox(width: 4),
        Expanded(child: _metricTile('PAYMENT', '₹500', 'SBI • 5% OFF', const Color(0xFFD9F1FF), 'assets/member_card/29_sbi_payment_card_graphic.webp')),
        const SizedBox(width: 4),
        Expanded(child: _metricTile('BODY', '69.5 kg', '↓0.8 kg', const Color(0xFFD8FFE2), 'assets/member_card/27_dumbbell_promo_graphic.webp')),
      ],
    );
  }

  Widget _metricTile(String label, String value, String note, Color color, String image) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.white, width: 1.2),
        boxShadow: const [BoxShadow(color: Color(0x887C31FF), blurRadius: 5)],
      ),
      padding: const EdgeInsets.fromLTRB(4, 5, 4, 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, maxLines: 1, style: const TextStyle(color: _ink, fontSize: 8, fontWeight: FontWeight.w900)),
          FittedBox(fit: BoxFit.scaleDown, child: Text(value, style: const TextStyle(color: _ink, fontSize: 17, fontWeight: FontWeight.w900))),
          Text(note, maxLines: 1, style: const TextStyle(color: _ink, fontSize: 8, fontWeight: FontWeight.w800)),
          Expanded(child: Image.asset(image, fit: BoxFit.contain, filterQuality: FilterQuality.medium)),
        ],
      ),
    );
  }

  Widget _attendancePanel() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFFCFF), Color(0xFFEAD9FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFEBCFFF), width: 1.5),
        boxShadow: const [BoxShadow(color: Color(0xAA9B4CFF), blurRadius: 8)],
      ),
      padding: const EdgeInsets.fromLTRB(7, 5, 7, 4),
      child: Column(
        children: [
          SizedBox(
            height: 20,
            child: Row(
              children: [
                const Icon(Icons.show_chart, color: Color(0xFF7B26C8), size: 17),
                const SizedBox(width: 4),
                const Expanded(child: Text('Attendance Analytics', style: TextStyle(color: _ink, fontSize: 12, fontWeight: FontWeight.w900))),
                const Icon(Icons.notifications_active, color: Color(0xFF7B26C8), size: 15),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(color: const Color(0xFFFFE5E8), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.redAccent)),
                  child: const Text('● LIVE', style: TextStyle(color: Colors.red, fontSize: 8, fontWeight: FontWeight.w900)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 3),
          _partnerBanner(),
          const SizedBox(height: 4),
          SizedBox(
            height: 69,
            child: Row(
              children: [
                SizedBox(
                  width: 76,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 65,
                        height: 65,
                        child: CircularProgressIndicator(
                          value: 0.81,
                          strokeWidth: 9,
                          backgroundColor: const Color(0xFFE3D5F2),
                          valueColor: const AlwaysStoppedAnimation<Color>(_green),
                        ),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('81%', style: TextStyle(color: _ink, fontSize: 18, fontWeight: FontWeight.w900)),
                          Text('25/31', style: TextStyle(color: _ink, fontSize: 8, fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _AttendanceLegend(color: Color(0xFF0CCB60), label: 'Present', count: '23', percent: '74%'),
                      _AttendanceLegend(color: Color(0xFFE52B52), label: 'Absent', count: '2', percent: '6%'),
                      _AttendanceLegend(color: Color(0xFF8A35D5), label: 'Holiday', count: '4', percent: '13%'),
                      _AttendanceLegend(color: Color(0xFFFFB21C), label: 'Late', count: '2', percent: '6%'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          const Row(
            children: [
              Expanded(child: _MiniStat(icon: '🔥', value: '5d')),
              Expanded(child: _MiniStat(icon: '🏆', value: '14d')),
              Expanded(child: _MiniStat(icon: '↗', value: '+6%')),
            ],
          ),
          const SizedBox(height: 3),
          _recoveryBanner(),
          const SizedBox(height: 3),
          SizedBox(
            height: 17,
            child: Row(
              children: [
                const Expanded(child: Text('October attendance', style: TextStyle(color: _ink, fontSize: 12, fontWeight: FontWeight.w900))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: _violet, borderRadius: BorderRadius.circular(12)),
                  child: const Text('🏋 Train More  •  15% OFF', style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.w900)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          const Row(
            children: [
              _Weekday('Mon'), _Weekday('Tue'), _Weekday('Wed'), _Weekday('Thu'),
              _Weekday('Fri'), _Weekday('Sat'), _Weekday('Sun'),
            ],
          ),
          const SizedBox(height: 2),
          const Row(
            children: [
              _DayCell('13', Color(0xFFD7F8DF)),
              _DayCell('14', Color(0xFFD7F8DF)),
              _DayCell('15', Color(0xFFD7F8DF)),
              _DayCell('16', Color(0xFFE7D8FF), selected: true),
              _DayCell('17', Color(0xFFFFDDE2)),
              _DayCell('18', Color(0xFFE5E2E9), off: true),
              _DayCell('19', Color(0xFFD7F8DF)),
            ],
          ),
          const SizedBox(height: 2),
          const Row(
            children: [
              _DayCell('20', Color(0xFFD7F8DF)),
              _DayCell('21', Color(0xFFFFEDC7)),
              _DayCell('22', Color(0xFFD7F8DF)),
              _DayCell('23', Color(0xFFFFDDE2)),
              _DayCell('24', Color(0xFFD7F8DF)),
              _DayCell('25', Color(0xFFE5E2E9), off: true),
              _DayCell('', Colors.transparent),
            ],
          ),
          const Spacer(),
          const Text('Sample data • API connection required for live records', style: TextStyle(color: Color(0xFF766B80), fontSize: 7, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _partnerBanner() {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFF3C7), Color(0xFFF4D9FF)]),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD8B3F3)),
      ),
      child: Row(
        children: [
          Image.asset('assets/member_card/05_blinkit_grocery_bag.webp', width: 34, height: 24, fit: BoxFit.contain),
          const SizedBox(width: 5),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Healthy Snacks & Gym Essentials', maxLines: 1, style: TextStyle(color: _ink, fontSize: 9, fontWeight: FontWeight.w900)),
                Text('Member partner offer • Up to 30% OFF', maxLines: 1, style: TextStyle(color: Color(0xFF6E258F), fontSize: 7, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: _ink, size: 17),
        ],
      ),
    );
  }

  Widget _recoveryBanner() {
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFF9E9FF), Color(0xFFE5C4FF)]),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD1A1F4)),
      ),
      child: Row(
        children: [
          Image.asset('assets/member_card/03_whey_protein_tub.webp', width: 22, height: 22, fit: BoxFit.contain),
          const SizedBox(width: 5),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Recovery Combo', style: TextStyle(color: _ink, fontSize: 9, fontWeight: FontWeight.w900)),
                Text('Up to 30% OFF', style: TextStyle(color: Color(0xFFC31C40), fontSize: 8, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: _ink, size: 17),
        ],
      ),
    );
  }

  Widget _glassPanel({
    required Widget child,
    double radius = 12,
    Color border = const Color(0xFFB56AFF),
    Color fill = const Color(0xFF431078),
  }) {
    return Container(
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: border, width: 1.3),
        boxShadow: const [BoxShadow(color: Color(0x887D26D9), blurRadius: 5)],
      ),
      child: child,
    );
  }

  Widget _statusPill(String label, Color background, Color foreground) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: Colors.white70, width: 0.7),
          boxShadow: const [BoxShadow(color: Color(0x667A29FF), blurRadius: 4)],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(label, style: TextStyle(color: foreground, fontSize: 10, fontWeight: FontWeight.w900)),
        ),
      ),
    );
  }
}

class _AttendanceLegend extends StatelessWidget {
  const _AttendanceLegend({required this.color, required this.label, required this.count, required this.percent});
  final Color color;
  final String label;
  final String count;
  final String percent;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 4),
          SizedBox(width: 48, child: Text(label, style: const TextStyle(color: Color(0xFF28113F), fontSize: 9, fontWeight: FontWeight.w800))),
          SizedBox(width: 19, child: Text(count, textAlign: TextAlign.end, style: const TextStyle(color: Color(0xFF28113F), fontSize: 9, fontWeight: FontWeight.w900))),
          const SizedBox(width: 5),
          Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: double.parse(percent.replaceAll('%', '')) / 100, minHeight: 7, backgroundColor: const Color(0xFFE2D7EC), valueColor: AlwaysStoppedAnimation<Color>(color)))),
          const SizedBox(width: 4),
          SizedBox(width: 25, child: Text(percent, textAlign: TextAlign.end, style: const TextStyle(color: Color(0xFF28113F), fontSize: 8, fontWeight: FontWeight.w900))),
        ],
      );
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.icon, required this.value});
  final String icon;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 10)),
          const SizedBox(width: 3),
          Text(value, style: const TextStyle(color: Color(0xFF6B1BB4), fontSize: 10, fontWeight: FontWeight.w900)),
        ],
      );
}

class _Weekday extends StatelessWidget {
  const _Weekday(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Center(child: Text(label, style: const TextStyle(color: Color(0xFF4B3C5B), fontSize: 7, fontWeight: FontWeight.w800))),
      );
}

class _DayCell extends StatelessWidget {
  const _DayCell(this.day, this.color, {this.selected = false, this.off = false});
  final String day;
  final Color color;
  final bool selected;
  final bool off;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          height: 21,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: selected ? Border.all(color: const Color(0xFF7627C8), width: 1.5) : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(day, style: const TextStyle(color: Color(0xFF28113F), fontSize: 9, fontWeight: FontWeight.w900)),
              if (off) const Text('OFF', style: TextStyle(color: Color(0xFF635B6B), fontSize: 6, fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      );
}
