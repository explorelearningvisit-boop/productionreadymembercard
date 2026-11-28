import 'package:flutter/material.dart';

import '../data/dashboard_campaigns.dart';
import '../theme/member_theme.dart';

/// An ad footer is a sibling of the module hit-area, never nested inside it.
class CampaignFooterButton extends StatelessWidget {
  const CampaignFooterButton({
    required this.campaign,
    required this.onTap,
    this.compact = false,
    super.key,
  });

  final DashboardCampaign campaign;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Advertisement. ${campaign.brand}. ${campaign.offer}. Open preview.',
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          key: ValueKey('campaign-footer-${campaign.id}'),
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: compact ? 21 : 24,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: campaign.accent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.82)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                  decoration: BoxDecoration(
                    color: campaign.accentText.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'AD',
                    style: TextStyle(
                      color: campaign.accentText,
                      fontSize: compact ? 7.5 : 8,
                      height: 1,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 3),
                Expanded(
                  child: Text(
                    '${campaign.brand} ${campaign.offer}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: campaign.accentText,
                      fontSize: compact ? 9 : 9.5,
                      height: 1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: campaign.accentText,
                  size: compact ? 13 : 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A paid placement with its own action surface, image, offer and sponsor tag.
class SponsoredCampaignBanner extends StatelessWidget {
  const SponsoredCampaignBanner({
    required this.campaign,
    required this.onTap,
    required this.height,
    required this.imageWidth,
    this.width,
    this.compact = true,
    super.key,
  });

  final DashboardCampaign campaign;
  final VoidCallback onTap;
  final double height;
  final double imageWidth;
  final double? width;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Semantics(
        button: true,
        label: 'Sponsored advertisement. ${campaign.brand}. ${campaign.offer}. ${campaign.cta}.',
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          child: InkWell(
            key: ValueKey('campaign-banner-${campaign.id}'),
            onTap: onTap,
            borderRadius: BorderRadius.circular(9),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: compact ? 3 : 5, vertical: compact ? 1 : 2),
              decoration: BoxDecoration(
                color: campaign.surface,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: campaign.accent.withOpacity(0.35)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                    decoration: BoxDecoration(
                      color: campaign.accent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'AD',
                      style: TextStyle(
                        color: campaign.accentText,
                        fontSize: compact ? 7 : 8,
                        height: 1,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Image.asset(
                    campaign.asset,
                    width: imageWidth,
                    height: height - 6,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: compact
                        ? Text(
                            '${campaign.brand} · ${campaign.offer}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: campaign.accentText == Colors.white
                                  ? campaign.accent
                                  : MemberTheme.ink,
                              fontSize: 7,
                              height: 1,
                              fontWeight: FontWeight.w900,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                campaign.brand,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: MemberTheme.ink,
                                  fontSize: 9.5,
                                  height: 1,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                campaign.offer,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: campaign.accentText == Colors.white
                                      ? campaign.accent
                                      : MemberTheme.ink,
                                  fontSize: 8.5,
                                  height: 1,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(width: 2),
                  Icon(Icons.open_in_new_rounded, color: MemberTheme.muted, size: compact ? 10 : 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

abstract final class CampaignPreviewSheet {
  static Future<void> show(
    BuildContext context,
    DashboardCampaign campaign, {
    Color accent = MemberTheme.purple,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        key: ValueKey('campaign-preview-${campaign.id}'),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 20),
        decoration: BoxDecoration(
          color: MemberTheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          border: Border.all(color: MemberTheme.glassEdge),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.campaign_outlined, color: accent, size: 20),
                const SizedBox(width: 7),
                const Text(
                  'Sponsored offer preview',
                  style: TextStyle(
                    color: MemberTheme.ink,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Image.asset(campaign.asset, width: 70, height: 64, fit: BoxFit.contain),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(campaign.brand, style: TextStyle(color: accent, fontSize: 12, fontWeight: FontWeight.w700)),
                      Text(campaign.headline, style: const TextStyle(color: MemberTheme.ink, fontSize: 18, fontWeight: FontWeight.w900)),
                      Text(campaign.offer, style: TextStyle(color: campaign.accent, fontSize: 16, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'This is a local creative preview. A verified advertiser landing URL has not been configured, so no purchase or external redirect will be started.',
              style: TextStyle(color: MemberTheme.muted, fontSize: 12, height: 1.3),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                key: ValueKey('close-campaign-preview-${campaign.id}'),
                style: FilledButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(42),
                ),
                onPressed: () => Navigator.of(sheetContext).pop(),
                child: const Text('Close preview'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
