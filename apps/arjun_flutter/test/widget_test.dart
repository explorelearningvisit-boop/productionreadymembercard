import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:arjun_app/main.dart';
import 'package:arjun_app/operations.dart';
import 'package:arjun_app/role_dashboards.dart';
import 'package:arjun_app/sponsored_placements.dart';

void main() {
  testWidgets('ARJUN app boots into its configured Material application', (tester) async {
    await tester.pumpWidget(const ArjunApp());
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('ARJUN'), findsOneWidget);
  });

  testWidgets('Supplier dashboard labels sponsored placement', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SupplierDashboard()));
    expect(find.text('नमस्ते, सप्लायर 👋'), findsOneWidget);
    expect(find.text('विज्ञापन'), findsOneWidget);
    expect(find.text('अपनी दुकान को आगे बढ़ाएँ'), findsOneWidget);
  });

  testWidgets('Manager and admin have distinct role dashboards', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ManagerDashboard()));
    expect(find.text('नमस्ते, मैनेजर 👷'), findsOneWidget);
    await tester.pumpWidget(const MaterialApp(home: AdminDashboard()));
    expect(find.text('ARJUN Operations'), findsOneWidget);
    expect(find.text('KYC बाकी'), findsOneWidget);
  });

  testWidgets('Customer discovery contains a labelled sponsored slot', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SponsoredSupplierPlacement())));
    expect(find.text('प्रायोजित • स्थानीय सप्लायर'), findsOneWidget);
    expect(find.text('निर्माण सामग्री सही दाम पर पाएँ'), findsOneWidget);
  });

  testWidgets('Operations hub opens and exposes its first modules', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: OperationsHub()));
    expect(find.text('ARJUN Operations'), findsOneWidget);
    expect(find.text('काम का पूरा प्रबंधन'), findsOneWidget);
    expect(find.text('Job lifecycle'), findsOneWidget);
    expect(find.text('Attendance & check-in'), findsOneWidget);
  });

  testWidgets('Job lifecycle screen opens with its initial state', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: JobLifecycleScreen()));
    expect(find.text('Job lifecycle'), findsOneWidget);
    expect(find.text('घर की वायरिंग'), findsOneWidget);
    expect(find.text('Posted'), findsOneWidget);
  });
}
