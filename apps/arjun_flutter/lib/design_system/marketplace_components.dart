import 'package:flutter/material.dart';
import 'app_tokens.dart';

class MarketplaceSectionTitle extends StatelessWidget {
  const MarketplaceSectionTitle(this.title, {super.key, this.action, this.onAction});
  final String title;
  final String? action;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppTokens.ink, fontWeight: FontWeight.w800,
      ))),
      if (action != null)
        TextButton(onPressed: onAction, child: Text(action!)),
    ],
  );
}

class MarketplaceStatusChip extends StatelessWidget {
  const MarketplaceStatusChip({super.key, required this.label, required this.color});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(minHeight: 28),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(color: color.withValues(alpha: .12), borderRadius: BorderRadius.circular(30)),
    child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12)),
  );
}

class MarketplaceActionTile extends StatelessWidget {
  const MarketplaceActionTile({super.key, required this.icon, required this.label,
    required this.tint, required this.onTap});
  final IconData icon;
  final String label;
  final Color tint;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Semantics(
    button: true, label: label,
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppTokens.radiusCard),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTokens.radiusCard),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 104, minWidth: 88),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(width: 48, height: 48,
                decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(15)),
                child: Icon(icon, color: AppTokens.ink, size: 25)),
              const SizedBox(height: 8),
              Text(label, textAlign: TextAlign.center, maxLines: 2,
                style: const TextStyle(fontSize: 12, height: 1.2, fontWeight: FontWeight.w700)),
            ]),
          ),
        ),
      ),
    ),
  );
}

class MarketplaceEmptyState extends StatelessWidget {
  const MarketplaceEmptyState({super.key, required this.icon, required this.title,
    required this.message, this.actionLabel, this.onAction});
  final IconData icon;
  final String title, message;
  final String? actionLabel;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 52, color: AppTokens.muted),
        const SizedBox(height: 12),
        Text(title, textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTokens.ink)),
        const SizedBox(height: 6),
        Text(message, textAlign: TextAlign.center,
          style: const TextStyle(color: AppTokens.muted, height: 1.4)),
        if (actionLabel != null && onAction != null) ...[
          const SizedBox(height: 14),
          FilledButton(onPressed: onAction, child: Text(actionLabel!)),
        ],
      ]),
    ),
  );
}
