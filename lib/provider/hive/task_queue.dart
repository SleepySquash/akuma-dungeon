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

import 'package:hive_flutter/hive_flutter.dart';

import '/domain/model_type_id.dart';
import '/domain/model/impossible.dart';
import '/domain/model/task_queue.dart';
import '/domain/model/task.dart';
import '/domain/model/task/all.dart';
import '/util/log.dart';
import 'base.dart';
import 'task.dart';

/// [Hive] storage for the [MyTaskQueue]s.
class TaskQueueHiveProvider extends HiveBaseProvider<MyTaskQueue> {
  @override
  String get boxName => 'task_queue';

  /// Returns the list of [MyTaskQueue]s from the [Hive].
  Iterable<MyTaskQueue> get items => valuesSafe;

  @override
  void registerAdapters() {
    Hive.maybeRegisterAdapter(DecimalAdapter());
    Hive.maybeRegisterAdapter(MyTaskQueueAdapter());
    Hive.maybeRegisterAdapter(MyTaskAdapter());
  }

  /// Puts the provided [MyTaskQueue] to the [Hive].
  Future<void> put(MyTaskQueue queue) => putSafe(queue.queue.id, queue);

  /// Returns the stored [MyTaskQueue] from the [Hive].
  MyTaskQueue? get(String id) => getSafe(id);

  /// Indicates whether the provided [MyTaskQueue] is stored in the [Hive].
  bool contains(String id) => box.containsKey(id);

  /// Removes the stored [MyTaskQueue] from the [Hive].
  Future<void> remove(String id) => deleteSafe(id);
}

class MyTaskQueueAdapter extends TypeAdapter<MyTaskQueue> {
  @override
  final typeId = ModelTypeId.taskQueue;

  @override
  MyTaskQueue read(BinaryReader reader) {
    final id = reader.read() as String;
    final TaskQueue? queue = TasksQueues.get(id);
    if (queue == null) {
      Log.print('[$runtimeType] Cannot find `TaskQueue` with id: $id');
      return MyTaskQueue(queue: ImpossibleTaskQueue());
    }

    final progress = reader.read() as int;
    final activeId = reader.read() as String?;
    final activeProgress = reader.read() as int?;

    Task? active;
    if (activeId != null) {
      active = Tasks.get(activeId);
      if (active == null) {
        Log.print('[$runtimeType] Cannot find `Task` with id: $activeId');
      }
    }

    return MyTaskQueue(
      queue: queue,
      active: active == null
          ? null
          : MyTask(task: active, progress: activeProgress ?? 0),
      progress: progress,
    );
  }

  @override
  void write(BinaryWriter writer, MyTaskQueue obj) {
    writer.write(obj.queue.id);
    writer.write(obj.progress);
    writer.write(obj.active?.task.id);
    writer.write(obj.active?.progress);
  }
}
