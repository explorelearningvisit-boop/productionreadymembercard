import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym/main.dart';

void main() {
  testWidgets('Gold dashboard renders member intelligence at 360dp', (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymDesignLab());
    await tester.pumpAndSettle();

    expect(find.text('Attendance Intelligence'), findsOneWidget);
    expect(find.text('Ashwani Kumar Sharma Vishwakarma'), findsOneWidget);
    expect(find.textContaining('CHECKED-IN'), findsOneWidget);
    expect(find.text('Calendar'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('all four intelligence tabs render dedicated workspaces', (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymDesignLab());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Workout').first);
    await tester.pumpAndSettle();
    expect(find.text('Workout sessions'), findsOneWidget);
    expect(find.text('Training session'), findsOneWidget);

    await tester.tap(find.text('Payment').first);
    await tester.pumpAndSettle();
    expect(find.text('Payment due'), findsOneWidget);
    expect(find.text('₹500 Due'), findsWidgets);

    await tester.tap(find.text('Body').first);
    await tester.pumpAndSettle();
    expect(find.text('Body weight'), findsOneWidget);
    expect(find.text('69.5 kg'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('attendance rail switches bounded workspace content', (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymDesignLab());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Trend').first);
    await tester.pumpAndSettle();
    expect(find.text('Monthly attendance trend'), findsOneWidget);

    await tester.tap(find.text('Record').first);
    await tester.pumpAndSettle();
    expect(find.text('Attendance record'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
