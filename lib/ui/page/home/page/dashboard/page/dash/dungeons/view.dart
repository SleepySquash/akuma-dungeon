import 'package:audioplayers/audioplayers.dart' show AssetSource;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/item/all.dart';
import '/domain/model/reward.dart';
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
              const ListTile(title: Text('Артефакты')),
              ListTile(
                leading: const Icon(Icons.church),
                title: const Text('Монастырь ушедшей цивилизации'),
                subtitle: const Text('Очень холодное и мрачное место...'),
                trailing: const Icon(Icons.ac_unit),
                onTap: () async {
                  List<DungeonStage> stages(double multiplier) {
                    const List<NextStageCondition> conditions = [
                      SlayedStageCondition(10),
                      TimerStageCondition(Duration(seconds: 120)),
                    ];

                    const List<NextStageCondition> boss = [
                      SlayedStageCondition(1),
                      TimerStageCondition(Duration(seconds: 30)),
                    ];

                    return [
                      DungeonStage(
                        name: 'Алтарь',
                        enemies: SlimeEnemies.e,
                        conditions: conditions,
                        multiplier: multiplier,
                      ),
                      DungeonStage(
                        name: 'Алтарь - Босс Битва',
                        enemies: SlimeEnemies.ePlus,
                        conditions: boss,
                        multiplier: multiplier,
                      ),
                    ];
                  }

                  bool? result = await DungeonPreviewView.show(
                    context,
                    name: 'Монастырь ушедшей цивилизации',
                    description: 'Очень холодное и мрачное место...',
                    background: 'location/magic_forest_altar',
                    difficulties: [
                      DungeonDifficulty(
                        level: 10,
                        music:
                            AssetSource('music/mixkit-forest-treasure-138.mp3'),
                        background: 'magic_forest_altar',
                        rewards: [
                          ChanceItemReward(const InitiateFeather(), 0.4),
                          ChanceItemReward(const InitiateFlower(), 0.4),
                          ChanceItemReward(const AdventurerWatch(), 0.4),
                          const MoneyReward(100),
                          const ExpReward(10),
                          const RankReward(1),
                        ],
                        stages: stages(10),
                      ),
                    ],
                  );

                  if (result == true) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  }
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.auto_awesome),
              //   title: const Text('Секта лунатиков'),
              //   subtitle: const Text(
              //     'Невероятное количество магии привлекает нежить',
              //   ),
              //   trailing: const Icon(Icons.whatshot),
              //   onTap: () {},
              // ),
              const Divider(),
              const ListTile(title: Text('Ресурсы')),
              ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text('Старая библиотека'),
                subtitle: const Text(
                  'Кто знает, сколько потерянных знаний здесь хранится?',
                ),
                trailing: const Icon(Icons.book),
                onTap: () async {
                  List<DungeonStage> stages(double multiplier) {
                    const List<NextStageCondition> conditions = [
                      SlayedStageCondition(10),
                      TimerStageCondition(Duration(seconds: 120)),
                    ];

                    const List<NextStageCondition> boss = [
                      SlayedStageCondition(1),
                      TimerStageCondition(Duration(seconds: 30)),
                    ];

                    return [
                      DungeonStage(
                        name: 'Библиотека',
                        enemies: SlimeEnemies.e,
                        conditions: conditions,
                        multiplier: multiplier,
                      ),
                      DungeonStage(
                        name: 'Библиотека',
                        enemies: SlimeEnemies.e,
                        conditions: conditions,
                        multiplier: multiplier,
                      ),
                      DungeonStage(
                        name: 'Библиотека',
                        enemies: SlimeEnemies.e,
                        conditions: conditions,
                        multiplier: multiplier,
                      ),
                      DungeonStage(
                        name: 'Библиотека - Босс Битва',
                        enemies: SlimeEnemies.ePlus,
                        conditions: boss,
                        multiplier: multiplier,
                      ),
                    ];
                  }

                  bool? result = await DungeonPreviewView.show(
                    context,
                    name: 'Древняя Библиотека',
                    description:
                        'Под руинами некогда величавого города остаются погребёнными тысячи книг, древней литературы неизвестного языка.',
                    background: 'location/library',
                    difficulties: [
                      DungeonDifficulty(
                        level: 10,
                        music:
                            AssetSource('music/mixkit-forest-treasure-138.mp3'),
                        background: 'library',
                        rewards: [
                          MinMaxItemReward(const SwordBookMinor(), 0, 3),
                          const MoneyReward(100),
                          const ExpReward(10),
                          const RankReward(1),
                        ],
                        stages: stages(10),
                      ),
                      DungeonDifficulty(
                        level: 30,
                        music:
                            AssetSource('music/mixkit-forest-treasure-138.mp3'),
                        background: 'library',
                        rewards: [
                          MinMaxItemReward(const SwordBookMinor(), 1, 3),
                          MinMaxItemReward(const SwordBookMajor(), 0, 2),
                          const MoneyReward(500),
                          const ExpReward(20),
                          const RankReward(1),
                        ],
                        stages: stages(60),
                      ),
                      DungeonDifficulty(
                        level: 60,
                        music:
                            AssetSource('music/mixkit-forest-treasure-138.mp3'),
                        background: 'library',
                        rewards: [
                          MinMaxItemReward(const SwordBookMinor(), 1, 3),
                          MinMaxItemReward(const SwordBookMajor(), 1, 3),
                          MinMaxItemReward(const SwordBookSuperior(), 0, 2),
                          const MoneyReward(1500),
                          const ExpReward(50),
                          const RankReward(2),
                        ],
                        stages: stages(240),
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
