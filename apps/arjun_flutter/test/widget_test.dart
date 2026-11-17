import 'package:flutter_test/flutter_test.dart';
import 'package:arjun_app/main.dart';
import 'package:arjun_app/operations.dart';

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
