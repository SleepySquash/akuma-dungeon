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

import 'package:akuma/ui/page/home/widget/material_button.dart';
import 'package:akuma/ui/widget/item_selector/view.dart';
import 'package:akuma/util/platform_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/item.dart';
import '/ui/page/home/widget/screen_switcher.dart';
import '/ui/widget/backdrop.dart';
import 'component/attributes.dart';
import 'component/enhance.dart';
import 'component/upgrade.dart';
import 'controller.dart';

class ItemView extends StatefulWidget {
  const ItemView({
    Key? key,
    required this.item,
    this.exchangeItemSettings,
  }) : super(key: key);

  final ExchangeItemSettings? exchangeItemSettings;
  final MyItem item;

  /// Displays a dialog with the provided [character] above the current
  /// contents.
  static Future<T?> show<T extends Object?>({
    required BuildContext context,
    required MyItem item,
    ExchangeItemSettings? exchangeItemSettings,
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (BuildContext context, _, __) {
          return ItemView(
            item: item,
            exchangeItemSettings: exchangeItemSettings,
          );
        },
      ),
    );
  }

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView>
    with SingleTickerProviderStateMixin {
  /// [AnimationController] controlling the opening and closing animation.
  late final AnimationController _fading;

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
              Navigator.of(context).pop();
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
    var fade = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _fading,
      curve: const Interval(0, 0.3, curve: Curves.ease),
    ));

    return GetBuilder(
      init: ItemController(
        widget.item,
        exchangeItemSettings: widget.exchangeItemSettings,
      ),
      builder: (ItemController c) {
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
              builder: (context, child) {
                return FadeTransition(
                  opacity: fade,
                  child: Obx(() {
                    return Hero(
                      tag: c.item.value.id,
                      child: Image.asset(
                        'assets/item/${c.item.value.item.asset}.png',
                      ),
                    );
                  }),
                );
              },
            ),
            AnimatedBuilder(
              animation: _fading,
              builder: (_, child) =>
                  Opacity(opacity: _fading.value, child: child!),
              child: AnimatedSwitcher(
                duration: 200.milliseconds,
                child: _screen(c),
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
                  child: Flex(
                    direction:
                        context.isMobile ? Axis.vertical : Axis.horizontal,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (c.exchangeItemSettings != null) ...[
                        if (context.isMobile)
                          FloatingActionButton(
                            heroTag: 0,
                            onPressed: () async {
                              dynamic selected = await ItemSelector.show(
                                context: context,
                                empty: const NoopItem(0),
                                category: c.exchangeItemSettings?.category,
                                filter: c.exchangeItemSettings?.filter,
                              );

                              if (selected is Rx<MyItem>) {
                                c.exchangeItemSettings?.onExchange
                                    ?.call(selected.value);
                                c.item.value = selected.value;
                              } else if (selected is NoopItem) {
                                c.exchangeItemSettings?.onExchange?.call(null);
                                _dismiss();
                              }
                            },
                            child: const Icon(Icons.change_circle),
                          )
                        else
                          WideButton(
                            onPressed: () async {
                              dynamic selected = await ItemSelector.show(
                                context: context,
                                empty: const NoopItem(0),
                                category: c.exchangeItemSettings?.category,
                                filter: c.exchangeItemSettings?.filter,
                              );

                              if (selected is Rx<MyItem>) {
                                c.exchangeItemSettings?.onExchange
                                    ?.call(selected.value);
                                c.item.value = selected.value;
                              } else if (selected is NoopItem) {
                                c.exchangeItemSettings?.onExchange?.call(null);
                                _dismiss();
                              }
                            },
                            child: const Text('Switch'),
                          ),
                        const SizedBox(width: 10, height: 10),
                      ],
                      FloatingActionButton(
                        heroTag: 1,
                        mini: false,
                        onPressed: _dismiss,
                        child: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _screen(ItemController c) {
    return ScreenSwitcher(
      tabs: [
        Screen(
          desktop: const Text('Attributes'),
          mobile: const Icon(Icons.person),
          child: ItemAttributesTab(c),
        ),
        if (c.item.value is MyWeapon || c.item.value is MyEquipable) ...[
          Screen(
            desktop: const Text('Enhance'),
            mobile: const Icon(Icons.plus_one),
            child: ItemEnhanceTab(c),
          ),
          Screen(
            desktop: const Text('Upgrade'),
            mobile: const Icon(Icons.upgrade),
            child: ItemUpgradeTab(c),
          ),
        ],
      ],
    );
  }

  /// Starts a dismiss animation.
  void _dismiss() => _fading.reverse();
}
