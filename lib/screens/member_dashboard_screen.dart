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
      systemNavigationBarColor: Color(0xFFE6D5FF),
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    child: Scaffold(
      backgroundColor: MemberTheme.canvas,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE5D0FF), Color(0xFFF9F5FF), Color(0xFFE4D0FA)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            final horizontal = constraints.maxWidth < 390 ? 8.0 : 14.0;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(horizontal, 5, horizontal, 8),
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
