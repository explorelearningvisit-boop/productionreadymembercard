import 'package:flutter_test/flutter_test.dart';

import 'package:bad_gym_member_intelligence/data/sample_member.dart';

void main() {
  test('member card uses a valid membership progress value', () {
    expect(MemberSample.membershipProgress, closeTo(0.7333, 0.001));
    expect(MemberSample.membershipDays, lessThan(MemberSample.membershipTotalDays));
  });
}
