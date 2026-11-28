import 'package:flutter/material.dart';

@immutable
class DashboardCampaign {
  const DashboardCampaign({
    required this.id,
    required this.advertiserId,
    required this.placementId,
    required this.brand,
    required this.headline,
    required this.offer,
    required this.cta,
    required this.asset,
    required this.surface,
    required this.accent,
    required this.accentText,
  });

  final String id;
  final String advertiserId;
  final String placementId;
  final String brand;
  final String headline;
  final String offer;
  final String cta;
  final String asset;
  final Color surface;
  final Color accent;
  final Color accentText;
}

/// Preview inventory. Production campaigns and frequency caps must come
/// from the server; this local set keeps the reference placements distinct.
abstract final class DashboardCampaigns {
  static const wheyTop = DashboardCampaign(
    id: 'whey-top-25',
    advertiserId: 'whey-nutrition',
    placementId: 'member-header-whey',
    brand: 'Whey Protein',
    headline: 'Whey Protein',
    offer: '25% OFF',
    cta: 'BUY NOW',
    asset: 'assets/material_pack/inbox/PulseVault/03_whey_protein_tub.webp',
    surface: Color(0xFF4F078E),
    accent: Color(0xFFFFD94F),
    accentText: Color(0xFF271140),
  );
  static const protinexAttendance = DashboardCampaign(
    id: 'protinex-attendance-10',
    advertiserId: 'protinex',
    placementId: 'kpi-attendance-protinex',
    brand: 'Protinex',
    headline: 'Protein',
    offer: '10% OFF',
    cta: 'VIEW',
    asset: 'assets/material_pack/inbox/PulseVault/28_protinex_tub.webp',
    surface: Color(0xFFFFE4E9),
    accent: Color(0xFFD92E55),
    accentText: Colors.white,
  );
  static const creatineWorkout = DashboardCampaign(
    id: 'creatine-workout-15',
    advertiserId: 'creatine-partner',
    placementId: 'kpi-workout-creatine',
    brand: 'Creatine',
    headline: 'Creatine',
    offer: '15% OFF',
    cta: 'VIEW',
    asset: 'assets/material_pack/inbox/PulseVault/06_creatine_tub.webp',
    surface: Color(0xFFF0D9FF),
    accent: Color(0xFF8F29C9),
    accentText: Colors.white,
  );
  static const sbiPayment = DashboardCampaign(
    id: 'sbi-payment-5',
    advertiserId: 'sbi-bank',
    placementId: 'kpi-payment-sbi',
    brand: 'SBI',
    headline: 'SBI',
    offer: 'GET 5% OFF',
    cta: 'VIEW',
    asset: 'assets/material_pack/inbox/PulseVault/29_sbi_payment_card_graphic.webp',
    surface: Color(0xFFD8EFFF),
    accent: Color(0xFF1769C2),
    accentText: Colors.white,
  );
  static const fatLossBody = DashboardCampaign(
    id: 'fat-loss-body-20',
    advertiserId: 'fat-loss-partner',
    placementId: 'kpi-body-fat-loss',
    brand: 'Fat Loss',
    headline: 'Fat Loss',
    offer: '20% OFF',
    cta: 'VIEW',
    asset: 'assets/material_pack/inbox/PulseVault/fat_loss_support_tub.png',
    surface: Color(0xFFDFF8E8),
    accent: Color(0xFF159B52),
    accentText: Colors.white,
  );
  static const blinkitAttendance = DashboardCampaign(
    id: 'blinkit-attendance-30',
    advertiserId: 'blinkit',
    placementId: 'attendance-header-blinkit',
    brand: 'Blinkit',
    headline: 'Healthy snacks & gym essentials',
    offer: 'UP TO 30% OFF',
    cta: 'SHOP',
    asset: 'assets/material_pack/inbox/PulseVault/05_blinkit_grocery_bag.webp',
    surface: Color(0xFFFFF3C8),
    accent: Color(0xFFFFD943),
    accentText: Color(0xFF29163E),
  );
  static const recoveryHydration = DashboardCampaign(
    id: 'recovery-hydration-30',
    advertiserId: 'recovery-hydration-partner',
    placementId: 'attendance-strip-recovery',
    brand: 'Recovery',
    headline: 'Recovery combo',
    offer: 'UP TO 30% OFF',
    cta: 'VIEW',
    asset: 'assets/material_pack/inbox/PulseVault/04_purple_shaker.webp',
    surface: Color(0xFFF0E2FF),
    accent: Color(0xFF7716CA),
    accentText: Colors.white,
  );
  static const trainMore = DashboardCampaign(
    id: 'train-more-15',
    advertiserId: 'train-more-partner',
    placementId: 'attendance-calendar-train-more',
    brand: 'Train More',
    headline: 'Train More',
    offer: 'GET 15% OFF',
    cta: 'VIEW',
    asset: 'assets/material_pack/inbox/PulseVault/27_dumbbell_promo_graphic.webp',
    surface: Color(0xFFF2E4FF),
    accent: Color(0xFF7716CA),
    accentText: Colors.white,
  );

  static const placements = <DashboardCampaign>[
    wheyTop,
    protinexAttendance,
    creatineWorkout,
    sbiPayment,
    fatLossBody,
    blinkitAttendance,
    recoveryHydration,
    trainMore,
  ];

  static bool get hasUniqueCampaignIds =>
      placements.map((campaign) => campaign.id).toSet().length == placements.length;

  static bool get hasUniqueAdvertisers =>
      placements.map((campaign) => campaign.advertiserId).toSet().length == placements.length;

  static bool get hasUniquePlacementIds =>
      placements.map((campaign) => campaign.placementId).toSet().length == placements.length;
}
