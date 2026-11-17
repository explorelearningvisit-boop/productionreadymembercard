import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('renders compact member dashboard at 360dp without page scrolling', (tester) async {
    tester.view.physicalSize = const Size(360, 700);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const MemberIntelligenceApp());
    await tester.pumpAndSettle();

    expect(find.text('BAD GYM'), findsOneWidget);
    expect(find.text('Ashwani Kumar Singh Vishwakarma'), findsOneWidget);
    expect(find.text('Attendance Intelligence'), findsOneWidget);
    expect(find.textContaining('22 / 30 DAYS'), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('all ten dashboard themes are selectable in the same app', (tester) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const MemberIntelligenceApp());
    await tester.pumpAndSettle();

    for (final theme in dashboardThemes) {
      await tester.tap(find.byIcon(Icons.palette_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Choose your dashboard'), findsOneWidget);
      await tester.tap(find.text(theme.name));
      await tester.pumpAndSettle();
      expect(find.text('BAD GYM'), findsOneWidget);
      }
  });

  testWidgets('quick tabs and contextual rail replace the bounded workspace', (tester) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const MemberIntelligenceApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Workout').first);
    await tester.pumpAndSettle();
    expect(find.text('Workout Intelligence'), findsOneWidget);

    await tester.tap(find.text('History').last);
    await tester.pumpAndSettle();
    expect(find.text('Workout history'), findsOneWidget);

    await tester.tap(find.text('Payment').first);
    await tester.pumpAndSettle();
    expect(find.text('Payment Intelligence'), findsOneWidget);
    await tester.tap(find.text('Transactions').last);
    await tester.pumpAndSettle();
    expect(find.text('Payment transactions'), findsOneWidget);

    await tester.tap(find.text('Body').first);
    await tester.pumpAndSettle();
    expect(find.text('Body Intelligence'), findsOneWidget);
    await tester.tap(find.text('Composition').last);
    await tester.pumpAndSettle();
    expect(find.text('Body composition'), findsOneWidget);
  });

  testWidgets('compact 320dp viewport has no render overflow', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const MemberIntelligenceApp());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
