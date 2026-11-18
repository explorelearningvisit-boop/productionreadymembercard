import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym_member_intelligence/main.dart';

void main() {
  testWidgets('dashboard renders key sections at target mobile width', (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    expect(find.text('Member Intelligence'), findsOneWidget);
    expect(find.text('Attendance Intelligence'), findsOneWidget);
    expect(find.text('Oct 2026'), findsOneWidget);
  });
}
