/// Local preview data. Replace this immutable model with repository data
/// when the member API is connected.
class MemberSample {
  const MemberSample({
    required this.name,
    required this.memberId,
    required this.age,
    required this.gender,
    required this.plan,
    required this.attendance,
    required this.workout,
    required this.bodyWeight,
    required this.paymentDue,
    required this.membershipDays,
    required this.membershipTotalDays,
    required this.daysRemaining,
  });

  static const demo = MemberSample(
    name: 'Ashwani Kumar Singh',
    memberId: 'BG215',
    age: '28 yrs',
    gender: 'Male',
    plan: 'Gold Plan',
    attendance: '81%',
    workout: '58 min',
    bodyWeight: '69.5 kg',
    paymentDue: '₹500',
    membershipDays: 22,
    membershipTotalDays: 30,
    daysRemaining: 8,
  );

  final String name;
  final String memberId;
  final String age;
  final String gender;
  final String plan;
  final String attendance;
  final String workout;
  final String bodyWeight;
  final String paymentDue;
  final int membershipDays;
  final int membershipTotalDays;
  final int daysRemaining;

  double get membershipProgress =>
      membershipTotalDays <= 0 ? 0 : membershipDays / membershipTotalDays;
}
