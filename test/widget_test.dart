import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym/main.dart';

void configurePhoneViewport(WidgetTester tester, {double height = 700}) {
  tester.view.physicalSize = Size(360, height);
  tester.view.devicePixelRatio = 1;
}

void main() {
  testWidgets('compact dashboard fits 360dp viewport without vertical scrolling', (tester) async {
    configurePhoneViewport(tester);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.text('Attendance Calendar'), findsOneWidget);
    expect(find.text('October 2026'), findsOneWidget);
    expect(find.text('Attendance'), findsOneWidget);
    expect(find.text('Workout'), findsOneWidget);
    expect(find.text('Payment'), findsOneWidget);
    expect(find.text('Body'), findsOneWidget);
    expect(find.byKey(const ValueKey('fixed_intelligence_viewport')), findsOneWidget);
    expect(find.byKey(const ValueKey('contextual_navigation_rail')), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsNothing);
    expect(tester.takeException(), isNull);

    final viewport = tester.getRect(find.byKey(const ValueKey('fixed_intelligence_viewport')));
    expect(viewport.height, greaterThan(300));
    expect(viewport.bottom, lessThanOrEqualTo(700));
  });

  testWidgets('attendance contextual rail swaps calendar, trend, history and insights in place', (tester) async {
    configurePhoneViewport(tester);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();
    final before = tester.getRect(find.byKey(const ValueKey('fixed_intelligence_viewport')));

    await tester.tap(find.byKey(const ValueKey('rail_trend')));
    await tester.pumpAndSettle();
    expect(find.text('Attendance Trend'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('rail_history')));
    await tester.pumpAndSettle();
    expect(find.text('Attendance History'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('rail_insights')));
    await tester.pumpAndSettle();
    expect(find.text('Attendance Insights'), findsOneWidget);

    final after = tester.getRect(find.byKey(const ValueKey('fixed_intelligence_viewport')));
    expect(after.height, closeTo(before.height, 1));
    expect(tester.takeException(), isNull);
  });

  testWidgets('four intelligence tabs open their own contextual workspaces', (tester) async {
    configurePhoneViewport(tester);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Workout').first);
    await tester.pumpAndSettle();
    expect(find.text('Workout'), findsWidgets);
    expect(find.text('Sessions'), findsOneWidget);

    await tester.tap(find.text('Payment').first);
    await tester.pumpAndSettle();
    expect(find.text('Payments'), findsOneWidget);

    await tester.tap(find.text('Body').first);
    await tester.pumpAndSettle();
    expect(find.text('Measure'), findsOneWidget);

    await tester.tap(find.text('Attendance').first);
    await tester.pumpAndSettle();
    expect(find.text('Attendance Calendar'), findsOneWidget);
  });

  testWidgets('header notification and QR actions remain available', (tester) async {
    configurePhoneViewport(tester, height: 800);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('header_notification_button')));
    await tester.pumpAndSettle();
    expect(find.text('Gym Alerts & Updates'), findsOneWidget);
    await tester.tap(find.text('Mark All as Read'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('member_avatar_button')));
    await tester.pumpAndSettle();
    expect(find.text('VIP ACCESS PASS'), findsOneWidget);
  });
}
