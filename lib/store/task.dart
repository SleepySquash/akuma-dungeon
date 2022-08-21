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

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/domain/model/progression.dart';
import '/domain/model/task.dart';
import '/domain/repository/task.dart';
import '/provider/hive/progression.dart';
import '/provider/hive/task.dart';
import '/util/obs/obs.dart';

class TaskRepository extends DisposableInterface
    implements AbstractTaskRepository {
  TaskRepository(this._taskHive, this._progressHive);

  @override
  late final RxObsMap<String, Rx<MyTask>> tasks;

  @override
  late final Rx<GameProgression> progression;

  final TaskHiveProvider _taskHive;
  final ProgressionHiveProvider _progressHive;

  StreamIterator<BoxEvent>? _localSubscription;
  StreamIterator<BoxEvent>? _progressSubscription;

  @override
  void onInit() {
    tasks = RxObsMap(
      Map.fromEntries(_taskHive.items.map((e) => MapEntry(e.task.id, Rx(e)))),
    );

    progression = Rx(_progressHive.get() ?? GameProgression());

    _initLocalSubscription();
    _initProgressSubscription();

    super.onInit();
  }

  @override
  void onClose() {
    _localSubscription?.cancel();
    _progressSubscription?.cancel();
    super.onClose();
  }

  @override
  void accept(Task task) => _taskHive.put(MyTask(task: task));

  @override
  void update(MyTask task) => _taskHive.put(task);

  @override
  void cancel(Task task) => _taskHive.remove(task.id);

  @override
  void progress(int to) {
    GameProgression progression = _progressHive.get() ?? GameProgression();
    progression.level = to;

    _progressHive.set(progression);
  }

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

  Future<void> _initProgressSubscription() async {
    _progressSubscription = StreamIterator(_progressHive.boxEvents);
    while (await _progressSubscription!.moveNext()) {
      BoxEvent e = _progressSubscription!.current;
      if (e.deleted) {
        // No-op.
      } else {
        progression.value = e.value;
        progression.refresh();
      }
    }
  }
}
