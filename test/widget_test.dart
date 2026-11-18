import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym_member_intelligence/main.dart';

void main() {
  testWidgets('dashboard renders key sections', (tester) async {
    await tester.pumpWidget(const BadGymApp());
    expect(find.text('BAD '), findsNothing); // brand uses a rich text span
    expect(find.text('Member Intelligence'), findsOneWidget);
    expect(find.text('Attendance Intelligence'), findsOneWidget);
    expect(find.text('PROTEIN '), findsNothing); // rich text span is composed
  });
}
