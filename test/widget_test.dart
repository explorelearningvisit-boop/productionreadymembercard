import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym_member_intelligence/main.dart';
import 'package:bad_gym_member_intelligence/widgets/dashboard_components.dart';
import 'package:bad_gym_member_intelligence/widgets/attendance_intelligence.dart';

void main() {
  testWidgets('approved BAD GYM member dashboard fits 360dp without overflow', (tester) async {
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
    expect(tester.takeException(), isNull);
  });
}
