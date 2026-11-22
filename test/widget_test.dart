import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym_member_intelligence/main.dart';

void main() {
  Future<void> setViewport(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  testWidgets('V1 dashboard renders approved member hierarchy', (tester) async {
    await setViewport(tester, const Size(360, 800));
    await tester.pumpWidget(const BadGymApp());
    expect(find.text('BAD GYM'), findsOneWidget);
    expect(find.text('CHECK-IN'), findsOneWidget);
    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.text('Attendance Analytics'), findsOneWidget);
    expect(find.text('Big Billion Sale'), findsOneWidget);
  });

  testWidgets('four sponsored KPI cards are present', (tester) async {
    await setViewport(tester, const Size(360, 800));
    await tester.pumpWidget(const BadGymApp());
    expect(find.text('Attendance'), findsWidgets);
    expect(find.text('Workout'), findsOneWidget);
    expect(find.text('Payment'), findsWidgets);
    expect(find.text('Body'), findsOneWidget);
    expect(find.text('blinkit'), findsOneWidget);
    expect(find.text('Protinex'), findsOneWidget);
  });

  testWidgets('compact 320dp viewport builds without layout exception', (tester) async {
    await setViewport(tester, const Size(320, 720));
    await tester.pumpWidget(const BadGymApp());
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.text('Attendance Analytics'), findsOneWidget);
  });

  testWidgets('rail selection responds to tap', (tester) async {
    await setViewport(tester, const Size(360, 800));
    await tester.pumpWidget(const BadGymApp());
    await tester.tap(find.text('Insights'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
