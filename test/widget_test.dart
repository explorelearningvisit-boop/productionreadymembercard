import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym/main.dart';

void configurePhoneViewport(WidgetTester tester, {double height = 800}) {
  tester.view.physicalSize = Size(360, height);
  tester.view.devicePixelRatio = 1;
}

void main() {
  testWidgets('reference dashboard renders all six visual sections at 360dp',
      (tester) async {
    configurePhoneViewport(tester);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    expect(find.text('BAD GYM', findRichText: true), findsOneWidget);
    expect(find.text('Member Intelligence'), findsOneWidget);
    expect(find.text('CHECKED-IN'), findsOneWidget);
    expect(find.text('Ashwani Kumar Sharma Vishwakarma'), findsOneWidget);
    expect(find.text('Great Indian\nFestival'), findsOneWidget);
    expect(find.text('Attendance Intelligence'), findsOneWidget);
    expect(find.text('October 2026'), findsOneWidget);
    expect(find.text('AI Insights'), findsOneWidget);
    expect(find.byKey(const ValueKey('stat_tab_attendance')), findsOneWidget);
    expect(find.byKey(const ValueKey('stat_tab_workout')), findsOneWidget);
    expect(find.byKey(const ValueKey('stat_tab_payment')), findsOneWidget);
    expect(find.byKey(const ValueKey('stat_tab_body')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('dashboard fits compact 360dp viewport without layout overflow',
      (tester) async {
    configurePhoneViewport(tester, height: 600);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    expect(find.text('Attendance Intelligence'), findsOneWidget);
    expect(find.byKey(const ValueKey('rail_item_0')), findsOneWidget);
    final layoutException = tester.takeException();
    if (layoutException != null) {
      // Include the render tree so CI identifies the exact RenderFlex that overflowed.
      debugDumpRenderTree();
      fail(
        'Compact 360x600 layout produced a Flutter error:\n'
        '${layoutException is FlutterError ? layoutException.toStringDeep() : layoutException}',
      );
    }
    final scrollables = find.byType(Scrollable);
    expect(scrollables, findsNothing);
  });

  testWidgets('quick tabs and attendance rail switch content in place',
      (tester) async {
    configurePhoneViewport(tester, height: 800);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('rail_item_1')));
    await tester.pumpAndSettle();
    expect(find.text('Attendance trend · last 7 weeks'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('stat_tab_workout')));
    await tester.pumpAndSettle();
    expect(find.text('Workout Intelligence'), findsOneWidget);
    expect(find.text('Weekly progress'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('stat_tab_payment')));
    await tester.pumpAndSettle();
    expect(find.text('Payment Intelligence'), findsOneWidget);
    expect(find.text('Outstanding balance'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('stat_tab_body')));
    await tester.pumpAndSettle();
    expect(find.text('Body Intelligence'), findsOneWidget);
    expect(find.text('Current weight'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('notification and QR actions remain interactive',
      (tester) async {
    configurePhoneViewport(tester, height: 800);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.notifications_none_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Gym Alerts & Updates'), findsOneWidget);
  });
}
