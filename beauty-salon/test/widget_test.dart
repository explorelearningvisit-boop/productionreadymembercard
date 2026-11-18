import 'package:flutter_test/flutter_test.dart';
import 'package:beauty_salon/main.dart';

void main() {
  testWidgets('role gate exposes all three workspaces', (tester) async {
    await tester.pumpWidget(const SalonApp());
    expect(find.text('BEAUTY STUDIO'), findsOneWidget);
    expect(find.text('Choose your workspace'), findsOneWidget);
    expect(find.text('Customer'), findsOneWidget);
    expect(find.text('Salon Owner'), findsOneWidget);
    expect(find.text('Salon Team'), findsOneWidget);
  });

  testWidgets('customer can open service catalogue and booking sheet', (tester) async {
    await tester.pumpWidget(const SalonApp());
    await tester.tap(find.text('Customer'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('VIEW ALL'));
    await tester.pumpAndSettle();
    expect(find.text('Explore services'), findsOneWidget);
    await tester.tap(find.text('Signature haircut'));
    await tester.pumpAndSettle();
    expect(find.text('Book your service'), findsOneWidget);
    expect(find.text('Request booking • 11:00 AM'), findsOneWidget);
  });

  testWidgets('owner can add a service to a demo bill', (tester) async {
    await tester.pumpWidget(const SalonApp());
    await tester.tap(find.text('Salon Owner'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OPEN POS'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Signature haircut'));
    await tester.pumpAndSettle();
    expect(find.text('₹499'), findsOneWidget);
    expect(find.text('Collect payment'), findsOneWidget);
  });
}
