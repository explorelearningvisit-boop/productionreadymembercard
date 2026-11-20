import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/member_theme.dart';
import '../widgets/dashboard_components.dart';
import '../widgets/attendance_intelligence.dart';

class MemberDashboardScreen extends StatelessWidget {
  const MemberDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: MemberTheme.canvas,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    child: Scaffold(
      backgroundColor: MemberTheme.canvas,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFFE8D7FF), Color(0xFFFFF9FF), Color(0xFFEEDCFF)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            final compact = constraints.maxWidth < 420;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(compact ? 8 : 16, 7, compact ? 8 : 16, 16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MemberProfileCard(),
                      SizedBox(height: 9),
                      PromoBanner(),
                      SizedBox(height: 9),
                      QuickMetricRow(),
                      SizedBox(height: 9),
                      AttendanceIntelligence(),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    ),
  );
}
