import 'package:flutter/material.dart';

/// Finite product-art entrance plus restrained pointer/touch depth feedback.
///
/// Product images never spin or animate continuously. Hover adds a small
/// perspective lean on pointer devices; touch uses a brief pressed response.
/// All motion respects the platform's reduced-animation preference.
class ArtworkEntrance extends StatefulWidget {
  const ArtworkEntrance({
    required this.child,
    this.motion = 0,
    super.key,
  });

  final Widget child;
  final int motion;

  @override
  State<ArtworkEntrance> createState() => _ArtworkEntranceState();
}

class _ArtworkEntranceState extends State<ArtworkEntrance> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    return MouseRegion(
      onEnter: (_) {
        if (!_hovered) setState(() => _hovered = true);
      },
      onExit: (_) {
        if (_hovered) setState(() => _hovered = false);
      },
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) {
          if (!_pressed) setState(() => _pressed = true);
        },
        onPointerUp: (_) {
          if (_pressed) setState(() => _pressed = false);
        },
        onPointerCancel: (_) {
          if (_pressed) setState(() => _pressed = false);
        },
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: reduceMotion
              ? Duration.zero
              : const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          child: widget.child,
          builder: (context, value, child) {
            final progress = reduceMotion
                ? 1.0
                : value.clamp(0.0, 1.0).toDouble();
            final offset = switch (widget.motion) {
              1 => Offset(0, (1 - progress) * -4),
              2 => Offset(0, (1 - progress) * 4),
              3 => Offset((1 - progress) * 6, 0),
              _ => Offset(0, (1 - progress) * 6),
            };
            final entryAngle =
                (widget.motion.isEven ? 1 : -1) * (1 - progress) * 0.10;
            final hoverY = !reduceMotion && _hovered ? 0.045 : 0.0;
            final hoverX = !reduceMotion && _hovered ? -0.025 : 0.0;
            final scale = reduceMotion
                ? 1.0
                : _pressed
                    ? 0.975
                    : _hovered
                        ? 1.015
                        : 1.0;

            return Opacity(
              opacity: progress,
              child: Transform.translate(
                offset: offset,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0012)
                    ..rotateY(entryAngle),
                  child: AnimatedContainer(
                    duration: reduceMotion
                        ? Duration.zero
                        : const Duration(milliseconds: 160),
                    curve: Curves.easeOutCubic,
                    transformAlignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0012)
                      ..rotateY(hoverY)
                      ..rotateX(hoverX)
                      ..scale(scale),
                    child: child,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
