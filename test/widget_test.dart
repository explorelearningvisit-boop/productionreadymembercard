import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym/main.dart';

void main() {
  testWidgets('Design Lab renders member intelligence at 360dp', (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const BadGymDesignLab());
    await tester.pumpAndSettle();
    expect(find.text('Attendance Intelligence'), findsOneWidget);
    expect(find.text('Ashwani Kumar Sharma Vishwakarma'), findsOneWidget);
    expect(find.textContaining('CHECKED-IN'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
