import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() => runApp(const MemberIntelligenceApp());

class MemberIntelligenceApp extends StatelessWidget {
  const MemberIntelligenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BAD GYM Member Intelligence',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
      textTheme: const TextTheme(
        bodySmall: TextStyle(fontFamily: 'Inter'),
        bodyMedium: TextStyle(fontFamily: 'Inter'),
        bodyLarge: TextStyle(fontFamily: 'Inter'),
      ),
        scaffoldBackgroundColor: const Color(0xFFF3F5F9),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB51F31)),
      ),
      home: const MemberDashboardPage(),
    );
  }
}

enum DayKind { present, late, absent, holiday, off }
enum WorkspaceTab { attendance, workout, payment, body }

class DashboardTheme {
  const DashboardTheme({
    required this.id,
    required this.name,
    required this.description,
    required this.background,
    required this.backgroundEnd,
    required this.surface,
    required this.surfaceEnd,
    required this.ink,
    required this.muted,
    required this.primary,
    required this.secondary,
    required this.border,
    required this.success,
    required this.warning,
    required this.danger,
    required this.neutral,
    required this.radius,
    required this.borderWidth,
    required this.dark,
    required this.style,
    required this.art,
    required this.promoArt,
  });

  final int id;
  final String name;
  final String description;
  final Color background;
  final Color backgroundEnd;
  final Color surface;
  final Color surfaceEnd;
  final Color ink;
  final Color muted;
  final Color primary;
  final Color secondary;
  final Color border;
  final Color success;
  final Color warning;
  final Color danger;
  final Color neutral;
  final double radius;
  final double borderWidth;
  final bool dark;
  final String style;
  final String art;
  final String promoArt;

  Color get canvasText => dark ? Colors.white : ink;
  Color get softText => dark ? const Color(0xFFB9BEC8) : muted;
  Color get cardText => dark ? Colors.white : ink;

  BoxDecoration panel({double? radius, bool selected = false}) {
    final r = radius ?? this.radius;
    final base = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: dark
            ? [surface.withOpacity(.98), surfaceEnd.withOpacity(.96)]
            : [surface.withOpacity(.98), surfaceEnd.withOpacity(.96)],
      ),
      borderRadius: BorderRadius.circular(r),
      border: Border.all(
        color: selected ? primary : border,
        width: selected ? borderWidth + .6 : borderWidth,
      ),
      boxShadow: [
        BoxShadow(
          color: primary.withOpacity(dark ? .17 : .10),
          blurRadius: style == 'neon' ? 15 : 9,
          spreadRadius: style == 'neon' ? 1 : 0,
          offset: const Offset(0, 3),
        ),
        if (style == 'glass')
          BoxShadow(color: Colors.white.withOpacity(.55), blurRadius: 2, offset: const Offset(-1, -1)),
      ],
    );
    return base;
  }
}

const dashboardThemes = <DashboardTheme>[
  DashboardTheme(
    id: 0, name: 'Ice Glass', description: 'Crystal blue · frosted glass',
    background: Color(0xFFEAF5FF), backgroundEnd: Color(0xFFCFE4FF),
    surface: Color(0xFFFDFEFF), surfaceEnd: Color(0xFFDCEBFF),
    ink: Color(0xFF10294C), muted: Color(0xFF526B8B),
    primary: Color(0xFF1679D8), secondary: Color(0xFF59B7F4),
    border: Color(0xFFB5D8FF), success: Color(0xFF0B9E50),
    warning: Color(0xFFF0B323), danger: Color(0xFFD93648),
    neutral: Color(0xFFD5DFEB), radius: 23, borderWidth: 1.2,
    dark: false, style: 'glass', art: 'assets/images/illustration_3d_dumbbell_mini.png', promoArt: 'assets/hero/dumbbell_3d.png',
  ),
  DashboardTheme(
    id: 1, name: 'Crimson Gold', description: 'Deep red · gold edge · luxury',
    background: Color(0xFF50000B), backgroundEnd: Color(0xFF19040A),
    surface: Color(0xFF8E0719), surfaceEnd: Color(0xFF51000C),
    ink: Color(0xFF2A080B), muted: Color(0xFFFFD9C4),
    primary: Color(0xFFFFC928), secondary: Color(0xFFE23A2E),
    border: Color(0xFFFFD36A), success: Color(0xFF14B95B),
    warning: Color(0xFFFFC12B), danger: Color(0xFFE3263B),
    neutral: Color(0xFFB6A8A5), radius: 20, borderWidth: 1.6,
    dark: true, style: 'gold', art: 'assets/themes/crimson_wave/checkin_success_banner.png', promoArt: 'assets/hero/hero_athlete.png',
  ),
  DashboardTheme(
    id: 2, name: 'Festival Yellow', description: 'Sunshine yellow · festive red',
    background: Color(0xFFFFF1A8), backgroundEnd: Color(0xFFFFD52D),
    surface: Color(0xFFFFFEF6), surfaceEnd: Color(0xFFFFEAA0),
    ink: Color(0xFF241B0A), muted: Color(0xFF74602D),
    primary: Color(0xFFC51D2B), secondary: Color(0xFFFFBE18),
    border: Color(0xFFE7B92B), success: Color(0xFF168B35),
    warning: Color(0xFFE5A900), danger: Color(0xFFD92D2D),
    neutral: Color(0xFFD8D2C2), radius: 19, borderWidth: 1.2,
    dark: false, style: 'festival', art: 'assets/themes/festive_gold/marquee_header.png', promoArt: 'assets/themes/festive_gold/top_lanterns.png',
  ),
  DashboardTheme(
    id: 3, name: 'Sky Pearl', description: 'Soft blue · pearl white · 3D',
    background: Color(0xFFDDEEFF), backgroundEnd: Color(0xFFF2F8FF),
    surface: Color(0xFFFFFFFF), surfaceEnd: Color(0xFFDCEBFA),
    ink: Color(0xFF0C2850), muted: Color(0xFF59718F),
    primary: Color(0xFF1769D2), secondary: Color(0xFF62B7EF),
    border: Color(0xFFB6D4F7), success: Color(0xFF16A34A),
    warning: Color(0xFFEAB308), danger: Color(0xFFDC3545),
    neutral: Color(0xFFD7DFEA), radius: 25, borderWidth: 1.1,
    dark: false, style: 'pearl', art: 'assets/backgrounds/bg_waves.png', promoArt: 'assets/hero/dumbbell_3d.png',
  ),
  DashboardTheme(
    id: 4, name: 'Athletic Red', description: 'White concrete · racing red',
    background: Color(0xFFF2F1EF), backgroundEnd: Color(0xFFE3E2E0),
    surface: Color(0xFFFFFFFF), surfaceEnd: Color(0xFFF2F0EE),
    ink: Color(0xFF151515), muted: Color(0xFF626262),
    primary: Color(0xFFD71927), secondary: Color(0xFF282828),
    border: Color(0xFFBFC0C2), success: Color(0xFF168B35),
    warning: Color(0xFFE5A900), danger: Color(0xFFD71927),
    neutral: Color(0xFFD7D7D7), radius: 11, borderWidth: 1.1,
    dark: false, style: 'athletic', art: 'assets/promo/promo_protein_bar.png', promoArt: 'assets/hero/hero_weights.png',
  ),
  DashboardTheme(
    id: 5, name: 'Emerald Pulse', description: 'Pearl white · vivid emerald',
    background: Color(0xFFF1F7EF), backgroundEnd: Color(0xFFDCEBD8),
    surface: Color(0xFFFFFFFF), surfaceEnd: Color(0xFFE7F3E3),
    ink: Color(0xFF122B1A), muted: Color(0xFF58705E),
    primary: Color(0xFF16A34A), secondary: Color(0xFF91D52B),
    border: Color(0xFFB7DDB9), success: Color(0xFF149447),
    warning: Color(0xFFE7AD17), danger: Color(0xFFD93643),
    neutral: Color(0xFFD8E0D8), radius: 22, borderWidth: 1.4,
    dark: false, style: 'emerald', art: 'assets/themes/emerald_neon/neon_green_dumbbell.png', promoArt: 'assets/themes/emerald_neon/neon_green_dumbbell.png',
  ),
  DashboardTheme(
    id: 6, name: 'Royal Ruby', description: 'Ruby red · champagne gold',
    background: Color(0xFF790018), backgroundEnd: Color(0xFF32000E),
    surface: Color(0xFFA70D25), surfaceEnd: Color(0xFF680018),
    ink: Color(0xFF31000A), muted: Color(0xFFFFD5C9),
    primary: Color(0xFFFFD15B), secondary: Color(0xFFED3147),
    border: Color(0xFFFFC65A), success: Color(0xFF13B85A),
    warning: Color(0xFFFFC22D), danger: Color(0xFFFF4659),
    neutral: Color(0xFFB9A5A4), radius: 21, borderWidth: 1.7,
    dark: true, style: 'ruby', art: 'assets/themes/festive_gold/bottom_gear.png', promoArt: 'assets/themes/royal_purple/purple_shaker.png',
  ),
  DashboardTheme(
    id: 7, name: 'Gold Festival', description: 'Warm gold · ivory · crimson',
    background: Color(0xFFFFE47A), backgroundEnd: Color(0xFFFFF4C8),
    surface: Color(0xFFFFFEF8), surfaceEnd: Color(0xFFFFEFC0),
    ink: Color(0xFF2C1B0B), muted: Color(0xFF7B5D34),
    primary: Color(0xFFB51F31), secondary: Color(0xFFE4A900),
    border: Color(0xFFE7BE49), success: Color(0xFF178B3C),
    warning: Color(0xFFE8A900), danger: Color(0xFFD42D36),
    neutral: Color(0xFFD9D2C4), radius: 18, borderWidth: 1.3,
    dark: false, style: 'goldFestival', art: 'assets/themes/festive_gold/top_lanterns.png', promoArt: 'assets/themes/festive_gold/top_lanterns.png',
  ),
  DashboardTheme(
    id: 8, name: 'Obsidian Neon', description: 'Carbon black · neon lime',
    background: Color(0xFF101211), backgroundEnd: Color(0xFF050706),
    surface: Color(0xFF242925), surfaceEnd: Color(0xFF111713),
    ink: Color(0xFF0A100B), muted: Color(0xFFB8C1B8),
    primary: Color(0xFFC4FF00), secondary: Color(0xFF8CDA00),
    border: Color(0xFF8EBB13), success: Color(0xFFB5F500),
    warning: Color(0xFFFFC928), danger: Color(0xFFFF4B53),
    neutral: Color(0xFF657067), radius: 17, borderWidth: 1.4,
    dark: true, style: 'neon', art: 'assets/images/black_plates.png', promoArt: 'assets/images/black_plates.png',
  ),
  DashboardTheme(
    id: 9, name: 'Minimal Red', description: 'Clean white · sharp red detail',
    background: Color(0xFFF7F7F7), backgroundEnd: Color(0xFFECECEC),
    surface: Color(0xFFFFFFFF), surfaceEnd: Color(0xFFF8F8F8),
    ink: Color(0xFF171717), muted: Color(0xFF686868),
    primary: Color(0xFFD51E2B), secondary: Color(0xFF202020),
    border: Color(0xFFD8D8D8), success: Color(0xFF178B3C),
    warning: Color(0xFFE6AA16), danger: Color(0xFFD51E2B),
    neutral: Color(0xFFDADADA), radius: 14, borderWidth: 1,
    dark: false, style: 'minimal', art: 'assets/images/illustration_3d_workout_dumbbells.png', promoArt: 'assets/hero/dumbbell_3d.png',
  ),
];

class MemberDashboardPage extends StatefulWidget {
  const MemberDashboardPage({super.key});

  @override
  State<MemberDashboardPage> createState() => _MemberDashboardPageState();
}

class _MemberDashboardPageState extends State<MemberDashboardPage> {
  int _themeIndex = 0;
  WorkspaceTab _tab = WorkspaceTab.attendance;
  int _subSection = 0;
  late final DateTime _today = DateTime(2026, 10, 16);
  late int _month = 10;
  late int _year = 2026;

  DashboardTheme get t => dashboardThemes[_themeIndex];
  DateTime get _monthDate => DateTime(_year, _month, 1);
  int get _daysInMonth => DateUtils.getDaysInMonth(_year, _month);
  int get _firstWeekdayOffset => (_monthDate.weekday + 6) % 7;
  DayKind _dayKind(int day) {
    if (_month == 10 && _year == 2026) {
      const fixture = <int, DayKind>{
        1: DayKind.off, 2: DayKind.off, 3: DayKind.present, 4: DayKind.off,
        5: DayKind.present, 6: DayKind.present, 7: DayKind.present, 8: DayKind.present,
        9: DayKind.present, 10: DayKind.late, 11: DayKind.off, 12: DayKind.present,
        13: DayKind.present, 14: DayKind.present, 15: DayKind.present, 16: DayKind.present,
        17: DayKind.absent, 18: DayKind.present, 19: DayKind.present, 20: DayKind.present,
        21: DayKind.late, 22: DayKind.present, 23: DayKind.absent, 24: DayKind.absent,
        25: DayKind.off, 26: DayKind.present, 27: DayKind.present, 28: DayKind.late,
        29: DayKind.present, 30: DayKind.present, 31: DayKind.present,
      };
      return fixture[day] ?? DayKind.off;
    }
    final date = DateTime(_year, _month, day);
    if (date.weekday == DateTime.sunday) return DayKind.off;
    if (date.isAfter(_today)) return DayKind.off;
    if (day % 13 == 0 || day % 17 == 0) return DayKind.absent;
    if (day % 10 == 0) return DayKind.late;
    if (day % 11 == 0) return DayKind.holiday;
    return DayKind.present;
  }

  int get _present => _month == 10 && _year == 2026 ? 23 : List.generate(_daysInMonth, (i) => _dayKind(i + 1)).where((v) => v == DayKind.present).length;
  int get _late => _month == 10 && _year == 2026 ? 2 : List.generate(_daysInMonth, (i) => _dayKind(i + 1)).where((v) => v == DayKind.late).length;
  int get _absent => _month == 10 && _year == 2026 ? 2 : List.generate(_daysInMonth, (i) => _dayKind(i + 1)).where((v) => v == DayKind.absent).length;
  int get _holiday => _month == 10 && _year == 2026 ? 4 : List.generate(_daysInMonth, (i) => _dayKind(i + 1)).where((v) => v == DayKind.holiday).length;
  int get _tracked => _present + _late + _absent;
  int get _countOffDays => List.generate(_daysInMonth, (i) => _dayKind(i + 1))
      .where((v) => v == DayKind.off).length;
  int get _attendanceRate => _month == 10 && _year == 2026 ? 81 : (_tracked == 0 ? 0 : ((_present + _late) * 100 / _tracked).round());

  int get _membershipDaysUsed => 22;
  int get _membershipDaysTotal => 30;
  double get _membershipProgress => _membershipDaysUsed / _membershipDaysTotal;

  void _setTab(WorkspaceTab tab) {
    setState(() {
      _tab = tab;
      _subSection = 0;
    });
  }

  void _setSubSection(int index) => setState(() => _subSection = index);

  void _changeMonth(int delta) {
    setState(() {
      final next = DateTime(_year, _month + delta, 1);
      _year = next.year;
      _month = next.month;
    });
  }

  Future<void> _showThemePicker() async {
    final selected = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: t.surface,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(t.radius + 8))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 38, height: 4, decoration: BoxDecoration(color: t.muted.withOpacity(.4), borderRadius: BorderRadius.circular(8)))),
              const SizedBox(height: 12),
              Text('Choose your dashboard', style: TextStyle(color: t.ink, fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text('10 complete visual systems · shared member data', style: TextStyle(color: t.muted, fontSize: 10)),
              const SizedBox(height: 12),
              SizedBox(
                height: 365,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: dashboardThemes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 9, crossAxisSpacing: 9, childAspectRatio: 2.55,
                  ),
                  itemBuilder: (context, index) {
                    final theme = dashboardThemes[index];
                    final active = index == _themeIndex;
                    return InkWell(
                      onTap: () => Navigator.pop(context, index),
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [theme.background, theme.backgroundEnd]),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: active ? theme.primary : theme.border, width: active ? 2 : 1),
                        ),
                        child: Row(children: [
                          Container(
                            width: 34, height: 34,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(color: theme.surface, shape: BoxShape.circle, border: Border.all(color: theme.border)),
                            child: Image.asset(theme.promoArt, fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => Icon(Icons.fitness_center_rounded, color: theme.primary, size: 20)),
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(theme.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: theme.ink, fontSize: 10, fontWeight: FontWeight.w800)),
                            Text(theme.description, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: theme.muted, fontSize: 7)),
                          ])),
                          if (active) Icon(Icons.check_circle, color: theme.primary, size: 17),
                        ]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (selected != null && mounted) setState(() => _themeIndex = selected);
  }

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
                  child: Stack(children: [
                    Positioned(
                      right: -18, top: 48, width: 150, height: 110,
                      child: IgnorePointer(child: Opacity(
                        opacity: t.dark ? .12 : .16,
                        child: Image.asset(t.art, fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink()),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _brandHeader(compact ? 38 : 43),
                          SizedBox(height: gap),
                          _memberCard(ultraCompact ? 132 : compact ? 148 : 164),
                          SizedBox(height: gap),
                          _paymentStrip(ultraCompact ? 40 : compact ? 46 : 50),
                          SizedBox(height: gap),
                          _membershipProgress(ultraCompact ? 36 : compact ? 40 : 44),
                          SizedBox(height: gap),
                          _quickMetrics(ultraCompact ? 62 : compact ? 70 : 76),
                          SizedBox(height: gap),
                          _quickNavRow(ultraCompact ? 36 : compact ? 40 : 44),
                          SizedBox(height: gap),
                          Expanded(child: _workspace()),
                        ],
                      ),
                    ),
                  ]),
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
        Container(
          width: height - 3, height: height - 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [t.primary, t.secondary]),
            borderRadius: BorderRadius.circular(t.radius * .55),
            border: Border.all(color: t.border, width: t.borderWidth),
            boxShadow: [BoxShadow(color: t.primary.withOpacity(.22), blurRadius: 8)],
          ),
          child: const Icon(Icons.fitness_center_rounded, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 8),
        Expanded(child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('BAD GYM', style: TextStyle(color: t.canvasText, fontFamily: 'Poppins', fontSize: 20, height: 1, fontWeight: FontWeight.w900, letterSpacing: -.7)),
              Text('Member Intelligence', style: TextStyle(color: t.softText, fontSize: 9, height: 1.2, fontWeight: FontWeight.w600)),
            ],
          ),
        )),
        _headerAction(Icons.notifications_none_rounded, 'Notifications', badge: '3'),
        const SizedBox(width: 5),
        InkWell(
          onTap: _showThemePicker,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: height - 2, height: height - 2,
            decoration: t.panel(radius: 14, selected: true),
            child: Icon(Icons.palette_outlined, color: t.primary, size: 20),
          ),
        ),
      ]),
    );
  }

  Widget _headerAction(IconData icon, String label, {String? badge}) {
    return Container(
      width: 34, height: 34,
      decoration: t.panel(radius: t.style == 'athletic' ? 9 : 13),
      child: Stack(clipBehavior: Clip.none, children: [
        Center(child: Icon(icon, color: t.canvasText, size: 19)),
        if (badge != null) Positioned(right: -3, top: -4, child: Container(
          width: 15, height: 15, alignment: Alignment.center,
          decoration: const BoxDecoration(color: Color(0xFFE33143), shape: BoxShape.circle),
          child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
        )),
      ]),
    );
  }

  Widget _memberCard(double height) {
    return Container(
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: t.panel(radius: t.radius + 3, selected: false),
      child: Stack(children: [
        Positioned.fill(child: DecoratedBox(decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [t.surface, t.surfaceEnd, t.backgroundEnd]),
        ))),
        Positioned(right: -18, top: -18, width: 120, height: height,
          child: IgnorePointer(child: Opacity(opacity: t.dark ? .16 : .12,
            child: Image.asset(t.art, fit: BoxFit.contain, errorBuilder: (_, __, ___) => const SizedBox.shrink())))),
        Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(
            width: height * .70,
            child: Align(alignment: Alignment.bottomCenter, child: Image.asset(
              'assets/hero/hero_athlete.png',
              width: height * .70, height: height - 4, fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
              errorBuilder: (_, __, ___) => Icon(Icons.person, color: t.primary, size: 72),
            )),
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.fromLTRB(2, 8, 8, 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(children: [
                Expanded(child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  decoration: BoxDecoration(color: t.primary.withOpacity(.16), borderRadius: BorderRadius.circular(18), border: Border.all(color: t.primary.withOpacity(.5))),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.check_circle_rounded, color: t.success, size: 14),
                    const SizedBox(width: 4),
                    Text('CHECK-IN', style: TextStyle(color: t.cardText, fontSize: 9, fontWeight: FontWeight.w900)),
                  ]),
                )),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () => _showNotice('Freeze member', 'Member freeze requests are not connected in this demo.'),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 62,
                    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                    decoration: BoxDecoration(color: t.secondary.withOpacity(.18), borderRadius: BorderRadius.circular(12), border: Border.all(color: t.secondary)),
                    child: Column(children: [
                      Icon(Icons.ac_unit_rounded, color: t.secondary, size: 15),
                      Text('FREEZE', style: TextStyle(color: t.cardText, fontSize: 7.5, fontWeight: FontWeight.w900)),
                      Text('MEMBER', style: TextStyle(color: t.cardText, fontSize: 7.5, fontWeight: FontWeight.w900)),
                    ]),
                  ),
                ),
              ]),
              const SizedBox(height: 6),
              Text('Welcome Back 👋', style: TextStyle(color: t.softText, fontSize: 9, fontWeight: FontWeight.w600)),
              Text('Ashwani Kumar Singh Vishwakarma', maxLines: 2, overflow: TextOverflow.ellipsis,
                style: TextStyle(color: t.cardText, fontFamily: 'Poppins', fontSize: 14, height: 1.02, letterSpacing: -.25, fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
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
              const SizedBox(height: 6),
              Wrap(spacing: 5, runSpacing: 3, children: [
                _memberBadge(Icons.workspace_premium_rounded, 'Gold Plan', t.warning, darkText: true),
                _memberBadge(Icons.check_circle_rounded, 'Active', t.success),
              ]),
            ]),
          )),
        ]),
      ]),
    );
  }

  Widget _memberBadge(IconData icon, String label, Color color, {bool darkText = false}) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 11, color: darkText ? const Color(0xFF271B05) : Colors.white),
      const SizedBox(width: 3),
      Text(label, style: TextStyle(color: darkText ? const Color(0xFF271B05) : Colors.white, fontSize: 8.5, fontWeight: FontWeight.w900)),
    ]),
  );

  void _showNotice(String title, String message) {
    showDialog<void>(context: context, builder: (context) => AlertDialog(
      title: Text(title, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800)),
      content: Text(message),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
    ));
  }

  Widget _paymentStrip(double height) => Container(
    height: height,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: t.panel(radius: t.radius, selected: false),
    child: Row(children: [
      Expanded(child: Row(children: [
        Icon(Icons.account_balance_wallet_rounded, color: t.danger, size: 21),
        const SizedBox(width: 7),
        Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('PAYMENT', style: TextStyle(color: t.softText, fontSize: 8, fontWeight: FontWeight.w800)),
          Text('₹500 Due', style: TextStyle(color: t.danger, fontSize: 13, fontWeight: FontWeight.w900)),
        ]),
      ])),
      Container(width: 1, height: height * .62, color: t.border),
      Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.calendar_month_rounded, color: t.primary, size: 20),
        const SizedBox(width: 6),
        Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('8 Days Left', style: TextStyle(color: t.primary, fontSize: 12, fontWeight: FontWeight.w900)),
          Text('Expires: 24 Oct 2026', style: TextStyle(color: t.softText, fontSize: 8.5, fontWeight: FontWeight.w600)),
        ]),
      ])),
      Icon(Icons.chevron_right_rounded, color: t.primary, size: 19),
    ]),
  );

  Widget _membershipProgress(double height) => Container(
    height: height,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: t.panel(radius: t.radius, selected: false),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(children: [
        Text('Membership 22 / 30 Days', style: TextStyle(color: t.cardText, fontSize: 10, fontWeight: FontWeight.w900)),
        const Spacer(),
        Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          decoration: BoxDecoration(color: t.primary.withOpacity(.14), borderRadius: BorderRadius.circular(14)),
          child: Text('73%', style: TextStyle(color: t.primary, fontSize: 11, fontWeight: FontWeight.w900))),
      ]),
      const SizedBox(height: 4),
      ClipRRect(borderRadius: BorderRadius.circular(10), child: LinearProgressIndicator(
        value: _membershipProgress, minHeight: 6, backgroundColor: t.neutral,
        valueColor: AlwaysStoppedAnimation<Color>(t.primary),
      )),
    ]),
  );

  String get _todayLabel => 'Completed · 07:12 AM';
  String get _expiryLabel => '24 Oct 2026';

  String _monthName(int month) => const ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][month - 1];


  Widget _promotionStrip(double height) {
    final promo = t.promoArt;
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: t.panel(radius: t.radius, selected: false),
      child: Row(children: [
        Expanded(child: Text('MEMBER EXCLUSIVE  ·  Fitness & Wellness  ·  Up to 40% OFF',
          maxLines: 1, overflow: TextOverflow.ellipsis,
          style: TextStyle(color: t.cardText, fontSize: 12, height: 1.05, fontWeight: FontWeight.w800))),
        SizedBox(width: 66, height: height - 5, child: Image.asset(promo, fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Icon(Icons.local_offer_rounded, color: t.primary, size: 28))),
        const SizedBox(width: 5),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(color: t.primary, borderRadius: BorderRadius.circular(16)),
          child: Text('Explore ›', style: TextStyle(color: t.dark ? Colors.black : Colors.white, fontSize: 10, fontWeight: FontWeight.w900))),
      ]),
    );
  }

  Widget _quickMetrics(double height) {
    final items = <(WorkspaceTab, String, IconData, String, String, String)>[
      (WorkspaceTab.attendance, 'assets/badges/stat_attendance.png', Icons.event_available_rounded, 'Attendance', '81%', '↑ +6%'),
      (WorkspaceTab.workout, 'assets/badges/stat_workout.png', Icons.fitness_center_rounded, 'Workout', '58 min', '↑ +12%'),
      (WorkspaceTab.payment, 'assets/badges/stat_payment.png', Icons.account_balance_wallet_rounded, 'Payment', '₹500', 'Due'),
      (WorkspaceTab.body, 'assets/badges/stat_body.png', Icons.monitor_weight_rounded, 'Body', '69.5 kg', '↓ -0.8 kg'),
    ];
    return SizedBox(height: height, child: Row(children: List.generate(items.length, (index) {
      final item = items[index];
      final active = _tab == item.$1;
      return Expanded(child: Padding(
        padding: EdgeInsets.only(right: index == 3 ? 0 : 4),
        child: InkWell(
          onTap: () => _setTab(item.$1),
          borderRadius: BorderRadius.circular(t.radius),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
            decoration: t.panel(radius: t.radius, selected: active),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(item.$2, width: 17, height: 17, fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(item.$3, color: active ? t.primary : t.secondary, size: 15)),
              const SizedBox(height: 2),
              Text(item.$4, maxLines: 1, overflow: TextOverflow.ellipsis,
                style: TextStyle(color: t.cardText, fontSize: 9, height: 1.05, fontWeight: FontWeight.w700)),
              FittedBox(fit: BoxFit.scaleDown, child: Text(item.$5,
                style: TextStyle(color: item.$1 == WorkspaceTab.payment ? t.danger : t.cardText, fontSize: 12, height: 1.05, fontWeight: FontWeight.w900))),
              Text(item.$6, maxLines: 1, overflow: TextOverflow.ellipsis,
                style: TextStyle(color: item.$1 == WorkspaceTab.payment ? t.danger : t.success, fontSize: 8, height: 1, fontWeight: FontWeight.w800)),
            ]),
          ),
        ),
      ));
    })));
  }

  Widget _quickNavRow(double height) {
    final items = <(WorkspaceTab, String, IconData)>[
      (WorkspaceTab.attendance, 'Attendance', Icons.calendar_month_rounded),
      (WorkspaceTab.workout, 'Workout', Icons.fitness_center_rounded),
      (WorkspaceTab.payment, 'Payment', Icons.account_balance_wallet_rounded),
      (WorkspaceTab.body, 'Body', Icons.monitor_weight_rounded),
    ];
    return SizedBox(height: height, child: Row(children: List.generate(items.length, (index) {
      final item = items[index];
      final active = _tab == item.$1;
      return Expanded(child: Padding(
        padding: EdgeInsets.only(right: index == 3 ? 0 : 4),
        child: InkWell(
          onTap: () => _setTab(item.$1),
          borderRadius: BorderRadius.circular(t.radius),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
            decoration: t.panel(radius: t.radius * .8, selected: active),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(item.$3, color: active ? (t.dark ? Colors.white : t.primary) : t.secondary, size: 14),
              const SizedBox(width: 3),
              Flexible(child: Text(item.$2, maxLines: 1, overflow: TextOverflow.ellipsis,
                style: TextStyle(color: t.cardText, fontSize: 8.5, fontWeight: FontWeight.w800))),
            ]),
          ),
        ),
      ));
    })));
  }

  List<String> get _railLabels => switch (_tab) {
    WorkspaceTab.attendance => const ['Intelligence','Calendar','History','Trend','Goals','More'],
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
            width: 48,
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
                      Icon(icons[index], size: 16, color: active ? (t.dark ? Colors.black : Colors.white) : t.primary),
                      const SizedBox(height: 2),
                      Text(labels[index], maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: active ? (t.dark ? Colors.black : Colors.white) : t.cardText, fontSize: 8.5, fontWeight: FontWeight.w700)),
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
        Text(title, style: TextStyle(color: t.cardText, fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Expanded(child: child),
      ]),
    );
  }

  Widget _attendanceCalendar() {
    final days = <Widget>[];
    for (var i = 0; i < _firstWeekdayOffset; i++) {
      days.add(const SizedBox.shrink());
    }
    for (var day = 1; day <= _daysInMonth; day++) {
      final kind = _dayKind(day);
      final isToday = _year == _today.year && _month == _today.month && day == _today.day;
      final isSunday = DateTime(_year, _month, day).weekday == DateTime.sunday;
      final color = switch (kind) {
        DayKind.present => t.primary,
        DayKind.late => t.warning,
        DayKind.absent => t.danger,
        DayKind.holiday || DayKind.off => t.neutral,
      };
      days.add(Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 24, height: 24,
          decoration: BoxDecoration(
            color: color,
            shape: t.style == 'athletic' || t.style == 'minimal' ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: t.style == 'athletic' || t.style == 'minimal' ? BorderRadius.circular(6) : null,
            border: isToday ? Border.all(color: t.secondary, width: 2) : Border.all(color: Colors.white.withOpacity(.65), width: .6),
            boxShadow: kind == DayKind.present ? [BoxShadow(color: color.withOpacity(.20), blurRadius: 2, offset: const Offset(0, 1))] : null,
          ),
          alignment: Alignment.center,
          child: Text(day.toString(), style: TextStyle(
            color: kind == DayKind.off || kind == DayKind.holiday ? (t.dark ? Colors.white70 : t.muted) : Colors.white,
            fontSize: 9.5, fontWeight: FontWeight.w900,
          )),
        ),
        if (isSunday) Text('OFF', style: TextStyle(color: t.muted, fontSize: 6.5, height: 1, fontWeight: FontWeight.w900)),
        if (kind == DayKind.holiday && !isSunday) Text('HOL', style: TextStyle(color: t.muted, fontSize: 6.5, height: 1, fontWeight: FontWeight.w900)),
      ])));
    }
    return _innerPanel(
      title: 'Attendance Intelligence',
      child: Column(children: [
        SizedBox(height: 54, child: Row(children: [
          SizedBox(width: 50, height: 50, child: Stack(alignment: Alignment.center, children: [
            SizedBox.expand(child: CircularProgressIndicator(
              value: _attendanceRate / 100, strokeWidth: 4.5, backgroundColor: t.neutral,
              valueColor: AlwaysStoppedAnimation<Color>(t.primary),
            )),
            Column(mainAxisSize: MainAxisSize.min, children: [
              Text('$_attendanceRate%', style: TextStyle(color: t.cardText, fontSize: 12, fontWeight: FontWeight.w900)),
              Text('25 / 31', style: TextStyle(color: t.softText, fontSize: 7, fontWeight: FontWeight.w700)),
            ]),
          ])),
          const SizedBox(width: 5),
          Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(children: [Expanded(child: _legendDot('Present 23', t.success)), Expanded(child: _legendDot('Late 2', t.warning))]),
            const SizedBox(height: 5),
            Row(children: [Expanded(child: _legendDot('Absent 2', t.danger)), Expanded(child: _legendDot('Holiday 4', t.secondary))]),
          ])),
          Container(width: 1, height: 44, color: t.border),
          const SizedBox(width: 5),
          SizedBox(width: 66, child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Icon(Icons.local_fire_department_rounded, color: t.warning, size: 14), const SizedBox(width: 2), Text('Streak', style: TextStyle(color: t.softText, fontSize: 7.5, fontWeight: FontWeight.w700))]),
            Text('5 Days', style: TextStyle(color: t.cardText, fontSize: 10, fontWeight: FontWeight.w900)),
            const SizedBox(height: 3),
            Row(children: [Icon(Icons.emoji_events_rounded, color: t.warning, size: 14), const SizedBox(width: 2), Text('Best', style: TextStyle(color: t.softText, fontSize: 7.5, fontWeight: FontWeight.w700))]),
            Text('14 Days', style: TextStyle(color: t.cardText, fontSize: 10, fontWeight: FontWeight.w900)),
          ])),
        ])),
        const SizedBox(height: 4),
        Row(children: const ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'].map((d) => Expanded(
          child: Center(child: Text(d, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.grey))),
        )).toList()),
        const SizedBox(height: 2),
        Expanded(child: LayoutBuilder(builder: (context, constraints) {
          final rowExtent = math.max(26.0, (constraints.maxHeight - 12) / 6).toDouble();
          return GridView.count(
            crossAxisCount: 7, shrinkWrap: false, physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 1, crossAxisSpacing: 1, mainAxisExtent: rowExtent, childAspectRatio: 1.0, children: days,
          );
        })),
        const SizedBox(height: 2),
        Wrap(alignment: WrapAlignment.spaceBetween, spacing: 3, runSpacing: 1, children: [
          _legendDot('Present', t.success), _legendDot('Late', t.warning),
          _legendDot('Absent', t.danger), _legendDot('Holiday', t.secondary),
          _legendDot('Off', t.neutral), _legendDot('Today', t.primary),
        ]),
      ]),
    );
  }

  Widget _legendDot(String label, Color color) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    const SizedBox(width: 2),
    Text(label, style: TextStyle(color: t.softText, fontSize: 7.5, fontWeight: FontWeight.w700)),
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
