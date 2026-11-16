import 'package:flutter/material.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';

class AttendanceHistoryCard extends StatelessWidget {
  final MemberIntelligenceData data;

  const AttendanceHistoryCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final historyItems = [
      _HistoryEntry(
          date: '16 Oct 2026',
          time: '07:12 AM',
          duration: '58 min',
          location: 'Main Gym Floor',
          isToday: true),
      _HistoryEntry(
          date: '15 Oct 2026',
          time: '06:45 PM',
          duration: '62 min',
          location: 'Free Weights Area',
          isToday: false),
      _HistoryEntry(
          date: '14 Oct 2026',
          time: '07:05 AM',
          duration: '55 min',
          location: 'Cardio Zone',
          isToday: false),
      _HistoryEntry(
          date: '13 Oct 2026',
          time: '07:30 AM',
          duration: '50 min',
          location: 'Functional Arena',
          isToday: false),
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: BadGymColors.coralPrimary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.history_rounded,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Check-In History',
                    style: TextStyle(
                      fontFamily: BadGymTypography.fontHeading,
                      fontWeight: FontWeight.w800,
                      fontSize: 12.5,
                      color: BadGymColors.inkPrimary,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    'Recent visits and workout logs',
                    style: TextStyle(
                      fontFamily: BadGymTypography.fontBody,
                      fontWeight: FontWeight.w500,
                      fontSize: 9,
                      color: BadGymColors.inkMuted,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...historyItems.map((item) => _buildItem(item)),
        ],
      ),
    );
  }

  Widget _buildItem(_HistoryEntry item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: item.isToday ? const Color(0xFFF0FDF4) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              item.isToday ? const Color(0xFF86EFAC) : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: item.isToday
                  ? const Color(0xFF22C55E)
                  : const Color(0xFFE2E8F0),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.isToday ? Icons.check_rounded : Icons.access_time_rounded,
              size: 15,
              color: item.isToday ? Colors.white : const Color(0xFF64748B),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.date,
                      style: const TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      item.duration,
                      style: const TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                        color: Color(0xFF059669),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 1.5),
                Text(
                  '${item.time} • ${item.location}',
                  style: const TextStyle(
                    fontFamily: BadGymTypography.fontBody,
                    fontSize: 9,
                    color: Color(0xFF64748B),
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

class _HistoryEntry {
  final String date;
  final String time;
  final String duration;
  final String location;
  final bool isToday;

  _HistoryEntry({
    required this.date,
    required this.time,
    required this.duration,
    required this.location,
    required this.isToday,
  });
}
