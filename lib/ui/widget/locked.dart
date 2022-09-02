import 'package:flutter/material.dart';

class LockedWidget extends StatelessWidget {
  const LockedWidget({
    Key? key,
    this.locked = true,
    this.borderRadius,
    this.additional = const [],
    required this.child,
  }) : super(key: key);

  final bool locked;

  final BorderRadius? borderRadius;

  final List<Widget> additional;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (locked)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(30),
                color: Colors.black.withOpacity(0.6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.lock, color: Colors.white),
                  if (additional.isNotEmpty) const SizedBox(width: 10),
                  ...additional,
                ],
              ),
            ),
          )
      ],
    );
  }
}
