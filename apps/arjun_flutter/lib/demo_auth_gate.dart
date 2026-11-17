import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Demo identity is deliberately available only in debug builds.
/// Release builds cannot enable this gate with a dart-define.
const bool _demoAuthRequested = bool.fromEnvironment(
  'ARJUN_DEMO_AUTH',
  defaultValue: true,
);

class DemoAuthGate extends StatelessWidget {
  const DemoAuthGate({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode && _demoAuthRequested) return _DemoLogin(onContinue: () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => child),
      );
    });
    return const _AuthNotConfigured();
  }
}

class _DemoLogin extends StatefulWidget {
  const _DemoLogin({required this.onContinue});
  final VoidCallback onContinue;

  @override
  State<_DemoLogin> createState() => _DemoLoginState();
}

class _DemoLoginState extends State<_DemoLogin>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 850),
  )..forward();
  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF087F5B);
    const deep = Color(0xFF063B32);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F4),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(22, 28, 22, 24),
            children: [
              Container(
                height: 220,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [deep, Color(0xFF0C8060), Color(0xFFB9E5C8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -8,
                      bottom: -18,
                      child: Icon(Icons.engineering_rounded,
                          size: 174, color: Colors.white.withValues(alpha: .14)),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.construction_rounded,
                              color: Color(0xFFFFC857), size: 42),
                          Spacer(),
                          Text('ARJUN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              )),
                          Text('काम • हुनर • भरोसा',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16)),
                          SizedBox(height: 8),
                          Text('Rooted in Kashi. Built for the World.',
                              style: TextStyle(
                                  color: Color(0xFFD9F5E8), fontSize: 11)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text('ARJUN में आपका स्वागत है',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF12372F))),
              const SizedBox(height: 6),
              const Text('टेस्टिंग के लिए एक टैप में ऐप खोलें।',
                  style: TextStyle(color: Color(0xFF63736D), fontSize: 14)),
              const SizedBox(height: 22),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE4ECE7)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFE0F4E9),
                        child: Icon(Icons.person_rounded, color: green),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text('Demo Tester',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w800)),
                      ),
                      Chip(
                        label: Text('TEST'),
                        visualDensity: VisualDensity.compact,
                        backgroundColor: Color(0xFFFFF2D2),
                        side: BorderSide.none,
                      ),
                    ]),
                    SizedBox(height: 16),
                    _DemoField(icon: Icons.mail_outline, value: 'tester@arjun.demo'),
                    SizedBox(height: 9),
                    _DemoField(icon: Icons.phone_android, value: '+91 90000 00000'),
                    SizedBox(height: 14),
                    Text('यह नकली टेस्ट पहचान है। इससे OTP, ईमेल या वास्तविक अकाउंट सत्यापित नहीं होता।',
                        style: TextStyle(
                            color: Color(0xFF697A73), fontSize: 11)),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 58,
                child: FilledButton.icon(
                  onPressed: widget.onContinue,
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: const Text('टेस्ट ऐप खोलें',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                  style: FilledButton.styleFrom(
                    backgroundColor: green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Center(
                child: Text('DEVELOPMENT ENVIRONMENT ONLY',
                    style: TextStyle(
                        color: Color(0xFF8B9892),
                        fontSize: 10,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoField extends StatelessWidget {
  const _DemoField({required this.icon, required this.value});
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F7F5),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(children: [
          Icon(icon, size: 18, color: const Color(0xFF087F5B)),
          const SizedBox(width: 10),
          Text(value,
              style: const TextStyle(
                  color: Color(0xFF33463D), fontWeight: FontWeight.w600)),
        ]),
      );
}

class _AuthNotConfigured extends StatelessWidget {
  const _AuthNotConfigured();

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock_outline_rounded,
                    size: 54, color: Color(0xFF087F5B)),
                SizedBox(height: 16),
                Text('Authentication setup required',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                SizedBox(height: 8),
                Text(
                  'Production login is not connected yet. Demo login is disabled outside debug builds.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
}
