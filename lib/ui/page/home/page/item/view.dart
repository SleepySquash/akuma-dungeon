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

import 'package:akuma/domain/model/item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/character.dart';
import '/ui/widget/backdrop.dart';
import 'controller.dart';

class ItemView extends StatefulWidget {
  const ItemView({Key? key, required this.item}) : super(key: key);

  final MyItem item;

  /// Displays a dialog with the provided [character] above the current
  /// contents.
  static void show<T extends Object?>({
    required BuildContext context,
    required MyItem item,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (BuildContext context, _, __) {
          return ItemView(item: item);
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
      init: ItemController(),
      builder: (ItemController c) {
        return Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (c.screen.value == null) {
                  _dismiss();
                } else {
                  c.screen.value = null;
                }
              },
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
                  child: Hero(
                    tag: widget.item.id,
                    child: Image.asset(
                      'assets/item/${widget.item.item.asset}.png',
                    ),
                  ),
                );
              },
            ),
            ..._buildInterface(c),
          ],
        );
      },
    );
  }

  List<Widget> _buildInterface(ItemController c) {
    Widget screen(ItemViewScreen? current) {
      return Container();
      // switch (current) {
      //   case NekoViewScreen.request:
      //     return RequestScreen(c);

      //   case NekoViewScreen.action:
      //     return ActionScreen(c);

      //   case NekoViewScreen.activity:
      //     return ActivityScreen(c);

      //   case NekoViewScreen.talk:
      //     return TalkScreen(c);

      //   default:
      //     return NekoScreen(c);
      // }
    }

    return [
      AnimatedBuilder(
        animation: _fading,
        builder: (_, child) => Opacity(opacity: _fading.value, child: child!),
        child: Obx(
          () => AnimatedSwitcher(
            duration: 200.milliseconds,
            child: screen(c.screen.value),
          ),
        ),
      ),
      AnimatedBuilder(
        animation: _fading,
        builder: (_, child) => Opacity(opacity: _fading.value, child: child!),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16, right: 16),
            child: Obx(
              () => FloatingActionButton(
                mini: false,
                onPressed: c.screen.value == null
                    ? _dismiss
                    : () {
                        switch (c.screen.value) {
                          // case CharacterViewScreen.action:
                          // case CharacterViewScreen.activity:
                          // case CharacterViewScreen.request:
                          //   c.screen.value = null;
                          //   break;

                          default:
                            c.screen.value = null;
                            break;
                        }
                      },
                child: c.screen.value == null
                    ? const Icon(Icons.close_rounded)
                    : const Icon(Icons.arrow_back),
              ),
            ),
          ),
        ),
      ),
    ];
  }

  /// Starts a dismiss animation.
  void _dismiss() => _fading.reverse();
}
