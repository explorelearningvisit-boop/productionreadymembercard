import 'package:flutter/material.dart';

void main() => runApp(const BadGymApp());

class BadGymApp extends StatelessWidget {
  const BadGymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BAD GYM Member Intelligence',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      ),
      home: const CleanRebuildShell(),
    );
  }
}

/// Clean-slate shell only. The dashboard UI is intentionally not recreated
/// until the user's final approved first/red reference and its matching asset
/// pack are available to prevent accidental reuse of the retired visual system.
class CleanRebuildShell extends StatelessWidget {
  const CleanRebuildShell({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'BAD GYM',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: Color(0xFF303030),
            ),
          ),
        ),
      ),
    );
  }
}
