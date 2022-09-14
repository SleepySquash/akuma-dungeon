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
import '/domain/model/commission.dart';
import '/domain/model/impossible.dart';
import '/domain/model/task.dart';
import '/domain/model/task/commission/all.dart';
import '/util/log.dart';
import 'base.dart';

/// [Hive] storage for the [MyCommission]s.
class CommissionHiveProvider extends HiveBaseProvider<MyCommission> {
  @override
  String get boxName => 'commission';

  /// Returns the list of [MyCommission]s from the [Hive].
  Iterable<MyCommission> get items => valuesSafe;

  @override
  void registerAdapters() {
    Hive.maybeRegisterAdapter(MyCommissionAdapter());
  }

  /// Puts the provided [MyCommission] to the [Hive].
  Future<void> put(MyCommission commission) =>
      putSafe(commission.id, commission);

  /// Returns the stored [MyCommission] from the [Hive].
  MyCommission? get(String id) => getSafe(id);

  /// Indicates whether the provided [MyCommission] is stored in the [Hive].
  bool contains(String id) => box.containsKey(id);

  /// Removes the stored [MyCommission] from the [Hive].
  Future<void> remove(String id) => deleteSafe(id);
}

class MyCommissionAdapter extends TypeAdapter<MyCommission> {
  @override
  final typeId = ModelTypeId.task;

  @override
  MyCommission read(BinaryReader reader) {
    final String id = reader.read() as String;
    final String taskId = reader.read() as String;
    final DateTime appearedAt = reader.read() as DateTime;
    final bool accepted = reader.read() as bool;
    final int progress = reader.read() as int;

    final Task? task = Commissions.get(taskId);
    if (task == null) {
      Log.print('[$runtimeType] Cannot find `Task` with id: $taskId');
      return MyCommission(task: const ImpossibleTask());
    }

    return MyCommission(
      task: task,
      appearedAt: appearedAt,
      accepted: accepted,
      progress: progress,
    );
  }

  @override
  void write(BinaryWriter writer, MyCommission obj) {
    writer.write(obj.task.id);
    writer.write(obj.appearedAt);
    writer.write(obj.accepted);
    writer.write(obj.progress);
  }
}
