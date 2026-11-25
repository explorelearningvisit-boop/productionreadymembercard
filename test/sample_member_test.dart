import 'package:flutter_test/flutter_test.dart';

import 'package:bad_gym_member_intelligence/data/sample_member.dart';

void main() {
  group('MemberSample', () {
    test('demo membership progress is valid', () {
      final member = MemberSample.demo;
      expect(member.membershipProgress, closeTo(0.7333, 0.001));
      expect(member.membershipDays, lessThan(member.membershipTotalDays));
      expect(member.daysRemaining, member.membershipTotalDays - member.membershipDays);
    });

    test('progress safely handles an invalid zero-day plan', () {
      const member = MemberSample(
        name: 'Test',
        memberId: 'T0',
        age: '0 yrs',
        gender: 'N/A',
        plan: 'Test',
        attendance: '0%',
        workout: '0 min',
        bodyWeight: '0 kg',
        paymentDue: '₹0',
        membershipDays: 0,
        membershipTotalDays: 0,
        daysRemaining: 0,
      );
      expect(member.membershipProgress, 0);
    });
  });
}
