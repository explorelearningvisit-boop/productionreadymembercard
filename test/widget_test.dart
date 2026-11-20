import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym_member_intelligence/main.dart';
import 'package:bad_gym_member_intelligence/screens/member_dashboard_screen.dart';

void main() {
  testWidgets('purple neon member dashboard renders at 360dp', (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();
    expect(find.byType(MemberDashboardScreen), findsOneWidget);
    expect(find.text('CHECK-IN'), findsOneWidget);
    expect(find.text('FREEZE'), findsOneWidget);
    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.text('Attendance Intelligence'), findsOneWidget);
    expect(find.text('Home overview'), findsOneWidget);
    expect(find.text('Big Billion Sale'), findsOneWidget);
    expect(find.text('81%'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('freeze action toggles its visible state', (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const BadGymApp());
    await tester.tap(find.text('FREEZE'));
    await tester.pumpAndSettle();
    expect(find.text('FROZEN'), findsOneWidget);
  });
}
