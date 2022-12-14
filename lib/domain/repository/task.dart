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

import 'package:get/get.dart';

import '/domain/model/task_queue.dart';
import '/domain/model/task.dart';
import '/util/obs/obs.dart';

abstract class AbstractTaskRepository {
  RxObsMap<String, Rx<MyTask>> get tasks;
  RxObsMap<String, Rx<MyTaskQueue>> get queues;
  Iterable<String> get completedTasks;

  void start(TaskQueue task);
  void progress(MyTaskQueue task);
  void abandon(TaskQueue task);

  void accept(Task task);
  void update(MyTask task);
  void cancel(Task task);

  Future<void> complete(Task task);
  Future<void> uncomplete(String id);
  Future<CompletedTask?> getCompleted(String id);
  bool isCompleted(String id);
}
