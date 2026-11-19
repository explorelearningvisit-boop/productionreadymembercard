import 'package:flutter_test/flutter_test.dart';
import 'package:beauty_salon/main.dart';

void main() {
  testWidgets('GlowBelle dashboard shows core reference sections', (tester) async {
    await tester.view.setPhysicalSize(const Size(432, 900));
    await tester.view.setDevicePixelRatio(1);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const GlowBelleApp());
    expect(find.text('GlowBelle'), findsOneWidget);
    expect(find.text('Priya Sharma 👑'), findsOneWidget);
    expect(find.text('Featured Treatment'), findsOneWidget);
    expect(find.text('Your Upcoming Booking'), findsOneWidget);
    expect(find.text('Member Intelligence'), findsOneWidget);
    expect(find.text('Recommended For You'), findsOneWidget);
  });

  testWidgets('bottom navigation switches sections', (tester) async {
    await tester.view.setPhysicalSize(const Size(432, 900));
    await tester.view.setDevicePixelRatio(1);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const GlowBelleApp());
    await tester.tap(find.text('Bookings'));
    await tester.pumpAndSettle();
    expect(find.text('Bookings'), findsWidgets);
    expect(find.text('Your GlowBelle experience'), findsOneWidget);
  });
}
