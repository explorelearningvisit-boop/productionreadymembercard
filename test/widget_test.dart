import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym/main.dart';

void configurePhoneViewport(WidgetTester tester, {double height = 900}) {
  tester.view.physicalSize = Size(360, height);
  tester.view.devicePixelRatio = 1;
}

void main() {
  testWidgets('composite member dashboard renders all core sections at 360dp',
      (tester) async {
    configurePhoneViewport(tester);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.text('Attendance Intelligence'), findsOneWidget);
    expect(find.text('October 2026'), findsWidgets);
    expect(find.text('Attendance'), findsOneWidget);
    expect(find.text('Workout'), findsOneWidget);
    expect(find.text('Payment'), findsWidgets);
    expect(find.text('Body'), findsOneWidget);
    expect(find.byKey(const ValueKey('fixed_intelligence_viewport')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('contextual_navigation_rail')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('member_dashboard_outer_card')),
        findsOneWidget);
    expect(tester.takeException(), isNull);

    final viewport = tester
        .getRect(find.byKey(const ValueKey('fixed_intelligence_viewport')));
    expect(viewport.height, closeTo(372.0, 1.0));
  });

  testWidgets(
      'quick stats tabs switch intelligence views without viewport height jumping',
      (tester) async {
    configurePhoneViewport(tester, height: 1000);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();
    final before = tester
        .getRect(find.byKey(const ValueKey('fixed_intelligence_viewport')));

    final workoutTab = find.byKey(const ValueKey('stat_tab_workout'));
    await tester.ensureVisible(workoutTab);
    await tester.tap(workoutTab, warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('workout_card')), findsOneWidget);

    final paymentTab = find.byKey(const ValueKey('stat_tab_payment'));
    await tester.ensureVisible(paymentTab);
    await tester.tap(paymentTab, warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('payment_card')), findsOneWidget);

    final bodyTab = find.byKey(const ValueKey('stat_tab_body'));
    await tester.ensureVisible(bodyTab);
    await tester.tap(bodyTab, warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('body_card')), findsOneWidget);

    final attendanceTab = find.byKey(const ValueKey('stat_tab_attendance'));
    await tester.ensureVisible(attendanceTab);
    await tester.tap(attendanceTab, warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('attendance_card')), findsOneWidget);

    final after = tester
        .getRect(find.byKey(const ValueKey('fixed_intelligence_viewport')));
    expect(after.height, closeTo(before.height, 0.5));
    expect(tester.takeException(), isNull);
  });

  testWidgets('header notification and QR actions remain available',
      (tester) async {
    configurePhoneViewport(tester, height: 1000);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('header_notification_button')),
        warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.text('Gym Alerts & Updates'), findsOneWidget);
    await tester.tap(find.text('Mark All as Read'), warnIfMissed: false);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('member_avatar_button')),
        warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.text('VIP ACCESS PASS'), findsOneWidget);
  });
}
