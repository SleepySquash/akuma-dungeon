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

import 'dart:async';

import 'package:akuma/provider/hive/commission.dart';
import 'package:akuma/provider/hive/completed_task.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/domain/model/impossible.dart';
import '/domain/model/task_queue.dart';
import '/domain/model/task.dart';
import '/domain/repository/task.dart';
import '/provider/hive/task_queue.dart';
import '/provider/hive/task.dart';
import '/util/obs/obs.dart';

class TaskRepository extends DisposableInterface
    implements AbstractTaskRepository {
  TaskRepository(
    this._taskHive,
    this._queueHive,
    this._commissionHive,
    this._completedTaskHive,
  );

  @override
  late final RxObsMap<String, Rx<MyTask>> tasks;

  @override
  late final RxObsMap<String, Rx<MyTaskQueue>> queues;

  final TaskHiveProvider _taskHive;
  final TaskQueueHiveProvider _queueHive;
  final CommissionHiveProvider _commissionHive;
  final CompletedTaskHiveProvider _completedTaskHive;

  StreamIterator<BoxEvent>? _localSubscription;
  StreamIterator<BoxEvent>? _queueSubscription;

  @override
  void onInit() {
    for (MyTask task in _taskHive.items) {
      if (task.task is Impossible) {
        _taskHive.remove(task.task.id);
      }
    }

    for (MyTaskQueue queue in _queueHive.items) {
      if (queue.queue is Impossible) {
        _queueHive.remove(queue.queue.id);
      }
    }

    tasks = RxObsMap(
      Map.fromEntries(_taskHive.items.map((e) => MapEntry(e.task.id, Rx(e)))),
    );

    queues = RxObsMap(
      Map.fromEntries(_queueHive.items.map((e) => MapEntry(e.queue.id, Rx(e)))),
    );

    _initLocalSubscription();
    _initQueueSubscription();

    super.onInit();
  }

  @override
  void onClose() {
    _localSubscription?.cancel();
    _queueSubscription?.cancel();
    super.onClose();
  }

  @override
  void accept(Task task) => _taskHive.put(MyTask(task: task));

  @override
  void update(MyTask task) => _taskHive.put(task);

  @override
  void cancel(Task task) => _taskHive.remove(task.id);

  @override
  void start(TaskQueue queue) => _queueHive.put(MyTaskQueue(queue: queue));

  @override
  void progress(MyTaskQueue queue) => _queueHive.put(queue);

  @override
  void abandon(TaskQueue queue) => _queueHive.remove(queue.id);

  @override
  void complete(CompletedTask task) => _completedTaskHive.put(task);

  @override
  Future<CompletedTask?> getCompleted(String id) => _completedTaskHive.get(id);

  @override
  bool isCompleted(String id) => _completedTaskHive.contains(id);

  Future<void> _initLocalSubscription() async {
    _localSubscription = StreamIterator(_taskHive.boxEvents);
    while (await _localSubscription!.moveNext()) {
      BoxEvent e = _localSubscription!.current;
      if (e.deleted) {
        tasks.remove(e.key);
      } else {
        Rx<MyTask>? task = tasks[e.key];
        if (task == null) {
          tasks[e.key] = Rx(e.value);
        } else {
          task.value = e.value;
          task.refresh();
        }
      }
    }
  }

  Future<void> _initQueueSubscription() async {
    _queueSubscription = StreamIterator(_queueHive.boxEvents);
    while (await _queueSubscription!.moveNext()) {
      BoxEvent e = _queueSubscription!.current;
      if (e.deleted) {
        tasks.remove(e.key);
      } else {
        Rx<MyTaskQueue>? queue = queues[e.key];
        if (queue == null) {
          queues[e.key] = Rx(e.value);
        } else {
          queue.value = e.value;
          queue.refresh();
        }
      }
    }
  }
}

/// Maximum `Commission`s for location `Aloross` is 4:
/// [
///   1. CommissionA [no timeout]
///   2. CommissionB [timeout: 7 days]
///   3. DungeonA    [timeout: 1 days]
///   4. DungeonB    [timeout: 2 days]
/// ]
///
/// => accept `CommissionB` => `MyTask` with `CommissionB.task` is created.
///
/// [
///   1. CommissionA [no timeout]
///   2. DungeonA    [timeout: 1 days]
///   3. DungeonB    [timeout: 2 days]
/// ]
///
/// Q: When a new `Commission` is placed?
/// A: After `CommissionB` is completed (or failed) plus optional timeout.
/// The same applies to `Dungeon`s.
/// 
/// Thus `MyCommission` should store its progress and accepted [DateTime].
/// 
/// So:
/// [
///   1. CommissionA [no timeout]
///   2. CommissionB [ACCEPTED, at: 2022-09-10, progress: 1]
///   3. DungeonA    [timeout: 1 days]
///   4. DungeonB    [ACCEPTED, at: 2022-09-10, progress: 2]
/// ]
/// 
/// Dungeon is a special `Commission`, whose `Task` is generated at CTOR.
/// 
/// Every `Location` has its own `Commission`s list.