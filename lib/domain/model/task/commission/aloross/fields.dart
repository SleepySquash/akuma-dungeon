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

import '../aloross.dart';
import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/location/all.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';
import '/domain/model/task/queue/main/chapter_1.dart';

class AlorossSlimeFieldsCommission extends AlorossCommission {
  const AlorossSlimeFieldsCommission();

  @override
  String get name => 'Слаймы вокруг города';

  @override
  String? get subtitle => 'Вокруг города поселились слаймы, разберись с ними';

  @override
  IconData get icon => Icons.landslide;

  @override
  List<TaskCriteria> get criteria => const [
        NotCompletedCriteria(),
        CompletedCriteria(task: FirstDungeonTask()),
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
            background: 'fields',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(1)],
              ),
              DungeonStage(
                background: 'forest',
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(2)],
              ),
            ],
          ),
        ),
      ];
}

class AlorossSlimeFields2Commission extends AlorossCommission {
  const AlorossSlimeFields2Commission();

  @override
  String get name => 'Слаймы снова вокруг города';

  @override
  String? get subtitle => 'Вокруг города поселились слаймы, разберись с ними';

  @override
  IconData get icon => Icons.landslide;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const ControlReward(AlorossLocation(), 1),
      ];

  @override
  List<TaskCriteria> get criteria => [
        ...super.criteria,
        const CompletedCriteria(task: AlorossSlimeFieldsCommission()),
      ];

  @override
  List<TaskStep> get steps => [
        DungeonStep(
          Dungeon(
            background: 'fields',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(1)],
              ),
              DungeonStage(
                background: 'forest',
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(2)],
              ),
            ],
          ),
        ),
      ];
}
