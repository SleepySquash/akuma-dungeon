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

import 'package:flutter/cupertino.dart' show kCupertinoModalBarrierColor;
import 'package:flutter/material.dart';

import '/util/platform_utils.dart';

/// Stylized modal popup.
///
/// Intended to be displayed with the [show] method.
abstract class ModalPopup {
  /// Opens a new [ModalPopup] wrapping the provided [child].
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    EdgeInsets? mobilePadding = const EdgeInsets.fromLTRB(32, 0, 32, 0),
    double? maxWidth = 600,
    bool noPadding = false,
    bool isDismissible = true,
  }) {
    if (context.isMobile) {
      return showModalBottomSheet(
        context: context,
        barrierColor: kCupertinoModalBarrierColor,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        isDismissible: isDismissible,
        enableDrag: isDismissible,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (context) {
          if (noPadding) {
            return SafeArea(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    child,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        Center(
                          child: Container(
                            width: 60,
                            height: 3,
                            decoration: BoxDecoration(
                              color: const Color(0xFFCCCCCC),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    )
                  ],
                ),
              ),
            );
          }

          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                if (isDismissible) ...[
                  Center(
                    child: Container(
                      width: 60,
                      height: 3,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCCCCC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                Flexible(child: Padding(padding: mobilePadding!, child: child)),
                const SizedBox(height: 12),
              ],
            ),
          );
        },
      );
    } else {
      return showDialog(
        context: context,
        barrierColor: kCupertinoModalBarrierColor,
        barrierDismissible: isDismissible,
        builder: (context) {
          if (noPadding) {
            return Center(
              child: Container(
                constraints:
                    BoxConstraints(maxWidth: maxWidth ?? double.infinity),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      child,
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: InkResponse(
                          onTap: Navigator.of(context).pop,
                          radius: 11,
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Color(0xBB818181),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Center(
            child: Container(
              constraints:
                  BoxConstraints(maxWidth: maxWidth ?? double.infinity),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      if (isDismissible)
                        InkResponse(
                          onTap: Navigator.of(context).pop,
                          radius: 11,
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Color(0xBB818181),
                          ),
                        ),
                    ],
                  ),
                  Flexible(child: child),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
