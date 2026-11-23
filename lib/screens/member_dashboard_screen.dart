import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/sample_member.dart';
import '../theme/member_theme.dart';
import '../widgets/attendance_intelligence.dart';
import '../widgets/dashboard_components.dart';

class MemberDashboardScreen extends StatefulWidget {
  const MemberDashboardScreen({super.key});

  @override
  State<MemberDashboardScreen> createState() => _MemberDashboardScreenState();
}

class _MemberDashboardScreenState extends State<MemberDashboardScreen> {
  int section = 0;
  bool frozen = false;

  void _select(int index) => setState(() => section = index);

  Future<void> _freeze() async {
    final next = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              frozen ? 'Resume membership' : 'Freeze membership',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: MemberTheme.ink),
            ),
            const SizedBox(height: 5),
            Text(
              frozen
                  ? 'Resume check-in for ${MemberSample.name}. Sample only — no billing API is connected.'
                  : 'Pausing holds the Gold plan for ${MemberSample.name} and blocks check-in. Sample only — no billing API is connected.',
              style: const TextStyle(
                  fontSize: 13,
                  height: 1.35,
                  color: MemberTheme.muted,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: () => Navigator.pop(context, !frozen),
              style: FilledButton.styleFrom(
                backgroundColor: MemberTheme.purple,
                minimumSize: const Size.fromHeight(44),
                shape: const StadiumBorder(),
              ),
              child: Text(frozen ? 'Resume now' : 'Freeze now'),
            ),
          ],
          ),
        ),
      ),
    );
    if (next != null && mounted) setState(() => frozen = next);
  }

  void _notify() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            SizedBox(height: 10),
            _Note('Check-in recorded', 'Today · 07:12 AM'),
            _Note('Payment due', '₹500 before 24 Oct 2026'),
            _Note('Plan window', '8 days left on Gold'),
            SizedBox(height: 8),
            Text(MemberSample.sampleNote,
                style: TextStyle(fontSize: 10, color: MemberTheme.muted)),
          ],
          ),
        ),
      ),
    );
  }

  void _checkInInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          frozen
              ? 'Membership is frozen · resume your plan before check-in'
              : 'Check-in already complete · 07:12 AM',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: MemberTheme.canvas,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: MemberTheme.canvas,
          body: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFD8B4FE),
                  Color(0xFFF7EEFF),
                  Color(0xFFE9D5FF)
                ],
              ),
            ),
            child: Stack(
              children: [
                const Positioned(
                    top: -40,
                    right: -30,
                    child: _Glow(size: 180, color: Color(0x66C084FC))),
                const Positioned(
                    bottom: 20,
                    left: -40,
                    child: _Glow(size: 140, color: Color(0x559333EA))),
                SafeArea(
                  child: _DashboardScroll(
                    section: section,
                    frozen: frozen,
                    onSelect: _select,
                    onFreeze: _freeze,
                    onNotify: _notify,
                    onCheckIn: _checkInInfo,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _Glow extends StatelessWidget {
  final double size;
  final Color color;
  const _Glow({required this.size, required this.color});

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
      );
}

class _DashboardScroll extends StatelessWidget {
  final int section;
  final bool frozen;
  final ValueChanged<int> onSelect;
  final VoidCallback onFreeze;
  final VoidCallback onNotify;
  final VoidCallback onCheckIn;

  const _DashboardScroll({
    required this.section,
    required this.frozen,
    required this.onSelect,
    required this.onFreeze,
    required this.onNotify,
    required this.onCheckIn,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 520;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.fromLTRB(compact ? 7 : 14, 4, compact ? 7 : 14, 8),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0x22FFFFFF),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: const Color(0xFFFFD76A), width: 1.3),
                boxShadow: const [
                  BoxShadow(color: Color(0x337C3AED), blurRadius: 14, offset: Offset(0, 4)),
                  BoxShadow(color: Color(0x22FFC928), blurRadius: 8, spreadRadius: 1),
                ],
              ),
              child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (frozen) ...[
                    const SizedBox(height: 5),
                    const _FrozenBanner(),
                  ],
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xF8FFFFFF),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFFFD76A),
                        width: 1.5,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x447A18D1),
                          blurRadius: 14,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ActionStrip(
                          frozen: frozen,
                          onFreeze: onFreeze,
                          onNotify: onNotify,
                          onCheckIn: onCheckIn,
                        ),
                        const SizedBox(height: 7),
                        const MemberProfileCard(),
                        const SizedBox(height: 7),
                        Row(
                          key: const ValueKey('payment-promo-row'),
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Expanded(flex: 4, child: PaymentStrip()),
                            const SizedBox(width: 6),
                            Expanded(
                              flex: 6,
                              child: PromoBanner(onShop: () => onSelect(1)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const MembershipProgress(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 7),
                  AttendanceIntelligence(section: section, onSelect: onSelect),
                  const SizedBox(height: 5),
                  const EquipmentFooter(),
                ],
              ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FrozenBanner extends StatelessWidget {
  const _FrozenBanner();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFE0F2FE),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white),
        ),
        child: const Text(
          'Membership frozen · sample hold, no API connected',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Color(0xFF075985)),
        ),
      );
}

class _Note extends StatelessWidget {
  final String title;
  final String detail;
  const _Note(this.title, this.detail);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            const Icon(Icons.circle, size: 8, color: MemberTheme.purple),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 13)),
                  Text(detail,
                      style: const TextStyle(
                          fontSize: 11, color: MemberTheme.muted)),
                ],
              ),
            ),
          ],
        ),
      );
}
