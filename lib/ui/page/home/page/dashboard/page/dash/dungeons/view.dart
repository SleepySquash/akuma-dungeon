import 'package:audioplayers/audioplayers.dart' show AssetSource;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/item/standard.dart';
import '/domain/model/task.dart';
import '/ui/widget/modal_popup.dart';
import 'controller.dart';
import 'dungeon_preview/view.dart';

class DungeonsView extends StatelessWidget {
  const DungeonsView({Key? key}) : super(key: key);

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(context: context, child: const DungeonsView());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DungeonsController(),
      builder: (DungeonsController c) {
        return Material(
          type: MaterialType.transparency,
          child: ListView(
            shrinkWrap: true,
            children: [
              // const ListTile(title: Text('Артефакты')),
              // ListTile(
              //   leading: const Icon(Icons.church),
              //   title: const Text('Монастырь ушедшей цивилизации'),
              //   subtitle: const Text('Очень холодное и мрачное место...'),
              //   trailing: const Icon(Icons.ac_unit),
              //   onTap: () {},
              // ),
              // ListTile(
              //   leading: const Icon(Icons.auto_awesome),
              //   title: const Text('Секта лунатиков'),
              //   subtitle: const Text(
              //     'Невероятное количество магии привлекает нежить',
              //   ),
              //   trailing: const Icon(Icons.whatshot),
              //   onTap: () {},
              // ),
              // const Divider(),
              const ListTile(title: Text('Ресурсы')),

              ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text('Старая библиотека'),
                subtitle: const Text(
                  'Кто знает, сколько потерянных знаний здесь хранится?',
                ),
                trailing: const Icon(Icons.book),
                onTap: () async {
                  const List<NextStageCondition> conditions = [
                    SlayedStageCondition(10),
                    TimerStageCondition(Duration(seconds: 120)),
                  ];

                  const List<NextStageCondition> boss = [
                    SlayedStageCondition(1),
                    TimerStageCondition(Duration(seconds: 30)),
                  ];

                  bool? result = await DungeonPreviewView.show(
                    context,
                    name: 'Древняя Библиотека',
                    description:
                        'Под руинами некогда величавого города остаются погребёнными тысячи книг, древней литературы неизвестного языка.',
                    background: 'dungeon/library',
                    difficulties: [
                      DungeonDifficulty(
                        level: 10,
                        music:
                            AssetSource('music/mixkit-forest-treasure-138.mp3'),
                        background: 'library',
                        rewards: [
                          RandomItemReward(const SwordBookMinor(), 0, 3),
                          const MoneyReward(100),
                          const ExpReward(10),
                          const RankReward(1),
                        ],
                        stages: [
                          DungeonStage(
                            name: 'Библиотека',
                            enemies: SlimeEnemies.e,
                            conditions: conditions,
                            multiplier: 10,
                          ),
                          DungeonStage(
                            name: 'Библиотека',
                            enemies: SlimeEnemies.e,
                            conditions: conditions,
                            multiplier: 10,
                          ),
                          DungeonStage(
                            name: 'Библиотека',
                            enemies: SlimeEnemies.e,
                            conditions: conditions,
                            multiplier: 10,
                          ),
                          DungeonStage(
                            name: 'Библиотека - Босс Битва',
                            enemies: SlimeEnemies.ePlus,
                            conditions: boss,
                            multiplier: 10,
                          ),
                        ],
                      ),
                      DungeonDifficulty(
                        level: 30,
                        music:
                            AssetSource('music/mixkit-forest-treasure-138.mp3'),
                        background: 'library',
                        rewards: [
                          RandomItemReward(const SwordBookMinor(), 1, 3),
                          RandomItemReward(const SwordBookMajor(), 0, 2),
                          const MoneyReward(500),
                          const ExpReward(20),
                          const RankReward(1),
                        ],
                        stages: [
                          DungeonStage(
                            name: 'Библиотека',
                            enemies: SlimeEnemies.e,
                            conditions: conditions,
                            multiplier: 30,
                          ),
                          DungeonStage(
                            name: 'Библиотека',
                            enemies: SlimeEnemies.e,
                            conditions: conditions,
                            multiplier: 30,
                          ),
                          DungeonStage(
                            name: 'Библиотека',
                            enemies: SlimeEnemies.e,
                            conditions: conditions,
                            multiplier: 30,
                          ),
                          DungeonStage(
                            name: 'Библиотека - Босс Битва',
                            enemies: SlimeEnemies.ePlus,
                            conditions: boss,
                            multiplier: 30,
                          ),
                        ],
                      ),
                      DungeonDifficulty(
                        level: 60,
                        music:
                            AssetSource('music/mixkit-forest-treasure-138.mp3'),
                        background: 'library',
                        rewards: [
                          RandomItemReward(const SwordBookMinor(), 1, 3),
                          RandomItemReward(const SwordBookMajor(), 1, 3),
                          RandomItemReward(const SwordBookSuperior(), 0, 2),
                          const MoneyReward(1500),
                          const ExpReward(50),
                          const RankReward(2),
                        ],
                        stages: [
                          DungeonStage(
                            name: 'Библиотека',
                            enemies: SlimeEnemies.e,
                            conditions: conditions,
                            multiplier: 60,
                          ),
                          DungeonStage(
                            name: 'Библиотека',
                            enemies: SlimeEnemies.e,
                            conditions: conditions,
                            multiplier: 60,
                          ),
                          DungeonStage(
                            name: 'Библиотека',
                            enemies: SlimeEnemies.e,
                            conditions: conditions,
                            multiplier: 60,
                          ),
                          DungeonStage(
                            name: 'Библиотека - Босс Битва',
                            enemies: SlimeEnemies.ePlus,
                            conditions: boss,
                            multiplier: 60,
                          ),
                        ],
                      ),
                    ],
                  );

                  if (result == true) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
