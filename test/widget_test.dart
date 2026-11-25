import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bad_gym_member_intelligence/main.dart';

void main() {
  testWidgets('member card renders essential member information',
      (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    expect(find.text('BAD GYM'), findsOneWidget);
    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.text('ID BG215  •  28 yrs  •  Male'), findsOneWidget);
    expect(find.text('Gold Plan'), findsOneWidget);
    expect(find.text('Not checked in'), findsOneWidget);
    expect(find.text('22 / 30 days'), findsOneWidget);
    expect(find.text('81%'), findsOneWidget);
    expect(find.text('58 min'), findsOneWidget);
    expect(find.text('69.5 kg'), findsOneWidget);
    expect(find.text('₹500'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('check-in changes the member state without overlays',
      (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('check-in-button')));
    await tester.pump();

    expect(find.text('Checked in'), findsOneWidget);
    expect(find.text('CHECKED IN'), findsOneWidget);
    expect(find.text('Not checked in'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('card stays usable at 320, 360 and 390 dp', (tester) async {
    for (final size in <Size>[
      const Size(320, 640),
      const Size(360, 780),
      const Size(390, 844),
    ]) {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;

      await tester.pumpWidget(const BadGymApp());
      await tester.pumpAndSettle();

      expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
      expect(find.byKey(const ValueKey('check-in-button')), findsOneWidget);
      expect(tester.takeException(), isNull);
    }

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('repeated mount and dispose does not retain inactive elements',
      (tester) async {
    for (var cycle = 0; cycle < 5; cycle++) {
      await tester.pumpWidget(const BadGymApp());
      await tester.pumpAndSettle();
      expect(find.text('MEMBER INTELLIGENCE'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(tester.takeException(), isNull);
    }
  });
}
