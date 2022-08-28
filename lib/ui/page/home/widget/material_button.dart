import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  const WideButton({
    Key? key,
    this.onPressed,
    required this.child,
  }) : super(key: key);

  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6.0,
      focusElevation: 6.0,
      hoverElevation: 8.0,
      highlightElevation: 6.0,
      enableFeedback: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        ),
      ),
      fillColor: Theme.of(context).colorScheme.primaryContainer,
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
          fontSize: 24,
        ),
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(child: child),
        ),
      ),
    );
  }
}
