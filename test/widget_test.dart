import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym_member_intelligence/main.dart';
import 'package:bad_gym_member_intelligence/screens/member_dashboard_screen.dart';

void main() {
  Future<void> pumpDashboard(WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();
  }

  testWidgets('reference dashboard renders at 360dp', (tester) async {
    await pumpDashboard(tester);
    expect(find.byType(MemberDashboardScreen), findsOneWidget);
    for (final label in [
      'CHECK-IN', 'FREEZE', 'Ashwani Kumar Singh', 'BG215',
      'Gold Plan', 'Active', '₹500 Due', '8 Days Left',
      'Membership 22 / 30 Days', 'Big Billion Sale',
      'Attendance', 'Workout', 'Payment', 'Body',
      'Attendance Intelligence', 'Home overview',
      'Present', 'Absent', 'Holiday', 'History',
    ]) {
      expect(find.textContaining(label), findsWidgets, reason: 'Missing reference label: $label');
    }
    expect(find.text('81%'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('freeze control toggles and navigation rail selection works', (tester) async {
    await pumpDashboard(tester);
    await tester.tap(find.text('FREEZE'));
    await tester.pumpAndSettle();
    expect(find.text('FROZEN'), findsOneWidget);
    await tester.tap(find.text('Attend'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('supplied UI and equipment sprite atlases load', (tester) async {
    await pumpDashboard(tester);
    final uiSprites = await rootBundle.load('assets/images/badgym_ui_sprites.webp');
    final equipmentSprites = await rootBundle.load('assets/images/badgym_equipment_sprites.webp');
    final memberHero = await rootBundle.load('assets/images/member_hero.webp');
    final memberPortrait = await rootBundle.load('assets/images/member_portrait.png');
    final gymInterior = await rootBundle.load('assets/images/gym_interior.webp');
    final gymPlants = await rootBundle.load('assets/images/gym_plants.webp');
    expect(uiSprites.lengthInBytes, greaterThan(1000));
    expect(equipmentSprites.lengthInBytes, greaterThan(1000));
    expect(memberHero.lengthInBytes, greaterThan(1000));
    expect(memberPortrait.lengthInBytes, greaterThan(1000));
    expect(gymInterior.lengthInBytes, greaterThan(1000));
    expect(gymPlants.lengthInBytes, greaterThan(1000));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('dashboard remains usable on a narrow 320dp device', (tester) async {
    tester.view.physicalSize = const Size(320, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const BadGymApp());
    await tester.pumpAndSettle();
    expect(find.text('Attendance Intelligence'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
