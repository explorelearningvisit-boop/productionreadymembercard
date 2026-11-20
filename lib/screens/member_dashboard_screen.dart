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
          statusBarColor: Color(0xFFE9F8F7),
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xFFE9F8F7),
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: MemberTheme.canvas,
          body: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFDDF7F4),
                  Color(0xFFF7FFFF),
                  Color(0xFFD9F3EF),
                  Color(0xFFEAF8F7),
                ],
                stops: [0, .32, .72, 1],
              ),
            ),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 420;
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    padding: EdgeInsets.fromLTRB(
                        compact ? 8 : 16, 5, compact ? 8 : 16, 14),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 760),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const _BrandHeader(compact: true),
                            const SizedBox(height: 7),
                            const MemberProfileCard(),
                            const SizedBox(height: 9),
                            const PromoBanner(),
                            const SizedBox(height: 9),
                            const QuickMetricRow(),
                            const SizedBox(height: 9),
                            const AttendanceIntelligence(),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
}

class _BrandHeader extends StatelessWidget {
  final bool compact;
  const _BrandHeader({required this.compact});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [MemberTheme.leaf, MemberTheme.emerald],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4400A94E),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.fitness_center_rounded,
                  color: Colors.white, size: 22),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: 'BAD ',
                        style: TextStyle(
                            color: Color(0xFF101D1B),
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            height: 1),
                      ),
                      TextSpan(
                        text: 'GYM',
                        style: TextStyle(
                            color: MemberTheme.forest,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            height: 1),
                      ),
                    ]),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'FITNESS MANAGEMENT SYSTEM',
                    style: TextStyle(
                      color: MemberTheme.ink,
                      fontSize: 7,
                      letterSpacing: .65,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 54,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                gradient: const LinearGradient(
                  colors: [MemberTheme.leaf, MemberTheme.emerald],
                ),
              ),
            ),
          ],
        ),
      );
}
