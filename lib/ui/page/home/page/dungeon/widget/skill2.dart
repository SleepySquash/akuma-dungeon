import 'dart:math';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

import '/theme.dart';
import 'hit_indicator.dart';

class FloatingSkill extends StatefulWidget {
  const FloatingSkill({
    super.key,
    required this.asset,
    required this.text,
    this.position,
    this.direction = HitIndicatorFlowDirection.any,
    this.onEnd,
  });

  final String asset;
  final String text;

  final Offset? position;
  final HitIndicatorFlowDirection direction;

  final void Function()? onEnd;

  @override
  State<FloatingSkill> createState() => _FloatingSkillState();
}

class _FloatingSkillState extends State<FloatingSkill>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Offset _offset;

  @override
  void initState() {
    _offset = Offset(
      widget.direction.horizontal * 1,
      widget.direction.vertical * 3 + Random().nextDouble() * 0.5,
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
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
              translation: const Offset(-0.5, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    CustomBoxShadow(
                      blurRadius: 8,
                      color: Colors.black.withOpacity(0.2),
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    height: 60,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset('assets/${widget.asset}.png'),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BorderedText(
                            child: Text(
                              widget.text,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
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
