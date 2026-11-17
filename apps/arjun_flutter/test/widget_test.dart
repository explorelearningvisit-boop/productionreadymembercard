import 'package:flutter_test/flutter_test.dart';
import 'package:arjun_app/main.dart';
import 'package:arjun_app/operations.dart';
import 'package:arjun_app/role_dashboards.dart';
import 'package:arjun_app/sponsored_placements.dart';

void main() {
  testWidgets('Debug tester can enter ARJUN with one tap', (tester) async {
    await tester.pumpWidget(const ArjunApp());
    expect(find.text('ARJUN'), findsOneWidget);
    expect(find.text('tester@arjun.demo'), findsOneWidget);
    expect(find.text('टेस्ट ऐप खोलें'), findsOneWidget);

    await tester.tap(find.text('टेस्ट ऐप खोलें'));
    await tester.pumpAndSettle();

    expect(find.text('नमस्ते 👋'), findsOneWidget);
    expect(find.text('काम पोस्ट करें'), findsWidgets);
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
    expect(find.text('KYC समीक्षा'), findsOneWidget);
  });

  testWidgets('Customer discovery contains a labelled sponsored slot', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SponsoredSupplierPlacement())));
    expect(find.text('प्रायोजित • स्थानीय सप्लायर'), findsOneWidget);
    expect(find.text('निर्माण सामग्री सही दाम पर पाएँ'), findsOneWidget);
  });

  testWidgets('Operations hub exposes core marketplace modules', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: OperationsHub()));
    expect(find.text('Job lifecycle'), findsOneWidget);
    expect(find.text('Attendance & check-in'), findsOneWidget);
    expect(find.text('Manager inspection'), findsOneWidget);
    expect(find.text('Supplier inventory'), findsOneWidget);
    expect(find.text('Payments & ledger'), findsOneWidget);
    expect(find.text('Help & dispute support'), findsOneWidget);
  });

  testWidgets('Job lifecycle can advance a demo milestone', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: JobLifecycleScreen()));
    expect(find.text('Posted'), findsOneWidget);
    await tester.tap(find.text('Advance demo milestone'));
    await tester.pumpAndSettle();
    expect(find.text('Matched'), findsOneWidget);
  });
}
