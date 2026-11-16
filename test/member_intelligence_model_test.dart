import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';

void main() {
  group('MemberIntelligenceData derived values', () {
    final data = MemberIntelligenceData.ashwaniKumarSingh;

    test('normalizes legacy percentage values before rendering progress', () {
      expect(data.usedPercentage, 73.0);
      expect(data.membershipProgress, closeTo(0.73, 0.0001));
      expect(data.membershipPercent, 73);
    });

    test('derives membership days remaining and label consistently', () {
      expect(data.calculatedDaysLeft, 8);
      expect(data.membershipDaysLabel, 'Membership 22 / 30 Days');
    });

    test('formats the selected attendance month from model state', () {
      expect(data.attendanceMonthLabel, 'October 2026');
    });
  });
}
