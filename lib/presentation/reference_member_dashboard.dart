import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/presentation/widgets/member_qr_sheet.dart';
import 'package:bad_gym/presentation/widgets/notification_sheet.dart';

class ReferenceMemberDashboard extends StatefulWidget {
  const ReferenceMemberDashboard({super.key});

  @override
  State<ReferenceMemberDashboard> createState() => _ReferenceMemberDashboardState();
}

class _ReferenceMemberDashboardState extends State<ReferenceMemberDashboard> {
  final MemberIntelligenceData _data = MemberIntelligenceData.ashwaniKumarSingh;
  int _tab = 0;
  int _rail = 0;
  static const _blue = Color(0xFF1685D5);
  static const _navy = Color(0xFF142F55);
  static const _muted = Color(0xFF617C9C);
  static const _green = Color(0xFF17B64B);
  static const _amber = Color(0xFFF5B51B);
  static const _red = Color(0xFFE34850);
  static const _line = Color(0xFFA8D4F6);

  List<String> get _railLabels => switch (_tab) {
    0 => const ['Calendar', 'Trend', 'History', 'Insight', 'Goal'],
    1 => const ['Overview', 'Trend', 'Programs', 'History'],
    2 => const ['Overview', 'Transactions', 'Due date', 'Rewards'],
    _ => const ['Overview', 'Composition', 'Measures', 'Progress'],
  };

  List<IconData> get _railIcons => switch (_tab) {
    0 => const [Icons.calendar_month_rounded, Icons.bar_chart_rounded, Icons.history_rounded, Icons.auto_awesome_rounded, Icons.track_changes_rounded],
    1 => const [Icons.fitness_center_rounded, Icons.show_chart_rounded, Icons.view_list_rounded, Icons.history_rounded],
    2 => const [Icons.account_balance_wallet_rounded, Icons.receipt_long_rounded, Icons.event_available_rounded, Icons.stars_rounded],
    _ => const [Icons.monitor_weight_rounded, Icons.pie_chart_rounded, Icons.straighten_rounded, Icons.show_chart_rounded],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7F3FF),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xFFE7F3FF),
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            final h = constraints.maxHeight;
            final compact = h < 690;
            final headerH = compact ? 48.0 : 54.0;
            final profileH = compact ? 150.0 : 166.0;
            final promoH = compact ? 64.0 : 74.0;
            final statsH = compact ? 91.0 : 104.0;
            final insightH = compact ? 48.0 : 54.0;
            const gap = 5.0;
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFE6F3FF), Color(0xFFF9FCFF), Color(0xFFDDEEFF)],
                ),
              ),
              child: Stack(children: [
                Positioned.fill(child: IgnorePointer(child: Opacity(
                  opacity: .35,
                  child: Image.asset('assets/images/bg_waves.png', fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink()),
                ))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(7, 2, 7, 3),
                  child: Column(children: [
                    SizedBox(height: headerH, child: _header()),
                    const SizedBox(height: gap),
                    SizedBox(height: profileH, child: _memberPass(compact)),
                    const SizedBox(height: gap),
                    SizedBox(height: promoH, child: _festivalBanner()),
                    const SizedBox(height: gap),
                    SizedBox(height: statsH, child: _quickStats(compact)),
                    const SizedBox(height: gap),
                    Expanded(child: _workspace(compact)),
                    const SizedBox(height: gap),
                    SizedBox(height: insightH, child: _insights(compact)),
                  ]),
                ),
              ]),
            );
          }),
        ),
      ),
    );
  }

  Widget _header() => Row(children: [
    _glass(
      width: 48, height: 46, radius: 16,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Image.asset('assets/images/logo_dumbbell.png', fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const Icon(Icons.fitness_center_rounded, color: _blue, size: 26)),
      ),
    ),
    const SizedBox(width: 8),
    Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
      RichText(text: const TextSpan(children: [
        TextSpan(text: 'BAD ', style: TextStyle(color: _navy, fontSize: 21, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, letterSpacing: -.8)),
        TextSpan(text: 'GYM', style: TextStyle(color: _blue, fontSize: 21, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, letterSpacing: -.8)),
      ])),
      const Text('Member Intelligence', style: TextStyle(color: _muted, fontSize: 10.5, height: 1, fontWeight: FontWeight.w700)),
    ])),
    _headerButton(Icons.search_rounded, () => _showInfo('Search', 'Search members by name, ID or phone.')),
    const SizedBox(width: 5),
    Stack(clipBehavior: Clip.none, children: [
      _headerButton(Icons.notifications_none_rounded, () => NotificationSheet.show(context)),
      Positioned(right: -1, top: -2, child: Container(
        width: 17, height: 17, alignment: Alignment.center,
        decoration: const BoxDecoration(color: _red, shape: BoxShape.circle),
        child: Text('${_data.notificationCount}', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900)),
      )),
    ]),
    const SizedBox(width: 5),
    _headerButton(Icons.qr_code_scanner_rounded, () => MemberQrSheet.show(context, _data)),
  ]);

  Widget _headerButton(IconData icon, VoidCallback action) => InkWell(
    onTap: action, borderRadius: BorderRadius.circular(15),
    child: _glass(width: 42, height: 43, radius: 15,
      child: Icon(icon, color: _navy, size: 23)),
  );

  Widget _memberPass(bool compact) {
    final avatar = compact ? 68.0 : 78.0;
    return _glass(radius: 22, padding: const EdgeInsets.fromLTRB(9, 7, 9, 6), child: Column(children: [
      Expanded(child: Row(children: [
        Container(
          width: avatar, height: avatar,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [BoxShadow(color: _blue.withValues(alpha: .18), blurRadius: 8, spreadRadius: 1)],
          ),
          child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(
            'assets/images/avatar_ashwani_hq.png', fit: BoxFit.cover, alignment: Alignment.topCenter,
            errorBuilder: (_, __, ___) => Image.asset('assets/images/avatar_ashwini.png', fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.person, color: _blue, size: 45)),
          )),
        ),
        const SizedBox(width: 8),
        Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(spacing: 5, runSpacing: 3, crossAxisAlignment: WrapCrossAlignment.center, children: [
            _pill(Icons.check_rounded, 'CHECKED-IN', _green, Colors.white),
            _pill(Icons.calendar_month_rounded, '${_data.checkInDate} · ${_data.checkInTime}', const Color(0xFFE8F4FF), _navy, outlined: true),
          ]),
          const SizedBox(height: 4),
          Text(_data.name, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(color: _navy, fontSize: compact ? 12.3 : 13.7, fontWeight: FontWeight.w900, letterSpacing: -.25)),
          const SizedBox(height: 3),
          FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Row(children: [
            const Icon(Icons.badge_outlined, size: 12, color: _blue),
            const SizedBox(width: 2),
            Text(_data.memberId, style: const TextStyle(color: _navy, fontSize: 9.5, fontWeight: FontWeight.w700)),
            const SizedBox(width: 5), const Text('|', style: TextStyle(color: _muted)),
            const SizedBox(width: 5), const Icon(Icons.person_outline, size: 12, color: _blue),
            const SizedBox(width: 2), Text('${_data.age} Yrs', style: const TextStyle(color: _navy, fontSize: 9.5, fontWeight: FontWeight.w700)),
            const SizedBox(width: 5), const Text('|', style: TextStyle(color: _muted)),
            const SizedBox(width: 5), const Icon(Icons.male_rounded, size: 13, color: _blue),
            Text(_data.gender, style: const TextStyle(color: _navy, fontSize: 9.5, fontWeight: FontWeight.w700)),
          ])),
          const SizedBox(height: 3),
          Wrap(spacing: 5, children: [
            _pill(Icons.verified_rounded, _data.isActive ? 'Active' : 'Inactive', _green, Colors.white),
            _pill(Icons.workspace_premium_rounded, _data.planName, _amber, const Color(0xFF513400)),
          ]),
        ])),
        const SizedBox(width: 5),
        InkWell(onTap: () => MemberQrSheet.show(context, _data), child: Container(
          width: compact ? 43 : 49, height: compact ? 43 : 49,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: _line)),
          child: const Icon(Icons.qr_code_2_rounded, size: 37, color: _navy),
        )),
      ])),
      Container(height: 1, color: _line.withValues(alpha: .65), margin: const EdgeInsets.symmetric(vertical: 5)),
      Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Membership  ${_data.daysUsed} / ${_data.totalDays} Days', style: const TextStyle(color: _navy, fontSize: 9.5, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          ClipRRect(borderRadius: BorderRadius.circular(10), child: LinearProgressIndicator(
            value: _data.membershipProgress, minHeight: 6, backgroundColor: const Color(0xFFD3E8FA),
            valueColor: const AlwaysStoppedAnimation(_blue),
          )),
        ])),
        const SizedBox(width: 8),
        Container(width: 1, height: 30, color: _line),
        const SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Expires: ${_data.renewDate}', style: const TextStyle(color: _navy, fontSize: 9, fontWeight: FontWeight.w900)),
          Text('(${_data.daysLeft} Days Left)', style: const TextStyle(color: Color(0xFF9C397A), fontSize: 9, fontWeight: FontWeight.w800)),
        ]),
        const SizedBox(width: 8),
        _glass(radius: 14, padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Text('${_data.membershipPercent}%', style: const TextStyle(color: _blue, fontSize: 11, fontWeight: FontWeight.w900))),
      ]),
    ]));
  }

  Widget _pill(IconData icon, String text, Color bg, Color fg, {bool outlined = false}) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    decoration: BoxDecoration(
      color: bg, borderRadius: BorderRadius.circular(20),
      border: outlined ? Border.all(color: _line) : null,
      boxShadow: outlined ? const [] : [BoxShadow(color: bg.withValues(alpha: .18), blurRadius: 4, offset: const Offset(0, 1))],
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 10, color: fg), const SizedBox(width: 2),
      Text(text, style: TextStyle(color: fg, fontSize: 8.2, fontWeight: FontWeight.w900)),
    ]),
  );

  Widget _festivalBanner() => _glass(radius: 18, padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5), child: Row(children: [
    Expanded(flex: 3, child: Container(
      height: double.infinity, alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: .78), borderRadius: BorderRadius.circular(13), border: Border.all(color: _line)),
      child: const Text('amazon', style: TextStyle(color: Color(0xFF182D4A), fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -1.1)),
    )),
    const SizedBox(width: 6),
    Expanded(flex: 3, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.auto_awesome_rounded, color: Color(0xFFE7A51B), size: 17),
      const Text('Great Indian\nFestival', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF8A1C65), fontSize: 11, height: .95, fontWeight: FontWeight.w900)),
    ])),
    const SizedBox(width: 5),
    Expanded(flex: 3, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Up to 40% OFF', maxLines: 1, style: TextStyle(color: _navy, fontSize: 11, fontWeight: FontWeight.w900)),
      Text('Fitness & Wellness', maxLines: 1, style: TextStyle(color: _blue, fontSize: 8.5, fontWeight: FontWeight.w800)),
    ])),
    const SizedBox(width: 4),
    const Icon(Icons.fitness_center_rounded, color: _navy, size: 30),
    const SizedBox(width: 3),
    Align(alignment: Alignment.topRight, child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(color: _blue, borderRadius: BorderRadius.circular(10)),
      child: const Text('Sponsored', style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.w900)),
    )),
  ]));

  Widget _quickStats(bool compact) {
    final values = [
      ('Attendance', Icons.event_available_rounded, '${_data.attendanceRate}%', '+6%', _green),
      ('Workout', Icons.fitness_center_rounded, _data.workoutTime, '+12%', const Color(0xFF8151E8)),
      ('Payment', Icons.account_balance_wallet_rounded, _data.paymentAmount, 'SBI Card · 10% Cashback', _red),
      ('Body', Icons.monitor_weight_rounded, _data.bodyWeight, '-0.8 kg', const Color(0xFF159B62)),
    ];
    return Row(children: List.generate(4, (i) {
      final v = values[i];
      return Expanded(child: Padding(
        padding: EdgeInsets.only(right: i == 3 ? 0 : 4),
        child: InkWell(
          key: ValueKey('stat_tab_${['attendance','workout','payment','body'][i]}'),
          onTap: () => setState(() { _tab = i; _rail = 0; }),
          borderRadius: BorderRadius.circular(16),
          child: _glass(radius: 16, padding: const EdgeInsets.fromLTRB(3, 5, 3, 4), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(v.$2, color: v.$5, size: compact ? 13 : 15),
              const SizedBox(width: 2),
              Flexible(child: Text(v.$1, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: _navy, fontSize: 8.3, fontWeight: FontWeight.w900))),
            ]),
            const SizedBox(height: 4),
            if (i == 0)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(width: compact ? 38 : 44, height: compact ? 38 : 44, child: Stack(alignment: Alignment.center, children: [
                  SizedBox.expand(child: CircularProgressIndicator(value: _data.attendanceRate / 100, strokeWidth: 5, backgroundColor: const Color(0xFFD7E9F9), valueColor: const AlwaysStoppedAnimation(_green))),
                  Text('${_data.attendanceRate}%', style: const TextStyle(color: _navy, fontSize: 11, fontWeight: FontWeight.w900)),
                ])),
              ])
            else
              Text(v.$3, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: i == 2 ? _red : _navy, fontSize: compact ? 11 : 13, fontWeight: FontWeight.w900)),
            const SizedBox(height: 3),
            if (i == 1) _miniBars()
            else Text(v.$4, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: i == 2 ? _blue : _green, fontSize: i == 2 ? 6.3 : 8, fontWeight: FontWeight.w900)),
          ])),
        ),
      ));
    }));
  }

  Widget _miniBars() => SizedBox(height: 12, child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [5,8,10,12,13].map((h) => Container(
    width: 5, height: h.toDouble(), margin: const EdgeInsets.symmetric(horizontal: 1),
    decoration: BoxDecoration(color: const Color(0xFF8B54E8), borderRadius: BorderRadius.circular(3)),
  )).toList()));

  Widget _workspace(bool compact) {
    return _glass(radius: 22, padding: const EdgeInsets.all(6), child: Row(children: [
      SizedBox(width: compact ? 48 : 54, child: Column(children: List.generate(_railLabels.length, (i) {
        final selected = i == _rail;
        return Expanded(child: InkWell(
          key: ValueKey('rail_item_$i'),
          onTap: () => setState(() => _rail = i),
          borderRadius: BorderRadius.circular(13),
          child: Container(
            margin: const EdgeInsets.only(bottom: 2),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: selected ? const LinearGradient(colors: [_blue, Color(0xFF55B4F1)], begin: Alignment.topLeft, end: Alignment.bottomRight) : null,
              color: selected ? null : Colors.white.withValues(alpha: .35),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: selected ? Colors.white : _line.withValues(alpha: .65)),
              boxShadow: selected ? [BoxShadow(color: _blue.withValues(alpha: .25), blurRadius: 8, offset: const Offset(0, 2))] : const [],
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(_railIcons[i], color: selected ? Colors.white : _navy, size: compact ? 17 : 19),
              const SizedBox(height: 2),
              Text(_railLabels[i], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: selected ? Colors.white : _navy, fontSize: 8, fontWeight: FontWeight.w800)),
            ]),
          ),
        ));
      }))),
      const SizedBox(width: 6),
      Expanded(child: Column(children: [
        Row(children: [
          Icon(_railIcons[_rail], color: _blue, size: 19),
          const SizedBox(width: 5),
          Expanded(child: Text(_tab == 0 ? 'Attendance Intelligence' : ['Attendance','Workout','Payment','Body'][_tab] + ' Intelligence', maxLines: 1, overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: _navy, fontSize: 14, fontWeight: FontWeight.w900))),
          _glass(radius: 16, padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), child: Row(children: [
            Text(_data.attendanceMonthLabel, style: const TextStyle(color: _navy, fontSize: 9, fontWeight: FontWeight.w800)),
            const Icon(Icons.keyboard_arrow_down_rounded, color: _navy, size: 15),
          ])),
        ]),
        const SizedBox(height: 5),
        Expanded(child: _workspaceContent(compact)),
      ])),
    ]));
  }

  Widget _workspaceContent(bool compact) {
    if (_tab == 0 && _rail == 0) return _calendarWorkspace(compact);
    if (_tab == 0 && _rail == 1) return _trendWorkspace();
    if (_tab == 0 && _rail == 2) return _simplePanel('Recent attendance records', [
      ('Today', '${_data.checkInTime} · Checked in', _green),
      ('Yesterday', 'Present · 07:26 AM', _green),
      ('Previous session', 'Late · 07:48 AM', _amber),
      ('Missed session', 'Absent', _red),
    ]);
    if (_tab == 0 && _rail == 3) return _simplePanel('Member attendance insights', [
      ('Current streak', _data.currentStreak, _green),
      ('Best streak', _data.bestStreak, _blue),
      ('Present days', '${_data.presentCount}', _green),
      ('Late arrivals', '${_data.lateCount}', _amber),
      ('Missed sessions', '${_data.absentCount}', _red),
    ]);
    if (_tab == 0 && _rail == 4) return _goalWorkspace();
    if (_tab == 1) return _simplePanel(['Workout overview','Workout trend','Workout programs','Workout history'][_rail], [
      ('Today', _data.workoutTime, _blue), ('Weekly progress', '+12%', _green), ('Sessions', '5 this week', _navy),
    ]);
    if (_tab == 2) return _simplePanel(['Payment overview','Transactions','Due date & offers','Member rewards'][_rail], [
      ('Outstanding balance', _data.paymentAmount, _red), ('Next due date', _data.paymentNextDue, _amber), ('Early payment reward', '10% Cashback', _blue),
    ]);
    return _simplePanel(['Body overview','Body composition','Measurements','Body progress'][_rail], [
      ('Current weight', _data.bodyWeight, _blue), ('Change', '−0.8 kg', _green), ('Target', 'Member goal', _navy),
    ]);
  }

  Widget _calendarWorkspace(bool compact) => Row(children: [
    Expanded(flex: 6, child: _calendarGrid(compact)),
    const SizedBox(width: 6),
    Container(width: 1, color: _line.withValues(alpha: .8)),
    const SizedBox(width: 6),
    Expanded(flex: 4, child: _attendanceSummary(compact)),
  ]);

  Widget _calendarGrid(bool compact) {
    final byDay = {for (final day in _data.calendarDays) day.day: day};
    final first = DateTime(_data.attendanceYear, _data.attendanceMonth, 1).weekday;
    final count = DateTime(_data.attendanceYear, _data.attendanceMonth + 1, 0).day;
    final cells = <Widget>[];
    for (var i = 1; i < first; i++) { cells.add(const SizedBox.shrink()); }
    for (var day = 1; day <= count; day++) {
      final item = byDay[day];
      final sunday = DateTime(_data.attendanceYear, _data.attendanceMonth, day).weekday == DateTime.sunday;
      final status = item?.status ?? DayAttendanceStatus.empty;
      final color = switch (status) {
        DayAttendanceStatus.present => _green,
        DayAttendanceStatus.late => _amber,
        DayAttendanceStatus.absent => _red,
        DayAttendanceStatus.holiday || DayAttendanceStatus.empty => const Color(0xFFB7C8D9),
      };
      final filled = status == DayAttendanceStatus.present || status == DayAttendanceStatus.late || status == DayAttendanceStatus.absent;
      cells.add(Center(child: Container(
        width: compact ? 25 : 29, height: compact ? 25 : 29,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled ? color : const Color(0xFFE7F0F9),
          border: Border.all(color: item?.isToday == true ? _green : (filled ? color : _line), width: item?.isToday == true ? 2.2 : 1),
          boxShadow: [BoxShadow(color: (filled ? color : _blue).withValues(alpha: .16), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Stack(alignment: Alignment.center, children: [
          Padding(padding: EdgeInsets.only(bottom: sunday ? 5 : 0), child: Text('$day', style: TextStyle(color: filled ? Colors.white : _navy, fontSize: compact ? 9 : 10, fontWeight: FontWeight.w900))),
          if (sunday) const Positioned(bottom: 1, child: Text('OFF', style: TextStyle(color: _muted, fontSize: 5, fontWeight: FontWeight.w900))),
        ]),
      )));
    }
    while (cells.length % 7 != 0) { cells.add(const SizedBox.shrink()); }
    return Column(children: [
      const Row(children: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'].map((d) => Expanded(child: Center(child: Text(d, style: TextStyle(color: _navy, fontSize: 8.5, fontWeight: FontWeight.w900))))).toList()),
      const SizedBox(height: 3),
      Expanded(child: LayoutBuilder(builder: (context, constraints) {
        final rows = (cells.length / 7).ceil();
        return Column(children: List.generate(rows, (row) => Expanded(
          child: Row(children: List.generate(7, (column) => Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 1,
                vertical: compact ? 0.5 : 1.5,
              ),
              child: cells[row * 7 + column],
            ),
          ))),
        )));
      })),
      const SizedBox(height: 3),
      FittedBox(fit: BoxFit.scaleDown, child: Row(children: [
        _legend(_green, 'Present'), const SizedBox(width: 5), _legend(_amber, 'Late'),
        const SizedBox(width: 5), _legend(_red, 'Absent'), const SizedBox(width: 5), _legend(const Color(0xFFB7C8D9), 'Holiday'),
      ])),
    ]);
  }

  Widget _legend(Color color, String text) => Row(children: [
    Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    const SizedBox(width: 2),
    Text(text, style: const TextStyle(color: _muted, fontSize: 7.5, fontWeight: FontWeight.w700)),
  ]);

  Widget _attendanceSummary(bool compact) => Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Expanded(flex: 5, child: Center(child: SizedBox(
      width: compact ? 82 : 96, height: compact ? 82 : 96,
      child: Stack(alignment: Alignment.center, children: [
        SizedBox.expand(child: CircularProgressIndicator(value: _data.attendanceRate / 100, strokeWidth: 7, backgroundColor: const Color(0xFFD4E8F9), valueColor: const AlwaysStoppedAnimation(_blue))),
        Column(mainAxisSize: MainAxisSize.min, children: [
          Text('${_data.attendanceRate}%', style: const TextStyle(color: _navy, fontSize: 21, fontWeight: FontWeight.w900)),
          Text(_data.attendanceFraction, style: const TextStyle(color: _navy, fontSize: 7.5, fontWeight: FontWeight.w800)),
        ]),
      ]),
    ))),
    _statLine(_green, 'Present', _data.presentCount, _data.presentCount / 31),
    _statLine(_amber, 'Late', _data.lateCount, _data.lateCount / 31),
    _statLine(_red, 'Absent', _data.absentCount, _data.absentCount / 31),
    _statLine(const Color(0xFF9EB4CA), 'Holiday', _data.holidayCount, _data.holidayCount / 31),
    const SizedBox(height: 3),
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('🔥', style: TextStyle(fontSize: 12)),
      const SizedBox(width: 3),
      Text('${_data.currentStreak} Streak', style: const TextStyle(color: _navy, fontSize: 8.5, fontWeight: FontWeight.w900)),
    ]),
  ]);

  Widget _statLine(Color color, String label, int value, double fraction) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 4),
      Expanded(child: Text(label, style: const TextStyle(color: _navy, fontSize: 8, fontWeight: FontWeight.w700))),
      Text('$value', style: const TextStyle(color: _navy, fontSize: 8.5, fontWeight: FontWeight.w900)),
      const SizedBox(width: 3),
      SizedBox(width: 24, child: ClipRRect(borderRadius: BorderRadius.circular(5), child: LinearProgressIndicator(value: fraction, minHeight: 4, backgroundColor: const Color(0xFFDCEAF6), valueColor: AlwaysStoppedAnimation(color)))),
    ]),
  );

  Widget _trendWorkspace() => Column(children: [
    const Align(alignment: Alignment.centerLeft, child: Text('Attendance trend · last 7 weeks', style: TextStyle(color: _navy, fontSize: 10, fontWeight: FontWeight.w900))),
    const SizedBox(height: 8),
    Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [62,74,68,86,78,92,81].asMap().entries.map((entry) => Expanded(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text('${entry.value}%', style: const TextStyle(color: _navy, fontSize: 8, fontWeight: FontWeight.w800)),
        const SizedBox(height: 3),
        Expanded(child: Align(alignment: Alignment.bottomCenter, child: Container(width: 16, height: math.max(10, entry.value * .8), decoration: BoxDecoration(gradient: const LinearGradient(colors: [_blue, Color(0xFF76C8F7)], begin: Alignment.bottomCenter, end: Alignment.topCenter), borderRadius: BorderRadius.circular(7))))),
        const SizedBox(height: 3),
        Text('W${entry.key + 1}', style: const TextStyle(color: _muted, fontSize: 8)),
      ]),
    ))).toList())),
  ]);

  Widget _simplePanel(String title, List<(String, String, Color)> rows) => Container(
    width: double.infinity, padding: const EdgeInsets.all(9),
    decoration: BoxDecoration(color: Colors.white.withValues(alpha: .48), borderRadius: BorderRadius.circular(16), border: Border.all(color: _line)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: _navy, fontSize: 11, fontWeight: FontWeight.w900)),
      const SizedBox(height: 7),
      ...rows.map((r) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(children: [
        Container(width: 7, height: 7, decoration: BoxDecoration(color: r.$3, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Expanded(child: Text(r.$1, style: const TextStyle(color: _navy, fontSize: 9, fontWeight: FontWeight.w700))),
        Text(r.$2, style: TextStyle(color: r.$3, fontSize: 9, fontWeight: FontWeight.w900)),
      ]))),
    ]),
  );

  Widget _goalWorkspace() => Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Text('85%', style: TextStyle(color: _blue, fontSize: 30, fontWeight: FontWeight.w900)),
    const Text('Target attendance', style: TextStyle(color: _navy, fontSize: 10, fontWeight: FontWeight.w700)),
    const SizedBox(height: 8),
    ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: _data.attendanceRate / 85, minHeight: 8, backgroundColor: const Color(0xFFDCEAF6), valueColor: const AlwaysStoppedAnimation(_blue))),
    const SizedBox(height: 5),
    Text('Current ${_data.attendanceRate}% · Target 85%', style: const TextStyle(color: _muted, fontSize: 8)),
  ]);

  Widget _insights(bool compact) => _glass(radius: 18, padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), child: Row(children: [
    const Icon(Icons.auto_awesome_rounded, color: Color(0xFF8050E8), size: 22),
    const SizedBox(width: 4),
    const Expanded(child: Text('AI Insights', style: TextStyle(color: _navy, fontSize: 10, fontWeight: FontWeight.w900))),
    Container(width: 1, height: 28, color: _line),
    const SizedBox(width: 6),
    const Icon(Icons.bar_chart_rounded, color: _blue, size: 20),
    Expanded(flex: 2, child: Text('Attendance ↑ 6% vs last month', maxLines: 2, style: TextStyle(color: _navy, fontSize: compact ? 8 : 9, fontWeight: FontWeight.w800))),
    Container(width: 1, height: 28, color: _line),
    const SizedBox(width: 5),
    const Icon(Icons.emoji_events_rounded, color: _amber, size: 21),
    const SizedBox(width: 3),
    Expanded(child: Text('Best Streak ${_data.bestStreak}', maxLines: 2, style: const TextStyle(color: _navy, fontSize: 8.5, fontWeight: FontWeight.w900))),
    const Icon(Icons.chevron_right_rounded, color: _blue, size: 20),
  ]));

  Widget _glass({double? width, double? height, double radius = 16, EdgeInsets padding = EdgeInsets.zero, required Widget child}) => Container(
    width: width, height: height, padding: padding,
    decoration: BoxDecoration(
      gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xDFFFFFFF), Color(0xBDEAF6FF), Color(0xC8FFFFFF)]),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: Colors.white.withValues(alpha: .95), width: 1.2),
      boxShadow: [
        BoxShadow(color: const Color(0xFF74B9EC).withValues(alpha: .18), blurRadius: 10, offset: const Offset(0, 3)),
        BoxShadow(color: Colors.white.withValues(alpha: .8), blurRadius: 2, offset: const Offset(-1, -1)),
      ],
    ),
    child: child,
  );

  void _showInfo(String title, String body) => showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFFF3FAFF),
      title: Text(title, style: const TextStyle(color: _navy, fontWeight: FontWeight.w900)),
      content: Text(body, style: const TextStyle(color: _muted)),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
    ),
  );
}
