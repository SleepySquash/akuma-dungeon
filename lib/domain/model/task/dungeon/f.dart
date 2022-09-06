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
import '/domain/model/item/all.dart';
import '/domain/model/rank.dart';
import '/domain/model/task_queue.dart';
import '/domain/model/task.dart';

abstract class FDungeonTasks {
  static List<Task> get tasks => const [
        SlimeFieldsDungeonTask(),
        SlimeForestDungeonTask(),
        SlimeSwampDungeonTask(),
        RestaurantDungeonTask(),
        SaveCaravanTask(),
      ];

  static List<TaskQueue> get queues => const [];
}

abstract class FDungeonTask extends Task with GuildTask {
  const FDungeonTask();

  @override
  List<TaskReward> get rewards => const [
        MoneyReward(100),
        RankReward(4),
        ControlReward(1),
        ReputationReward(1),
        ItemReward(Ruby(2)),
      ];
}

class SlimeFieldsDungeonTask extends FDungeonTask {
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
            background: 'fields',
            stages: [
              DungeonStage(
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

class SlimeForestDungeonTask extends FDungeonTask {
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
            background: 'forest',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.enemies,
                conditions: const [SlayedStageCondition(1)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.enemies,
                conditions: const [SlayedStageCondition(2)],
              ),
            ],
          ),
        ),
      ];
}

class SlimeSwampDungeonTask extends FDungeonTask {
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
            background: 'swamp',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.enemies,
                conditions: const [SlayedStageCondition(1)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.enemies,
                conditions: const [SlayedStageCondition(2)],
              ),
            ],
          ),
        ),
      ];
}

class RestaurantDungeonTask extends FDungeonTask {
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
        ItemReward(Items.consumable.sample(1).first),
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
            background: 'swamp',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.enemies,
                conditions: const [SlayedStageCondition(1)],
              ),
              DungeonStage(
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

class SaveCaravanTask extends FDungeonTask {
  const SaveCaravanTask();

  @override
  String get id => 'save_caravan_task1';

  @override
  String get name => 'Спасти караван';

  @override
  String? get description => 'Спаси караван из Лахтабурга';

  @override
  IconData get icon => Icons.restaurant;

  @override
  Rank get rank => Rank.F;

  @override
  List<TaskReward> get rewards => [
        ...super.rewards,
        ItemReward(Items.consumable.sample(1).first),
      ];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          BackgroundLine('location/guild.jpg'),
          CharacterLine('HyunWoo.png'),
          DialogueLine(
            'Привет, нам нужна твоя помощь!',
            by: 'Хозяин каравана',
            voice: 'tasks/savecaravan1/1.m4a',
          ),
          DialogueLine(
            'Караван из Лахтабурга был отправлен к нам ещё джва года назад',
            by: 'Хозяин каравана',
            voice: 'tasks/savecaravan1/2.m4a',
          ),
          DialogueLine(
            'Но чёртовы эльф... то есть слаймы решили его ограбить!',
            by: 'Хозяин каравана',
            voice: 'tasks/savecaravan1/3.m4a',
          ),
          DialogueLine(
            'Пожалуйста, помоги спасти его!',
            by: 'Хозяин каравана',
            voice: 'tasks/savecaravan1/4.m4a',
          ),
        ]),
        DungeonStep(
          Dungeon(
            stages: [
              DungeonStage(
                background: 'forest',
                enemies: SlimeEnemies.e,
                conditions: const [SlayedStageCondition(10)],
              ),
            ],
          ),
        ),
        NovelStep([
          BackgroundLine('dungeon/forest.jpg'),
          CharacterLine('HyunWoo.png'),
          DialogueLine(
            'Смотри, их становится больше!',
            by: 'Хозяин каравана',
            voice: 'tasks/savecaravan1/5.m4a',
          ),
          DialogueLine(
            'Давай расправимся с ними здесь и сейчас!',
            by: 'Хозяин каравана',
            voice: 'tasks/savecaravan1/6.m4a',
          ),
        ]),
        DungeonStep(
          Dungeon(
            stages: [
              DungeonStage(
                background: 'forest',
                enemies: SlimeEnemies.ePlus,
                conditions: const [SlayedStageCondition(20)],
              ),
            ],
          ),
        ),
        NovelStep([
          BackgroundLine('dungeon/forest.jpg'),
          CharacterLine('HyunWoo.png'),
          DialogueLine(
            'Уф, славная была битва!',
            by: 'Хозяин каравана',
            voice: 'tasks/savecaravan1/7.m4a',
          ),
          DialogueLine(
            'Спасибо что спас нас, гильдия выдаст тебе награду!',
            by: 'Хозяин каравана',
            voice: 'tasks/savecaravan1/8.m4a',
          ),
        ]),
      ];
}
