import 'package:flutter/material.dart';

import '../aloross.dart';
import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/location/all.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';
import '/domain/model/task/queue/main/chapter_1.dart';

class AlorossSlimeSwampCommission extends AlorossCommission {
  const AlorossSlimeSwampCommission();

  @override
  String get name => 'Слаймы на болоте';

  @override
  String? get subtitle => 'Победи слаймов на болоте';

  @override
  IconData get icon => Icons.forest;

  @override
  List<TaskCriteria> get criteria => const [
        CompletedCriteria(task: FirstDungeonTask()),
        OrCriteria([
          NotCompletedCriteria(),
          CompletedCriteria(sinceLast: Duration(seconds: 10)),
        ]),
      ];

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const ControlReward(AlorossLocation(), 1),
      ];

  @override
  List<TaskStep> get steps => [
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-games-worldbeat-466.mp3',
            background: 'swamp',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(1)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(2)],
              ),
            ],
          ),
        ),
      ];
}
