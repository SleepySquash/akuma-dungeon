import 'dart:async';

import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:novel/novel.dart';

import '/domain/model/task_queue.dart';
import '/domain/model/task.dart';
import '/domain/model/task/queue/main/all.dart';
import '/domain/repository/task.dart';
import '/router.dart';
import '/util/obs/obs.dart';
import '/util/rewards.dart';
import 'flag.dart';
import 'item.dart';
import 'location.dart';
import 'player.dart';
import 'progression.dart';

class TaskService extends DisposableInterface {
  TaskService(
    this._taskRepository,
    this._flagService,
    this._playerService,
    this._itemService,
    this._locationService,
    this._progressionService,
  );

  final AbstractTaskRepository _taskRepository;
  final FlagService _flagService;
  final PlayerService _playerService;
  final ItemService _itemService;
  final LocationService _locationService;
  final ProgressionService _progressionService;

  RxObsMap<String, Rx<MyTask>> get tasks => _taskRepository.tasks;
  RxObsMap<String, Rx<MyTaskQueue>> get queues => _taskRepository.queues;
  Iterable<String> get completedTasks => _taskRepository.completedTasks;

  @override
  void onInit() {
    bool containsMainQuest = queues.values.firstWhereOrNull((e) =>
            MainTasks.queues
                .firstWhereOrNull((q) => q.id == e.value.queue.id) !=
            null) !=
        null;

    if (!containsMainQuest) {
      start(MainTasks.queues.first);
    }

    super.onInit();
  }

  void start(TaskQueue task) => _taskRepository.start(task);
  void progress(MyTaskQueue task) => _taskRepository.progress(task);
  void abandon(TaskQueue task) => _taskRepository.abandon(task);
  void complete(MyTaskQueue queue) {
    if (queue.isCompleted) {
      queue.active = null;
      // Put [queue] to `completed` queues?
    }
  }

  void accept(Task task) => _taskRepository.accept(task);
  void cancel(Task task) => _taskRepository.cancel(task);
  void finish(MyTask task) {
    if (task.isCompleted) {
      task.task.rewards.compute(
        itemService: _itemService,
        locationService: _locationService,
        playerService: _playerService,
        flagService: _flagService,
      );

      _taskRepository.complete(task.task);

      cancel(task.task);
    }
  }

  Future<void> executeQueue(MyTaskQueue queue) async {
    MyTask? task = queue.active ?? queue.execute();

    if (queue.isCompleted) {
      complete(queue);
    } else if (task != null) {
      bool met = await task.task.criteriaMet(
        player: _playerService.player,
        progression: _progressionService.progression.value,
        isTaskCompleted: _taskRepository.isCompleted,
        getCompleted: _taskRepository.getCompleted,
      );

      if (!met) {
        return;
      }

      queue.active!.execute(
        save: () => _taskRepository.progress(queue),
        onEnd: () {
          finish(task);
          if (queue.complete()) {
            complete(queue);
          }
          router.home();
        },
        location: _locationService.location.value.location,
      );
    }
  }

  void restartQueue(MyTaskQueue queue) {
    queue.restart();
    queues[queue.queue.id]?.refresh();
  }

  void executeTask(MyTask task) {
    task.execute(
      save: () => _taskRepository.update(task),
      location: _locationService.location.value.location,
    );
  }

  bool isCompleted(String id) => _taskRepository.isCompleted(id);
  Future<CompletedTask?> getCompleted(String id) =>
      _taskRepository.getCompleted(id);
  void uncomplete(String id) => _taskRepository.uncomplete(id);
}
