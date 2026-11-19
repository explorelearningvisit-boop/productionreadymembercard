import 'package:flutter/material.dart';
import '../widgets/dashboard_components.dart';
import '../widgets/attendance_intelligence.dart';

class MemberDashboardScreen extends StatelessWidget {
  const MemberDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
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
                padding: EdgeInsets.fromLTRB(compact ? 10 : 18, 10, compact ? 10 : 18, 22),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        CheckInFreezeHeader(),
                        SizedBox(height: 10),
                        MemberHeroCard(),
                        SizedBox(height: 9),
                        PaymentExpiryStrip(),
                        SizedBox(height: 10),
                        MembershipProgress(),
                        SizedBox(height: 12),
                        PromoBanner(),
                        SizedBox(height: 10),
                        QuickMetricRow(),
                        SizedBox(height: 14),
                        AttendanceIntelligence(),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      );
}
