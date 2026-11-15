import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/dashboard_theme_variant.dart';
import 'package:bad_gym/presentation/widgets/bottom_promo_banner.dart';

class ThemeAdaptiveBottomSection extends StatelessWidget {
  final DashboardThemeVariant variant;
  final MemberIntelligenceData data;

  const ThemeAdaptiveBottomSection({
    super.key,
    required this.variant,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case DashboardThemeVariant.festiveGold:
        return _buildFestiveGoldBottom();
      case DashboardThemeVariant.darkObsidianGold:
        return _buildDarkObsidianBottom(context);
      case DashboardThemeVariant.crimsonWave:
        return _buildCrimsonWaveBottom();
      case DashboardThemeVariant.royalPurple:
        return _buildRoyalPurpleBottom();
      case DashboardThemeVariant.emeraldNeon:
        return _buildEmeraldNeonBottom();
    }
  }

  // 1. Festive Gold: Real Gym Duffle Bag, Dumbbell, Shaker, and "TRAIN TRACK TRANSFORM" banner
  Widget _buildFestiveGoldBottom() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/themes/festive_gold/bottom_gear.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const BottomPromoBanner(),
            ),
          ),
        ],
      ),
    );
  }

  // 2. Dark Obsidian: Muscle Building Program + 4 Luxury Action Buttons
  Widget _buildDarkObsidianBottom(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Muscle Building Program Card
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/themes/dark_obsidian/muscle_building_banner.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),
          const SizedBox(height: 12),

          // 4 Action Buttons Row: Renew Plan | Download Invoice | Upgrade Plan | Contact Support
          Row(
            children: [
              _buildDarkActionButton(
                icon: Icons.sync_rounded,
                label: 'Renew Plan',
                highlight: true,
                onTap: () {
                  HapticFeedback.lightImpact();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Renew Plan selected')),
                  );
                },
              ),
              const SizedBox(width: 8),
              _buildDarkActionButton(
                icon: Icons.download_rounded,
                label: 'Download\nInvoice',
                onTap: () {
                  HapticFeedback.lightImpact();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Downloading invoice...')),
                  );
                },
              ),
              const SizedBox(width: 8),
              _buildDarkActionButton(
                icon: Icons.workspace_premium_rounded,
                label: 'Upgrade\nPlan',
                onTap: () {
                  HapticFeedback.lightImpact();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Upgrade Plan selected')),
                  );
                },
              ),
              const SizedBox(width: 8),
              _buildDarkActionButton(
                icon: Icons.support_agent_rounded,
                label: 'Contact\nSupport',
                onTap: () {
                  HapticFeedback.lightImpact();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Contacting BAD GYM Support...')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDarkActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool highlight = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          decoration: BoxDecoration(
            color: highlight ? const Color(0xFFFFD700) : const Color(0xFF1E212D),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: highlight ? const Color(0xFFFFB300) : Colors.white12,
              width: 1,
            ),
            boxShadow: highlight
                ? [
                    BoxShadow(
                      color: const Color(0xFFFFD700).withValues(alpha: 0.3),
                      blurRadius: 8,
                    )
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: highlight ? Colors.black87 : const Color(0xFFFFD700),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: highlight ? Colors.black : Colors.white70,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 3. Crimson Wave: Bottom Wave Ribbon with mint leaves
  Widget _buildCrimsonWaveBottom() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/themes/crimson_wave/bottom_red_wave.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const BottomPromoBanner(),
            ),
          ),
        ],
      ),
    );
  }

  // 4. Royal Purple: AI Insight Coaching Card
  Widget _buildRoyalPurpleBottom() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/themes/royal_purple/ai_insight_card.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const BottomPromoBanner(),
            ),
          ),
        ],
      ),
    );
  }

  // 5. Emerald Neon: Bioluminescent Energy Promo
  Widget _buildEmeraldNeonBottom() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF00E676),
            Color(0xFF00B0FF),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00E676).withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.bolt, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BIO-ENERGY WORKOUT MODE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Active heart rate monitoring & eco-gym rewards enabled.',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
