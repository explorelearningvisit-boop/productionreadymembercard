import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bad_gym_member_intelligence/main.dart';

void main() {
  testWidgets('purple dashboard renders all approved sections', (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    expect(find.text('CHECK-IN'), findsOneWidget);
    expect(find.text('FREEZE'), findsOneWidget);
    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.textContaining('Gold Plan'), findsOneWidget);
    expect(find.text('₹500 Due'), findsOneWidget);
    expect(find.text('Membership 22 / 30 Days'), findsOneWidget);
    expect(find.text('Attendance Analytics'), findsOneWidget);
    expect(find.text('Attend'), findsOneWidget);
    expect(find.text('Insights'), findsOneWidget);
    expect(find.text('Goals'), findsOneWidget);
    expect(find.text('October attendance'), findsOneWidget);
    expect(find.text('Present'), findsOneWidget);
    expect(find.text('Absent'), findsOneWidget);
    expect(find.text('Holiday'), findsOneWidget);
    expect(find.text('Late'), findsOneWidget);
    expect(find.text('Sample data • API connection required for live records'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('check-in remains safe when tapped repeatedly', (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();
    final checkIn = find.byKey(const ValueKey('check-in-button'));
    await tester.tap(checkIn);
    await tester.pump();
    await tester.tap(checkIn);
    await tester.pump();
    expect(find.text('CHECK-IN'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('dashboard renders on compact phone sizes without overflow or scrolling', (tester) async {
    for (final size in <Size>[
      const Size(320, 560),
      const Size(320, 640),
      const Size(360, 600),
      const Size(360, 700),
      const Size(390, 720),
    ]) {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      await tester.pumpWidget(const BadGymApp());
      await tester.pumpAndSettle();

      expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
      expect(find.text('Attendance Analytics'), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsNothing);
      expect(find.byType(ListView), findsNothing);
      expect(tester.takeException(), isNull, reason: 'Failed at $size');
    }
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('repeated mount and dispose stays clean', (tester) async {
    for (var cycle = 0; cycle < 5; cycle++) {
      await tester.pumpWidget(const BadGymApp());
      await tester.pumpAndSettle();
      expect(find.text('Attendance Analytics'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(tester.takeException(), isNull);
    }
  });
}
