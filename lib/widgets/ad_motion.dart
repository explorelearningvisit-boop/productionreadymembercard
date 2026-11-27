import 'dart:async';

import 'package:flutter/material.dart';

/// Rotates a compact sponsor/offer caption without continuously animating
/// the whole dashboard. The timer is cancelled when the widget is disposed.
class RotatingAdMessage extends StatefulWidget {
  const RotatingAdMessage({
    required this.messages,
    required this.style,
    this.interval = const Duration(seconds: 7),
    this.alignment = Alignment.centerLeft,
    this.textAlign = TextAlign.left,
    super.key,
  });

  final List<String> messages;
  final TextStyle style;
  final Duration interval;
  final Alignment alignment;
  final TextAlign textAlign;

  @override
  State<RotatingAdMessage> createState() => _RotatingAdMessageState();
}

class _RotatingAdMessageState extends State<RotatingAdMessage> {
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    if (widget.messages.length > 1) {
      _timer = Timer.periodic(widget.interval, (_) {
        if (!mounted) return;
        setState(() => _index = (_index + 1) % widget.messages.length);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final message = widget.messages[_index];
    return ClipRect(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 420),
        reverseDuration: const Duration(milliseconds: 260),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          final offset = Tween<Offset>(
            begin: const Offset(0, 0.24),
            end: Offset.zero,
          ).animate(animation);
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(position: offset, child: child),
          );
        },
        child: Align(
          key: ValueKey(_index),
          alignment: widget.alignment,
          child: Text(
            message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: widget.textAlign,
            style: widget.style,
          ),
        ),
      ),
    );
  }
}

/// A short, one-shot entrance gives each advertiser/product image a clear
/// reveal without a forever-loop that would waste battery or hinder testing.
class ArtworkEntrance extends StatelessWidget {
  const ArtworkEntrance({
    required this.child,
    this.motion = 0,
    super.key,
  });

  final Widget child;

  /// 0 = rise/scale, 1 = settle/scale, 2 = slight tilt, 3 = fade/slide.
  final int motion;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 560 + (motion * 90)),
      curve: motion == 2 ? Curves.easeOutBack : Curves.easeOutCubic,
      child: child,
      builder: (context, value, child) {
        final eased = value.clamp(0.0, 1.0).toDouble();
        final offset = switch (motion) {
          1 => Offset(0, (1 - eased) * -5),
          2 => Offset(0, (1 - eased) * 7),
          3 => Offset((1 - eased) * 8, 0),
          _ => Offset(0, (1 - eased) * 9),
        };
        final scale = motion == 1 ? 0.94 + (0.06 * eased) : 0.88 + (0.12 * eased);
        return Opacity(
          opacity: eased,
          child: Transform.translate(
            offset: offset,
            child: Transform.rotate(
              angle: motion == 2 ? (1 - eased) * -0.045 : 0,
              child: Transform.scale(scale: scale, child: child),
            ),
          ),
        );
      },
    );
  }
}


/// Rotates sponsor artwork independently from the member's data visualizations.
/// Assets are bundled locally so ad changes never depend on network availability.
class RotatingAdArtwork extends StatefulWidget {
  const RotatingAdArtwork({
    required this.assets,
    required this.width,
    required this.height,
    this.interval = const Duration(seconds: 6),
    this.fit = BoxFit.contain,
    super.key,
  });

  final List<String> assets;
  final double width;
  final double height;
  final Duration interval;
  final BoxFit fit;

  @override
  State<RotatingAdArtwork> createState() => _RotatingAdArtworkState();
}

class _RotatingAdArtworkState extends State<RotatingAdArtwork> {
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _startRotation();
  }

  @override
  void didUpdateWidget(covariant RotatingAdArtwork oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assets != widget.assets ||
        oldWidget.interval != widget.interval) {
      _timer?.cancel();
      _index = 0;
      _startRotation();
    }
  }

  void _startRotation() {
    if (widget.assets.length > 1) {
      _timer = Timer.periodic(widget.interval, (_) {
        if (!mounted) return;
        setState(() => _index = (_index + 1) % widget.assets.length);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.assets.isEmpty) return SizedBox(width: widget.width, height: widget.height);
    final asset = widget.assets[_index];
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 520),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.88, end: 1).animate(animation),
            child: child,
          ),
        ),
        child: Image.asset(
          asset,
          key: ValueKey(asset),
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
