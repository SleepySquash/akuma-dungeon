import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  const WideButton({
    Key? key,
    this.mini = false,
    this.fillColor,
    this.onPressed,
    required this.child,
  }) : super(key: key);

  factory WideButton.small({
    Key? key,
    void Function()? onPressed,
    required Widget child,
  }) =>
      WideButton(
        mini: true,
        onPressed: onPressed,
        child: child,
      );

  final Color? fillColor;

  final void Function()? onPressed;

  final bool mini;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6.0,
      focusElevation: 6.0,
      hoverElevation: 8.0,
      highlightElevation: 6.0,
      enableFeedback: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      fillColor: fillColor ?? Theme.of(context).colorScheme.primaryContainer,
      splashColor:
          Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.12),
      focusColor:
          Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.12),
      hoverColor:
          Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.08),
      onPressed: onPressed,
      child: DefaultTextStyle(
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          fontSize: mini ? 17 : 24,
        ),
        child: Container(
          height: mini ? 40 : 56,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: child,
        ),
      ),
    );
  }
}
