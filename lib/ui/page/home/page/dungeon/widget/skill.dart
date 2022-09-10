import 'dart:async';

import 'package:akuma/theme.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class SlidingSkill extends StatefulWidget {
  const SlidingSkill({
    Key? key,
    required this.asset,
    required this.text,
    this.onEnd,
  }) : super(key: key);

  final String asset;
  final String text;

  final void Function()? onEnd;

  @override
  State<SlidingSkill> createState() => _SlidingSkillState();
}

class _SlidingSkillState extends State<SlidingSkill>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Timer? _timer;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      ..addStatusListener((s) {
        switch (s) {
          case AnimationStatus.completed:
            if (mounted) {
              _timer = Timer(const Duration(seconds: 2), _controller.reverse);
            }
            break;

          case AnimationStatus.dismissed:
            if (mounted) {
              widget.onEnd?.call();
            }
            break;

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
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _controller.value,
          child: FractionalTranslation(
            translation: Offset(
                CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(0, 0.5, curve: Curves.ease),
                        ).value *
                        0.5 -
                    0.5,
                0),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(flex: 1, child: SizedBox(width: 1)),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: [
                CustomBoxShadow(
                  blurRadius: 8,
                  color: Colors.black.withOpacity(0.2),
                  blurStyle: BlurStyle.outer,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
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
          const Expanded(flex: 2, child: SizedBox(width: 1)),
        ],
      ),
    );
  }
}
