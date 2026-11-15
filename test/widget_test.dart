import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym/main.dart';
import 'package:bad_gym/presentation/widgets/vertical_navigation_rail.dart';

void main() {
  testWidgets('renders BAD GYM Luxury Gold & Ivory Member Intelligence screen with all core components', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    // Verify Check-In Success Ribbon
    expect(find.text('Check-In Success!'), findsOneWidget);
    expect(find.text('CHECK-IN'), findsOneWidget);

    // Verify Member Profile Card (Luxury Gold & Ivory Theme)
    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.textContaining('BG215'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
    expect(find.text('Gold Plan'), findsOneWidget);
    expect(find.text('₹500 Due'), findsOneWidget);
    expect(find.text('8 Days Left'), findsOneWidget);
    expect(find.textContaining('Expires: 24 Oct 2026'), findsOneWidget);
    expect(find.textContaining('Membership 22 / 30 Days'), findsOneWidget);
    expect(find.text('73%'), findsOneWidget);

    // Verify Quick Stats Row (3 Cards: Attendance, Workout, Body)
    expect(find.text('Attendance'), findsOneWidget);
    expect(find.text('81%'), findsWidgets);
    expect(find.text('Workout'), findsWidgets);
    expect(find.text('58 min'), findsOneWidget);
    expect(find.text('Body'), findsOneWidget);
    expect(find.text('69.5 kg'), findsOneWidget);

    // Verify Attendance Trend Card
    expect(find.text('Attendance Trend'), findsOneWidget);
    expect(find.text('Maximum'), findsOneWidget);
    expect(find.text('Average'), findsOneWidget);
    expect(find.text('Minimum'), findsOneWidget);

    // Verify Smart Insight Banner
    expect(find.text('Smart Insight'), findsOneWidget);

    // Verify Bottom Metric Strip
    expect(find.text('Streak'), findsOneWidget);
    expect(find.text('Best'), findsOneWidget);
    expect(find.text('Plan Days'), findsOneWidget);
    expect(find.text('Next Goal'), findsOneWidget);

    // Verify Vertical Navigation Rail
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Members'), findsOneWidget);
    expect(find.text('Reports'), findsOneWidget);
    expect(find.text('More'), findsOneWidget);
  });

  testWidgets('taps rail navigation tab', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    // Tap Members rail item
    await tester.tap(find.text('Members').first);
    await tester.pumpAndSettle();

    // Verify state updated
    expect(find.byType(VerticalNavigationRail), findsOneWidget);
  });

  testWidgets('switches between intelligence cards via QuickStatsRow', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    // Initial state: Attendance Trend
    expect(find.text('Attendance Trend'), findsOneWidget);

    // Tap Workout quick stat tab
    await tester.tap(find.text('58 min'));
    await tester.pumpAndSettle();
    expect(find.text('Workout Intelligence'), findsOneWidget);

    // Tap Body quick stat tab
    await tester.tap(find.text('69.5 kg'));
    await tester.pumpAndSettle();
    expect(find.text('Body Intelligence'), findsOneWidget);

    // Switch back to Attendance
    await tester.tap(find.text('81%').first);
    await tester.pumpAndSettle();
    expect(find.text('Attendance Trend'), findsOneWidget);
  });

  testWidgets('opens RenewalSheet, NotificationSheet, and MemberQrSheet modals', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    // 1. Open Notification Sheet from top bell
    await tester.tap(find.byKey(const ValueKey('header_notification_button')));
    await tester.pumpAndSettle();
    expect(find.text('Gym Alerts & Updates'), findsOneWidget);
    expect(find.text('Mark All as Read'), findsOneWidget);

    // Dismiss Notification Sheet
    await tester.tap(find.text('Mark All as Read'));
    await tester.pumpAndSettle();
    expect(find.text('Gym Alerts & Updates'), findsNothing);

    // 2. Open QR Pass from athlete avatar
    await tester.tap(find.byKey(const ValueKey('member_avatar_button')).first);
    await tester.pumpAndSettle();
    expect(find.text('VIP ACCESS PASS'), findsOneWidget);

    // Dismiss QR Pass
    await tester.tap(find.text('Close Pass'));
    await tester.pumpAndSettle();
    expect(find.text('VIP ACCESS PASS'), findsNothing);
  });
}
