import 'package:flutter_test/flutter_test.dart';
import 'package:bad_gym_member_intelligence/data/sample_member.dart';

void main() {
  test('october sample matches the approved attendance totals', () {
    expect(MemberSample.countKind(DayKind.present), MemberSample.present);
    expect(MemberSample.countKind(DayKind.absent), MemberSample.absent);
    expect(MemberSample.countKind(DayKind.holiday), MemberSample.holiday);
    expect(MemberSample.countKind(DayKind.late), MemberSample.late);
    expect(MemberSample.countKind(DayKind.off), 0);
    expect(
      MemberSample.present + MemberSample.late + MemberSample.absent + MemberSample.holiday,
      MemberSample.monthDays,
    );
    expect(MemberSample.kindFor(MemberSample.today), DayKind.present);
    expect(MemberSample.workoutSum, MemberSample.workoutMinutes);
    expect(MemberSample.membershipDone / MemberSample.membershipTotal,
        closeTo(0.7333, 0.001));
  });
}
