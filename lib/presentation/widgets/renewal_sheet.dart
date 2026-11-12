import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class RenewalSheet extends StatelessWidget {
  final MemberIntelligenceData data;

  const RenewalSheet({super.key, required this.data});

  static Future<void> show(BuildContext context, MemberIntelligenceData data) {
    HapticFeedback.mediumImpact();
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => RenewalSheet(data: data),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: BadGymColors.purpleDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Row(
                  children: [
                    Icon(Icons.autorenew_rounded, color: BadGymColors.neonLime, size: 22),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Renew Gold Membership',
                        style: TextStyle(
                          fontFamily: BadGymTypography.fontHeading,
                          fontWeight: FontWeight.w800,
                          fontSize: 15.5,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: BadGymColors.redAbsent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: BadGymColors.redAbsent.withValues(alpha: 0.4)),
                ),
                child: Text(
                  '${data.daysLeft} Days Left',
                  style: const TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: BadGymColors.redAbsent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Expiry notice card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: BadGymColors.purpleInnerGlass,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: BadGymColors.neonViolet.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded, color: BadGymColors.inkLight, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Current cycle ends on ${data.renewDate}. Renew early to lock in your discounted ₹1,200/month rate without break in streak.',
                    style: const TextStyle(
                      fontFamily: BadGymTypography.fontBody,
                      fontSize: 10.5,
                      color: BadGymColors.inkLight,
                      height: 1.25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Plan Option 1: Monthly Gold Plan (Selected)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [BadGymColors.purpleCardStart, BadGymColors.purpleCardMid],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: BadGymColors.neonViolet, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: BadGymColors.neonViolet.withValues(alpha: 0.3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: BadGymColors.gold.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.workspace_premium, color: BadGymColors.gold, size: 20),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Gold Plan (1 Month)',
                              style: TextStyle(
                                fontFamily: BadGymTypography.fontHeading,
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.check_circle, color: BadGymColors.neonLime, size: 14),
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Full Gym Floor + Steam + Locker + 1 Shake/mo',
                        style: TextStyle(
                          fontFamily: BadGymTypography.fontBody,
                          fontSize: 9.5,
                          color: BadGymColors.inkLight,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  '₹1,200',
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Plan Option 2: 3-Month Platinum (Save 15%)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: BadGymColors.purpleInnerGlass,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: BadGymColors.neonViolet.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: BadGymColors.cyanBody.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.diamond_rounded, color: BadGymColors.cyanBody, size: 20),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Platinum (3 Months)',
                              style: TextStyle(
                                fontFamily: BadGymTypography.fontHeading,
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'SAVE 15%',
                            style: TextStyle(
                              fontFamily: BadGymTypography.fontHeading,
                              fontSize: 8.5,
                              fontWeight: FontWeight.w900,
                              color: BadGymColors.neonLime,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(
                        'All Gold perks + Personal Trainer 2 sessions',
                        style: TextStyle(
                          fontFamily: BadGymTypography.fontBody,
                          fontSize: 9.5,
                          color: BadGymColors.inkLight,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  '₹3,200',
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Checkout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Payment gateway initialized • Secure UPI checkout'),
                    backgroundColor: BadGymColors.purpleCardStart,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: BadGymColors.neonLime,
                foregroundColor: const Color(0xFF0F172A),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Proceed to Pay ₹1,200',
                style: TextStyle(
                  fontFamily: BadGymTypography.fontHeading,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
