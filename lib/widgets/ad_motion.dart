import 'package:flutter/material.dart';

/// Brief, one-shot entrance for a campaign or member product asset.
/// No periodic timer, shimmer, pulse or off-screen animation is used.
class ArtworkEntrance extends StatelessWidget {
  const ArtworkEntrance({
    required this.child,
    this.motion = 0,
    super.key,
  });

  final Widget child;

  /// A small layout-specific offset; motion is always finite and one-shot.
  final int motion;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
      child: child,
      builder: (context, value, child) {
        final progress = value.clamp(0.0, 1.0).toDouble();
        final offset = switch (motion) {
          1 => Offset(0, (1 - progress) * -4),
          2 => Offset(0, (1 - progress) * 4),
          3 => Offset((1 - progress) * 6, 0),
          _ => Offset(0, (1 - progress) * 6),
        };
        final scale = 0.96 + (0.04 * progress);
        return Opacity(
          opacity: progress,
          child: Transform.translate(
            offset: offset,
            child: Transform.scale(scale: scale, child: child),
          ),
        );
      },
    );
  }
}
