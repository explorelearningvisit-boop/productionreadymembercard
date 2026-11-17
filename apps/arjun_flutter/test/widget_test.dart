import 'package:flutter_test/flutter_test.dart';
import 'package:arjun_app/main.dart';

void main() {
  testWidgets('ARJUN opens the Hindi-first dashboard', (tester) async {
    await tester.pumpWidget(const ArjunApp());
    expect(find.text('ARJUN'), findsOneWidget);
    expect(find.text('नमस्ते 👋'), findsOneWidget);
    expect(find.text('काम पोस्ट करें'), findsWidgets);
  });
}
