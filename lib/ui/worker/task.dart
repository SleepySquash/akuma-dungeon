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

import 'package:akuma/domain/model/task.dart';
import 'package:get/get.dart';

import '/domain/service/notification.dart';
import '/domain/service/task.dart';
import '/util/obs/obs.dart';

class TaskWorker extends DisposableInterface {
  TaskWorker(this._taskService, this._notificationService);

  final TaskService _taskService;

  final NotificationService _notificationService;

  late final StreamSubscription _subscription;
  final Map<String, Worker> _workers = {};

  @override
  void onInit() {
    for (var e in _taskService.tasks.values) {
      _addWorker(e);
    }

    _subscription = _taskService.tasks.changes.listen((e) {
      switch (e.op) {
        case OperationKind.added:
          _addWorker(e.value!);
          _notificationService.notify(
            LocalNotification(
              title: 'New task!',
              subtitle: e.value!.value.task.name,
              icon: e.value!.value.task.icon,
            ),
          );
          break;

        case OperationKind.removed:
          _workers.remove(e.key)?.dispose();
          if (e.value?.value.isCompleted == true) {
            _notificationService.notify(
              LocalNotification(
                title: 'Task completed!',
                subtitle: e.value!.value.task.name,
                icon: e.value!.value.task.icon,
              ),
            );
          }
          break;

        case OperationKind.updated:
          // No-op.
          break;
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    for (var e in _workers.values) {
      e.dispose();
    }

    _subscription.cancel();
    super.onClose();
  }

  void _addWorker(Rx<MyTask> task) {
    bool completed = false;
    _workers[task.value.task.id] = ever(
      task,
      (MyTask task) {
        if (!completed && task.isCompleted) {
          completed = task.isCompleted;
          _notificationService.notify(
            LocalNotification(
              title: 'Task can be completed!',
              subtitle: task.task.name,
              icon: task.task.icon,
            ),
          );
        }
      },
    );
  }
}
