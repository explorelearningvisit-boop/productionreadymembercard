import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/member_theme.dart';

class PurpleMemberDashboard extends StatefulWidget {
  const PurpleMemberDashboard({super.key});

  @override
  State<PurpleMemberDashboard> createState() => _PurpleMemberDashboardState();
}

class _PurpleMemberDashboardState extends State<PurpleMemberDashboard> {
  int selectedRail = 0;
  int selectedMetric = 0;

  static const Color ink = Color(0xFF21102F);
  static const Color purple = Color(0xFF7100C7);
  static const Color violet = Color(0xFFB52BFF);
  static const Color deepPurple = Color(0xFF39005F);
  static const Color gold = Color(0xFFFFC928);
  static const Color green = Color(0xFF14C94A);
  static const Color red = Color(0xFFE9273F);
  static const Color canvas = Color(0xFFF7F0FF);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 380;
    return Container(
      color: canvas,
      child: Stack(
        children: [
          const Positioned.fill(child: _LavenderBackdrop()),
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(compact ? 8 : 12, 7, compact ? 8 : 12, 16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: _masterFrame(compact),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _masterFrame(bool compact) {
    return Container(
      padding: EdgeInsets.all(compact ? 5 : 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(compact ? 29 : 34),
        border: Border.all(color: const Color(0xFFFFD85A), width: 1.6),
        boxShadow: [
          BoxShadow(color: violet.withOpacity(.45), blurRadius: 18, spreadRadius: 1),
          BoxShadow(color: gold.withOpacity(.30), blurRadius: 9, spreadRadius: .5),
          const BoxShadow(color: Colors.white, blurRadius: 2, spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _saleBanner(compact),
          SizedBox(height: compact ? 8 : 10),
          _checkInFreeze(compact),
          SizedBox(height: compact ? 8 : 10),
          _memberIdentity(compact),
          SizedBox(height: compact ? 7 : 9),
          _paymentPanel(compact),
          SizedBox(height: 6),
          _earlyPayOffer(compact),
          SizedBox(height: 7),
          _membershipProgress(compact),
          SizedBox(height: compact ? 8 : 10),
          _metricMenu(compact),
          SizedBox(height: compact ? 8 : 10),
          _attendanceSection(compact),
          SizedBox(height: 8),
          _footer(compact),
        ],
      ),
    );
  }

  Widget _saleBanner(bool compact) {
    return _neonPanel(
      radius: 23,
      padding: EdgeInsets.symmetric(horizontal: compact ? 10 : 14, vertical: compact ? 9 : 12),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF22003F), Color(0xFF6500A9), Color(0xFF260044)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(17),
        ),
        padding: EdgeInsets.symmetric(horizontal: compact ? 7 : 12, vertical: compact ? 9 : 12),
        child: Row(
          children: [
            Text('🎁', style: TextStyle(fontSize: compact ? 35 : 43)),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _gradientText('Big Billion Sale', compact ? 19 : 24, FontWeight.w900,
                      const [Color(0xFFFFFFFF), Color(0xFFFFD83C)]),
                  Text('Up to 40% OFF', style: TextStyle(
                    color: Colors.white, fontSize: compact ? 15 : 18, fontWeight: FontWeight.w900)),
                  Text('Fitness Gear · Supplements · Nutrition',
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white.withOpacity(.88),
                      fontSize: compact ? 8 : 10, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Column(
              children: [
                Text('🏋️', style: TextStyle(fontSize: compact ? 26 : 34)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 11, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFFFFE65B), Color(0xFFFFA900)]),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [BoxShadow(color: gold.withOpacity(.4), blurRadius: 8)],
                  ),
                  child: Text('Shop Now ›', style: TextStyle(
                    color: ink, fontSize: compact ? 9 : 11, fontWeight: FontWeight.w900)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkInFreeze(bool compact) {
    return _neonPanel(
      radius: 30,
      padding: EdgeInsets.symmetric(horizontal: compact ? 9 : 13, vertical: compact ? 8 : 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 12, vertical: 7),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF4A007F), Color(0xFF9C16E8)]),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: purple.withOpacity(.25), blurRadius: 8)],
              ),
              child: Row(
                children: [
                  _roundIcon(Icons.check_rounded, green, compact ? 27 : 32),
                  const SizedBox(width: 7),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('CHECK-IN', style: TextStyle(color: Colors.white,
                      fontSize: compact ? 15 : 18, fontWeight: FontWeight.w900)),
                    Text('Completed · 07:12 AM', style: TextStyle(color: Colors.white,
                      fontSize: compact ? 10 : 12, fontWeight: FontWeight.w600)),
                  ])),
                ],
              ),
            ),
          ),
          Container(width: 1.2, height: 36, margin: const EdgeInsets.symmetric(horizontal: 8),
            color: purple.withOpacity(.55)),
          Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.ac_unit_rounded, color: purple, size: compact ? 25 : 29),
              const SizedBox(width: 5),
              Text('FREEZE', style: TextStyle(color: ink,
                fontSize: compact ? 14 : 17, fontWeight: FontWeight.w900)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _memberIdentity(bool compact) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: compact ? 98 : 116,
          height: compact ? 105 : 124,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [Color(0xFFFFE57A), Color(0xFFFFA900), Color(0xFF8A3D00)],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            border: Border.all(color: const Color(0xFFFFE9A1), width: 2),
            boxShadow: [
              BoxShadow(color: gold.withOpacity(.55), blurRadius: 10, spreadRadius: 1),
              BoxShadow(color: purple.withOpacity(.20), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(19),
            child: Stack(
              fit: StackFit.expand,
              children: [
                const DecoratedBox(decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFFFFF0B0), Color(0xFFE7A52B), Color(0xFF6B2A00)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight))),
                Positioned(top: 6, right: 6, child: Icon(Icons.auto_awesome,
                  color: Colors.white.withOpacity(.75), size: 16)),
                Center(child: Text('💪', style: TextStyle(fontSize: compact ? 56 : 68))),
                Positioned(bottom: 4, right: 6, child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(5)),
                  child: const Text('BAD GYM', style: TextStyle(color: gold, fontSize: 7, fontWeight: FontWeight.w900)))),
              ],
            ),
          ),
        ),
        SizedBox(width: compact ? 8 : 11),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Ashwani Kumar Singh', maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(color: ink, fontSize: compact ? 17 : 21, fontWeight: FontWeight.w900)),
            const SizedBox(height: 5),
            Wrap(spacing: compact ? 5 : 8, crossAxisAlignment: WrapCrossAlignment.center, children: [
              _identityMeta(Icons.calendar_month, 'BG215', compact),
              _metaDivider(),
              _identityMeta(Icons.person, '28 Yrs', compact),
              _metaDivider(),
              _identityMeta(Icons.male, 'Male', compact),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: _planPill(compact)),
              const SizedBox(width: 5),
              Expanded(child: _activePill(compact)),
            ]),
          ]),
        ),
      ],
    );
  }

  Widget _paymentPanel(bool compact) {
    return _softPanel(
      radius: 22,
      padding: EdgeInsets.symmetric(horizontal: compact ? 9 : 13, vertical: compact ? 8 : 10),
      child: Row(children: [
        Icon(Icons.account_balance_wallet_rounded, color: purple, size: compact ? 24 : 28),
        const SizedBox(width: 6),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Payment Due', style: TextStyle(color: ink, fontSize: compact ? 9 : 11, fontWeight: FontWeight.w800)),
          Text('₹500', style: TextStyle(color: red, fontSize: compact ? 18 : 21, fontWeight: FontWeight.w900)),
        ])),
        Container(width: 1, height: 40, color: const Color(0xFFD9C9EB)),
        const SizedBox(width: 8),
        Icon(Icons.calendar_month_rounded, color: purple, size: compact ? 23 : 27),
        const SizedBox(width: 5),
        Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('8 Days Left', style: TextStyle(color: purple, fontSize: compact ? 14 : 17, fontWeight: FontWeight.w900)),
          Text('Expires: 24 Oct 2026', maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(color: ink, fontSize: compact ? 8 : 10, fontWeight: FontWeight.w600)),
        ])),
        Container(width: compact ? 34 : 42, height: compact ? 34 : 42,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFDDD4E8))),
          child: CustomPaint(painter: _QrPainter()),
        ),
      ]),
    );
  }

  Widget _earlyPayOffer(bool compact) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 12, vertical: compact ? 6 : 7),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFF16A), Color(0xFFFFB800), Color(0xFFFFE65B)]),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFFF6B2), width: 1.2),
        boxShadow: [BoxShadow(color: gold.withOpacity(.35), blurRadius: 7, offset: const Offset(0, 2))],
      ),
      child: Row(children: [
        const Icon(Icons.sell_rounded, color: Color(0xFF7C3A00), size: 16),
        const SizedBox(width: 5),
        Expanded(child: Text('Pay Early & Save More!', maxLines: 1, overflow: TextOverflow.ellipsis,
          style: TextStyle(color: ink, fontSize: compact ? 9 : 11, fontWeight: FontWeight.w900))),
        _offerDivider(),
        _offerText('1M', '5%', compact),
        _offerDivider(),
        _offerText('3M', '10%', compact),
        _offerDivider(),
        _offerText('6M', '15%', compact),
        const Icon(Icons.chevron_right_rounded, color: ink, size: 19),
      ]),
    );
  }

  Widget _membershipProgress(bool compact) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: Text('Membership 22 / 30 Days', style: TextStyle(
          color: ink, fontSize: compact ? 12 : 14, fontWeight: FontWeight.w900))),
        Container(padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
          decoration: BoxDecoration(color: const Color(0xFFE9D4FF), borderRadius: BorderRadius.circular(15)),
          child: Text('73%', style: TextStyle(color: ink, fontSize: compact ? 15 : 18, fontWeight: FontWeight.w900))),
      ]),
      const SizedBox(height: 5),
      ClipRRect(borderRadius: BorderRadius.circular(12), child: const LinearProgressIndicator(
        value: .73, minHeight: 9, backgroundColor: Color(0xFFE5D9F2),
        valueColor: AlwaysStoppedAnimation(violet))),
    ]);
  }

  Widget _metricMenu(bool compact) {
    return Row(children: [
      Expanded(child: _metricCard('Attendance', '81%', '↑ +6%', Icons.calendar_month_rounded,
        const Color(0xFFFFD84C), const Color(0xFF087D2A), 'blinkit', 'Healthy Food for Fitness', compact)),
      const SizedBox(width: 4),
      Expanded(child: _metricCard('Workout', '58 min', '↑ +12%', Icons.fitness_center_rounded,
        const Color(0xFF9D18F5), purple, 'Creatine + Protein', 'Up to 25% OFF', compact)),
      const SizedBox(width: 4),
      Expanded(child: _metricCard('Payment', '₹500 Due', 'SBI', Icons.account_balance_wallet_rounded,
        const Color(0xFF14BCEB), const Color(0xFF075C9D), 'Pay with SBI Card', '5% OFF', compact)),
      const SizedBox(width: 4),
      Expanded(child: _metricCard('Body', '69.5 kg', '↓ -0.8 kg', Icons.monitor_weight_rounded,
        const Color(0xFF39D36B), const Color(0xFF147C35), 'Protinex', 'Gain Muscle', compact)),
    ]);
  }

  Widget _metricCard(String title, String value, String change, IconData icon, Color tint,
      Color accent, String sponsor, String tagline, bool compact) {
    return Container(
      constraints: BoxConstraints(minHeight: compact ? 100 : 116),
      padding: EdgeInsets.symmetric(horizontal: compact ? 4 : 6, vertical: compact ? 6 : 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.white, tint.withOpacity(.22), tint.withOpacity(.10)],
          begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: Colors.white, width: 1.6),
        boxShadow: [BoxShadow(color: accent.withOpacity(.20), blurRadius: 8, offset: const Offset(0, 3)),
          BoxShadow(color: purple.withOpacity(.08), blurRadius: 3)],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: accent, size: compact ? 14 : 17),
          const SizedBox(width: 3),
          Flexible(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(color: ink, fontSize: compact ? 8 : 10, fontWeight: FontWeight.w900))),
        ]),
        Text(value, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: TextStyle(color: accent, fontSize: compact ? 14 : 17, fontWeight: FontWeight.w900)),
        Container(margin: const EdgeInsets.only(top: 2), padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(color: Colors.white.withOpacity(.78), borderRadius: BorderRadius.circular(9)),
          child: Text(change, maxLines: 1, style: TextStyle(color: accent, fontSize: compact ? 7 : 8, fontWeight: FontWeight.w900))),
        const Spacer(),
        Text(sponsor, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: TextStyle(color: accent, fontSize: compact ? 8 : 9, fontWeight: FontWeight.w900)),
        Text(tagline, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: TextStyle(color: ink, fontSize: compact ? 6 : 7, fontWeight: FontWeight.w700)),
      ]),
    );
  }

  Widget _attendanceSection(bool compact) {
    const labels = ['Attend', 'Insights', 'Cal', 'History', 'Trend', 'Goals'];
    const icons = [Icons.calendar_month_rounded, Icons.bar_chart_rounded, Icons.calendar_view_month_rounded,
      Icons.history_rounded, Icons.trending_up_rounded, Icons.emoji_events_rounded];
    const values = ['81%', 'AI', 'Oct', '30D', '+12%', '3/5'];
    final dates = List.generate(31, (i) => i + 1);
    return _neonPanel(
      radius: 22,
      padding: EdgeInsets.all(compact ? 5 : 7),
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          width: compact ? 54 : 62,
          padding: EdgeInsets.symmetric(vertical: compact ? 5 : 7, horizontal: 3),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF3A005F), Color(0xFF8700C8), Color(0xFF3A005F)],
              begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: const Color(0xFFE6B7FF), width: 1),
            boxShadow: [BoxShadow(color: purple.withOpacity(.30), blurRadius: 8)],
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(labels.length, (i) {
            final active = selectedRail == i;
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => setState(() => selectedRail = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                decoration: BoxDecoration(
                  gradient: active ? const LinearGradient(colors: [Color(0xFFFFD94C), Color(0xFFFFA900)]) : null,
                  borderRadius: BorderRadius.circular(10),
                  border: active ? Border.all(color: Colors.white, width: 1) : null,
                ),
                child: Column(children: [
                  Icon(icons[i], color: active ? deepPurple : Colors.white, size: compact ? 17 : 20),
                  const SizedBox(height: 2),
                  Text(labels[i], maxLines: 1, style: TextStyle(
                    color: active ? deepPurple : Colors.white, fontSize: compact ? 7 : 8, fontWeight: FontWeight.w900)),
                  Text(values[i], maxLines: 1, style: TextStyle(
                    color: active ? deepPurple : const Color(0xFFFFE45C), fontSize: compact ? 7 : 8, fontWeight: FontWeight.w900)),
                ]),
              ),
            );
          })),
        ),
        SizedBox(width: compact ? 5 : 7),
        Expanded(child: _attendanceContent(compact, dates)),
      ]),
    );
  }

  Widget _attendanceContent(bool compact, List<int> dates) {
    return _softPanel(
      radius: 17,
      padding: EdgeInsets.all(compact ? 7 : 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: compact ? 25 : 29, height: compact ? 25 : 29,
            decoration: const BoxDecoration(shape: BoxShape.circle,
              gradient: LinearGradient(colors: [violet, deepPurple])),
            child: const Icon(Icons.trending_up_rounded, color: Colors.white, size: 18)),
          const SizedBox(width: 5),
          Expanded(child: Text('Attendance Analytics', maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(color: ink, fontSize: compact ? 11 : 14, fontWeight: FontWeight.w900))),
          Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(color: const Color(0xFFFFF0F2), border: Border.all(color: red),
              borderRadius: BorderRadius.circular(12)),
            child: Text('● LIVE', style: TextStyle(color: red, fontSize: compact ? 7 : 9, fontWeight: FontWeight.w900))),
        ]),
        const SizedBox(height: 5),
        Align(alignment: Alignment.centerRight, child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD8C9E9))),
          child: Text('Oct 2026  ⌄', style: TextStyle(color: ink, fontSize: compact ? 8 : 9, fontWeight: FontWeight.w800)))),
        const SizedBox(height: 4),
        Row(children: [
          SizedBox(width: compact ? 70 : 84, height: compact ? 70 : 84,
            child: Stack(alignment: Alignment.center, children: [
              SizedBox.expand(child: CircularProgressIndicator(value: .81, strokeWidth: compact ? 8 : 10,
                backgroundColor: const Color(0xFFEBDCF8), valueColor: const AlwaysStoppedAnimation(purple))),
              Column(mainAxisSize: MainAxisSize.min, children: [
                Text('81%', style: TextStyle(color: ink, fontSize: compact ? 18 : 21, fontWeight: FontWeight.w900)),
                Text('25 / 31\\nDays', textAlign: TextAlign.center,
                  style: TextStyle(color: ink, fontSize: compact ? 8 : 9, fontWeight: FontWeight.w700)),
              ]),
            ]),
          ),
          SizedBox(width: compact ? 6 : 9),
          Expanded(child: Column(children: const [
            _LegendRow(color: green, label: 'Present', count: '23'),
            _LegendRow(color: gold, label: 'Late', count: '2'),
            _LegendRow(color: red, label: 'Absent', count: '2'),
            _LegendRow(color: purple, label: 'Holiday', count: '4'),
          ])),
          Container(width: 1, height: compact ? 66 : 78, color: const Color(0xFFD8C9E9)),
          SizedBox(width: compact ? 5 : 8),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('🔥', style: TextStyle(fontSize: 19)),
            Text('Streak', style: TextStyle(fontSize: compact ? 8 : 9, color: ink, fontWeight: FontWeight.w700)),
            Text('5 Days', style: TextStyle(fontSize: compact ? 12 : 15, color: purple, fontWeight: FontWeight.w900)),
            const SizedBox(height: 3),
            const Text('🏆', style: TextStyle(fontSize: 18)),
            Text('Best', style: TextStyle(fontSize: compact ? 8 : 9, color: ink, fontWeight: FontWeight.w700)),
            Text('14 Days', style: TextStyle(fontSize: compact ? 11 : 14, color: purple, fontWeight: FontWeight.w900)),
          ])),
        ]),
        const SizedBox(height: 6),
        _calendar(dates, compact),
        const SizedBox(height: 5),
        Wrap(spacing: compact ? 5 : 8, runSpacing: 3, children: const [
          _LegendDot(color: green, label: 'Present'),
          _LegendDot(color: gold, label: 'Late'),
          _LegendDot(color: red, label: 'Absent'),
          _LegendDot(color: violet, label: 'Holiday'),
          _LegendDot(color: Color(0xFFB9B5C4), label: 'Off'),
        ]),
      ]),
    );
  }

  Widget _calendar(List<int> dates, bool compact) {
    final states = <int, String>{
      1:'off', 2:'off', 3:'present', 4:'off', 5:'present', 6:'present', 7:'present',
      8:'present', 9:'present', 10:'late', 11:'off', 12:'present', 13:'present',
      14:'present', 15:'present', 16:'present', 17:'absent', 18:'off', 19:'present',
      20:'present', 21:'late', 22:'present', 23:'absent', 24:'absent', 25:'off',
      26:'present', 27:'present', 28:'late', 29:'present', 30:'present', 31:'present',
    };
    final dayLabels = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
    return Column(children: [
      Row(children: dayLabels.map((d) => Expanded(child: Center(child: Text(d,
        style: TextStyle(color: ink, fontSize: compact ? 7 : 9, fontWeight: FontWeight.w900)))).toList()),
      const SizedBox(height: 3),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 35,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, mainAxisSpacing: compact ? 3 : 4, crossAxisSpacing: compact ? 3 : 4,
          childAspectRatio: compact ? 1.55 : 1.6,
        ),
        itemBuilder: (context, index) {
          final day = index - 2;
          if (day < 1 || day > 31) return const SizedBox.shrink();
          final state = states[day] ?? 'present';
          final Color start = switch (state) {
            'present' => const Color(0xFF00D52F),
            'late' => const Color(0xFFFFBE00),
            'absent' => const Color(0xFFFF263D),
            'off' => const Color(0xFFE5E2EC),
            _ => purple,
          };
          final Color end = switch (state) {
            'present' => const Color(0xFF008C24),
            'late' => const Color(0xFFE98A00),
            'absent' => const Color(0xFFC9002A),
            'off' => const Color(0xFFC9C5D2),
            _ => deepPurple,
          };
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [start, end], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: Colors.white.withOpacity(.8), width: .8),
              boxShadow: state == 'off' ? [] : [BoxShadow(color: end.withOpacity(.18), blurRadius: 3, offset: const Offset(0, 1))],
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('$day', style: TextStyle(color: state == 'off' ? ink : Colors.white,
                fontSize: compact ? 9 : 11, fontWeight: FontWeight.w900)),
              if (state == 'off') Text('OFF', style: TextStyle(color: ink, fontSize: compact ? 5 : 6, fontWeight: FontWeight.w900)),
            ]),
          );
        },
      ),
    ]);
  }

  Widget _footer(bool compact) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 13, vertical: compact ? 8 : 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFEBD5FF), Color(0xFFD9B2FF), Color(0xFFF9E7FF)],
          begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: purple.withOpacity(.15), blurRadius: 10)],
      ),
      child: Row(children: [
        _footerAction(Icons.self_improvement_rounded, 'Yoga', compact),
        _footerAction(Icons.water_drop_rounded, 'Bottle', compact),
        _footerAction(Icons.travel_explore_rounded, 'Travel', compact),
        const Spacer(),
        _roundIcon(Icons.circle_outlined, deepPurple, compact ? 31 : 36),
        const SizedBox(width: 8),
        _roundIcon(Icons.radio_button_checked, deepPurple, compact ? 31 : 36),
      ]),
    );
  }

  Widget _footerAction(IconData icon, String label, bool compact) => Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: deepPurple, size: compact ? 22 : 26),
      Text(label, style: TextStyle(color: ink, fontSize: compact ? 8 : 10, fontWeight: FontWeight.w900)),
    ]),
  );

  Widget _neonPanel({required Widget child, required double radius, EdgeInsets? padding}) {
    return Container(
      padding: const EdgeInsets.all(2.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: const LinearGradient(colors: [Color(0xFFFFF5A6), Color(0xFFFFB900),
          Color(0xFFFF3BD8), Color(0xFF8D00FF), Color(0xFFFFE66B)],
          begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [
          BoxShadow(color: violet.withOpacity(.34), blurRadius: 11, spreadRadius: .5),
          BoxShadow(color: gold.withOpacity(.20), blurRadius: 6),
        ],
      ),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: const Color(0xFFFDF9FF),
          borderRadius: BorderRadius.circular(radius - 2),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: child,
      ),
    );
  }

  Widget _softPanel({required Widget child, required double radius, EdgeInsets? padding}) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.white, Color(0xFFF0E4FF)],
          begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: const Color(0xFFFFFFFF), width: 1.5),
        boxShadow: [BoxShadow(color: purple.withOpacity(.12), blurRadius: 9, offset: const Offset(0, 3)),
          BoxShadow(color: Colors.white.withOpacity(.8), blurRadius: 2, spreadRadius: 1)],
      ),
      child: child,
    );
  }

  Widget _roundIcon(IconData icon, Color color, double size) => Container(
    width: size, height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle,
      boxShadow: [BoxShadow(color: color.withOpacity(.25), blurRadius: 6)]),
    child: Icon(icon, color: Colors.white, size: size * .68),
  );

  Widget _identityMeta(IconData icon, String label, bool compact) => Row(mainAxisSize: MainAxisSize.min, children: [
    Icon(icon, color: purple, size: compact ? 13 : 15),
    const SizedBox(width: 2),
    Text(label, style: TextStyle(color: ink, fontSize: compact ? 9 : 11, fontWeight: FontWeight.w800)),
  ]);

  Widget _metaDivider() => Container(width: 1, height: 15, color: purple.withOpacity(.35));

  Widget _planPill(bool compact) => Container(
    padding: EdgeInsets.symmetric(horizontal: compact ? 5 : 7, vertical: compact ? 5 : 6),
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFFFE45B), Color(0xFFFFB800)]),
      borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.white, width: 1.3),
      boxShadow: [BoxShadow(color: gold.withOpacity(.28), blurRadius: 5)]),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.workspace_premium_rounded, color: const Color(0xFF8C4B00), size: compact ? 13 : 15),
      const SizedBox(width: 3),
      Flexible(child: Text('Gold Plan', maxLines: 1, style: TextStyle(color: const Color(0xFF572B00),
        fontSize: compact ? 9 : 10, fontWeight: FontWeight.w900))),
    ]),
  );

  Widget _activePill(bool compact) => Container(
    padding: EdgeInsets.symmetric(horizontal: compact ? 5 : 7, vertical: compact ? 5 : 6),
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF22ED58), Color(0xFF00A936)]),
      borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.white, width: 1.3),
      boxShadow: [BoxShadow(color: green.withOpacity(.25), blurRadius: 5)]),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.check_rounded, color: Colors.white, size: compact ? 13 : 15),
      const SizedBox(width: 3),
      Text('Active', style: TextStyle(color: Colors.white, fontSize: compact ? 9 : 10, fontWeight: FontWeight.w900)),
    ]),
  );

  Widget _offerDivider() => Container(width: 1, height: 18, margin: const EdgeInsets.symmetric(horizontal: 5),
    color: const Color(0xFF9B6900).withOpacity(.5));

  Widget _offerText(String period, String discount, bool compact) => Column(children: [
    Text(period, style: TextStyle(color: ink, fontSize: compact ? 7 : 9, fontWeight: FontWeight.w800)),
    Text(discount, style: TextStyle(color: red, fontSize: compact ? 8 : 10, fontWeight: FontWeight.w900)),
  ]);

  Widget _gradientText(String text, double size, FontWeight weight, List<Color> colors) => ShaderMask(
    shaderCallback: (bounds) => LinearGradient(colors: colors).createShader(bounds),
    child: Text(text, style: TextStyle(color: Colors.white, fontSize: size, fontWeight: weight)),
  );
}

class _LavenderBackdrop extends StatelessWidget {
  const _LavenderBackdrop();

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xFFF7F0FF), Color(0xFFE9D5FF), Color(0xFFF9F2FF)],
        begin: Alignment.topCenter, end: Alignment.bottomCenter),
    ),
    child: CustomPaint(painter: _GlowOrbsPainter()),
  );
}

class _GlowOrbsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 38);
    p.color = const Color(0xFFD7A4FF).withOpacity(.24);
    canvas.drawCircle(Offset(size.width * .08, size.height * .27), 55, p);
    p.color = const Color(0xFFFFD86B).withOpacity(.16);
    canvas.drawCircle(Offset(size.width * .91, size.height * .66), 48, p);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.color, required this.label, required this.count});
  final Color color;
  final String label;
  final String count;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 4),
      Expanded(child: Text(label, style: const TextStyle(color: Color(0xFF21102F), fontSize: 9, fontWeight: FontWeight.w700))),
      Text(count, style: const TextStyle(color: Color(0xFF21102F), fontSize: 10, fontWeight: FontWeight.w900)),
    ]),
  );
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    const SizedBox(width: 3),
    Text(label, style: const TextStyle(color: Color(0xFF21102F), fontSize: 7, fontWeight: FontWeight.w700)),
  ]);
}

class _QrPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0xFF160F20);
    const n = 21;
    final cell = size.width / n;
    final random = math.Random(215);
    for (int y = 0; y < n; y++) {
      for (int x = 0; x < n; x++) {
        final finder = _finder(x, y, 0, 0) || _finder(x, y, n - 7, 0) || _finder(x, y, 0, n - 7);
        if (finder || random.nextBool()) {
          canvas.drawRect(Rect.fromLTWH(x * cell, y * cell, cell * .92, cell * .92), p);
        }
      }
    }
    final white = Paint()..color = Colors.white;
    for (final origin in [const Point(0, 0), Point(n - 7, 0), Point(0, n - 7)]) {
      canvas.drawRect(Rect.fromLTWH(origin.x * cell, origin.y * cell, cell * 7, cell * 7), white);
      canvas.drawRect(Rect.fromLTWH((origin.x + 1) * cell, (origin.y + 1) * cell, cell * 5, cell * 5), p);
      canvas.drawRect(Rect.fromLTWH((origin.x + 2) * cell, (origin.y + 2) * cell, cell * 3, cell * 3), white);
    }
  }

  bool _finder(int x, int y, int ox, int oy) => x >= ox && x < ox + 7 && y >= oy && y < oy + 7;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
