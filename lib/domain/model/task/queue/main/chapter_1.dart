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

import '/domain/model/task_queue.dart';
import '/domain/model/task.dart';
import 'chapter_1/first_dungeon.dart';
import 'chapter_1/first_steps.dart';
import 'chapter_1/friendship_shines.dart';
import 'chapter_1/introduction.dart';
import 'chapter_1/second_steps.dart';
import 'chapter_1/unexpected_encounter.dart';

export 'chapter_1/first_dungeon.dart';
export 'chapter_1/first_steps.dart';
export 'chapter_1/friendship_shines.dart';
export 'chapter_1/introduction.dart';
export 'chapter_1/second_steps.dart';
export 'chapter_1/unexpected_encounter.dart';

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
  String get name => 'Основная история. Глава I';

  @override
  List<Task> get tasks => const [
        IntroductionTask(),
        FirstStepsTask(),
        SecondStepsTask(),
        FirstDungeonTask(),
        UnexpectedEncounterTask(),
        FriendshipShinesTask(),
      ];
}
