import 'dart:async';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class AnimatedTitle extends StatefulWidget {
  const AnimatedTitle({
    super.key,
    required this.title,
    this.color,
    this.fontSize,
    this.onEnd,
  });

  final String title;

  final Color? color;
  final double? fontSize;

  final void Function()? onEnd;

  @override
  State<AnimatedTitle> createState() => _AnimatedTitleState();
}

class _AnimatedTitleState extends State<AnimatedTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Timer? _timer;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
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
          child: Transform.scale(
            scale: 1 + _controller.value * 0.5,
            child: child,
          ),
        );
      },
      child: Center(
        child: BorderedText(
          child: Text(
            widget.title,
            style: TextStyle(
              color: widget.color ?? Colors.white,
              fontSize: widget.fontSize ?? 36,
            ),
          ),
        ),
      ),
    );
  }
}
