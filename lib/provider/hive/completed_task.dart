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
import '/domain/model/task.dart';
import 'base.dart';

/// [Hive] storage for the [MyTask]s.
class CompletedTaskHiveProvider extends HiveLazyProvider<CompletedTask> {
  @override
  String get boxName => 'completed_task';

  @override
  void registerAdapters() {
    Hive.maybeRegisterAdapter(DecimalAdapter());
    Hive.maybeRegisterAdapter(CompletedTaskAdapter());
  }

  /// Puts the provided [CompletedTask] to the [Hive].
  Future<void> put(CompletedTask task) => putSafe(task.id, task);

  /// Returns the stored [CompletedTask] from the [Hive].
  Future<CompletedTask?> get(String id) => getSafe(id);

  /// Indicates whether the provided [CompletedTask] is stored in the [Hive].
  bool contains(String id) => box.containsKey(id);

  /// Removes the stored [CompletedTask] from the [Hive].
  Future<void> remove(String id) => deleteSafe(id);
}

class CompletedTaskAdapter extends TypeAdapter<CompletedTask> {
  @override
  final typeId = ModelTypeId.completedTask;

  @override
  CompletedTask read(BinaryReader reader) {
    final String id = reader.read() as String;
    final int count = reader.read() as int;
    final DateTime completedAt = reader.read() as DateTime;
    final DateTime updatedAt = reader.read() as DateTime;
    return CompletedTask(
      id: id,
      count: count,
      completedAt: completedAt,
      updatedAt: updatedAt,
    );
  }

  @override
  void write(BinaryWriter writer, CompletedTask obj) {
    writer.write(obj.id);
    writer.write(obj.count);
    writer.write(obj.completedAt);
    writer.write(obj.updatedAt);
  }
}
