import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bad_gym_member_intelligence/data/dashboard_navigation.dart';
import 'package:bad_gym_member_intelligence/data/sample_member.dart';
import 'package:bad_gym_member_intelligence/main.dart';
import 'package:bad_gym_member_intelligence/screens/member_dashboard_screen.dart';
import 'package:bad_gym_member_intelligence/theme/member_theme.dart';
import 'package:bad_gym_member_intelligence/widgets/ad_motion.dart';

void setPhoneViewport(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
}

void addViewportReset(WidgetTester tester) {
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('reference structure, campaign art and pearl glass render', (tester) async {
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
    expect(find.text('Attendance Analytics'), findsOneWidget);
    expect(find.text('October attendance'), findsOneWidget);
    expect(find.text('Present'), findsOneWidget);
    expect(find.text('Absent'), findsOneWidget);
    expect(find.text('Holiday'), findsOneWidget);
    expect(find.text('Late'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test('Gold, Silver, Diamond and Spark use distinct member palettes', () {
    final gold = MemberPlanPalette.forPlan('Gold Plan');
    final spark = MemberPlanPalette.forPlan('Spark Plan');
    final silver = MemberPlanPalette.forPlan('Silver Plan');
    final diamond = MemberPlanPalette.forPlan('Diamond Plan');
    expect(gold.planName, 'Gold');
    expect(gold.frameGradient.first, const Color(0xFF3B2500));
    expect(gold.railGradient.first, const Color(0xFF765000));
    expect(gold.railSelected, const Color(0xFFFFE7A1));
    expect(gold.canvasGradient.first, const Color(0xFFFFFEF8));
    expect(spark.frameGradient.first, const Color(0xFF06452F));
    expect(silver.frameGradient.first, const Color(0xFF23334C));
    expect(diamond.planName, 'Diamond');
    expect(diamond.frameGradient.first, const Color(0xFF18364B));
  });

  test('each module has six destinations in the screenshot rail contract', () {
    for (final module in DashboardNavigation.modules) {
      final items = DashboardNavigation.itemsFor(module);
      expect(items, hasLength(6));
      expect(items.first.label, switch (module) {
        DashboardModule.attendance => 'Attend',
        DashboardModule.workout => 'Workout',
        DashboardModule.payment => 'Payment',
        DashboardModule.body => 'Body',
      });
      expect(items.last.label, module == DashboardModule.payment ? 'Rewards' : 'Goals');
    }
    expect(
      DashboardNavigation.itemsFor(DashboardModule.attendance).map((item) => item.id),
      ['attend', 'insights', 'calendar', 'history', 'trend', 'goals'],
    );
    expect(
      DashboardNavigation.itemsFor(DashboardModule.payment).map((item) => item.id),
      ['overview', 'insights', 'invoices', 'history', 'methods', 'rewards'],
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
    await tester.pumpWidget(MaterialApp(
      theme: MemberTheme.light,
      home: const MemberDashboardScreen(member: sparkMember),
    ));
    await tester.pumpAndSettle();
    expect(
      tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor,
      MemberPlanPalette.forPlan('Spark Plan').frameGradient.first,
    );
    expect(find.text('Spark Member'), findsOneWidget);
    expect(find.text('PAYMENT STATUS'), findsOneWidget);
    expect(find.text('Paid'), findsOneWidget);
    expect(find.text('PAYMENT DUE'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('all KPI cards switch modules and contextual rail', (tester) async {
    setPhoneViewport(tester, const Size(360, 780));
    addViewportReset(tester);
    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    for (final module in DashboardNavigation.modules) {
      await tester.tap(find.byKey(ValueKey('metric-${module.name}')));
      await tester.pumpAndSettle();
      final destinations = DashboardNavigation.itemsFor(module);
      for (var i = 0; i < destinations.length; i++) {
        expect(find.byKey(ValueKey(DashboardNavigation.keyFor(module, i))), findsOneWidget);
      }
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('every contextual destination opens its own detail panel', (tester) async {
    setPhoneViewport(tester, const Size(360, 780));
    addViewportReset(tester);
    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    for (final module in DashboardNavigation.modules) {
      await tester.tap(find.byKey(ValueKey('metric-${module.name}')));
      await tester.pumpAndSettle();
      final items = DashboardNavigation.itemsFor(module);
      for (var i = 0; i < items.length; i++) {
        await tester.tap(find.byKey(ValueKey(DashboardNavigation.keyFor(module, i))));
        await tester.pumpAndSettle();
        expect(find.text(items[i].title), findsOneWidget,
            reason: '${module.name} / ${items[i].id}');
        final expectedContent = switch (module) {
          DashboardModule.attendance => const [
              'Attendance Analytics',
              'WEEKLY ACTIVITY',
              'October 2026',
              'Gym check-in',
              'Attendance trend is not connected',
              'Monthly attendance',
            ],
          DashboardModule.workout => const [
              'Workout average',
              'Workout insights not connected',
              'Latest workout summary',
              'WORKOUT MINUTES • LAST 7 DAYS',
              'Recovery products',
              'Workout consistency',
            ],
          DashboardModule.payment => const [
              'Payment due',
              'Payment insights not connected',
              'Membership balance',
              'Outstanding membership amount',
              'Payment method preview',
              'Member reward preview',
            ],
          DashboardModule.body => const [
              'Current weight',
              'Body insights not connected',
              'Latest recorded weight',
              'Body weight',
              'Nutrition offer preview',
              'Set a body goal',
            ],
        };
        expect(
          find.text(expectedContent[i]),
          findsOneWidget,
          reason: 'Expected panel body for ${module.name} / ${items[i].id}',
        );
      }
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('Freeze and whey campaign actions open honest preview sheets', (tester) async {
    setPhoneViewport(tester, const Size(360, 780));
    addViewportReset(tester);
    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('freeze-preview-button')));
    await tester.pumpAndSettle();
    expect(find.text('Freeze request preview'), findsOneWidget);
    expect(
      find.text(
        'Demo preview only. No freeze request has been submitted and no membership dates have changed.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Close preview'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('whey-offer-preview')));
    await tester.pumpAndSettle();
    expect(find.text('Whey Protein · 25% OFF'), findsOneWidget);
    expect(
      find.text(
        'Sample campaign preview. A live purchase destination has not been connected yet.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Close offer'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('product artwork responds to hover and reduced motion', (tester) async {
    setPhoneViewport(tester, const Size(360, 780));
    addViewportReset(tester);
    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();

    final artwork = find.byKey(const ValueKey('artwork-Attendance'));
    expect(artwork, findsOneWidget);
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: tester.getCenter(artwork));
    await mouse.moveTo(tester.getCenter(artwork));
    await tester.pump(const Duration(milliseconds: 180));
    await mouse.removePointer();
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: MaterialApp(
          theme: MemberTheme.light,
          home: const Scaffold(
            body: Center(
              child: ArtworkEntrance(child: Icon(Icons.fitness_center)),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.fitness_center), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('rail layout remains inside compact and primary viewports', (tester) async {
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
      expect(find.byKey(const ValueKey('navigation-rail')), findsOneWidget);
      expect(tester.getSize(find.byKey(const ValueKey('navigation-rail'))).height, greaterThan(0));
      final layoutException = tester.takeException();
      if (layoutException != null) {
        debugPrint('Layout exception at $size: $layoutException');
        debugDumpRenderTree();
      }
      expect(layoutException, isNull, reason: 'Viewport $size');
    }
    addViewportReset(tester);
  });

  testWidgets('check-in control stays stable across repeated taps', (tester) async {
    setPhoneViewport(tester, const Size(360, 700));
    addViewportReset(tester);
    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();
    final checkIn = find.byKey(const ValueKey('check-in-button'));
    await tester.tap(checkIn);
    await tester.pumpAndSettle();
    await tester.tap(checkIn);
    await tester.pumpAndSettle();
    expect(find.text('PREVIEW · CHECKED IN'), findsOneWidget);
    expect(find.byKey(const ValueKey('check-in-freeze-header-image')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
