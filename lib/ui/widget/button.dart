// Copyright © 2022 NIKITA ISAENKO, <https://github.com/SleepySquash>
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU Affero General Public License v3.0 as published by the
// Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License v3.0 for
// more details.
//
// You should have received a copy of the GNU Affero General Public License v3.0
// along with this program. If not, see
// <https://www.gnu.org/licenses/agpl-3.0.html>.

import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  final Widget child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: onPressed == null ? MouseCursor.defer : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          color: Colors.transparent,
          child: child,
        ),
      ),
    );
  }
}

class PreciseButton extends StatefulWidget {
  const PreciseButton({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  final Widget child;
  final void Function(Offset)? onPressed;

  @override
  State<PreciseButton> createState() => _PreciseButtonState();
}

class _PreciseButtonState extends State<PreciseButton> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      cursor: SystemMouseCursors.click,
      child: Listener(
        onPointerDown: (d) {
          widget.onPressed?.call(d.position);
          // ++_fingers;

          // if (_fingers == 1) {
          //   widget.onPressed?.call();
          // }
        },
        // onPointerUp: (d) {
        //   --_fingers;
        //   if (_fingers < 0) {
        //     _fingers = 0;
        //   }
        // },
        child: Container(
          color: Colors.transparent,
          child: widget.child,
        ),
      ),
    );
  }
}
