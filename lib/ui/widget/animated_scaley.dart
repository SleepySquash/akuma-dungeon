import 'package:flutter/material.dart';

class AnimatedScaleY extends ImplicitlyAnimatedWidget {
  const AnimatedScaleY({
    super.key,
    required this.scaleY,
    super.duration = const Duration(milliseconds: 250),
    super.curve,
    super.onEnd,
    required this.child,
  });

  final double scaleY;
  final Widget child;

  @override
  ImplicitlyAnimatedWidgetState<AnimatedScaleY> createState() =>
      _AnimatedScaleYState();
}

class _AnimatedScaleYState
    extends ImplicitlyAnimatedWidgetState<AnimatedScaleY> {
  late Animation<double> _animation;

  Tween<double>? _scaleY;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _scaleY = visitor(
      _scaleY,
      widget.scaleY,
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;
  }

  @override
  void didUpdateTweens() {
    _animation = animation.drive(_scaleY!);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scaleY: _animation.value,
          child: child!,
        );
      },
      child: widget.child,
    );
  }
}
