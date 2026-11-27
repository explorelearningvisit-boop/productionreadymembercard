import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bad_gym_member_intelligence/data/dashboard_navigation.dart';
import 'package:bad_gym_member_intelligence/data/sample_member.dart';
import 'package:bad_gym_member_intelligence/main.dart';
import 'package:bad_gym_member_intelligence/screens/member_dashboard_screen.dart';
import 'package:bad_gym_member_intelligence/theme/member_theme.dart';

void setPhoneViewport(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
}

void addViewportReset(WidgetTester tester) {
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('first reference structure and PulseVault artwork render', (tester) async {
    setPhoneViewport(tester, const Size(360, 780));
    addViewportReset(tester);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('check-in-button')), findsOneWidget);
    expect(find.text('Check-in'), findsOneWidget);
    expect(find.text('Freeze'), findsOneWidget);
    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.text('Gold Plan'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
    expect(find.text('Gold member perks · Sample'), findsOneWidget);
    expect(find.text('Member rewards · Sample'), findsOneWidget);

    expect(find.text('Attendance'), findsOneWidget);
    expect(find.text('Workout'), findsOneWidget);
    expect(find.text('Payment'), findsOneWidget);
    expect(find.text('Body'), findsOneWidget);
    expect(find.text('₹500 Due'), findsNWidgets(2));
    expect(find.text('Membership 22 / 30 Days'), findsOneWidget);
    expect(find.text('Attendance Analytics'), findsOneWidget);
    expect(find.text('Present'), findsOneWidget);
    expect(find.text('Absent'), findsOneWidget);
    expect(find.text('Holiday'), findsOneWidget);
    expect(find.text('Late'), findsOneWidget);
    expect(find.text('October attendance'), findsOneWidget);

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(
      scaffold.backgroundColor,
      MemberPlanPalette.forPlan('Gold Plan').frameGradient.first,
    );
    expect(find.byType(CustomPaint), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  test('plan palettes use the full adaptive member shell', () {
    final gold = MemberPlanPalette.forPlan('Gold Plan');
    final spark = MemberPlanPalette.forPlan('Spark Plan');
    final silver = MemberPlanPalette.forPlan('Silver Plan');

    expect(gold.planName, 'Gold');
    expect(gold.railGradient.first, const Color(0xFF6D0201));
    expect(gold.railSelected, const Color(0xFFFDE870));
    expect(gold.canvasGradient.first, const Color(0xFFFFFEFC));
    expect(spark.planName, 'Spark');
    expect(spark.frameGradient.first, const Color(0xFF06452F));
    expect(silver.planName, 'Silver');
  });

  test('each horizontal module owns five contextual rail destinations', () {
    for (final module in DashboardNavigation.modules) {
      final items = DashboardNavigation.itemsFor(module);
      expect(items, hasLength(5));
      expect(items.first.id, 'overview');
      expect(
        DashboardNavigation.keyFor(module, 0),
        'navigation-${module.name}-overview',
      );
    }

    expect(
      DashboardNavigation.itemsFor(DashboardModule.payment)
          .map((item) => item.id),
      containsAll(['invoices', 'history', 'methods', 'rewards']),
    );
    expect(
      DashboardNavigation.itemsFor(DashboardModule.body)
          .map((item) => item.id),
      containsAll(['weight', 'measurements', 'nutrition', 'goals']),
    );
  });

  testWidgets('Spark member receives the green shell', (tester) async {
    setPhoneViewport(tester, const Size(360, 780));
    addViewportReset(tester);

    const sparkMember = MemberSample(
      name: 'Spark Member',
      memberId: 'BG216',
      age: '24 yrs',
      gender: 'Male',
      plan: 'Spark Plan',
      attendance: '88%',
      workout: '42 min',
      bodyWeight: '67 kg',
      paymentDue: '₹0',
      membershipDays: 12,
      membershipTotalDays: 90,
      daysRemaining: 78,
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: MemberTheme.light,
        home: const MemberDashboardScreen(member: sparkMember),
      ),
    );
    await tester.pumpAndSettle();

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(
      scaffold.backgroundColor,
      MemberPlanPalette.forPlan('Spark Plan').frameGradient.first,
    );
    expect(find.text('Spark Plan'), findsOneWidget);
    expect(find.text('Spark Member'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('all four KPI cards change their module and vertical menu', (tester) async {
    setPhoneViewport(tester, const Size(360, 780));
    addViewportReset(tester);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('metric-workout')));
    await tester.pumpAndSettle();
    expect(find.text('Workout Overview'), findsOneWidget);
    expect(find.byKey(const ValueKey('navigation-workout-overview')), findsOneWidget);
    expect(find.byKey(const ValueKey('navigation-workout-log')), findsOneWidget);
    expect(find.byKey(const ValueKey('navigation-workout-recovery')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('metric-payment')));
    await tester.pumpAndSettle();
    expect(find.text('Payment Overview'), findsOneWidget);
    expect(find.byKey(const ValueKey('navigation-payment-invoices')), findsOneWidget);
    expect(find.byKey(const ValueKey('navigation-payment-methods')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('metric-body')));
    await tester.pumpAndSettle();
    expect(find.text('Body Overview'), findsOneWidget);
    expect(find.byKey(const ValueKey('navigation-body-weight')), findsOneWidget);
    expect(find.byKey(const ValueKey('navigation-body-nutrition')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('metric-attendance')));
    await tester.pumpAndSettle();
    expect(find.text('Attendance Analytics'), findsOneWidget);
    expect(find.byKey(const ValueKey('navigation-attendance-calendar')), findsOneWidget);
    expect(find.byKey(const ValueKey('navigation-attendance-goals')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('vertical submenu opens the correct module-specific data', (tester) async {
    setPhoneViewport(tester, const Size(360, 780));
    addViewportReset(tester);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    final destinations = <(String, String, String, String)>[
      ('metric-attendance', 'navigation-attendance-calendar', 'Attendance Calendar', 'October 2026'),
      ('metric-attendance', 'navigation-attendance-history', 'Attendance History', 'Gym check-in'),
      ('metric-workout', 'navigation-workout-log', 'Workout Log', 'Latest workout summary'),
      ('metric-workout', 'navigation-workout-trend', 'Workout Trend', 'WORKOUT MINUTES'),
      ('metric-workout', 'navigation-workout-recovery', 'Recovery & Wellness', 'Recovery information'),
      ('metric-workout', 'navigation-workout-goals', 'Workout Goals', 'Workout consistency'),
      ('metric-payment', 'navigation-payment-invoices', 'Due & Invoices', 'Membership balance'),
      ('metric-payment', 'navigation-payment-history', 'Payment History', 'No completed payments loaded'),
      ('metric-payment', 'navigation-payment-methods', 'Payment Methods', 'Payment method preview'),
      ('metric-payment', 'navigation-payment-rewards', 'Payment Rewards', 'No active reward campaign'),
      ('metric-body', 'navigation-body-weight', 'Weight Trend', 'Weight trend is not available'),
      ('metric-body', 'navigation-body-measurements', 'Body Measurements', 'Other measurements not loaded'),
      ('metric-body', 'navigation-body-nutrition', 'Nutrition & Wellness', 'Nutrition offer preview'),
      ('metric-body', 'navigation-body-goals', 'Body Goals', 'Set a body goal'),
    ];

    for (final destination in destinations) {
      await tester.tap(find.byKey(ValueKey(destination.$1)));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(ValueKey(destination.$2)));
      await tester.pumpAndSettle();
      expect(find.text(destination.$3), findsOneWidget);
      expect(find.textContaining(destination.$4), findsWidgets);
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('navigation rail fits its panel and keeps labels inside the frame', (tester) async {
    setPhoneViewport(tester, const Size(360, 780));
    addViewportReset(tester);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    final rail = tester.getSize(find.byKey(const ValueKey('navigation-rail')));
    final panel = tester.getSize(find.byKey(const ValueKey('attendance-panel')));
    expect(rail.width, 50);
    expect(rail.height, closeTo(panel.height, 0.1));
    expect(panel.height, greaterThan(290));
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Calendar'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('check-in action remains safe when tapped repeatedly', (tester) async {
    setPhoneViewport(tester, const Size(360, 780));
    addViewportReset(tester);

    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();
    final checkIn = find.byKey(const ValueKey('check-in-button'));

    await tester.tap(checkIn);
    await tester.pumpAndSettle();
    await tester.tap(checkIn);
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('check-in-freeze-header-image')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('dashboard fits compact phone and short landscape-like viewports', (tester) async {
    for (final size in <Size>[
      const Size(320, 560),
      const Size(320, 640),
      const Size(360, 600),
      const Size(360, 700),
      const Size(390, 720),
      const Size(800, 600),
    ]) {
      setPhoneViewport(tester, size);
      await tester.pumpWidget(const BadGymApp());
      await tester.pumpAndSettle();

      expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
      expect(find.byKey(const ValueKey('navigation-rail')), findsOneWidget);
      expect(
        tester.getSize(find.byKey(const ValueKey('attendance-panel'))).height,
        greaterThan(0),
        reason: 'The detail workspace must remain visible at $size',
      );
      expect(find.byType(SingleChildScrollView), findsNothing);
      expect(find.byType(ListView), findsNothing);
      expect(tester.takeException(), isNull, reason: 'Failed at $size');
    }
    addViewportReset(tester);
  });

  testWidgets('repeated mount and dispose stays clean', (tester) async {
    setPhoneViewport(tester, const Size(360, 700));
    addViewportReset(tester);

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
