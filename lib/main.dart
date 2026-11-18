import 'package:flutter/material.dart';
import 'package:bad_gym/presentation/reference_member_dashboard.dart';
import 'package:bad_gym/core/theme/member_dashboard_palette.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BadGymApp());
}

class BadGymApp extends StatelessWidget {
  const BadGymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BAD GYM — Member Intelligence',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: MemberDashboardPalette.deepBurgundy,
        colorScheme: ColorScheme.fromSeed(
          seedColor: MemberDashboardPalette.crimson,
          primary: MemberDashboardPalette.crimson,
          surface: MemberDashboardPalette.ivory,
        ),
      ),
      home: const ReferenceMemberDashboard(),
    );
  }
}
