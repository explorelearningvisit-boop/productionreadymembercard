import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym/main.dart';
import 'package:bad_gym/presentation/widgets/vertical_navigation_rail.dart';

void main() {
  testWidgets('renders BAD GYM Royal Purple Member Intelligence screen with all core components', (tester) async {
    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    // Verify VIP Header Bar (Image 2)
    expect(find.text('Checked In'), findsWidgets);
    expect(find.text('06:42 PM'), findsWidgets);
    expect(find.text('Fri, 16 Oct 2026'), findsWidgets);

    // Verify VIP Member Profile Card (Image 1)
    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.textContaining('BG215'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
    expect(find.text('Gold Plan'), findsOneWidget);
    expect(find.text('8 Days Left'), findsOneWidget);
    expect(find.textContaining('73.3% Used'), findsOneWidget);
    expect(find.text('Main Gym Floor'), findsOneWidget);
    expect(find.text('₹1,200'), findsOneWidget);
    expect(find.textContaining('Next Due: 24 Oct 2026'), findsOneWidget);

    // Verify Quick Stats Row (Image 3 Top)
    expect(find.text('81%'), findsWidgets);
    expect(find.text('58 min'), findsOneWidget);
    expect(find.text('Paid'), findsWidgets);
    expect(find.text('69.5 kg'), findsOneWidget);

    // Verify Attendance Intelligence Card (Image 3 Right)
    expect(find.text('Attendance Intelligence'), findsOneWidget);
    expect(find.text('October 2026'), findsWidgets);
    expect(find.text('Present'), findsOneWidget);
    expect(find.text('Late'), findsOneWidget);
    expect(find.text('Absent'), findsOneWidget);
    expect(find.text('Holiday'), findsOneWidget);
    expect(find.text('5 Days'), findsOneWidget);
    expect(find.text('14 Days'), findsOneWidget);

    // Verify Vertical Navigation Rail (Image 3 Left)
    expect(find.text('Intelligence'), findsOneWidget);
    expect(find.text('Calendar'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Trend'), findsOneWidget);
    expect(find.text('Streak'), findsOneWidget);
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
    expect(find.text('Chest & Arms'), findsOneWidget);
    expect(find.text('Today\'s Program'), findsOneWidget);
    expect(find.text('Log Next Set'), findsOneWidget);

    // Tap Payment quick stat tab
    await tester.tap(find.text('Paid').first);
    await tester.pumpAndSettle();
    expect(find.text('Payment Intelligence'), findsOneWidget);
    expect(find.text('Billing History'), findsOneWidget);
    expect(find.text('Renew Plan Now'), findsOneWidget);

    // Tap Body quick stat tab
    await tester.tap(find.text('69.5 kg'));
    await tester.pumpAndSettle();
    expect(find.text('Body Intelligence'), findsOneWidget);
    expect(find.text('Goal: 72.0 kg'), findsOneWidget);
    expect(find.text('Circumferences'), findsOneWidget);
    expect(find.text('Log Weight'), findsOneWidget);

    // Switch back to Attendance
    await tester.tap(find.text('81%'));
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
    expect(find.text('TURNSTILE GATE 02: ACCESS GRANTED'), findsOneWidget);

    // Dismiss QR Pass
    await tester.tap(find.text('Close Pass'));
    await tester.pumpAndSettle();
    expect(find.text('VIP ACCESS PASS'), findsNothing);

    // 3. Open Renewal Sheet from 3-dots more button in top header
    await tester.tap(find.byKey(const ValueKey('header_more_button')));
    await tester.pumpAndSettle();
    expect(find.text('Renew Gold Membership'), findsOneWidget);
    expect(find.text('Proceed to Pay ₹1,200'), findsOneWidget);

    // Dismiss Renewal Sheet
    await tester.tap(find.text('Proceed to Pay ₹1,200'));
    await tester.pumpAndSettle();
    expect(find.text('Renew Gold Membership'), findsNothing);
  });
}
