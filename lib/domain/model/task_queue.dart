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
    MyTask? active,
    this.progress = 0,
    String? nextTask,
  }) : active = active ?? MyTask(task: queue.tasks.first) {
    if (active != null) {
      int i = queue.tasks.indexOf(active.task);
      if (i != -1 && i < queue.tasks.length - 1) {
        nextTask = queue.tasks[i].id;
      }
    }
  }

  final TaskQueue queue;
  MyTask? active;

  int progress;

  String? nextTask;

  bool get isCompleted => progress >= queue.tasks.length;

  MyTask? accomplish() {
    if (active != null) {
      progress = queue.tasks.indexOf(active!.task) + 1;
      if (progress < queue.tasks.length) {
        active = MyTask(task: queue.tasks[progress]);
      }
    } else if (progress == 0) {
      Task? first = queue.tasks.firstOrNull;
      if (first != null) {
        active = MyTask(task: first);
      }
    }

    return active;
  }

  void restart() {
    progress = 0;
    Task? first = queue.tasks.firstOrNull;
    if (first != null) {
      active = MyTask(task: first);
    }
  }
}
