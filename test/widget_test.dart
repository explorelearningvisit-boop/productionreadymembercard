import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym_member_intelligence/main.dart';

void main() {
  testWidgets('clean-slate app shell renders on target 360dp viewport', (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    expect(find.text('BAD GYM'), findsOneWidget);
  });
}
