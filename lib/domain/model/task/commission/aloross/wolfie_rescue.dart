import 'package:flutter/material.dart';

import '../aloross.dart';
import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/location/all.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';
import '/domain/model/task/queue/main/chapter_1.dart';

class AlorossWolfieRescueCommission extends AlorossCommission {
  const AlorossWolfieRescueCommission();

  @override
  String get name => 'Просьба о помощи';

  @override
  String? get subtitle =>
      'Отряд путешественников не выходит на связь больше суток';

  @override
  IconData get icon => Icons.help;

  @override
  List<TaskCriteria> get criteria => const [
        CompletedCriteria(task: FirstDungeonTask()),
        NotCompletedCriteria(),
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
