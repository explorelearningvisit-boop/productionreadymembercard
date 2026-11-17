import 'package:flutter/material.dart';
import 'package:bad_gym/presentation/reference_member_dashboard.dart';

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
        scaffoldBackgroundColor: const Color(0xFFE7F3FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1685D5),
          primary: const Color(0xFF1685D5),
          surface: const Color(0xFFF8FCFF),
        ),
      ),
      home: const ReferenceMemberDashboard(),
    );
  }
}
