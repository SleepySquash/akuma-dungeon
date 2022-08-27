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

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/item.dart';
import '/ui/widget/backdrop.dart';
import '/ui/widget/item_grid.dart';
import 'controller.dart';

class ItemSelector extends StatefulWidget {
  const ItemSelector({
    Key? key,
    this.category,
    this.filter,
    this.empty,
  }) : super(key: key);

  final InventoryCategory? category;
  final Iterable<Rx<MyItem>> Function(Iterable<Rx<MyItem>> items)? filter;
  final dynamic empty;

  /// Displays a dialog with the provided [category] above the current
  /// contents.
  static Future<T?> show<T extends Object?>({
    required BuildContext context,
    InventoryCategory? category,
    dynamic empty,
    Iterable<Rx<MyItem>> Function(Iterable<Rx<MyItem>> items)? filter,
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (BuildContext context, _, __) {
          return ItemSelector(
            category: category,
            empty: empty,
            filter: filter,
          );
        },
      ),
    );
  }

  @override
  State<ItemSelector> createState() => _ItemSelectorState();
}

class _ItemSelectorState extends State<ItemSelector>
    with SingleTickerProviderStateMixin {
  /// [AnimationController] controlling the opening and closing animation.
  late final AnimationController _fading;

  /// [MyItem] to return in the [Navigator.pop] of this [ItemSelector].
  dynamic result;

  @override
  void initState() {
    _fading = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )
      ..addStatusListener(
        (status) {
          switch (status) {
            case AnimationStatus.reverse:
              Navigator.of(context).pop(result);
              break;

            case AnimationStatus.dismissed:
            case AnimationStatus.forward:
            case AnimationStatus.completed:
              // No-op.
              break;
          }
        },
      )
      ..forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ItemSelectorController(Get.find()),
      builder: (ItemSelectorController c) {
        return Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _dismiss,
              child: AnimatedBuilder(
                animation: _fading,
                builder: (context, child) => ConditionalBackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 0.01 + 15 * _fading.value,
                    sigmaY: 0.01 + 15 * _fading.value,
                  ),
                  child: Container(),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _fading,
              builder: (_, child) =>
                  Opacity(opacity: _fading.value, child: child!),
              child: AnimatedSwitcher(
                duration: 200.milliseconds,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ItemGrid(
                    category: widget.category,
                    items: c.items.values,
                    filter: widget.filter,
                    first: widget.empty,
                    onPressed: (e) {
                      result = e;
                      _dismiss();
                    },
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _fading,
              builder: (_, child) =>
                  Opacity(opacity: _fading.value, child: child!),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16, right: 16),
                  child: FloatingActionButton(
                    mini: false,
                    onPressed: _dismiss,
                    child: const Icon(Icons.close_rounded),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Starts a dismiss animation.
  void _dismiss() => _fading.reverse();
}
