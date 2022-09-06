import 'dart:math';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

enum HitIndicatorFlowDirection {
  any,
  down,
  horizontal,
  left,
  none,
  right,
  up,
  vertical,
}

extension HitIndicatorFlowDirectionExtension on HitIndicatorFlowDirection {
  int get horizontal {
    switch (this) {
      case HitIndicatorFlowDirection.any:
      case HitIndicatorFlowDirection.horizontal:
        return Random().nextBool() ? 1 : -1;

      case HitIndicatorFlowDirection.right:
        return 1;

      case HitIndicatorFlowDirection.left:
        return -1;

      case HitIndicatorFlowDirection.down:
      case HitIndicatorFlowDirection.up:
      case HitIndicatorFlowDirection.vertical:
      case HitIndicatorFlowDirection.none:
        return 0;
    }
  }

  int get vertical {
    switch (this) {
      case HitIndicatorFlowDirection.any:
      case HitIndicatorFlowDirection.vertical:
        return Random().nextBool() ? 1 : -1;

      case HitIndicatorFlowDirection.down:
        return 1;

      case HitIndicatorFlowDirection.up:
        return -1;

      case HitIndicatorFlowDirection.right:
      case HitIndicatorFlowDirection.left:
      case HitIndicatorFlowDirection.horizontal:
      case HitIndicatorFlowDirection.none:
        return 0;
    }
  }
}

class NumberIndicator extends StatefulWidget {
  const NumberIndicator({
    Key? key,
    this.position,
    required this.number,
    this.color,
    this.fontSize,
    this.direction = HitIndicatorFlowDirection.any,
    this.offsetMultiplier = 1,
    this.onEnd,
  }) : super(key: key);

  final Offset? position;
  final int number;

  final Color? color;
  final double? fontSize;
  final double offsetMultiplier;

  final HitIndicatorFlowDirection direction;

  final void Function()? onEnd;

  @override
  State<NumberIndicator> createState() => _NumberIndicatorState();
}

class _NumberIndicatorState extends State<NumberIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Offset _offset;

  @override
  void initState() {
    _offset = Offset(
      widget.direction.horizontal *
          Random().nextDouble() *
          widget.offsetMultiplier,
      widget.direction.vertical *
          Random().nextDouble() *
          widget.offsetMultiplier,
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..addStatusListener((s) {
        switch (s) {
          case AnimationStatus.completed:
            if (mounted) {
              widget.onEnd?.call();
            }
            break;

          case AnimationStatus.dismissed:
          case AnimationStatus.forward:
          case AnimationStatus.reverse:
            // No-op.
            break;
        }
      })
      ..forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: widget.position?.dx ?? MediaQuery.of(context).size.width / 2,
          top: widget.position?.dy ?? MediaQuery.of(context).size.height / 2,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return SlideTransition(
                position:
                    Tween<Offset>(begin: Offset.zero, end: _offset).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(
                      0,
                      1,
                      curve: Curves.fastLinearToSlowEaseIn,
                    ),
                  ),
                ),
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.5, end: 1).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: const Interval(
                        0,
                        1,
                        curve: Curves.fastLinearToSlowEaseIn,
                      ),
                    ),
                  ),
                  child: Opacity(
                    opacity: Tween<double>(begin: 0, end: 1)
                        .animate(
                          CurvedAnimation(
                            parent: _controller,
                            curve: const Interval(0, 0.2, curve: Curves.ease),
                          ),
                        )
                        .value,
                    child: Opacity(
                      opacity: Tween<double>(begin: 1, end: 0)
                          .animate(
                            CurvedAnimation(
                              parent: _controller,
                              curve: const Interval(0.8, 1, curve: Curves.ease),
                            ),
                          )
                          .value,
                      child: child,
                    ),
                  ),
                ),
              );
            },
            child: FractionalTranslation(
              translation: const Offset(-0.5, -0.5),
              child: BorderedText(
                child: Text(
                  '${widget.number}',
                  style: TextStyle(
                    color: widget.color ?? Colors.red,
                    fontSize: widget.fontSize ?? 36,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
