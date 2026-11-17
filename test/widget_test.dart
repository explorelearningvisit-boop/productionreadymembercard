import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym/main.dart';

void main() {
  testWidgets('renders the member intelligence dashboard without outer scrolling', (tester) async {
    tester.view.physicalSize = const Size(360, 700);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const MemberIntelligenceApp());
    expect(find.text('CHECK-IN'), findsOneWidget);
    expect(find.textContaining('FREEZE'), findsOneWidget);
    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.text('Attendance Intelligence'), findsOneWidget);
    expect(find.text('MEMBERSHIP  22 / 30 DAYS'), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('switches intelligence sections from the vertical rail',
      (tester) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const MemberIntelligenceApp());
    final workout = find.text('Workout').last;
    await tester.ensureVisible(workout);
    await tester.tap(workout);
    await tester.pumpAndSettle();
    expect(find.text('Workout Intelligence'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('uses the device current month and consistent membership expiry',
      (tester) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const MemberIntelligenceApp());
    final today = DateTime.now();
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final expiry = DateTime(today.year, today.month, today.day + 8);
    final expiryLabel =
        'Expires ${expiry.day} ${months[expiry.month - 1].substring(0, 3)} ${expiry.year}';

    expect(find.text('${months[today.month - 1]} ${today.year}'),
        findsOneWidget);
    expect(find.text('8 DAYS LEFT'), findsOneWidget);
    expect(find.text(expiryLabel), findsOneWidget);
  });

}
