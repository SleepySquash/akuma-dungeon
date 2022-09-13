import 'package:collection/collection.dart';

import 'task.dart';

abstract class TaskQueue {
  const TaskQueue();

  String get id;
  String get name => id;

  List<Task> get tasks;

  bool get finished => false;
}

class MyTaskQueue {
  MyTaskQueue({
    required this.queue,
    this.active,
    this.progress = 0,
  }) {
    if (active == null) {
      if (progress < queue.tasks.length) {
        next = queue.tasks[progress];
      }
    } else {
      if (active?.isCompleted == true) {
        complete();
      }

      if (progress < queue.tasks.length - 1) {
        next = queue.tasks[progress + 1];
      }
    }
  }

  final TaskQueue queue;

  MyTask? active;

  int progress;

  Task? next;

  bool get isCompleted => progress >= queue.tasks.length;

  MyTask? execute() {
    if (!complete()) {
      active = MyTask(task: next ?? queue.tasks[progress]);

      int i = next == null ? progress : queue.tasks.indexOf(next!);
      if (i < queue.tasks.length - 1) {
        next = queue.tasks[i + 1];
      }
    }

    return active;
  }

  bool complete() {
    if (active?.isCompleted == true) {
      progress = queue.tasks.indexOf(active!.task) + 1;
      if (progress < queue.tasks.length) {
        next = queue.tasks[progress];
      } else {
        next = null;
      }

      active = null;
    }

    return isCompleted;
  }

  void restart() {
    progress = 0;
    Task? first = queue.tasks.firstOrNull;
    if (first != null) {
      active = MyTask(task: first);
    }
  }
}
