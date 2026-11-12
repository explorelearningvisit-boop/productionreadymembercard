import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class NotificationSheet extends StatelessWidget {
  const NotificationSheet({super.key});

  static Future<void> show(BuildContext context) {
    HapticFeedback.mediumImpact();
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const NotificationSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: BadGymColors.purpleDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
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
                    Icon(
                      Icons.notifications_active_rounded,
                      color: BadGymColors.neonViolet,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Gym Alerts & Updates',
                        style: TextStyle(
                          fontFamily: BadGymTypography.fontHeading,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
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
                child: const Text(
                  '3 New',
                  style: TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: BadGymColors.redAbsent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Notification Items
          _buildNotificationItem(
            icon: Icons.access_time_filled_rounded,
            iconColor: BadGymColors.gold,
            title: 'Membership Renewal Notice',
            description: '8 days left on your Gold Plan. Early bird 15% renewal discount active until 24 Oct.',
            time: '10 min ago',
          ),
          const SizedBox(height: 10),
          _buildNotificationItem(
            icon: Icons.local_fire_department_rounded,
            iconColor: const Color(0xFFEA580C),
            title: '5-Day Streak Achieved! 🔥',
            description: 'Awesome discipline! Complete your Friday session to unlock the Consistent Beast badge.',
            time: '2 hours ago',
          ),
          const SizedBox(height: 10),
          _buildNotificationItem(
            icon: Icons.local_cafe_rounded,
            iconColor: BadGymColors.neonViolet,
            title: 'Complimentary Protein Shake',
            description: 'Your monthly Gold Member benefit: Claim 1 free Whey Isolate shake at the Nutrition Bar.',
            time: 'Yesterday',
          ),
          const SizedBox(height: 18),

          // Dismiss Button
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
                'Mark All as Read',
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

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: BadGymColors.purpleInnerGlass.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: BadGymColors.neonViolet.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontFamily: BadGymTypography.fontHeading,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontFamily: BadGymTypography.fontBody,
                        fontSize: 9.5,
                        color: BadGymColors.inkLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: BadGymTypography.fontBody,
                    fontSize: 10,
                    color: BadGymColors.inkLight,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
