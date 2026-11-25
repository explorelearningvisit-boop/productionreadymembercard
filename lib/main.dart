import 'package:flutter/material.dart';

import 'screens/member_dashboard_screen.dart';
import 'theme/member_theme.dart';

void main() => runApp(const BadGymApp());

class BadGymApp extends StatelessWidget {
  const BadGymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BAD GYM Member Intelligence',
      debugShowCheckedModeBanner: false,
      theme: MemberTheme.light,
      home: const MemberDashboardScreen(),
    );
  }
}
