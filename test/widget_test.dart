import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym_member_intelligence/main.dart';
import 'package:bad_gym_member_intelligence/widgets/dashboard_components.dart';

void main() {
  testWidgets('member dashboard renders all primary sections at 360dp', (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    final now = DateTime.now();
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];

    expect(find.text('CHECK-IN'), findsOneWidget);
    expect(find.text('FREEZE'), findsOneWidget);
    expect(find.byType(MemberProfileCard), findsOneWidget);
    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.text('Member Intelligence'), findsOneWidget);
    expect(find.text('${months[now.month - 1]} ${now.year}'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
