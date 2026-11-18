import 'package:flutter/material.dart';
import 'design_system/app_tokens.dart';
import 'dual_portal.dart';

export 'dual_portal.dart';

void main() => runApp(const ArjunApp());

class ArjunApp extends StatelessWidget {
  const ArjunApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'ARJUN',
    debugShowCheckedModeBanner: false,
    theme: buildMarketplaceTheme(),
    home: const RoleEntry(),
  );
}
