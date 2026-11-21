import 'package:flutter_test/flutter_test.dart';
import 'package:spriteforge/main.dart';

void main() {
  testWidgets('shows SpriteForge home screen', (tester) async {
    await tester.pumpWidget(const SpriteForgeApp());
    expect(find.text('SpriteForge'), findsOneWidget);
    expect(find.text('Choose image'), findsOneWidget);
    expect(find.text('Process all sprites'), findsOneWidget);
  });
}
