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

import 'package:novel/novel.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/task_queue.dart';
import '/domain/model/task.dart';

abstract class ChapterOneTasks {
  static List<Task> get tasks => [
        ...const ChapterOne().tasks,
      ];

  static List<TaskQueue> get queues => const [
        ChapterOne(),
      ];
}

class ChapterOne extends TaskQueue {
  const ChapterOne();

  @override
  String get id => 'chapter_one';

  @override
  String get name => 'Story - Chapter I';

  @override
  List<Task> get tasks => const [
        IntroductionTask(),
        NeighborVillageTask(),
        // NextMissionTask(),
      ];
}

class IntroductionTask extends Task {
  const IntroductionTask();

  @override
  String get id => 'chapter1_introduction';

  @override
  List<TaskStep> get steps => [
        NovelStep([
          BackgroundLine('location/guild.jpg'),
          DialogueLine('Hello, testing!!'),
          DialogueLine('Yay!'),
        ]),
        DungeonStep(
          Dungeon(
            background: 'fields',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.all,
                conditions: const [SlayedStageCondition(1)],
              ),
              DungeonStage(
                background: 'forest',
                enemies: SlimeEnemies.all,
                conditions: const [SlayedStageCondition(2)],
              ),
            ],
          ),
        ),
        NovelStep([
          BackgroundLine('location/guild.jpg'),
          DialogueLine('Wow, you did it!!'),
          DialogueLine('Yay! Yay! Yay!'),
        ]),
      ];
}

class NeighborVillageTask extends Task {
  const NeighborVillageTask();

  @override
  String get id => 'chapter1_neighbor_village';

  @override
  List<TaskCriteria> get criteria => [const LevelCriteria(10)];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          BackgroundLine('location/forest_house.jpg'),
          DialogueLine('Hello, testing!!'),
          DialogueLine('Yay!'),
        ]),
        DungeonStep(
          Dungeon(
            background: 'fields',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.all,
                conditions: const [SlayedStageCondition(1)],
              ),
              DungeonStage(
                background: 'forest',
                enemies: SlimeEnemies.all,
                conditions: const [SlayedStageCondition(2)],
              ),
            ],
          ),
        ),
        NovelStep([
          BackgroundLine('location/forest_house.jpg'),
          DialogueLine('Wow, you did it!!'),
          DialogueLine('Yay! Yay! Yay!'),
        ]),
      ];
}

class NextMissionTask extends Task {
  const NextMissionTask();

  @override
  String get id => 'chapter1_next_mission';

  @override
  List<TaskCriteria> get criteria => [const LevelCriteria(12)];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          BackgroundLine('location/forest_house.jpg'),
          DialogueLine('Ебать, ты дожил до этого момента!!'),
          DialogueLine('Я покажу тебе свою ПИСЬКУ!'),
          DialogueLine('ТЫ ГОТОВ, СПАНЧ БОБ?????'),
          DialogueLine('ЖОПА ТЕБЕ БУДЕТ...'),
        ]),
        DungeonStep(
          Dungeon(
            stages: [
              DungeonStage(
                background: 'fields',
                enemies: SlimeEnemies.unique,
                conditions: const [SlayedStageCondition(1)],
                multiplier: 1478024712421,
              ),
            ],
          ),
        ),
      ];
}
