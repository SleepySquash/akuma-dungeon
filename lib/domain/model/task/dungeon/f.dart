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

import 'package:collection/collection.dart';
import 'package:flutter/material.dart' show IconData, Icons;
import 'package:novel/novel.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/item/standard.dart';
import '/domain/model/rank.dart';
import '/domain/model/task_queue.dart';
import '/domain/model/task.dart';

abstract class FDungeonTasks {
  static List<Task> get tasks => const [
        SlimeFieldsDungeonTask(),
        SlimeForestDungeonTask(),
        SlimeSwampDungeonTask(),
        RestaurantDungeonTask(),
      ];

  static List<TaskQueue> get queues => const [];
}

class SlimeFieldsDungeonTask extends Task with GuildTask {
  const SlimeFieldsDungeonTask();

  @override
  String get id => 'slime_fields_dungeon';

  @override
  String get name => 'Слаймы вокруг города';

  @override
  String? get description =>
      'Вокруг города поселились слаймы, разберись с ними';

  @override
  IconData get icon => Icons.landslide;

  @override
  Rank get rank => Rank.F;

  @override
  List<TaskStep> get steps => [
        DungeonStep(
          Dungeon(
            stages: [
              DungeonStage(
                background: 'fields',
                enemies: SlimeEnemies.enemies,
                conditions: const [SlayedStageCondition(1)],
              ),
              DungeonStage(
                background: 'forest',
                enemies: SlimeEnemies.enemies,
                conditions: const [SlayedStageCondition(2)],
              ),
            ],
          ),
        ),
      ];
}

class SlimeForestDungeonTask extends Task with GuildTask {
  const SlimeForestDungeonTask();

  @override
  String get id => 'slime_forest_dungeon';

  @override
  String get name => 'Провести торговца через лес';

  @override
  String? get description => 'В лесу бродят слаймы, нужно защитить торговца';

  @override
  IconData get icon => Icons.forest;

  @override
  Rank get rank => Rank.F;

  @override
  List<TaskStep> get steps => [
        DungeonStep(
          Dungeon(
            stages: [
              DungeonStage(
                background: 'forest',
                enemies: SlimeEnemies.enemies,
                conditions: const [SlayedStageCondition(1)],
              ),
              DungeonStage(
                background: 'forest',
                enemies: SlimeEnemies.enemies,
                conditions: const [SlayedStageCondition(2)],
              ),
            ],
          ),
        ),
      ];
}

class SlimeSwampDungeonTask extends Task with GuildTask {
  const SlimeSwampDungeonTask();

  @override
  String get id => 'slime_swamp_dungeon';

  @override
  String get name => 'Слаймы на болоте';

  @override
  String? get description => 'Победи слаймов на болоте';

  @override
  IconData get icon => Icons.forest;

  @override
  Rank get rank => Rank.F;

  @override
  List<TaskStep> get steps => [
        DungeonStep(
          Dungeon(
            stages: [
              DungeonStage(
                background: 'swamp',
                enemies: SlimeEnemies.enemies,
                conditions: const [SlayedStageCondition(1)],
              ),
              DungeonStage(
                background: 'swamp',
                enemies: SlimeEnemies.enemies,
                conditions: const [SlayedStageCondition(2)],
              ),
            ],
          ),
        ),
      ];
}

class RestaurantDungeonTask extends Task with GuildTask {
  const RestaurantDungeonTask();

  @override
  String get id => 'restaurant_dungeon';

  @override
  String get name => 'Помощь на кухне';

  @override
  String? get description => 'Ресторану нужна смешная нарезка продуктов';

  @override
  IconData get icon => Icons.restaurant;

  @override
  Rank get rank => Rank.F;

  @override
  List<TaskReward> get rewards => [
        ...super.rewards,
        ItemReward(StandardItems.consumable.sample(1).first),
      ];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          BackgroundLine('location/guild.jpg'),
          DialogueLine('Hello, I am Novel!!'),
          DialogueLine('Wowwwww!!'),
        ]),
        DungeonStep(
          Dungeon(
            stages: [
              DungeonStage(
                background: 'swamp',
                enemies: SlimeEnemies.enemies,
                conditions: const [SlayedStageCondition(1)],
              ),
              DungeonStage(
                background: 'swamp',
                enemies: SlimeEnemies.enemies,
                conditions: const [SlayedStageCondition(2)],
              ),
            ],
          ),
        ),
        NovelStep([
          BackgroundLine('dungeon/akuma.jpg'),
          DialogueLine('Wow, you DID it!!!!!'),
          DialogueLine('Wowwwww!!'),
        ]),
      ];
}
