import 'package:flutter_test/flutter_test.dart';
import 'package:beauty_salon/main.dart';

void main() {
  testWidgets('shows the three role entry points', (tester) async {
    await tester.pumpWidget(const BeautySalonApp());
    expect(find.text('Customer'), findsOneWidget);
    expect(find.text('Salon Owner'), findsOneWidget);
    expect(find.text('Staff'), findsOneWidget);
  });
}
