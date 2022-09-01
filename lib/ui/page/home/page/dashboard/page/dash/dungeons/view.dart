import 'package:akuma/domain/model/item/all.dart';
import 'package:akuma/domain/model/task.dart';
import 'package:audioplayers/audioplayers.dart' show AssetSource;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/router.dart';
import '/ui/widget/modal_popup.dart';
import 'controller.dart';

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
                onTap: () {
                  const List<NextStageCondition> conditions = [
                    SlayedStageCondition(10),
                    TimerStageCondition(Duration(seconds: 120)),
                  ];

                  const List<NextStageCondition> boss = [
                    SlayedStageCondition(1),
                    TimerStageCondition(Duration(seconds: 30)),
                  ];

                  router.dungeon(
                    Dungeon(
                      music:
                          AssetSource('music/mixkit-forest-treasure-138.mp3'),
                      background: 'library',
                      rewards: [
                        const MoneyReward(100),
                        const ExpReward(10),
                        ItemReward(Items.skills.sample(1).first),
                        ItemReward(Items.skills.sample(1).first),
                        ItemReward(Items.skills.sample(1).first),
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
                  );

                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
