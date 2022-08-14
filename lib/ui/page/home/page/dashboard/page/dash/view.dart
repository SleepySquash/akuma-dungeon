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

import 'package:akuma/domain/model/enemy/fields.dart';
import 'package:akuma/ui/page/home/page/dungeon/controller.dart';
import 'package:akuma/ui/widget/dummy_character.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/router.dart';
import 'controller.dart';

class DashView extends StatelessWidget {
  const DashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashController(Get.find(), Get.find()),
      builder: (DashController c) {
        return Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: router.settings,
                  icon: const Icon(Icons.settings),
                ),
                const Spacer(),
                IconButton(
                  onPressed: c.logout,
                  icon: const Icon(Icons.logout),
                )
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Obx(() {
                      return DummyCharacter(
                        race: c.player.value!.race,
                        gender: c.player.value!.gender,
                      );
                    }),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () => router.dungeon(
                              DungeonSettings(
                                stages: [
                                  DungeonStage(
                                    name: 'Fields',
                                    enemies: FieldsEnemies.enemies,
                                    background: 'fields',
                                    conditions: [
                                      const SlayedStageCondition(10),
                                    ],
                                  ),
                                  DungeonStage(
                                    name: 'Forest',
                                    enemies: FieldsEnemies.enemies,
                                    background: 'forest',
                                    conditions: [
                                      const SlayedStageCondition(10),
                                      TimerStageCondition(120.seconds),
                                    ],
                                  ),
                                  DungeonStage(
                                    name: 'Swarm - Boss Battle',
                                    enemies: [RedLongSlimeEnemy()],
                                    background: 'swarm',
                                    conditions: [
                                      const SlayedStageCondition(1),
                                      TimerStageCondition(60.seconds),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                SizedBox(height: 8),
                                Text('Enter the dungeon'),
                                Text('(F - 01 - fields)'),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Battle pass'),
                          ),
                          const SizedBox(height: 4),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Mail'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
