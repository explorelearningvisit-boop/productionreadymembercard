import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() => runApp(const MemberIntelligenceApp());

class MemberIntelligenceApp extends StatelessWidget {
  const MemberIntelligenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: t.background,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: t.dark ? Brightness.light : Brightness.dark,
          statusBarBrightness: t.dark ? Brightness.dark : Brightness.light,
          systemNavigationBarColor: t.background,
          systemNavigationBarIconBrightness: t.dark ? Brightness.light : Brightness.dark,
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxHeight < 650;
              final ultraCompact = constraints.maxHeight < 570;
              final gap = ultraCompact ? 3.0 : 5.0;
              final width = math.min(constraints.maxWidth - 12, 520.0);
              return Center(
                child: SizedBox(
                  width: width,
                  height: constraints.maxHeight,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [t.background, t.backgroundEnd],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _brandHeader(compact ? 40 : 46),
                          SizedBox(height: gap),
                          _memberCard(ultraCompact ? 148 : compact ? 164 : 184),
                          SizedBox(height: gap),
                          _adBanner(ultraCompact ? 48 : compact ? 56 : 66),
                          SizedBox(height: gap),
                          _quickMetrics(ultraCompact ? 58 : compact ? 66 : 74),
                          SizedBox(height: gap),
                          Expanded(child: _workspace()),
                          SizedBox(height: gap),
                          _smartInsightStrip(ultraCompact ? 32 : 40),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _brandHeader(double height) {
    return SizedBox(
      height: height,
      child: Row(children: [
        InkWell(
          onTap: _showThemePicker,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: height - 2, height: height - 2,
            decoration: t.panel(radius: 15, selected: true),
            child: Icon(Icons.fitness_center_rounded, color: t.primary, size: 23),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('BAD GYM', style: TextStyle(color: t.canvasText, fontFamily: 'Poppins', fontSize: 21, height: 1, fontWeight: FontWeight.w900, letterSpacing: -.7)),
            Text('Member Intelligence', style: TextStyle(color: t.softText, fontSize: 10, height: 1.2, fontWeight: FontWeight.w600)),
          ],
        )),
        _headerAction(Icons.search_rounded, 'Search', onTap: _showSearchDialog),
        const SizedBox(width: 6),
        _headerAction(Icons.notifications_none_rounded, 'Notifications', badge: '3', onTap: () => _showHeaderMessage('Notifications', 'You have 3 unread notifications.')),
        const SizedBox(width: 6),
        _headerAction(Icons.qr_code_scanner_rounded, 'QR scanner', onTap: () => _showHeaderMessage('QR scanner', 'Member QR: BG215')),
      ]),
    );
  }

  Future<void> _showSearchDialog() async {
    final controller = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: t.surface,
        title: Text('Search member', style: TextStyle(color: t.ink, fontWeight: FontWeight.w800)),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Name, member ID or phone',
            filled: true,
            fillColor: t.surfaceEnd,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
    controller.dispose();
  }

  void _showHeaderMessage(String title, String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: t.surface,
        title: Text(title, style: TextStyle(color: t.ink, fontWeight: FontWeight.w800)),
        content: Text(message, style: TextStyle(color: t.muted)),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
  }

  Widget _headerAction(IconData icon, String label, {String? badge, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 38, height: 38,
        decoration: t.panel(radius: 14),
        child: Stack(clipBehavior: Clip.none, children: [
          Center(child: Icon(icon, color: t.canvasText, size: 20)),
          if (badge != null) Positioned(right: -3, top: -4, child: Container(
            width: 16, height: 16, alignment: Alignment.center,
            decoration: const BoxDecoration(color: Color(0xFFE33143), shape: BoxShape.circle),
            child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
          )),
        ]),
      ),
    );
  }

  Widget _memberCard(double height) {
    final dense = height < 160;
    final avatarSize = dense ? 76.0 : 88.0;
    return Container(
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: t.panel(radius: t.radius + 3, selected: false),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 7, 8, 6),
        child: Column(children: [
          Expanded(child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: avatarSize, height: avatarSize,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [t.secondary.withOpacity(.30), t.surfaceEnd]),
                ),
                child: Image.asset(
                  'assets/images/avatar_ashwani_hq.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (_, __, ___) => Icon(Icons.person, color: t.primary, size: 56),
                ),
              ),
            ),
            const SizedBox(width: 7),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Flexible(child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(color: t.success, borderRadius: BorderRadius.circular(16)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: const [
                      Icon(Icons.check_rounded, color: Colors.white, size: 12),
                      SizedBox(width: 2),
                      Text('CHECKED-IN', style: TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.w900)),
                    ]),
                  )),
                  const SizedBox(width: 4),
                  Flexible(child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    decoration: BoxDecoration(color: t.surfaceEnd, borderRadius: BorderRadius.circular(15), border: Border.all(color: t.border)),
                    child: FittedBox(fit: BoxFit.scaleDown, child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.calendar_month_rounded, color: t.primary, size: 12),
                      const SizedBox(width: 3),
                      Text('16 Oct 2026 · 07:12 AM', style: TextStyle(color: t.cardText, fontSize: 8.2, fontWeight: FontWeight.w800)),
                    ])),
                  )),
                ]),
                const SizedBox(height: 4),
                Text(
                  'Ashwani Kumar Sharma Vishwakarma',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: t.cardText, fontFamily: 'Poppins', fontSize: dense ? 12 : 13.5, height: 1.02, letterSpacing: -.2, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 3),
                FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Row(children: [
                  Icon(Icons.badge_outlined, color: t.softText, size: 12),
                  const SizedBox(width: 3),
                  Text('BG215', style: TextStyle(color: t.softText, fontSize: 9, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 5),
                  Text('|', style: TextStyle(color: t.softText, fontSize: 9)),
                  const SizedBox(width: 5),
                  Icon(Icons.person_outline_rounded, color: t.softText, size: 12),
                  const SizedBox(width: 2),
                  Text('28 Yrs', style: TextStyle(color: t.softText, fontSize: 9, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 5),
                  Text('|', style: TextStyle(color: t.softText, fontSize: 9)),
                  const SizedBox(width: 5),
                  Icon(Icons.male_rounded, color: t.secondary, size: 13),
                  Text('Male', style: TextStyle(color: t.softText, fontSize: 9, fontWeight: FontWeight.w700)),
                ])),
                const SizedBox(height: 3),
                Wrap(spacing: 4, children: [
                  _memberBadge(Icons.check_circle_rounded, 'Active', t.success),
                  _memberBadge(Icons.workspace_premium_rounded, 'Gold Plan', t.warning, darkText: true),
                ]),
              ],
            )),
            const SizedBox(width: 5),
            Container(
              width: dense ? 40 : 48, height: dense ? 40 : 48,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: t.border, width: 1.2), boxShadow: [BoxShadow(color: t.primary.withOpacity(.12), blurRadius: 7)]),
              child: QrImageView(
                data: 'BADGYM:MEMBER:BG215',
                version: QrVersions.auto,
                padding: EdgeInsets.zero,
                eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.black),
                dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Colors.black),
              ),
            ),
          ])),
          Container(height: 1, color: t.border.withOpacity(.8), margin: const EdgeInsets.symmetric(vertical: 4)),
          Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('MEMBERSHIP  22 / 30 Days', style: TextStyle(color: t.cardText, fontSize: 9.5, fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              ClipRRect(borderRadius: BorderRadius.circular(10), child: LinearProgressIndicator(
                value: _membershipProgress, minHeight: 6, backgroundColor: t.neutral,
                valueColor: AlwaysStoppedAnimation<Color>(t.primary),
              )),
            ])),
            const SizedBox(width: 8),
            Container(width: 1, height: 30, color: t.border),
            const SizedBox(width: 8),
            Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('EXPIRES: 24 OCT 2026', style: TextStyle(color: t.danger, fontSize: 9.2, fontWeight: FontWeight.w900)),
              Text('(8 Days Left)', style: TextStyle(color: t.danger, fontSize: 9, fontWeight: FontWeight.w700)),
            ]),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              decoration: BoxDecoration(color: t.primary.withOpacity(.14), borderRadius: BorderRadius.circular(14)),
              child: Text('73%', style: TextStyle(color: t.primary, fontSize: 11, fontWeight: FontWeight.w900)),
            ),
          ]),
        ]),
      ),
    );
  }

  Widget _adBanner(double height) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(t.radius),
        child: Stack(fit: StackFit.expand, children: [
          Image.asset(
            'assets/promo/promo_card_full.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [t.primary, t.secondary]),
              ),
              child: Row(children: [
                const SizedBox(width: 12),
                const Icon(Icons.fitness_center_rounded, color: Colors.white, size: 28),
                const SizedBox(width: 8),
                const Expanded(child: Text('GREAT INDIAN FITNESS FESTIVAL  ·  UP TO 40% OFF', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900))),
              ]),
            ),
          ),
          Positioned(right: 7, top: 5, child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(color: t.primary.withOpacity(.92), borderRadius: BorderRadius.circular(12)),
            child: const Text('Sponsored', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900)),
          )),
        ]),
      ),
    );
  }

  Widget _smartInsightStrip(double height) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: t.panel(radius: t.radius, selected: false),
      child: Row(children: [
        Icon(Icons.auto_awesome_rounded, color: t.primary, size: 18),
        const SizedBox(width: 4),
        Expanded(child: Text('AI Insights', style: TextStyle(color: t.cardText, fontSize: 10, fontWeight: FontWeight.w900))),
        Container(width: 1, height: 22, color: t.border),
        const SizedBox(width: 7),
        Expanded(flex: 2, child: Text('Attendance  ↑ 6% vs last month', maxLines: 2, style: TextStyle(color: t.cardText, fontSize: 9, fontWeight: FontWeight.w800))),
        Container(width: 1, height: 22, color: t.border),
        const SizedBox(width: 7),
        Icon(Icons.emoji_events_rounded, color: t.warning, size: 17),
        const SizedBox(width: 3),
        Expanded(child: Text('Best streak 14 Days', maxLines: 2, style: TextStyle(color: t.cardText, fontSize: 9, fontWeight: FontWeight.w900))),
      ]),
    );
  }

  Widget _memberBadge(IconData icon, String label, Color color, {bool darkText = false}) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 11, color: darkText ? const Color(0xFF271B05) : Colors.white),
      const SizedBox(width: 3),
      Text(label, style: TextStyle(color: darkText ? const Color(0xFF271B05) : Colors.white, fontSize: 11, fontWeight: FontWeight.w900)),
    ]),
  );

  String _monthName(int month) => const ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][month - 1];


  Widget _quickMetrics(double height) {
    final tabs = [WorkspaceTab.attendance, WorkspaceTab.workout, WorkspaceTab.payment, WorkspaceTab.body];
    final labels = ['Attendance', 'Workout', 'Payment', 'Body'];
    final values = ['81%', '58 min', '₹500 Due', '69.5 kg'];
    final colors = [t.success, const Color(0xFF8053E8), t.danger, const Color(0xFF159B65)];
    final icons = [Icons.event_available_rounded, Icons.fitness_center_rounded, Icons.account_balance_wallet_rounded, Icons.monitor_weight_rounded];
    return SizedBox(height: height, child: Row(children: List.generate(4, (index) {
      final active = _tab == tabs[index];
      return Expanded(child: Padding(
        padding: EdgeInsets.only(right: index == 3 ? 0 : 4),
        child: InkWell(
          onTap: () => _setTab(tabs[index]),
          borderRadius: BorderRadius.circular(t.radius),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: t.panel(radius: t.radius, selected: active),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(icons[index], color: colors[index], size: 14),
                const SizedBox(width: 3),
                Flexible(child: Text(labels[index], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: t.cardText, fontSize: 8.5, fontWeight: FontWeight.w800))),
              ]),
              const SizedBox(height: 2),
              if (index == 0)
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(width: 28, height: 28, child: Stack(alignment: Alignment.center, children: [
                    SizedBox.expand(child: CircularProgressIndicator(value: .81, strokeWidth: 3, backgroundColor: t.neutral, valueColor: AlwaysStoppedAnimation<Color>(colors[index]))),
                    Text('81', style: TextStyle(color: t.cardText, fontSize: 8, fontWeight: FontWeight.w900)),
                  ])),
                  const SizedBox(width: 4),
                  Text('↑ +6%', style: TextStyle(color: t.success, fontSize: 9, fontWeight: FontWeight.w900)),
                ])
              else if (index == 1)
                Column(children: [
                  Text(values[index], style: TextStyle(color: t.cardText, fontSize: 12, height: 1, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 3),
                  SizedBox(height: 13, child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [5,8,10,12,13].map((h) => Container(
                    width: 5, height: h.toDouble(), margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(color: colors[index], borderRadius: BorderRadius.circular(3)),
                  )).toList())),
                ])
              else if (index == 2)
                Column(children: [
                  Text('₹500 Due', style: TextStyle(color: t.danger, fontSize: 11, height: 1, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 3),
                  Text('SBI Card · 10% Cashback', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: t.softText, fontSize: 6.8, fontWeight: FontWeight.w700)),
                ])
              else
                Column(children: [
                  Text(values[index], style: TextStyle(color: t.cardText, fontSize: 12, height: 1, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 3),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.trending_down_rounded, color: t.success, size: 12),
                    Text('-0.8 kg', style: TextStyle(color: t.success, fontSize: 8.5, fontWeight: FontWeight.w900)),
                  ]),
                ]),
            ]),
          ),
        ),
      ));
    })));
  }

  List<String> get _railLabels => switch (_tab) {
    WorkspaceTab.attendance => const ['Insights','Calendar','History','Trend','Goals','More'],
    WorkspaceTab.workout => const ['Overview','Trend','Programs','History'],
    WorkspaceTab.payment => const ['Overview','Transactions','Due & Offers','Rewards'],
    WorkspaceTab.body => const ['Overview','Composition','Measurements','Progress'],
  };

  List<IconData> get _railIcons => switch (_tab) {
    WorkspaceTab.attendance => const [Icons.bar_chart_rounded, Icons.calendar_month_rounded, Icons.history_rounded, Icons.show_chart_rounded, Icons.track_changes_rounded, Icons.more_horiz_rounded],
    WorkspaceTab.workout => const [Icons.fitness_center_rounded, Icons.show_chart_rounded, Icons.view_list_rounded, Icons.history_rounded],
    WorkspaceTab.payment => const [Icons.account_balance_wallet_rounded, Icons.receipt_long_rounded, Icons.event_available_rounded, Icons.stars_rounded],
    WorkspaceTab.body => const [Icons.monitor_weight_rounded, Icons.pie_chart_rounded, Icons.straighten_rounded, Icons.show_chart_rounded],
  };

  String get _workspaceTitle => switch (_tab) {
    WorkspaceTab.attendance => 'Attendance Intelligence',
    WorkspaceTab.workout => 'Workout Intelligence',
    WorkspaceTab.payment => 'Payment Intelligence',
    WorkspaceTab.body => 'Body Intelligence',
  };

  Widget _workspace() {
    final labels = _railLabels;
    final icons = _railIcons;
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: t.panel(radius: t.radius + 2),
      child: Column(children: [
        Row(children: [
          Expanded(child: Row(children: [
            Icon(icons[_subSection], color: t.primary, size: 18),
            const SizedBox(width: 5),
            Expanded(child: Text(_workspaceTitle, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(color: t.cardText, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w800))),
          ])),
          if (_tab == WorkspaceTab.attendance)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              decoration: BoxDecoration(color: t.surfaceEnd, borderRadius: BorderRadius.circular(14), border: Border.all(color: t.border)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(_monthName(_month) + ' ' + _year.toString(), style: TextStyle(color: t.cardText, fontSize: 10, fontWeight: FontWeight.w700)),
                const SizedBox(width: 3),
                InkWell(onTap: () => _changeMonth(1), child: Icon(Icons.keyboard_arrow_down_rounded, color: t.primary, size: 15)),
              ]),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(color: t.surfaceEnd, borderRadius: BorderRadius.circular(14), border: Border.all(color: t.border)),
              child: Text(switch (_tab) {
                WorkspaceTab.workout => 'THIS WEEK',
                WorkspaceTab.payment => 'ACCOUNT',
                WorkspaceTab.body => 'PROGRESS',
                WorkspaceTab.attendance => 'MONTH',
              }, style: TextStyle(color: t.cardText, fontSize: 9, fontWeight: FontWeight.w800)),
            ),
        ]),
        const SizedBox(height: 5),
        Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(
            width: 56,
            child: Column(children: List.generate(labels.length, (index) {
              final active = _subSection == index;
              return Expanded(child: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: InkWell(
                  onTap: () => _setSubSection(index),
                  borderRadius: BorderRadius.circular(t.style == 'athletic' ? 8 : 13),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: active ? LinearGradient(colors: [t.primary, t.secondary]) : null,
                      color: active ? null : t.surfaceEnd,
                      borderRadius: BorderRadius.circular(t.style == 'athletic' ? 8 : 13),
                      border: Border.all(color: active ? t.primary : t.border, width: active ? 1.4 : .7),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(icons[index], size: 12, color: active ? (t.dark ? Colors.black : Colors.white) : t.primary),
                      const SizedBox(height: 2),
                      Text(labels[index], maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: active ? (t.dark ? Colors.black : Colors.white) : t.cardText, fontSize: 11, fontWeight: FontWeight.w700)),
                    ]),
                  ),
                ),
              ));
            })),
          ),
          const SizedBox(width: 6),
          Expanded(child: _workspaceContent()),
        ])),
      ]),
    );
  }

  Widget _workspaceContent() {
    switch (_tab) {
      case WorkspaceTab.attendance:
        return switch (_subSection) {
          0 => _attendanceInsights(),
          1 => _attendanceCalendar(),
          2 => _attendanceHistory(),
          3 => _attendanceTrend(),
          4 => _attendanceGoal(),
          5 => _attendanceInsights(),
          _ => _attendanceCalendar(),
        };
      case WorkspaceTab.workout:
        return _workoutContent();
      case WorkspaceTab.payment:
        return _paymentContent();
      case WorkspaceTab.body:
        return _bodyContent();
    }
  }

  Widget _innerPanel({required String title, required Widget child, EdgeInsets padding = const EdgeInsets.all(7)}) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [t.surface, t.surfaceEnd]),
        borderRadius: BorderRadius.circular(math.max(9, t.radius - 5)),
        border: Border.all(color: t.border, width: .8),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (title.isNotEmpty) Text(title, style: TextStyle(color: t.cardText, fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w800)),
        if (title.isNotEmpty) const SizedBox(height: 4),
        Expanded(child: child),
      ]),
    );
  }

  Widget _attendanceCalendar() {
    return _innerPanel(
      title: '',
      padding: const EdgeInsets.all(6),
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(flex: 6, child: Column(children: [
          Row(children: const ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'].map((d) => Expanded(
            child: Center(child: Text(d, style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Colors.grey))),
          )).toList()),
          const SizedBox(height: 3),
          Expanded(child: LayoutBuilder(builder: (context, constraints) {
            final rowExtent = ((constraints.maxHeight - 8) / 5).clamp(22.0, 34.0).toDouble();
            final diameter = math.min(29.0, rowExtent - 2);
            final days = <Widget>[];
            for (var i = 0; i < _firstWeekdayOffset; i++) {
              days.add(const SizedBox.shrink());
            }
            for (var day = 1; day <= _daysInMonth; day++) {
              final kind = _dayKind(day);
              final isToday = _year == _today.year && _month == _today.month && day == _today.day;
              final isSunday = DateTime(_year, _month, day).weekday == DateTime.sunday;
              final color = switch (kind) {
                DayKind.present => t.success,
                DayKind.late => t.warning,
                DayKind.absent => t.danger,
                DayKind.holiday || DayKind.off => t.muted,
              };
              final filled = kind == DayKind.present || kind == DayKind.late || kind == DayKind.absent;
              days.add(Center(child: SizedBox(
                width: diameter,
                height: diameter,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: filled ? color : t.neutral.withOpacity(.72),
                    border: Border.all(color: isToday ? t.primary : (filled ? color : t.border), width: isToday ? 2 : 1),
                    boxShadow: isToday ? [BoxShadow(color: t.primary.withOpacity(.18), blurRadius: 5)] : const [],
                  ),
                  alignment: Alignment.center,
                  child: Stack(alignment: Alignment.center, children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: isSunday || kind == DayKind.holiday ? 5 : 0),
                      child: Text('$day', style: TextStyle(
                        color: filled ? Colors.white : t.cardText,
                        fontSize: 10,
                        height: 1,
                        fontWeight: FontWeight.w900,
                      )),
                    ),
                    if (isSunday) Positioned(bottom: 1, child: Text('OFF', style: TextStyle(
                      color: filled ? Colors.white : t.muted, fontSize: 5.5, height: 1, fontWeight: FontWeight.w900,
                    ))),
                    if (kind == DayKind.holiday && !isSunday) Positioned(bottom: 1, child: Text('HOL', style: TextStyle(
                      color: filled ? Colors.white : t.muted, fontSize: 5.5, height: 1, fontWeight: FontWeight.w900,
                    ))),
                  ]),
                ),
              )));
            }
            while (days.length < 35) {
              days.add(const SizedBox.shrink());
            }
            return GridView.count(
              crossAxisCount: 7,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 2,
              crossAxisSpacing: 1,
              mainAxisExtent: rowExtent,
              childAspectRatio: 1,
              children: days,
            );
          })),
        ])),
        const SizedBox(width: 7),
        Container(width: 1, color: t.border),
        const SizedBox(width: 7),
        Expanded(flex: 4, child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 4, child: Center(child: SizedBox(
              width: 66, height: 66,
              child: Stack(alignment: Alignment.center, children: [
                SizedBox.expand(child: CircularProgressIndicator(
                  value: _attendanceRate / 100,
                  strokeWidth: 6,
                  backgroundColor: t.neutral,
                  valueColor: AlwaysStoppedAnimation<Color>(t.primary),
                )),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('$_attendanceRate%', style: TextStyle(color: t.cardText, fontSize: 16, fontWeight: FontWeight.w900)),
                  Text('$_tracked / $_daysInMonth', style: TextStyle(color: t.softText, fontSize: 8, fontWeight: FontWeight.w700)),
                ]),
              ]),
            ))),
            _attendanceStatRow('Present', _present, t.success),
            _attendanceStatRow('Late', _late, t.warning),
            _attendanceStatRow('Absent', _absent, t.danger),
            _attendanceStatRow('Holiday', _holiday, t.muted),
            const SizedBox(height: 3),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('🔥', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 3),
              Text('5 Days Streak', style: TextStyle(color: t.cardText, fontSize: 8.5, fontWeight: FontWeight.w900)),
            ]),
          ],
        )),
      ]),
    );
  }

  Widget _attendanceStatRow(String label, int value, Color color) {
    final percent = _tracked == 0 ? 0.0 : value / _tracked;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Expanded(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: t.cardText, fontSize: 8, fontWeight: FontWeight.w700))),
        Text('$value', style: TextStyle(color: t.cardText, fontSize: 8, fontWeight: FontWeight.w900)),
        const SizedBox(width: 4),
        SizedBox(width: 27, child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 4,
            backgroundColor: t.neutral,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        )),
      ]),
    );
  }

  Widget _legendDot(String label, Color color) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    const SizedBox(width: 2),
    Flexible(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,
      style: TextStyle(color: t.softText, fontSize: 10, fontWeight: FontWeight.w700))),
  ]);

  Widget _attendanceTrend() => _innerPanel(
    title: 'Attendance trend · last 7 weeks',
    child: Column(children: [
      Expanded(child: LayoutBuilder(builder: (context, constraints) {
        final values = [62, 74, 68, 86, 78, 92, _attendanceRate].map((v) => v.toDouble()).toList();
        final barAreaHeight = math.max(60.0, constraints.maxHeight - 34).toDouble();
        return Row(crossAxisAlignment: CrossAxisAlignment.end, children: List.generate(7, (i) {
          return Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Column(children: [
              Text('${values[i].round()}%', style: TextStyle(color: t.cardText, fontSize: 9, fontWeight: FontWeight.w800)),
              const SizedBox(height: 3),
              Expanded(child: Align(alignment: Alignment.bottomCenter, child: Container(
                width: 18,
                height: barAreaHeight * values[i] / 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [t.primary, t.secondary]),
                  borderRadius: BorderRadius.circular(t.style == 'athletic' ? 3 : 9),
                ),
              ))),
              const SizedBox(height: 3),
              Text('W${i + 1}', style: TextStyle(color: t.softText, fontSize: 9)),
            ]),
          ));
        }));
      })),
      const SizedBox(height: 4),
      _metricLine('Monthly attendance', '$_attendanceRate%', t.success),
      _metricLine('Late arrivals', '$_late', t.warning),
    ]),
  );

  Widget _attendanceHistory() => _innerPanel(
    title: 'Recent attendance records',
    child: Column(children: [
      _metricLine('Today', '07:12 AM · Checked in', t.success),
      _metricLine('Yesterday', 'Present · 07:26 AM', t.success),
      _metricLine('Previous session', 'Late · 07:48 AM', t.warning),
      _metricLine('Missed session', 'Absent', t.danger),
      _metricLine('Weekly total', '5 sessions', t.primary),
      const Spacer(),
      Text('Sample activity · connect live attendance source for verified records', style: TextStyle(color: t.softText, fontSize: 6.5)),
    ]),
  );

  Widget _attendanceInsights() => _innerPanel(
    title: 'Member attendance insights',
    child: Column(children: [
      _metricLine('Current streak', '5 days', t.success),
      _metricLine('Best streak', '14 days', t.primary),
      _metricLine('Present days', _present.toString(), t.success),
      _metricLine('Late arrivals', _late.toString(), t.warning),
      _metricLine('Missed sessions', _absent.toString(), t.danger),
      const Spacer(),
      Image.asset('assets/badges/streak_flame_hq.png', height: 38, fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Icon(Icons.local_fire_department_rounded, color: t.primary, size: 34)),
    ]),
  );

  Widget _attendanceGoal() => _innerPanel(
    title: 'Monthly consistency goal',
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('85%', style: TextStyle(color: t.primary, fontSize: 32, fontWeight: FontWeight.w900)),
      Text('Target attendance', style: TextStyle(color: t.cardText, fontSize: 10, fontWeight: FontWeight.w700)),
      const SizedBox(height: 10),
      ClipRRect(borderRadius: BorderRadius.circular(12), child: LinearProgressIndicator(
        value: (_attendanceRate / 85).clamp(0, 1), minHeight: 9,
        backgroundColor: t.neutral, valueColor: AlwaysStoppedAnimation<Color>(t.primary),
      )),
      const SizedBox(height: 6),
      Text('Current $_attendanceRate%  ·  Target 85%', style: TextStyle(color: t.softText, fontSize: 7)),
    ]),
  );

  Widget _metricLine(String label, String value, Color color) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [
      Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 6),
      Expanded(child: Text(label, style: TextStyle(color: t.cardText, fontSize: 10, fontWeight: FontWeight.w700))),
      Text(value, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900)),
    ]),
  );

  Widget _workoutContent() {
    if (_subSection == 2) {
      return _innerPanel(title: 'Workout programs', child: Center(child: Text(
        'Program library is not connected yet', textAlign: TextAlign.center,
        style: TextStyle(color: t.softText, fontSize: 12, fontWeight: FontWeight.w700),
      )));
    }
    if (_subSection == 3) {
      return _innerPanel(title: 'Workout history', child: Center(child: Text(
        'Session history is not connected yet', textAlign: TextAlign.center,
        style: TextStyle(color: t.softText, fontSize: 12, fontWeight: FontWeight.w700),
      )));
    }
    final values = _subSection == 1
        ? [32.0, 56, 44, 78, 66, 91, 72]
        : [38.0, 49, 58, 64, 70, 82, 88];
    return _innerPanel(
      title: _railLabels[_subSection] + ' · workout activity',
      child: Column(children: [
        Row(children: [
          Text('58 min today', style: TextStyle(color: t.cardText, fontSize: 9.5, height: 1, fontWeight: FontWeight.w900)),
          const Spacer(),
          Text('+12%', style: TextStyle(color: t.success, fontSize: 9.5, height: 1, fontWeight: FontWeight.w900)),
        ]),
        const SizedBox(height: 3),
        Expanded(child: LayoutBuilder(builder: (context, constraints) {
          final maxBarHeight = math.max(6.0, constraints.maxHeight - 24).toDouble();
          return Row(crossAxisAlignment: CrossAxisAlignment.end, children: List.generate(values.length, (i) =>
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Expanded(child: Align(alignment: Alignment.bottomCenter, child: Container(
                  height: math.min((values[i] / 100) * maxBarHeight, maxBarHeight).toDouble(),
                  width: 16,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [t.secondary, t.primary], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ))),
                const SizedBox(height: 2),
                Text(['M','T','W','T','F','S','S'][i], style: TextStyle(color: t.softText, fontSize: 9, height: 1)),
              ]),
            )),
          ));
        })),
      ]),
    );
  }

  Widget _paymentContent() {
    final title = _railLabels[_subSection];
    if (_subSection == 1) {
      return _innerPanel(title: 'Payment transactions', child: Column(children: [
        _metricLine('Last payment', '₹4,500 · Paid', t.success),
        _metricLine('Outstanding balance', '₹500 Due', t.danger),
        _metricLine('Payment history', 'Not connected', t.softText),
        const Spacer(),
        Text('Transaction records are not connected in this demo', style: TextStyle(color: t.softText, fontSize: 9)),
      ]));
    }
    if (_subSection == 2) {
      return _innerPanel(title: 'Due date & offers', child: Column(children: [
        _metricLine('Outstanding balance', '₹500 Due', t.danger),
        _metricLine('Next due date', 'In 4 days', t.warning),
        _metricLine('Early payment reward', 'Up to 2% savings', t.primary),
        const Spacer(),
        Text('Offers shown here are sample content', style: TextStyle(color: t.softText, fontSize: 9)),
      ]));
    }
    if (_subSection == 3) {
      return _innerPanel(title: 'Member rewards', child: Center(child: Text(
        'Rewards are not connected yet', textAlign: TextAlign.center,
        style: TextStyle(color: t.softText, fontSize: 12, fontWeight: FontWeight.w700),
      )));
    }
    return _innerPanel(
      title: '$title · member account',
      child: Column(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: t.danger.withOpacity(.09),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: t.danger.withOpacity(.35)),
          ),
          child: Row(children: [
            Icon(Icons.account_balance_wallet_rounded, color: t.danger, size: 22),
            const SizedBox(width: 8),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Outstanding balance', style: TextStyle(color: t.softText, fontSize: 10)),
              Text('₹500 DUE', style: TextStyle(color: t.danger, fontSize: 18, fontWeight: FontWeight.w900)),
            ])),
            Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
              decoration: BoxDecoration(color: t.primary, borderRadius: BorderRadius.circular(18)),
              child: const Text('Pay now ›', style: TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w900))),
          ]),
        ),
        const SizedBox(height: 7),
        _metricLine('Next due date', 'In 4 days', t.warning),
        _metricLine('Last payment', '₹4,500 · Paid', t.success),
        _metricLine('Early payment reward', 'Up to 2% savings', t.primary),
        _metricLine('Payment history', 'Not connected', t.softText),
        const Spacer(),
        Text('Sample payment details · no payment is collected in this demo', style: TextStyle(color: t.softText, fontSize: 9)),
      ]),
    );
  }

  Widget _bodyContent() {
    final title = _railLabels[_subSection];
    if (_subSection == 1 || _subSection == 2) {
      return _innerPanel(title: _subSection == 1 ? 'Body composition' : 'Body measurements', child: Center(child: Text(
        _subSection == 1 ? 'Composition data not connected' : 'Measurement history not connected',
        textAlign: TextAlign.center,
        style: TextStyle(color: t.softText, fontSize: 12, fontWeight: FontWeight.w700),
      )));
    }
    if (_subSection == 3) {
      return _innerPanel(title: 'Body progress', child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('69.5 kg', style: TextStyle(color: t.primary, fontSize: 28, fontWeight: FontWeight.w900)),
        Text('Current recorded weight', style: TextStyle(color: t.cardText, fontSize: 10)),
        const SizedBox(height: 8),
        Text('Progress history not connected', style: TextStyle(color: t.softText, fontSize: 9)),
      ]));
    }
    return _innerPanel(
      title: '$title · body progress',
      child: Column(children: [
        Row(children: [
          Expanded(child: _metricTile('Current weight', '69.5 kg', Icons.monitor_weight_outlined)),
          const SizedBox(width: 5),
          Expanded(child: _metricTile('Change', '−0.8 kg', Icons.trending_down_rounded)),
        ]),
        const SizedBox(height: 8),
        Expanded(child: Center(child: Image.asset('assets/images/illustration_3d_body_scale.png', fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Icon(Icons.accessibility_new_rounded, size: 64, color: t.primary)))),
        _metricLine('Body measurements', 'Not connected', t.softText),
        _metricLine('Progress target', 'Member goal', t.success),
      ]),
    );
  }

  Widget _metricTile(String label, String value, IconData icon) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
    decoration: BoxDecoration(
      color: t.primary.withOpacity(.08),
      borderRadius: BorderRadius.circular(11),
      border: Border.all(color: t.border),
    ),
    child: Row(children: [
      Icon(icon, color: t.primary, size: 13),
      const SizedBox(width: 5),
      Expanded(child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(color: t.cardText, fontSize: 12, height: 1.05, fontWeight: FontWeight.w800)),
          Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(color: t.softText, fontSize: 9, height: 1, fontWeight: FontWeight.w700)),
        ],
      )),
    ]),
  );

}
