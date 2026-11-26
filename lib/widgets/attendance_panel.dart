import 'package:flutter/material.dart';

import '../theme/member_theme.dart';
import 'dashboard_primitives.dart';

class AttendancePanel extends StatelessWidget {
  const AttendancePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const designHeight = 350.0;
        return FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: constraints.maxWidth,
            height: designHeight,
            child: _panel(),
          ),
        );
      },
    );
  }

  Widget _panel() {
    return Container(
      padding: const EdgeInsets.fromLTRB(7, 5, 7, 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [MemberTheme.surface, Color(0xFFEAD9FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFEBCFFF), width: 1.5),
        boxShadow: const [BoxShadow(color: Color(0x669B4CFF), blurRadius: 8)],
      ),
      child: Column(
        children: [
          _header(),
          const SizedBox(height: 3),
          _offerBanner(),
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
                          valueColor: const AlwaysStoppedAnimation<Color>(MemberTheme.green),
                        ),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('81%', style: TextStyle(
                            color: MemberTheme.ink, fontSize: 18, fontWeight: FontWeight.w900,
                          )),
                          Text('25/31', style: TextStyle(
                            color: MemberTheme.ink, fontSize: 8, fontWeight: FontWeight.w800,
                          )),
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
                      AttendanceLegend(color: Color(0xFF0CCB60), label: 'Present', count: '23', percent: '74%'),
                      AttendanceLegend(color: Color(0xFFE52B52), label: 'Absent', count: '2', percent: '6%'),
                      AttendanceLegend(color: Color(0xFF8A35D5), label: 'Holiday', count: '4', percent: '13%'),
                      AttendanceLegend(color: Color(0xFFFFB21C), label: 'Late', count: '2', percent: '6%'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          const Divider(height: 1, color: Color(0xFFD8C6E9)),
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
          _calendarTitle(),
          const SizedBox(height: 2),
          const Row(children: [
            WeekdayLabel('Mon'), WeekdayLabel('Tue'), WeekdayLabel('Wed'),
            WeekdayLabel('Thu'), WeekdayLabel('Fri'), WeekdayLabel('Sat'),
            WeekdayLabel('Sun'),
          ]),
          const SizedBox(height: 2),
          const Row(children: [
            AttendanceDayCell('13'), AttendanceDayCell('14'),
            AttendanceDayCell('15'), AttendanceDayCell('16',
              color: Color(0xFFE7D8FF), selected: true),
            AttendanceDayCell('17', color: Color(0xFFFFDDE2)),
            AttendanceDayCell('18', color: Color(0xFFE5E2E9), off: true),
            AttendanceDayCell('19'),
          ]),
          const SizedBox(height: 2),
          const Row(children: [
            AttendanceDayCell('20'), AttendanceDayCell('21',
              color: Color(0xFFFFEDC7)),
            AttendanceDayCell('22'), AttendanceDayCell('23',
              color: Color(0xFFFFDDE2)),
            AttendanceDayCell('24'), AttendanceDayCell('25',
              color: Color(0xFFE5E2E9), off: true),
            AttendanceDayCell(''),
          ]),
          const Spacer(),
          const Text(
            '23 present • 2 late • 2 absent • 4 holiday',
            maxLines: 1,
            style: TextStyle(color: MemberTheme.ink, fontSize: 7, fontWeight: FontWeight.w800),
          ),
          const Text(
            'Sample data • API connection required for live records',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: MemberTheme.muted, fontSize: 6, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return SizedBox(
      height: 20,
      child: Row(
        children: [
          Container(
            width: 19,
            height: 19,
            decoration: const BoxDecoration(color: MemberTheme.purple, shape: BoxShape.circle),
            child: const Icon(Icons.trending_up_rounded, color: Colors.white, size: 13),
          ),
          const SizedBox(width: 4),
          const Expanded(
            child: Text('Attendance Analytics', maxLines: 1, style: TextStyle(
              color: MemberTheme.ink, fontSize: 12, fontWeight: FontWeight.w900,
            )),
          ),
          const Icon(Icons.notifications_active, color: MemberTheme.purple, size: 15),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE5E8),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.redAccent),
            ),
            child: const Text('● LIVE', style: TextStyle(
              color: Colors.red, fontSize: 8, fontWeight: FontWeight.w900,
            )),
          ),
        ],
      ),
    );
  }

  Widget _offerBanner() {
    return _smallBanner(
      asset: 'assets/member_card/05_blinkit_grocery_bag.webp',
      assetWidth: 34,
      title: 'Healthy Snacks & Gym Essentials',
      subtitle: 'Member partner offer • Up to 30% OFF',
      colors: const [Color(0xFFFFF3C7), Color(0xFFF4D9FF)],
    );
  }

  Widget _recoveryBanner() {
    return _smallBanner(
      asset: 'assets/member_card/03_whey_protein_tub.webp',
      assetWidth: 23,
      title: 'Recovery Combo',
      subtitle: 'Up to 30% OFF',
      colors: const [Color(0xFFF9E9FF), Color(0xFFE5C4FF)],
    );
  }

  Widget _smallBanner({
    required String asset,
    required double assetWidth,
    required String title,
    required String subtitle,
    required List<Color> colors,
  }) {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD8B3F3)),
      ),
      child: Row(
        children: [
          Image.asset(asset, width: assetWidth, height: 23, fit: BoxFit.contain),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: MemberTheme.ink, fontSize: 9, fontWeight: FontWeight.w900)),
                Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFF6E258F), fontSize: 7, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: MemberTheme.ink, size: 18),
        ],
      ),
    );
  }

  Widget _calendarTitle() {
    return SizedBox(
      height: 17,
      child: Row(
        children: [
          Image.asset('assets/member_card/25_calendar_graphic.webp', width: 18, height: 18, fit: BoxFit.contain),
          const SizedBox(width: 3),
          const Expanded(
            child: Text('October attendance', maxLines: 1, style: TextStyle(
              color: MemberTheme.ink, fontSize: 12, fontWeight: FontWeight.w900,
            )),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF7D16B9), Color(0xFF3B0878)]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('🏋 Train More • 15% OFF', style: TextStyle(
              color: Colors.white, fontSize: 7, fontWeight: FontWeight.w900,
            )),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.icon, required this.value});
  final String icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(icon, style: const TextStyle(fontSize: 10)),
        const SizedBox(width: 3),
        Text(value, style: const TextStyle(
          color: MemberTheme.purple, fontSize: 10, fontWeight: FontWeight.w900,
        )),
      ],
    );
  }
}
