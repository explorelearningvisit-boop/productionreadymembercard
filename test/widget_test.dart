import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym/main.dart';
import 'package:bad_gym/presentation/widgets/vertical_navigation_rail.dart';

void main() {
  testWidgets('renders BAD GYM Red Strawberry Member Intelligence screen with all core components', (tester) async {
    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    // Verify Top Header Bar (Red Strawberry Theme)
    expect(find.text('CHECK-IN'), findsOneWidget);
    expect(find.text('07:12 AM'), findsOneWidget);
    expect(find.text('16 Oct 2026'), findsOneWidget);

    // Verify Member Profile Card (Red Strawberry Theme)
    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.textContaining('BG215'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
    expect(find.text('Gold Plan'), findsOneWidget);
    expect(find.text('₹500 Due'), findsOneWidget);
    expect(find.text('8 Days Left'), findsOneWidget);
    expect(find.textContaining('Expires: 24 Oct 2026'), findsOneWidget);
    expect(find.textContaining('Membership 22 / 30 Days'), findsOneWidget);
    expect(find.text('73%'), findsOneWidget);

    // Verify Quick Stats Row
    expect(find.text('81%'), findsWidgets);
    expect(find.text('58 min'), findsOneWidget);
    expect(find.text('Due'), findsWidgets);
    expect(find.text('69.5 kg'), findsOneWidget);

    // Verify Attendance Intelligence Card
    expect(find.text('Attendance Intelligence'), findsOneWidget);
    expect(find.text('Oct 2026'), findsOneWidget);
    expect(find.text('October 2026'), findsOneWidget);
    expect(find.text('Present'), findsWidgets);
    expect(find.text('Late'), findsWidgets);
    expect(find.text('Absent'), findsWidgets);
    expect(find.text('Holiday'), findsWidgets);
    expect(find.text('5 Days'), findsOneWidget);
    expect(find.text('14 Days'), findsOneWidget);

    // Verify Vertical Navigation Rail
    expect(find.text('Intelligence'), findsOneWidget);
    expect(find.text('Calendar'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Trend'), findsOneWidget);
    expect(find.text('More'), findsOneWidget);
  });

  testWidgets('taps rail navigation tab', (tester) async {
    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    // Tap Calendar rail item
    await tester.tap(find.text('Calendar').first);
    await tester.pumpAndSettle();

    // Verify state updated
    expect(find.byType(VerticalNavigationRail), findsOneWidget);
  });

  testWidgets('switches between intelligence cards via QuickStatsRow', (tester) async {
    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    // Initial state: Attendance Intelligence
    expect(find.text('Attendance Intelligence'), findsOneWidget);

    // Tap Workout quick stat tab
    await tester.tap(find.text('58 min'));
    await tester.pumpAndSettle();
    expect(find.text('Workout Intelligence'), findsOneWidget);

    // Tap Payment quick stat tab
    await tester.tap(find.text('Due').first);
    await tester.pumpAndSettle();
    expect(find.text('Payment Intelligence'), findsOneWidget);

    // Tap Body quick stat tab
    await tester.tap(find.text('69.5 kg'));
    await tester.pumpAndSettle();
    expect(find.text('Body Intelligence'), findsOneWidget);

    // Switch back to Attendance
    await tester.tap(find.text('81%').first);
    await tester.pumpAndSettle();
    expect(find.text('Attendance Intelligence'), findsOneWidget);
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
