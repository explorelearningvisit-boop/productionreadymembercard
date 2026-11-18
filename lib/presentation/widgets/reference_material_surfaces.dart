import 'package:flutter/material.dart';
import 'reference_design_tokens.dart';

/// Reusable double-edge pearl card from the approved glossy red/gold language.
class ReferenceCardSurface extends StatelessWidget {
  const ReferenceCardSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(10),
    this.radius = ReferenceDesignTokens.cardRadius,
    this.margin = EdgeInsets.zero,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        gradient: ReferenceDesignTokens.goldMetal,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: ReferenceDesignTokens.cardShadow,
      ),
      padding: const EdgeInsets.all(1.6),
      child: Container(
        decoration: BoxDecoration(
          gradient: ReferenceDesignTokens.pearlCard,
          borderRadius: BorderRadius.circular(radius - 1.5),
          border: Border.all(
            color: const Color(0xFFFFFDF8),
            width: 1,
          ),
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}

/// Glossy, beveled status/action pill. Text stays native and accessible.
class ReferenceGlossPill extends StatelessWidget {
  const ReferenceGlossPill({
    super.key,
    required this.label,
    required this.color,
    this.foreground = Colors.white,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  });

  final String label;
  final Color color;
  final Color foreground;
  final IconData? icon;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.lerp(color, Colors.white, .22)!,
            color,
            Color.lerp(color, Colors.black, .18)!,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Color.lerp(color, Colors.white, .52)!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: .28),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
          const BoxShadow(
            color: Color(0x66FFFFFF),
            blurRadius: 1,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: foreground),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Inter',
              color: foreground,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

/// Outer screen background and warm radial highlight.
class ReferencePageBackdrop extends StatelessWidget {
  const ReferencePageBackdrop({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: ReferenceDesignTokens.pageBackground,
      ),
      child: Stack(
        children: [
          const Positioned(
            top: -90,
            left: -60,
            child: IgnorePointer(
              child: SizedBox(
                width: 280,
                height: 280,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color(0x55FF9A30),
                        Color(0x00FF9A30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
