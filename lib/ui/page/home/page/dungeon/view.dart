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
import 'package:get/get.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/enemy.dart';
import '/ui/page/home/page/dungeon/component/menu.dart';
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

  final void Function()? onClear;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DungeonController(
        Get.find(),
        settings: settings,
        onClear: onClear,
      ),
      builder: (DungeonController c) {
        return Stack(
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
                          'assets/background/dungeon/$background.jpg',
                          key: Key(background),
                          fit: BoxFit.cover,
                        )
                      : const SizedBox(),
                );
              }),
            ),

            // Game itself.
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                alignment: Alignment.center,
                children: [
                  _enemy(c),
                  Column(
                    children: [
                      _top(c, context),
                      Expanded(child: _middle(c, context)),
                      _bottom(c, context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _enemy(DungeonController c) {
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
                onPressed: c.hitEnemy,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Image.asset('assets/monster/${enemy.enemy.asset}.png'),
                ),
              )
            : Container(),
      );
    });
  }

  Widget _top(DungeonController c, BuildContext context) {
    Widget _stageTitle() {
      return Obx(() {
        String? stage = c.stage.value?.name;
        if (stage != null) {
          return Text(stage);
        }

        return Container();
      });
    }

    Widget _enemyHp() {
      return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Obx(() {
          MyEnemy? enemy = c.enemy.value;
          if (enemy != null) {
            return Column(
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
                        value: 1 - enemy.hp.value / enemy.enemy.hp,
                        backgroundColor: Colors.red,
                        color: Colors.grey,
                      ),
                    ),
                    Text('${enemy.hp.value}/${enemy.enemy.hp}'),
                  ],
                ),
              ],
            );
          }

          return Container();
        }),
      );
    }

    Widget _conditions() {
      return Obx(() {
        List<Widget> widgets = [];

        Widget _styled(Widget child) {
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
              _styled(
                  Text('${c.slayedEnemies.value}/${condition.amount} slayed')),
            );
          } else if (condition is TimerStageCondition) {
            int seconds =
                condition.duration.inSeconds + c.duration.value.inSeconds;
            widgets.add(
              _styled(Text('${seconds > 0 ? '$seconds' : 0} seconds')),
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
                  _stageTitle(),
                  _enemyHp(),
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
          child: _conditions(),
        ),
      ],
    );
  }

  Widget _middle(DungeonController c, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: const [Text('Skills...')],
        ),
        const Spacer(),
      ],
    );
  }

  Widget _bottom(DungeonController c, BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          WidgetButton(
            child: Container(
              margin: const EdgeInsets.only(left: 8, bottom: 0),
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth / 4,
                maxHeight: 200,
              ),
              width: 180,
              height: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: DummyCharacter(
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                        gender: c.player.value!.gender,
                        race: c.player.value!.race,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 100),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Obx(() {
                          int hp = c.hp.value.ceil();
                          int maxHp = c.player.value?.hp ?? 10;

                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  minHeight: 20,
                                  value: 1 - c.hp.value / maxHp,
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
