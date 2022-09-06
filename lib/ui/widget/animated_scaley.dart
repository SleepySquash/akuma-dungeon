import 'package:flutter/material.dart';

class AnimatedScaleY extends ImplicitlyAnimatedWidget {
  const AnimatedScaleY({
    Key? key,
    required this.scaleY,
    Duration duration = const Duration(milliseconds: 250),
    Curve curve = Curves.linear,
    void Function()? onEnd,
    required this.child,
  }) : super(key: key, curve: curve, duration: duration, onEnd: onEnd);

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
