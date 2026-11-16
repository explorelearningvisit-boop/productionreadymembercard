import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class BottomPromoBanner extends StatelessWidget {
  final VoidCallback? onOrderPressed;

  const BottomPromoBanner({
    super.key,
    this.onOrderPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF9E0010),
            Color(0xFF5E0008),
            Color(0xFF380005),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFFF334B).withValues(alpha: 0.4),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFBA0018).withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21),
        child: Stack(
          children: [
            // Ambient glow behind burger
            Positioned(
              right: 20,
              top: 40,
              width: 160,
              height: 160,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFF9800).withValues(alpha: 0.25),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 1. Top Ribbon & 50% OFF Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Ribbon Pill: FITNESS NUTRITION
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 3),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFFDF7A),
                              Color(0xFFFFB300),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFB300)
                                  .withValues(alpha: 0.4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: const Text(
                          'FITNESS NUTRITION',
                          style: TextStyle(
                            fontFamily: BadGymTypography.fontHeading,
                            fontWeight: FontWeight.w900,
                            fontSize: 9.5,
                            letterSpacing: 0.6,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      // Starburst Badge: THIS WEEK 50% OFF
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3.5),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFFE600),
                              Color(0xFFFFB300),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.25),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'THIS WEEK',
                              style: TextStyle(
                                fontFamily: BadGymTypography.fontHeading,
                                fontWeight: FontWeight.w900,
                                fontSize: 7,
                                color: Color(0xFF8B0000),
                                height: 1.0,
                              ),
                            ),
                            Text(
                              '50% OFF',
                              style: TextStyle(
                                fontFamily: BadGymTypography.fontHeading,
                                fontWeight: FontWeight.w900,
                                fontSize: 11,
                                color: Color(0xFFB91C1C),
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // 2. Title: PROTEIN BURGER
                  const Text(
                    'PROTEIN\nBURGER',
                    style: TextStyle(
                      fontFamily: BadGymTypography.fontHeading,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                      color: Colors.white,
                      height: 0.95,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // 3. Middle Area: Model on left + Delicious Burger on right
                  SizedBox(
                    height: 120,
                    child: Stack(
                      children: [
                        // Fitness Model
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          width: 140,
                          child: Image.asset(
                            'assets/promo/promo_model.png',
                            fit: BoxFit.contain,
                            alignment: Alignment.bottomLeft,
                            errorBuilder: (_, __, ___) => const SizedBox(),
                          ),
                        ),

                        // Delicious Protein Burger
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          width: 170,
                          child: Image.asset(
                            'assets/promo/promo_burger.png',
                            fit: BoxFit.contain,
                            alignment: Alignment.centerRight,
                            errorBuilder: (_, __, ___) => const SizedBox(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 4. Bottom Row: 3 Feature Pills + Order Now ➔ Button
                  Row(
                    children: [
                      // Feature 1: High Protein
                      _buildFeatureBadge(
                        icon: Icons.fitness_center_rounded,
                        label: 'High\nProtein',
                      ),
                      const SizedBox(width: 8),

                      // Feature 2: Low Fat
                      _buildFeatureBadge(
                        icon: Icons.eco_rounded,
                        label: 'Low\nFat',
                      ),
                      const SizedBox(width: 8),

                      // Feature 3: More Energy
                      _buildFeatureBadge(
                        icon: Icons.bolt_rounded,
                        label: 'More\nEnergy',
                      ),

                      const Spacer(),

                      // Golden Pill Button: Order Now ➔
                      InkWell(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          onOrderPressed?.call();
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFFDF7A),
                                Color(0xFFFFB300),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.8),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFB300)
                                    .withValues(alpha: 0.6),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Order Now',
                                style: TextStyle(
                                  fontFamily: BadGymTypography.fontHeading,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.black,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureBadge({
    required IconData icon,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.12),
            border: Border.all(
              color: const Color(0xFFFFDF7A).withValues(alpha: 0.6),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: const Color(0xFFFFDF7A),
            size: 13,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: BadGymTypography.fontBody,
            fontSize: 7.5,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
