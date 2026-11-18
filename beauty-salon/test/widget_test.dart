import 'package:flutter_test/flutter_test.dart';
import 'package:beauty_salon/main.dart';

void main() {
  testWidgets('renders salon branding and role workspaces', (tester) async {
    await tester.pumpWidget(const SalonApp());
    expect(find.text('BEAUTY STUDIO'), findsOneWidget);
    expect(find.text('Choose your space'), findsOneWidget);
    expect(find.text('Customer'), findsOneWidget);
    expect(find.text('Salon Owner'), findsOneWidget);
    expect(find.text('Salon Team'), findsOneWidget);
  });
}
