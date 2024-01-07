import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;

import '/ui/widget/locked.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    Key? key,
    this.locked = false,
    this.lockedReason = const [],
    this.onPressed,
    this.badge,
    this.child,
  }) : super(key: key);

  final bool locked;
  final List<Widget> lockedReason;

  final void Function()? onPressed;

  final Widget? badge;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Badge(
        badgeContent: DefaultTextStyle(
          style: const TextStyle(color: Colors.white, fontSize: 24),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: badge ?? Container(),
          ),
        ),
        shape: BadgeShape.circle,
        position: BadgePosition.topEnd(top: 0, end: 10),
        showBadge: badge != null,
        ignorePointer: true,
        toAnimate: false,
        child: LockedWidget(
          locked: locked,
          additional: lockedReason,
          borderRadius: BorderRadius.circular(12),
          child: RawMaterialButton(
            elevation: 6.0,
            focusElevation: 6.0,
            hoverElevation: 8.0,
            highlightElevation: 6.0,
            enableFeedback: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            fillColor: Theme.of(context).colorScheme.primaryContainer,
            splashColor: Theme.of(context)
                .colorScheme
                .onPrimaryContainer
                .withOpacity(0.12),
            focusColor: Theme.of(context)
                .colorScheme
                .onPrimaryContainer
                .withOpacity(0.12),
            hoverColor: Theme.of(context)
                .colorScheme
                .onPrimaryContainer
                .withOpacity(0.08),
            onPressed: onPressed,
            child: DefaultTextStyle(
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
