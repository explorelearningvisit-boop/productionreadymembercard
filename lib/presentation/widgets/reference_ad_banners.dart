import 'package:flutter/material.dart';
import 'package:bad_gym/core/theme/member_dashboard_palette.dart';

/// Compact, responsive advertising surfaces sized to the phone viewport.
class ReferenceAmazonBanner extends StatelessWidget {
  const ReferenceAmazonBanner({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Amazon Great Indian Festival, up to 40 percent off fitness and wellness',
      child: ClipRRect(
        key: const ValueKey('amazon_festival_banner'),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFD45C), Color(0xFFFF8DC9), Color(0xFF9B38D8), Color(0xFFFFD76B)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            border: Border.all(color: MemberDashboardPalette.gold, width: 1.5),
            boxShadow: const [BoxShadow(color: Color(0x88FFB51C), blurRadius: 12, spreadRadius: 1)],
          ),
          child: Stack(
            children: [
              Positioned(left: -12, top: -22, child: _sparkle(76)),
              Positioned(right: -10, bottom: -30, child: _sparkle(92)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 9, vertical: compact ? 3 : 6),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .92),
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(color: const Color(0xFFFFE6A2)),
                        ),
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text('amazon', style: TextStyle(color: Color(0xFF172238), fontSize: 21, fontWeight: FontWeight.w900, letterSpacing: -1.2)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      flex: 3,
                      child: compact
                          ? const FittedBox(fit: BoxFit.scaleDown, child: Text('GREAT INDIAN FESTIVAL', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF8D164C), fontSize: 9, fontWeight: FontWeight.w900)))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.auto_awesome_rounded, color: Color(0xFFFFD12D), size: 15),
                                FittedBox(fit: BoxFit.scaleDown, child: Text('Great Indian\nFestival', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF8D164C), fontSize: 11, height: .95, fontWeight: FontWeight.w900))),
                              ],
                            ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 4,
                      child: compact
                          ? const FittedBox(fit: BoxFit.scaleDown, child: Text('UP TO 40% OFF', maxLines: 1, style: TextStyle(color: Color(0xFF2D183B), fontSize: 11, fontWeight: FontWeight.w900)))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                FittedBox(fit: BoxFit.scaleDown, child: Text('Up to 40% OFF', maxLines: 1, style: TextStyle(color: Color(0xFF2D183B), fontSize: 12, fontWeight: FontWeight.w900))),
                                FittedBox(fit: BoxFit.scaleDown, child: Text('Fitness & Wellness', maxLines: 1, style: TextStyle(color: Color(0xFF4E168E), fontSize: 9, fontWeight: FontWeight.w800))),
                              ],
                            ),
                    ),
                    const SizedBox(width: 3),
                    SizedBox(
                      width: compact ? 22 : 46,
                      height: compact ? 22 : 46,
                      child: Image.asset(
                        'assets/hero/hero_weights.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.fitness_center_rounded,
                          color: const Color(0xFF291B26),
                          size: compact ? 22 : 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(right: 5, top: 3, child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: MemberDashboardPalette.green, borderRadius: BorderRadius.circular(9)),
                child: const Text('Sponsored', style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.w900)),
              )),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _sparkle(double size) => Icon(Icons.auto_awesome_rounded, size: size, color: Colors.white.withValues(alpha: .22));
}

class ReferenceProteinBanner extends StatelessWidget {
  const ReferenceProteinBanner({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Fitness nutrition protein burger promotion, this week 50 percent off',
      child: ClipRRect(
        key: const ValueKey('protein_burger_banner'),
        borderRadius: BorderRadius.circular(17),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3D0008), Color(0xFF9D0018), Color(0xFF43000A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: MemberDashboardPalette.gold, width: 1.4),
            boxShadow: const [BoxShadow(color: Color(0x88FFB51C), blurRadius: 12, spreadRadius: 1)],
          ),
          child: Stack(
            children: [
              Positioned(right: -24, top: -34, child: Transform.rotate(
                angle: -.28,
                child: Container(width: 150, height: 65, decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFFFD72F), Color(0x00FFD72F)]),
                  borderRadius: BorderRadius.circular(40),
                )),
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: compact ? 7 : 10, vertical: compact ? 3 : 6),
                child: Row(
                  children: [
                    if (!compact) ...[
                      SizedBox(
                        width: 46,
                        height: 76,
                        child: Image.asset(
                          'assets/promo/promo_model.png',
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.fitness_center_rounded,
                            color: MemberDashboardPalette.gold,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                    Expanded(
                      flex: 5,
                      child: compact
                          ? const FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text('PROTEIN BURGER', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(color: MemberDashboardPalette.gold, borderRadius: BorderRadius.circular(5)),
                                  child: const Text('FITNESS NUTRITION', style: TextStyle(color: Color(0xFF2B080A), fontSize: 8, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: RichText(text: const TextSpan(children: [
                                    TextSpan(text: 'PROTEIN ', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
                                    TextSpan(text: 'BURGER', style: TextStyle(color: MemberDashboardPalette.gold, fontSize: 20, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
                                  ])),
                                ),
                                const Text('High Protein  •  Low Fat  •  More Energy', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w700)),
                              ],
                            ),
                    ),
                    const SizedBox(width: 4),
                    if (!compact)
                      SizedBox(
                        width: 64,
                        height: 76,
                        child: Image.asset(
                          'assets/promo/promo_burger.png',
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Text('🍔', style: TextStyle(fontSize: 34)),
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: compact ? 6 : 8, vertical: compact ? 3 : 5),
                      decoration: BoxDecoration(color: MemberDashboardPalette.gold, borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: Color(0x99FFB300), blurRadius: 8)]),
                      child: compact
                          ? const Text('50% OFF', style: TextStyle(color: Color(0xFF37000A), fontSize: 10, fontWeight: FontWeight.w900))
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('50% OFF', style: TextStyle(color: Color(0xFF37000A), fontSize: 11, fontWeight: FontWeight.w900)),
                                Text('Order Now  →', style: TextStyle(color: Color(0xFF37000A), fontSize: 8, fontWeight: FontWeight.w900)),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
