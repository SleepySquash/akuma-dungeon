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

      _taskRepository.getCompleted(task.task.id).then((v) {
        if (v != null) {
          ++v.count;
        } else {
          v = CompletedTask(id: task.task.id);
        }

        _taskRepository.complete(v);
      });

      cancel(task.task);
    }
  }

  void executeQueue(MyTaskQueue queue) {
    MyTask? task = queue.active ?? queue.execute();

    if (task != null) {
      if (!task.task.criteriaMet(
        player: _playerService.player.player.value,
        progression: _progressionService.progression.value,
      )) {
        return;
      }

      void execute(MyTask task) {
        void next() {
          task.progress++;
          _taskRepository.progress(queue);
          execute(task);
        }

        if (task.isCompleted) {
          finish(task);
          if (queue.complete()) {
            complete(queue);
          }
          router.home();
        } else {
          int i = task.progress;
          TaskStep step = task.task.steps[i];
          if (step is NovelStep) {
            router.nowhere();
            Novel.show(context: router.context!, scenario: step.scenario)
                .then((_) => next());
          } else if (step is DungeonStep) {
            if (step.withEntrance) {
              router.entrance(
                step.settings,
                _locationService.location.value.location.asset,
                onClear: () {
                  router.nowhere();
                  next();
                },
              );
            } else {
              router.dungeon(
                step.settings,
                onClear: () {
                  router.nowhere();
                  next();
                },
              );
            }
          } else if (step is ExecuteStep) {
            router.nowhere();
            FutureOr future = step.function.call();
            if (future is Future) {
              future.then((_) => next());
            }
          }
        }
      }

      execute(queue.active!);
    } else if (queue.isCompleted) {
      complete(queue);
    }
  }

  void restartQueue(MyTaskQueue queue) {
    queue.restart();
    queues[queue.queue.id]?.refresh();
  }

  void executeTask(MyTask task) async {
    void next() {
      task.progress++;
      _taskRepository.update(task);
      executeTask(task);
    }

    if (task.isCompleted) {
      router.home();
      finish(task);
    } else {
      int i = task.progress;
      TaskStep step = task.task.steps[i];
      if (step is NovelStep) {
        router.nowhere();
        Novel.show(context: router.context!, scenario: step.scenario)
            .then((_) => next());
      } else if (step is DungeonStep) {
        router.dungeon(
          step.settings,
          onClear: () {
            router.nowhere();
            next();
          },
        );
      }
    }
  }
}
