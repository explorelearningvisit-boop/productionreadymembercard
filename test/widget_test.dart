import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym_member_intelligence/main.dart';
import 'package:bad_gym_member_intelligence/widgets/attendance_intelligence.dart';
import 'package:bad_gym_member_intelligence/widgets/dashboard_components.dart';

Future<void> _pumpUi(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 700));
  // A state change can schedule AnimatedSwitcher after the first frame;
  // advance once more so outgoing and incoming children are no longer both
  // present when tests assert unique labels.
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  testWidgets('approved BAD GYM member dashboard fits 360dp without overflow',
      (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await _pumpUi(tester);

    expect(find.text('CHECK-IN'), findsOneWidget);
    expect(find.text('FREEZE'), findsOneWidget);
    expect(find.byType(MemberProfileCard), findsOneWidget);
    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.text('Attendance Analytics'), findsOneWidget);
    expect(find.byType(AttendanceIntelligence), findsOneWidget);
    expect(find.text('Big Billion Sale'), findsOneWidget);
    expect(find.text('81%'), findsWidgets);
    expect(
      find.byType(MembershipProgress),
      findsOneWidget,
    );
    expect(find.text('Membership 22 / 30 Days'), findsOneWidget);
    expect(find.text('73%'), findsOneWidget);
    expect(find.text('Welcome Back 👋'), findsNothing);
    expect(find.text('Shop Now ›'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('context rail switches the intelligence panel', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await _pumpUi(tester);

    Future<void> open(String rail, String heading) async {
      final finder = find.byKey(ValueKey('rail-$rail'));
      await tester.ensureVisible(finder);
      await tester.tap(finder);
      await _pumpUi(tester);
      expect(find.text(heading), findsOneWidget);
    }

    await open('Attend', 'Attendance Analytics');
    await open('Insights', 'More member insights');
    await open('Cal', 'October attendance');
    await open('History', 'Check-in history');
    await open('Trend', 'Attendance Analytics');
    await open('Goals', 'Member goals');
    expect(tester.takeException(), isNull);
  });

  testWidgets('shop, freeze and notifications respond', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await _pumpUi(tester);

    await tester.ensureVisible(find.text('FREEZE'));
    await tester.tap(find.text('FREEZE'));
    await _pumpUi(tester);
    expect(find.text('Freeze membership'), findsOneWidget);
    final freezeButton =
        tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Freeze now'));
    freezeButton.onPressed!.call();
    await _pumpUi(tester);
    expect(find.text('FROZEN'), findsOneWidget);

    await tester.ensureVisible(find.text('Shop Now ›'));
    await tester.tap(find.text('Shop Now ›'));
    await _pumpUi(tester);
    expect(find.text('More member insights'), findsOneWidget);
    expect(find.text('Hex dumbbells'), findsOneWidget);

    await tester.ensureVisible(find.text('CHECK-IN'));
    await tester.tap(find.text('CHECK-IN'));
    await tester.pump();
    expect(
      find.text('Membership is frozen · resume your plan before check-in'),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Notifications'));
    await _pumpUi(tester);
    expect(find.text('Payment due'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('dashboard remains layout-safe on a narrow 320dp phone',
      (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final previousFlutterErrorHandler = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.exception.toString().contains('RenderFlex overflowed')) {
        debugPrint('320dp RenderFlex details:\n${details.toString()}');
        final sourceLines =
            File('lib/widgets/dashboard_components.dart').readAsLinesSync();
        debugPrint('Formatted dashboard_components.dart lines 475-490:\n'
            '${sourceLines.skip(474).take(16).join('\n')}');
      }
      previousFlutterErrorHandler?.call(details);
    };
    addTearDown(() => FlutterError.onError = previousFlutterErrorHandler);

    await tester.pumpWidget(const BadGymApp());
    await _pumpUi(tester);

    final initialLayoutException = tester.takeException();
    if (initialLayoutException is FlutterError) {
      debugPrint('320dp initial layout diagnostics:\n'
          '${initialLayoutException.toStringDeep()}');
    } else if (initialLayoutException != null) {
      debugPrint('320dp initial layout exception: $initialLayoutException');
    }
    expect(initialLayoutException, isNull);

    final calendarTab = find.byKey(const ValueKey('rail-Cal'));
    await tester.ensureVisible(calendarTab);
    await tester.tap(calendarTab);
    await _pumpUi(tester);

    final calendarLayoutException = tester.takeException();
    if (calendarLayoutException is FlutterError) {
      debugPrint('320dp calendar layout diagnostics:\n'
          '${calendarLayoutException.toStringDeep()}');
    } else if (calendarLayoutException != null) {
      debugPrint('320dp calendar layout exception: $calendarLayoutException');
    }
    expect(calendarLayoutException, isNull);
    expect(find.text('October attendance'), findsOneWidget);
  });
}
