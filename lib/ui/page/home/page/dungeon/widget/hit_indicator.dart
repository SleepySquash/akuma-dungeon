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

class HitIndicator extends StatefulWidget {
  const HitIndicator({
    Key? key,
    required this.position,
    required this.damage,
    this.isCrit = false,
    this.direction = HitIndicatorFlowDirection.any,
    this.onEnd,
  }) : super(key: key);

  final Offset position;
  final int damage;
  final bool isCrit;
  final HitIndicatorFlowDirection direction;

  final void Function()? onEnd;

  @override
  State<HitIndicator> createState() => _HitIndicatorState();
}

class _HitIndicatorState extends State<HitIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Offset _offset;

  @override
  void initState() {
    _offset = Offset(
      widget.direction.horizontal * Random().nextDouble() * 2,
      widget.direction.vertical * Random().nextDouble() * 2,
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
          left: widget.position.dx,
          top: widget.position.dy,
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
                  '${widget.damage}',
                  style: TextStyle(
                    color: widget.isCrit ? Colors.yellow : Colors.red,
                    fontSize: widget.isCrit ? 48 : 36,
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
