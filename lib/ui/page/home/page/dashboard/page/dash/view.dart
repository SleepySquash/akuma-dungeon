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

import '/ui/page/home/page/settings/view.dart';
import '/ui/widget/dummy_character.dart';
import '/ui/widget/modal_popup.dart';
import '/ui/worker/music.dart';
import 'controller.dart';
import 'destination/view.dart';

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
                  onPressed: () => SettingsView.show(context: context),
                  icon: const Icon(Icons.settings),
                ),
                IconButton(
                  onPressed: () {
                    MusicWorker worker = Get.find<MusicWorker>();
                    if (worker.isPlaying) {
                      worker.stop();
                    } else {
                      worker.resume();
                    }
                  },
                  icon: const Icon(Icons.volume_down),
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
                            onPressed: () async {
                              await ModalPopup.show(
                                context: context,
                                maxWidth: 600,
                                child: const DestinationView(),
                              );

                              // return router.dungeon(
                              //   DungeonSettings(
                              //     stages: [
                              //       DungeonStage(
                              //         name: 'Fields',
                              //         enemies: FieldsEnemies.enemies,
                              //         background: 'fields',
                              //         conditions: [
                              //           const SlayedStageCondition(10),
                              //         ],
                              //       ),
                              //       DungeonStage(
                              //         name: 'Forest',
                              //         enemies: FieldsEnemies.enemies,
                              //         background: 'forest',
                              //         conditions: [
                              //           const SlayedStageCondition(10),
                              //           TimerStageCondition(120.seconds),
                              //         ],
                              //       ),
                              //       DungeonStage(
                              //         name: 'Swamp - Boss Battle',
                              //         enemies: [RedLongSlimeEnemy()],
                              //         background: 'swamp',
                              //         conditions: [
                              //           const SlayedStageCondition(1),
                              //           TimerStageCondition(60.seconds),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                SizedBox(height: 8),
                                Text('Путешествия!'),
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
                            onPressed: c.addLevel,
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
