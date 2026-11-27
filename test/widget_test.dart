import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bad_gym_member_intelligence/main.dart';
import 'package:bad_gym_member_intelligence/theme/member_theme.dart';

void main() {
  testWidgets('pearl glass dashboard renders all approved sections', (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('check-in-button')), findsOneWidget);
    expect(find.byKey(const ValueKey('check-in-freeze-header-image')), findsOneWidget);
    expect(find.text('CHECK-IN'), findsOneWidget);
    expect(find.text('FREEZE'), findsOneWidget);
    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, MemberPlanPalette.forPlan('Gold Plan').frameGradient.first);
    final memberName = tester.widget<Text>(find.text('Ashwani Kumar Singh'));
    expect(memberName.style?.color, MemberTheme.ink);
    expect(find.text('ATTENDANCE'), findsOneWidget);
    expect(find.byType(CustomPaint), findsWidgets);
    expect(find.byIcon(Icons.account_balance_wallet_rounded), findsOneWidget);
    expect(find.byIcon(Icons.calendar_month_rounded), findsOneWidget);
    expect(find.text('AD SPACE • BLINKIT'), findsOneWidget);
    expect(find.text('AD SPACE • SBI REWARDS'), findsOneWidget);
    expect(find.text('28 yrs Yrs'), findsNothing);
    expect(find.textContaining('Gold Plan'), findsOneWidget);
    expect(find.text('₹500 Due'), findsNWidgets(2));
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
    expect(find.text('CREATINE 15% OFF'), findsOneWidget);
    expect(find.text('BUY NOW ›'), findsOneWidget);
    expect(find.text('Sample data • API connection required for live records'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test('plan palettes switch the full card identity', () {
    final gold = MemberPlanPalette.forPlan('Gold Plan');
    final spark = MemberPlanPalette.forPlan('Spark Plan');
    expect(gold.planName, 'Gold');
    expect(spark.planName, 'Spark');
    expect(spark.accent, const Color(0xFF078552));
    expect(spark.frameGradient.first, const Color(0xFF06452F));
    expect(spark.canvasGradient.last, const Color(0xFFDDF8E8));
  });

  testWidgets('navigation rail is narrow and matches attendance panel height', (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    final rail = tester.getSize(find.byKey(const ValueKey('navigation-rail')));
    final panel = tester.getSize(find.byKey(const ValueKey('attendance-panel')));
    expect(rail.width, 48);
    expect(rail.height, panel.height);
    expect(panel.height, greaterThan(290),
        reason: 'Attendance panel should use the available height instead of leaving a large blank area');
    final dateCell = tester.getSize(find.byKey(const ValueKey('attendance-day-13')));
    expect(dateCell.height, greaterThanOrEqualTo(28),
        reason: 'Calendar dates must remain readable at 360dp width');
    final monthTitle = tester.widget<Text>(find.text('October attendance'));
    expect(monthTitle.style?.fontSize, greaterThanOrEqualTo(14));
    final presentLabel = tester.widget<Text>(find.text('Present'));
    expect(presentLabel.style?.fontSize, greaterThanOrEqualTo(9));
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
    expect(find.byKey(const ValueKey('check-in-freeze-header-image')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('dashboard renders on compact phone sizes without overflow or scrolling', (tester) async {
    for (final size in <Size>[
      const Size(320, 560),
      const Size(320, 640),
      const Size(360, 600),
      const Size(360, 700),
      const Size(390, 720),
      const Size(800, 600),
    ]) {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      await tester.pumpWidget(const BadGymApp());
      await tester.pumpAndSettle();

      expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
      expect(find.text('Attendance Analytics'), findsOneWidget);
      expect(
        tester.getSize(find.byKey(const ValueKey('attendance-panel'))).height,
        greaterThan(0),
        reason: 'Attendance panel must remain visible at $size',
      );
      expect(find.byType(SingleChildScrollView), findsNothing);
      expect(find.byType(ListView), findsNothing);
      expect(tester.takeException(), isNull, reason: 'Failed at $size');
    }
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('repeated mount and dispose stays clean', (tester) async {
    tester.view.physicalSize = const Size(360, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

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
