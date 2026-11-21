import 'package:flutter_test/flutter_test.dart';
import 'package:spriteforge/main.dart';

void main() {
  testWidgets('shows SpriteForge image studio', (tester) async {
    await tester.pumpWidget(const SpriteForgeApp());
    expect(find.text('SpriteForge'), findsOneWidget);
    expect(find.text('Upload any image(s)'), findsOneWidget);
    expect(find.text('AI remove background'), findsNothing);
  });
}
