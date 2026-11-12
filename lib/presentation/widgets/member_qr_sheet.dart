import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class MemberQrSheet extends StatelessWidget {
  final MemberIntelligenceData data;

  const MemberQrSheet({super.key, required this.data});

  static Future<void> show(BuildContext context, MemberIntelligenceData data) {
    HapticFeedback.heavyImpact();
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => MemberQrSheet(data: data),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: BadGymColors.purpleDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 26),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 38,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [BadGymColors.gold, BadGymColors.goldDark],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.workspace_premium, size: 14, color: Color(0xFF1E0E00)),
                    SizedBox(width: 4),
                    Text(
                      'VIP ACCESS PASS',
                      style: TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontWeight: FontWeight.w900,
                        fontSize: 10.5,
                        color: Color(0xFF1E0E00),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Text(
            data.name,
            style: const TextStyle(
              fontFamily: BadGymTypography.fontHeading,
              fontWeight: FontWeight.w800,
              fontSize: 17,
              color: Colors.white,
            ),
          ),
          Text(
            'Member ID: ${data.memberId} • Access Level: Main Gym + VIP Lounge',
            style: const TextStyle(
              fontFamily: BadGymTypography.fontBody,
              fontSize: 10.5,
              color: BadGymColors.inkLight,
            ),
          ),
          const SizedBox(height: 16),

          // Barcode & Gate Scanner Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: BadGymColors.neonViolet.withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Gate Scanner Barcode representation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    38,
                    (i) => Container(
                      width: (i % 3 == 0) ? 3.5 : ((i % 5 == 0) ? 1.5 : 2.5),
                      height: 64,
                      margin: const EdgeInsets.symmetric(horizontal: 1.2),
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${data.memberId}-20261016-0642',
                  style: const TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    letterSpacing: 2.0,
                    color: Colors.black,
                  ),
                ),
                const Divider(height: 20, color: Color(0xFFE5E7EB)),
                const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.nfc_rounded, size: 16, color: BadGymColors.emerald),
                      SizedBox(width: 6),
                      Text(
                        'Hold near turnstile reader or scan barcode',
                        style: TextStyle(
                          fontFamily: BadGymTypography.fontBody,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4B5563),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Gate Status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: BadGymColors.purpleInnerGlass,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: BadGymColors.neonLime.withValues(alpha: 0.4)),
            ),
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: BadGymColors.neonLime,
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(
                      width: 8,
                      height: 8,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'TURNSTILE GATE 02: ACCESS GRANTED',
                    style: TextStyle(
                      fontFamily: BadGymTypography.fontHeading,
                      fontWeight: FontWeight.w800,
                      fontSize: 10.5,
                      color: BadGymColors.neonLime,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: BadGymColors.purpleCardStart,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(color: BadGymColors.neonVioletBorder.withValues(alpha: 0.5)),
                ),
              ),
              child: const Text(
                'Close Pass',
                style: TextStyle(
                  fontFamily: BadGymTypography.fontHeading,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
