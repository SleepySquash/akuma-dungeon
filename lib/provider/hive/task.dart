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
import '/domain/model/task.dart';
import '/domain/model/task/all.dart';
import '/util/log.dart';
import 'base.dart';

/// [Hive] storage for the [MyTask]s.
class TaskHiveProvider extends HiveBaseProvider<MyTask> {
  @override
  Stream<BoxEvent> get boxEvents => box.watch();

  @override
  String get boxName => 'task';

  /// Returns the list of [MyTask]s from the [Hive].
  Iterable<MyTask> get items => valuesSafe;

  @override
  void registerAdapters() {
    Hive.maybeRegisterAdapter(MyTaskAdapter());
  }

  /// Puts the provided [MyTask] to the [Hive].
  Future<void> put(MyTask task) => putSafe(task.task.id, task);

  /// Returns the stored [MyTask] from the [Hive].
  MyTask? get(String id) => getSafe(id);

  /// Indicates whether the provided [MyTask] is stored in the [Hive].
  bool contains(String id) => box.containsKey(id);

  /// Removes the stored [MyTask] from the [Hive].
  Future<void> remove(String id) => deleteSafe(id);
}

class MyTaskAdapter extends TypeAdapter<MyTask> {
  @override
  final typeId = ModelTypeId.task;

  @override
  MyTask read(BinaryReader reader) {
    final String id = reader.read() as String;
    final int progress = reader.read() as int;
    final DateTime acceptedAt = reader.read() as DateTime;

    final Task? task = Tasks.get(id);
    if (task == null) {
      Log.print('[$runtimeType] Cannot find `Task` with id: $id');
      return MyTask(task: const ImpossibleTask());
    }

    return MyTask(task: task, progress: progress, acceptedAt: acceptedAt);
  }

  @override
  void write(BinaryWriter writer, MyTask obj) {
    writer.write(obj.task.id);
    writer.write(obj.progress);
    writer.write(obj.acceptedAt);
  }
}
