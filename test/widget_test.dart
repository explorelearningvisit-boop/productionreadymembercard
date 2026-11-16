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
    expect(find.text('Last Check-In'), findsOneWidget);
    expect(find.text('CHECK-IN'), findsNothing);
    expect(find.text('Check-In Success!'), findsNothing);

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

    // Verify Quick Stats Row (4 Cards: Attendance, Workout, Payment, Body)
    expect(find.text('Attendance'), findsOneWidget);
    expect(find.text('81%'), findsWidgets);
    expect(find.text('Workout'), findsWidgets);
    expect(find.text('58 min'), findsOneWidget);
    expect(find.text('Payment'), findsWidgets);
    expect(find.text('₹500'), findsOneWidget);
    expect(find.text('Body'), findsOneWidget);
    expect(find.text('69.5 kg'), findsOneWidget);

    // Verify Attendance Trend Card
    expect(find.text('Attendance Trend'), findsOneWidget);
    expect(find.text('OFF'), findsNWidgets(4));
    expect(find.text('Maximum'), findsOneWidget);
    expect(find.text('Average'), findsOneWidget);
    expect(find.text('Minimum'), findsOneWidget);

    // The entire member dashboard and its insight/summary are one card.
    expect(find.byKey(const ValueKey('member_dashboard_outer_card')), findsOneWidget);
    expect(find.text('Smart Insight'), findsOneWidget);
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

    // Tap Payment quick stat tab
    await tester.tap(find.text('₹500').first);
    await tester.pumpAndSettle();
    expect(find.text('Payment Intelligence'), findsOneWidget);

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

    // 1. Open the renewal sheet and verify checkout does not claim a payment.
    await tester.tap(find.text('8 Days Left'));
    await tester.pumpAndSettle();
    expect(find.text('Renew Gold Membership'), findsOneWidget);
    await tester.tap(find.text('Proceed to Pay ₹1,200'));
    await tester.pumpAndSettle();
    expect(find.text('Payment gateway is not connected yet. No payment was initiated.'), findsOneWidget);

    // 2. Open Notification Sheet from top bell
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
  testWidgets('keeps Member Intelligence usable at compact 360dp mobile width', (tester) async {
    tester.view.physicalSize = const Size(360, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.text('Attendance Trend'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('58 min'));
    await tester.pumpAndSettle();
    expect(find.text('Workout Intelligence'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('₹500').first);
    await tester.pumpAndSettle();
    expect(find.text('Payment Intelligence'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('69.5 kg'));
    await tester.pumpAndSettle();
    expect(find.text('Body Intelligence'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Members rail returns to the member intelligence overview', (tester) async {
    tester.view.physicalSize = const Size(360, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('69.5 kg'));
    await tester.pumpAndSettle();
    expect(find.text('Body Intelligence'), findsOneWidget);

    await tester.tap(find.text('Members').first);
    await tester.pumpAndSettle();
    expect(find.text('Attendance Trend'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

}
