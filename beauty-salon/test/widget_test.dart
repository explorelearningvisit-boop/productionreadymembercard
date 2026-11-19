import 'dart:ui' show Size;

import 'package:beauty_salon/main.dart';
import 'package:flutter_test/flutter_test.dart';

void setMobileViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(360, 640);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('GlowBelle dashboard renders and scrolls without layout exceptions', (tester) async {
    setMobileViewport(tester);
    await tester.pumpWidget(const GlowBelleApp());

    expect(find.text('GlowBelle'), findsOneWidget);
    expect(find.text('Priya Sharma 👑'), findsOneWidget);
    expect(tester.takeException(), isNull);

    final scrollable = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(
      find.text('Your Upcoming Booking'),
      260,
      scrollable: scrollable,
    );
    expect(find.text('Your Upcoming Booking'), findsOneWidget);
    expect(find.text('Member Intelligence'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.textContaining('Recommended For You'),
      260,
      scrollable: scrollable,
    );
    expect(find.textContaining('Recommended For You'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('bottom navigation switches sections', (tester) async {
    setMobileViewport(tester);
    await tester.pumpWidget(const GlowBelleApp());
    await tester.tap(find.text('Bookings').last);
    await tester.pumpAndSettle();

    expect(find.text('Your GlowBelle experience'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
