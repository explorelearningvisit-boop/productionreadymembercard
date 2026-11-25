import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:bad_gym_member_intelligence/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Android startup and rapid dashboard navigation stay error-free',
      (tester) async {
    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle(const Duration(milliseconds: 16));

    expect(find.text('CHECK-IN'), findsOneWidget);
    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(tester.takeException(), isNull);

    const tabs = ['Attend', 'Insights', 'Cal', 'History', 'Trend', 'Goals'];
    for (var round = 0; round < 6; round++) {
      for (final tab in tabs) {
        final finder = find.byKey(ValueKey('rail-$tab'));
        await tester.ensureVisible(finder);
        await tester.tap(finder);
        await tester.pump(const Duration(milliseconds: 16));
        expect(tester.takeException(), isNull, reason: 'tab=$tab round=$round');
      }
    }

    await tester.pumpAndSettle(const Duration(milliseconds: 16));
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle(const Duration(milliseconds: 16));
    expect(find.text('CHECK-IN'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
