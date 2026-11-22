import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym_member_intelligence/main.dart';
import 'package:bad_gym_member_intelligence/widgets/attendance_intelligence.dart';
import 'package:bad_gym_member_intelligence/widgets/dashboard_components.dart';

void main() {
  testWidgets('approved BAD GYM member dashboard fits 360dp without overflow',
      (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    expect(find.text('CHECK-IN'), findsOneWidget);
    expect(find.text('FREEZE'), findsOneWidget);
    expect(find.byType(MemberProfileCard), findsOneWidget);
    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.text('Attendance Intelligence'), findsOneWidget);
    expect(find.byType(AttendanceIntelligence), findsOneWidget);
    expect(find.text('Big Billion Sale'), findsOneWidget);
    expect(find.text('81%'), findsWidgets);
    expect(find.text('BAD GYM'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('rail opens every member workspace', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    Future<void> open(String rail, String heading) async {
      final finder = find.byKey(ValueKey('rail-$rail'));
      await tester.ensureVisible(finder);
      await tester.tap(finder);
      await tester.pumpAndSettle();
      expect(find.text(heading), findsOneWidget);
    }

    await open('Attend', 'October attendance');
    await open('Workout', 'Workout overview');
    await open('Pay', 'Payment overview');
    await open('Offers', 'Member offers');
    await open('History', 'Check-in history');
    await open('Home', 'Home overview');
    expect(tester.takeException(), isNull);
  });

  testWidgets('shop, freeze and notifications respond', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Shop Now ›'));
    await tester.tap(find.text('Shop Now ›'));
    await tester.pumpAndSettle();
    expect(find.text('Member offers'), findsOneWidget);
    expect(find.text('Hex dumbbells'), findsOneWidget);

    await tester.ensureVisible(find.text('FREEZE'));
    await tester.tap(find.text('FREEZE'));
    await tester.pumpAndSettle();
    expect(find.text('Freeze membership'), findsOneWidget);
    await tester.tap(find.text('Freeze now'));
    await tester.pumpAndSettle();
    expect(find.text('FROZEN'), findsOneWidget);

    await tester.tap(find.byTooltip('Notifications'));
    await tester.pumpAndSettle();
    expect(find.text('Payment due'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
