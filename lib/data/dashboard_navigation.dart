import 'package:flutter/material.dart';

enum DashboardModule {
  attendance,
  workout,
  payment,
  body,
}

class DashboardMenuItem {
  const DashboardMenuItem({
    required this.id,
    required this.label,
    required this.title,
    required this.icon,
  });

  final String id;
  final String label;
  final String title;
  final IconData icon;
}

abstract final class DashboardNavigation {
  static const modules = <DashboardModule>[
    DashboardModule.attendance,
    DashboardModule.workout,
    DashboardModule.payment,
    DashboardModule.body,
  ];

  static const Map<DashboardModule, String> moduleLabels = {
    DashboardModule.attendance: 'Attendance',
    DashboardModule.workout: 'Workout',
    DashboardModule.payment: 'Payment',
    DashboardModule.body: 'Body',
  };

  static const Map<DashboardModule, List<DashboardMenuItem>> menus = {
    DashboardModule.attendance: [
      DashboardMenuItem(
        id: 'overview',
        label: 'Overview',
        title: 'Attendance Analytics',
        icon: Icons.event_available_rounded,
      ),
      DashboardMenuItem(
        id: 'calendar',
        label: 'Calendar',
        title: 'Attendance Calendar',
        icon: Icons.calendar_month_rounded,
      ),
      DashboardMenuItem(
        id: 'history',
        label: 'History',
        title: 'Attendance History',
        icon: Icons.history_rounded,
      ),
      DashboardMenuItem(
        id: 'insights',
        label: 'Insights',
        title: 'Attendance Insights',
        icon: Icons.insights_rounded,
      ),
      DashboardMenuItem(
        id: 'goals',
        label: 'Goals',
        title: 'Attendance Goals',
        icon: Icons.emoji_events_rounded,
      ),
    ],
    DashboardModule.workout: [
      DashboardMenuItem(
        id: 'overview',
        label: 'Overview',
        title: 'Workout Overview',
        icon: Icons.fitness_center_rounded,
      ),
      DashboardMenuItem(
        id: 'log',
        label: 'Workout Log',
        title: 'Workout Log',
        icon: Icons.receipt_long_rounded,
      ),
      DashboardMenuItem(
        id: 'trend',
        label: 'Trend',
        title: 'Workout Trend',
        icon: Icons.show_chart_rounded,
      ),
      DashboardMenuItem(
        id: 'recovery',
        label: 'Recovery',
        title: 'Recovery & Wellness',
        icon: Icons.spa_rounded,
      ),
      DashboardMenuItem(
        id: 'goals',
        label: 'Goals',
        title: 'Workout Goals',
        icon: Icons.emoji_events_rounded,
      ),
    ],
    DashboardModule.payment: [
      DashboardMenuItem(
        id: 'overview',
        label: 'Overview',
        title: 'Payment Overview',
        icon: Icons.account_balance_wallet_rounded,
      ),
      DashboardMenuItem(
        id: 'invoices',
        label: 'Invoices',
        title: 'Due & Invoices',
        icon: Icons.request_quote_rounded,
      ),
      DashboardMenuItem(
        id: 'history',
        label: 'History',
        title: 'Payment History',
        icon: Icons.history_rounded,
      ),
      DashboardMenuItem(
        id: 'methods',
        label: 'Methods',
        title: 'Payment Methods',
        icon: Icons.credit_card_rounded,
      ),
      DashboardMenuItem(
        id: 'rewards',
        label: 'Rewards',
        title: 'Payment Rewards',
        icon: Icons.card_giftcard_rounded,
      ),
    ],
    DashboardModule.body: [
      DashboardMenuItem(
        id: 'overview',
        label: 'Overview',
        title: 'Body Overview',
        icon: Icons.monitor_weight_outlined,
      ),
      DashboardMenuItem(
        id: 'weight',
        label: 'Weight',
        title: 'Weight Trend',
        icon: Icons.scale_rounded,
      ),
      DashboardMenuItem(
        id: 'measurements',
        label: 'Measures',
        title: 'Body Measurements',
        icon: Icons.straighten_rounded,
      ),
      DashboardMenuItem(
        id: 'nutrition',
        label: 'Nutrition',
        title: 'Nutrition & Wellness',
        icon: Icons.restaurant_rounded,
      ),
      DashboardMenuItem(
        id: 'goals',
        label: 'Goals',
        title: 'Body Goals',
        icon: Icons.flag_rounded,
      ),
    ],
  };

  static List<DashboardMenuItem> itemsFor(DashboardModule module) =>
      menus[module]!;

  static String keyFor(DashboardModule module, int index) =>
      'navigation-${module.name}-${itemsFor(module)[index].id}';
}
