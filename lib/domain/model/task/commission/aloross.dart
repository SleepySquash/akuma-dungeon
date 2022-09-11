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

import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '/domain/model/commission.dart';
import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/item/all.dart';
import '/domain/model/location/all.dart';
import '/domain/model/rank.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';

abstract class AlorossCommissions {
  static List<QuestCommission> get tasks => const [
        AlorossSlimeFieldsCommission(),
        AlorossSlimeForestCommission(),
        AlorossSlimeSwampCommission(),
        AlorossRestaurantCommission(),
      ];
}

abstract class AlorossCommission extends Task with QuestCommission {
  const AlorossCommission();

  @override
  String? get location => 'aloross';

  @override
  Duration? get timeout => const Duration(minutes: 30);

  @override
  Rank get rank => Rank.F;

  @override
  List<Reward> get rewards => const [
        MoneyReward(50),
        ExpReward(100),
        ItemReward(Ruby(2)),
        RankReward(1),
        ReputationReward(AlorossLocation(), 1),
      ];
}

class AlorossSlimeFieldsCommission extends AlorossCommission {
  const AlorossSlimeFieldsCommission();

  @override
  String get name => 'Слаймы вокруг города';

  @override
  String? get description =>
      'Вокруг города поселились слаймы, разберись с ними';

  @override
  IconData get icon => Icons.landslide;

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

class AlorossSlimeForestCommission extends AlorossCommission {
  const AlorossSlimeForestCommission();

  @override
  String get name => 'Провести торговца через лес';

  @override
  String? get description => 'В лесу бродят слаймы, нужно защитить торговца';

  @override
  IconData get icon => Icons.forest;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const ControlReward(AlorossLocation(), 1),
      ];

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

class AlorossSlimeSwampCommission extends AlorossCommission {
  const AlorossSlimeSwampCommission();

  @override
  String get name => 'Слаймы на болоте';

  @override
  String? get description => 'Победи слаймов на болоте';

  @override
  IconData get icon => Icons.forest;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const ControlReward(AlorossLocation(), 1),
      ];

  @override
  List<TaskStep> get steps => [
        DungeonStep(
          Dungeon(
            music: AssetSource('music/mixkit-games-worldbeat-466.mp3'),
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

class AlorossRestaurantCommission extends AlorossCommission {
  const AlorossRestaurantCommission();

  @override
  String get name => 'Помощь на кухне';

  @override
  String? get description => 'Ресторану нужна смешная нарезка продуктов';

  @override
  IconData get icon => Icons.restaurant;

  @override
  List<Reward> get rewards => [
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
            music: AssetSource('music/mixkit-games-worldbeat-466.mp3'),
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
