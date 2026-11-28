import 'package:flutter/material.dart';
import 'screens/member_dashboard_screen.dart';
import 'theme/member_theme.dart';

void main() => runApp(const BadGymApp(autoRotateModules: true));

class BadGymApp extends StatelessWidget {
  const BadGymApp({this.autoRotateModules = false, super.key});

  final bool autoRotateModules;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BAD GYM Member Intelligence',
      debugShowCheckedModeBanner: false,
      theme: MemberTheme.light,
      home: MemberDashboardScreen(autoRotateModules: autoRotateModules),
    );
  }
}
