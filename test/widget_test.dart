import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym/main.dart';

void main() {
  testWidgets('renders the member intelligence dashboard', (tester) async {
    await tester.pumpWidget(const MemberIntelligenceApp());
    expect(find.text('CHECK-IN'), findsOneWidget);
    expect(find.textContaining('FREEZE'), findsOneWidget);
    expect(find.text('Ashwani Kumar Singh'), findsOneWidget);
    expect(find.text('Attendance Intelligence'), findsOneWidget);
    expect(find.text('Membership 22 / 30 Days'), findsOneWidget);
  });

  testWidgets('switches intelligence sections from the vertical rail',
      (tester) async {
    await tester.pumpWidget(const MemberIntelligenceApp());
    final workout = find.text('Workout').last;
    await tester.ensureVisible(workout);
    await tester.tap(workout);
    await tester.pumpAndSettle();
    expect(find.text('Workout Intelligence'), findsOneWidget);
  });
  testWidgets('uses the device current month and consistent membership expiry',
      (tester) async {
    await tester.pumpWidget(const MemberIntelligenceApp());
    final today = DateTime.now();
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final expiry = DateTime(today.year, today.month, today.day + 8);
    final expiryLabel =
        'Expires: ${expiry.day} ${months[expiry.month - 1].substring(0, 3)} ${expiry.year}';

    expect(find.text('${months[today.month - 1]} ${today.year}'),
        findsOneWidget);
    expect(find.text('8 Days Left'), findsOneWidget);
    expect(find.text(expiryLabel), findsOneWidget);
  });

}
