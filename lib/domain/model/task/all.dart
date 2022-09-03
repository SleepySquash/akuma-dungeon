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

import '/domain/model/task_queue.dart';
import '/domain/model/task.dart';
import 'dungeon/all.dart';
import 'main/all.dart';

abstract class Tasks {
  static List<Task> get all => [
        ...DungeonTasks.tasks,
        ...MainTasks.tasks,
      ];

  static Task? get(String id) => all.firstWhereOrNull((e) => e.id == id);
}

abstract class TasksQueues {
  static List<TaskQueue> get all => [
        ...DungeonTasks.queues,
        ...MainTasks.queues,
      ];

  static TaskQueue get(String id) => all.firstWhere((e) => e.id == id);
}