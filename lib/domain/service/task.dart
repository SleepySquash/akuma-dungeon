import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:novel/novel.dart';

import '/domain/model/item/standard.dart';
import '/domain/model/progression.dart';
import '/domain/model/task_queue.dart';
import '/domain/model/task.dart';
import '/domain/model/task/main/all.dart';
import '/domain/repository/task.dart';
import '/domain/service/item.dart';
import '/domain/service/player.dart';
import '/router.dart';
import '/util/obs/obs.dart';

class TaskService extends DisposableInterface {
  TaskService(
    this._taskRepository,
    this._playerService,
    this._itemService,
  );

  final AbstractTaskRepository _taskRepository;

  final PlayerService _playerService;
  final ItemService _itemService;

  RxObsMap<String, Rx<MyTask>> get tasks => _taskRepository.tasks;
  RxObsMap<String, Rx<MyTaskQueue>> get queues => _taskRepository.queues;
  Rx<GameProgression> get progression => _taskRepository.progression;

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
      for (var r in task.task.rewards) {
        if (r is MoneyReward) {
          _itemService.add(Dogecoin(r.amount));
        } else if (r is ExpReward) {
          _playerService.addExperience(r.amount);
        } else if (r is ItemReward) {
          _itemService.add(r.item);
        } else if (r is ExpReward) {
          _playerService.addRank(r.amount);
        }
      }

      cancel(task.task);
    }
  }

  void executeQueue(MyTaskQueue queue) {
    MyTask? task;

    if (queue.active?.isCompleted == true) {
      task = queue.accomplish();
    } else {
      task = queue.active;
    }

    if (task != null) {
      if (!task.criteriaMet(player: _playerService.player.value)) {
        return;
      }

      void _execute(MyTask task) {
        void _next() {
          task.progress++;
          _taskRepository.progress(queue);
          _execute(task);
        }

        if (task.isCompleted) {
          finish(task);
          if (queue.accomplish() == null) {
            complete(queue);
          }
          router.home();
        } else {
          int i = task.progress;
          TaskStep step = task.task.steps[i];
          if (step is NovelStep) {
            router.nowhere();
            Novel.show(context: router.context!, scenario: step.scenario)
                .then((_) => _next());
          } else if (step is DungeonStep) {
            router.dungeon(
              step.settings,
              onClear: () {
                router.nowhere();
                _next();
              },
            );
          }
        }
      }

      _execute(queue.active!);
    } else if (queue.isCompleted) {
      complete(queue);
    }
  }

  void restartQueue(MyTaskQueue queue) {
    queue.restart();
    queues[queue.queue.id]?.refresh();
  }

  void executeTask(MyTask task) async {
    void _next() {
      task.progress++;
      _taskRepository.update(task);
      executeTask(task);
    }

    if (task.isCompleted) {
      router.home();
      if (task.task is! GuildTask) {
        finish(task);
      }
    } else {
      int i = task.progress;
      TaskStep step = task.task.steps[i];
      if (step is NovelStep) {
        router.nowhere();
        Novel.show(context: router.context!, scenario: step.scenario)
            .then((_) => _next());
      } else if (step is DungeonStep) {
        router.dungeon(
          step.settings,
          onClear: () {
            router.nowhere();
            _next();
          },
        );
      }
    }
  }

  void setGoddessTower(int to) => _taskRepository.setGoddessTower(to);
  void setChapter(int to) => _taskRepository.setChapter(to);
}
