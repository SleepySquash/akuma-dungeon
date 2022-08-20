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

import 'package:akuma/domain/model/enemy/fields.dart';
import 'package:novel/novel.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/task.dart';
import '/router.dart';

abstract class FirstMainTasks {
  static List<Task> get all => [
        IntroductionTask(),
      ];
}

class IntroductionTask extends Task {
  @override
  String get id => 'introduction';

  @override
  List<TaskStep> get steps => [
        NovelStep([
          BackgroundLine('guild.jpg'),
          DialogueLine('Hello, testing!!'),
          DialogueLine('Yay!'),
        ]),
        DungeonStep(
          Dungeon(
            stages: [
              DungeonStage(
                background: 'fields',
                enemies: FieldsEnemies.all,
                conditions: const [SlayedStageCondition(1)],
              ),
              DungeonStage(
                background: 'forest',
                enemies: FieldsEnemies.all,
                conditions: const [SlayedStageCondition(2)],
              ),
            ],
          ),
        ),
        NovelStep([
          BackgroundLine('guild.jpg'),
          DialogueLine('Wow, you did it!!'),
          DialogueLine('Yay! Yay! Yay!'),
        ]),
      ];
}
