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

import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/enemy.dart';
import '/ui/page/home/page/dungeon/component/menu.dart';
import '/ui/widget/animated_scaley.dart';
import '/ui/widget/button.dart';
import '/ui/widget/dummy_character.dart';
import '/ui/widget/modal_popup.dart';
import 'controller.dart';

class DungeonView extends StatelessWidget {
  const DungeonView({
    Key? key,
    required this.settings,
    this.onClear,
  }) : super(key: key);

  final DungeonSettings settings;

  final FutureOr<void> Function()? onClear;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DungeonController(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        settings: settings,
        onClear: onClear,
      ),
      tag: settings.hashCode.toString(),
      builder: (DungeonController c) {
        return Focus(
          onKeyEvent: (_, event) {
            if (event is KeyDownEvent) {
              c.hitEnemy();
            }
            return KeyEventResult.handled;
          },
          autofocus: true,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background.
              Positioned.fill(
                child: Obx(() {
                  String? background =
                      c.stage.value?.background ?? c.settings.background;

                  return AnimatedSwitcher(
                    duration: 300.milliseconds,
                    layoutBuilder: (child, previous) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [...previous, if (child != null) child]
                            .map((e) => Positioned.fill(child: e))
                            .toList(),
                      );
                    },
                    child: background != null
                        ? Image.asset(
                            'assets/background/location/$background.jpg',
                            key: Key(background),
                            fit: BoxFit.cover,
                          )
                        : const ColoredBox(color: Colors.blueGrey),
                  );
                }),
              ),

              // Game itself.
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  alignment: Alignment.center,
                  children: [
                    _enemy(c, context),
                    Column(
                      children: [
                        _top(c, context),
                        Expanded(child: _middle(c, context)),
                        _bottom(c, context),
                      ],
                    ),
                    IgnorePointer(
                      child: Obx(() {
                        return Stack(
                          children: c.effects.entries.map((e) {
                            return KeyedSubtree(
                              key: Key(e.key),
                              child: e.value,
                            );
                          }).toList(),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _enemy(DungeonController c, BuildContext context) {
    return Obx(() {
      MyEnemy? enemy = c.enemy.value;
      return AnimatedSwitcher(
        duration: 600.milliseconds,
        switchInCurve: Curves.easeOutQuad,
        switchOutCurve: Curves.easeInQuad,
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: enemy != null
            ? PreciseButton(
                key: Key(enemy.key),
                onPressed: (p) => c.hitEnemy(at: p),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Obx(() {
                    return AnimatedScaleY(
                      duration: c.enemySlideDuration.value,
                      scaleY: c.enemyScaleY.value,
                      curve: Curves.ease,
                      child: AnimatedSlide(
                        duration: c.enemySlideDuration.value,
                        offset: c.enemySlideOffset.value,
                        curve: Curves.ease,
                        key: enemy.globalKey,
                        child: Image.asset(
                          'assets/monster/${enemy.enemy.asset}${enemy.enemy.ext}',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    );
                  }),
                ),
              )
            : Container(),
      );
    });
  }

  Widget _top(DungeonController c, BuildContext context) {
    Widget stageTitle() {
      return Obx(() {
        String? stage = c.stage.value?.name;
        if (stage != null) {
          return Text(stage);
        }

        return Container();
      });
    }

    Widget enemyHp() {
      return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Obx(() {
          MyEnemy? enemy = c.enemy.value;

          return AnimatedSwitcher(
            duration: 300.milliseconds,
            switchInCurve: Curves.easeOutQuad,
            switchOutCurve: Curves.easeInQuad,
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: enemy != null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(enemy.enemy.name),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              minHeight: 20,
                              value:
                                  1 - (enemy.hp.value / enemy.maxHp).toDouble(),
                              backgroundColor: Colors.red,
                              color: Colors.grey,
                            ),
                          ),
                          Text('${enemy.hp.value}/${enemy.maxHp}'),
                        ],
                      ),
                    ],
                  )
                : Container(),
          );
        }),
      );
    }

    Widget conditions() {
      return Obx(() {
        List<Widget> widgets = [];

        Widget styled(Widget child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(2),
            child: child,
          );
        }

        for (var condition in c.stage.value?.conditions ?? []) {
          if (condition is SlayedStageCondition) {
            widgets.add(
              styled(
                Text('${c.slayedEnemies.value}/${condition.amount} slayed'),
              ),
            );
          } else if (condition is TimerStageCondition) {
            int seconds =
                condition.duration.inSeconds + c.duration.value.inSeconds;
            widgets.add(
              styled(Text('${seconds > 0 ? '$seconds' : 0} seconds')),
            );
          }
        }

        if (widgets.isNotEmpty) {
          return Column(mainAxisSize: MainAxisSize.min, children: widgets);
        }

        return Container();
      });
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  stageTitle(),
                  enemyHp(),
                ],
              ),
            ),
            WidgetButton(
              onPressed: () => ModalPopup.show(
                context: context,
                child: DungeonMenu(c),
              ),
              child: const Icon(Icons.menu),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: conditions(),
        ),
      ],
    );
  }

  Widget _middle(DungeonController c, BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Skills...')],
        ),
        Spacer(),
      ],
    );
  }

  Widget _bottom(DungeonController c, BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 8, bottom: 0),
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth / 5,
              maxHeight: 200,
            ),
            width: 180,
            height: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: FractionalTranslation(
                    translation: const Offset(0, 0.3),
                    child: DummyCharacter(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                      gender: c.player.player.value.gender,
                      race: c.player.player.value.race,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() {
                            return AnimatedSwitcher(
                              duration: 300.milliseconds,
                              switchInCurve: Curves.easeOutQuad,
                              switchOutCurve: Curves.easeInQuad,
                              transitionBuilder: (child, animation) =>
                                  ScaleTransition(
                                      scale: animation, child: child),
                              child: c.sp.value > Decimal.zero
                                  ? Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Stack(
                                        children: [
                                          Icon(
                                            Icons.shield,
                                            size: 48,
                                            color:
                                                Colors.white.withOpacity(0.9),
                                          ),
                                          Positioned.fill(
                                            child: Center(
                                              child:
                                                  Text('${c.sp.value.ceil()}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            );
                          }),
                          Obx(() {
                            Decimal hp = c.hp.value;
                            Decimal maxHp = c.player.health;

                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    minHeight: 20,
                                    value: 1 - (c.hp.value / maxHp).toDouble(),
                                    backgroundColor: Colors.green,
                                    color: Colors.grey,
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(child: Text('$hp/$maxHp')),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _party(c)),
        ],
      );
    });
  }

  Widget _party(DungeonController c) {
    if (c.party.isNotEmpty != true) {
      return Container();
    }

    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: c.party.map((e) {
            return Flexible(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 200),
                child: FractionalTranslation(
                  translation: const Offset(0, 0.4),
                  child: Obx(() {
                    return Image.asset(
                      'assets/character/${e.character.character.value.character.asset}.png',
                      key: e.key,
                      opacity:
                          e.isAlive ? null : const AlwaysStoppedAnimation(0.7),
                    );
                  }),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
