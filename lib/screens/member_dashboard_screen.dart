import 'package:flutter/material.dart';

import '../data/sample_member.dart';
import '../theme/member_theme.dart';

class MemberDashboardScreen extends StatefulWidget {
  const MemberDashboardScreen({super.key});

  @override
  State<MemberDashboardScreen> createState() => _MemberDashboardScreenState();
}

class _MemberDashboardScreenState extends State<MemberDashboardScreen> {
  bool _checkedIn = false;
  String? _checkInTime;

  void _checkIn() {
    if (_checkedIn) return;
    setState(() {
      _checkedIn = true;
      _checkInTime = TimeOfDay.now().format(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MemberTheme.canvas,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F3FC), Color(0xFFEDE5F8)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 430),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'BAD GYM',
                              style: TextStyle(
                                color: MemberTheme.deepPurple,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.1,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'MEMBER CARD',
                              style: TextStyle(
                                color: MemberTheme.muted,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                MemberTheme.deepPurple,
                                Color(0xFF54249A),
                                Color(0xFF34206D),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: MemberTheme.gold,
                              width: 1.2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x247A38C5),
                                blurRadius: 18,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'MEMBER INTELLIGENCE',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ),
                                  _SampleBadge(),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Row(
                                children: [
                                  Container(
                                    width: 62,
                                    height: 62,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                        color: MemberTheme.gold,
                                        width: 2,
                                      ),
                                    ),
                                    child: const Text(
                                      'AS',
                                      style: TextStyle(
                                        color: MemberTheme.deepPurple,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          MemberSample.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            height: 1.08,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          'ID ${MemberSample.memberId}  •  ${MemberSample.age}  •  ${MemberSample.gender}',
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Row(
                                children: [
                                  _Pill(
                                    label: MemberSample.plan,
                                    background: MemberTheme.gold,
                                    foreground: MemberTheme.deepPurple,
                                  ),
                                  SizedBox(width: 8),
                                  _Pill(
                                    label: 'ACTIVE',
                                    background: Color(0xFFDDF7E7),
                                    foreground: MemberTheme.green,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.10),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.white24,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Text(
                                      "TODAY'S CHECK-IN",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _checkedIn
                                                ? 'Checked in'
                                                : 'Not checked in',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                        if (_checkedIn)
                                          Text(
                                            _checkInTime ?? '',
                                            style: const TextStyle(
                                              color: MemberTheme.gold,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 11),
                                    Semantics(
                                      button: true,
                                      enabled: !_checkedIn,
                                      label: _checkedIn
                                          ? 'Member checked in'
                                          : 'Check in member',
                                      child: GestureDetector(
                                        key: const ValueKey('check-in-button'),
                                        onTap: _checkedIn ? null : _checkIn,
                                        child: Container(
                                          height: 46,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: _checkedIn
                                                ? const Color(0xFFDDF7E7)
                                                : MemberTheme.gold,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            _checkedIn
                                                ? 'CHECKED IN'
                                                : 'CHECK IN',
                                            style: TextStyle(
                                              color: _checkedIn
                                                  ? MemberTheme.green
                                                  : MemberTheme.deepPurple,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'MEMBERSHIP',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      '${MemberSample.membershipDays} / ${MemberSample.membershipTotalDays} days',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${(MemberSample.membershipProgress * 100).round()}%',
                                    style: const TextStyle(
                                      color: MemberTheme.gold,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  height: 8,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: MemberSample.membershipDays,
                                        child: const ColoredBox(
                                          color: Color(0xFF42D98A),
                                        ),
                                      ),
                                      Expanded(
                                        flex: MemberSample.membershipTotalDays -
                                            MemberSample.membershipDays,
                                        child: const ColoredBox(
                                          color: Colors.white24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                '${MemberSample.daysRemaining} days remaining',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Row(
                                children: [
                                  Expanded(
                                    child: _Metric(
                                      label: 'ATTENDANCE',
                                      value: MemberSample.attendance,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: _Metric(
                                      label: 'WORKOUT',
                                      value: MemberSample.workout,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                children: [
                                  Expanded(
                                    child: _Metric(
                                      label: 'BODY WEIGHT',
                                      value: MemberSample.bodyWeight,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: _Metric(
                                      label: 'PAYMENT DUE',
                                      value: MemberSample.paymentDue,
                                      valueColor: Color(0xFFFFD166),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Demo member record • Live gym data is not connected',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: MemberTheme.muted,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SampleBadge extends StatelessWidget {
  const _SampleBadge();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
        ),
        child: const Text(
          'SAMPLE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.6,
          ),
        ),
      );
}

class _Pill extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;

  const _Pill({
    required this.label,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: foreground,
            fontSize: 10,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _Metric({
    required this.label,
    required this.value,
    this.valueColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.09),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 8,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.7,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      );
}
