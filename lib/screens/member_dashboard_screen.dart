import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/member_theme.dart';
import '../widgets/purple_dashboard.dart';

class MemberDashboardScreen extends StatelessWidget {
  const MemberDashboardScreen({super.key});
  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFF4EDFF),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFFF4EDFF),
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    child: Scaffold(
      backgroundColor: MemberTheme.canvas,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [Color(0xFFE8D5FF), Color(0xFFF8F4FF), Color(0xFFE6D5FF)]),
        ),
        child: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            final compact = constraints.maxWidth < 390;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(compact ? 8 : 14, 7, compact ? 8 : 14, 16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 620),
                  child: const PurpleMemberDashboard(),
                ),
              ),
            );
          }),
        ),
      ),
    ),
  );
}