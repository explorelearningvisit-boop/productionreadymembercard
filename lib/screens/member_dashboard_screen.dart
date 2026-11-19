import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/dashboard_components.dart';
import '../widgets/attendance_intelligence.dart';

class MemberDashboardScreen extends StatelessWidget {
  const MemberDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF700034),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
    child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF700034), Color(0xFFB20B5D), Color(0xFFFFDCEC)],
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(builder: (context, constraints) {
              final compact = constraints.maxWidth < 420;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.fromLTRB(compact ? 7 : 14, 6, compact ? 7 : 14, 14),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        MemberProfileCard(),
                        SizedBox(height: 6),
                        PromoBanner(),
                        SizedBox(height: 6),
                        QuickMetricRow(),
                        SizedBox(height: 6),
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
