import 'package:get/get.dart';
import 'package:novel/novel.dart';

import '/domain/model/progression.dart';
import '/domain/model/task.dart';
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

  late final RxInt completedTasks;

  final AbstractTaskRepository _taskRepository;

  final PlayerService _playerService;
  final ItemService _itemService;

  RxObsMap<String, Rx<MyTask>> get tasks => _taskRepository.tasks;
  Rx<GameProgression> get progression => _taskRepository.progression;

  @override
  void onInit() {
    completedTasks =
        RxInt(tasks.values.where((e) => e.value.isCompleted).length);

    super.onInit();
  }

  void accept(Task task) => _taskRepository.accept(task);
  void cancel(Task task) => _taskRepository.cancel(task);
  void finish(MyTask task) {
    if (task.isCompleted) {
      for (var r in task.task.rewards) {
        if (r is MoneyReward) {
          _playerService.addMoney(r.amount);
        } else if (r is ExpReward) {
          _playerService.addExperience(r.amount);
        } else if (r is ItemReward) {
          _itemService.add(r.item);
        } else if (r is ExpReward) {
          _playerService.addRank(r.amount);
        }
      }

      completedTasks.value--;
      cancel(task.task);
    }
  }

  Future<void> execute(MyTask task) async {
    void _next() {
      task.progress++;
      _taskRepository.update(task);
      execute(task);
    }

    if (task.isCompleted) {
      completedTasks.value++;
    } else {
      int i = task.progress;
      TaskStep step = task.task.steps[i];
      if (step is NovelStep) {
        Novel.show(context: router.context!, scenario: step.scenario)
            .then((_) => _next());
      } else if (step is DungeonStep) {
        router.dungeon(step.settings, onClear: _next);
      }
    }
  }

  void progress() => _taskRepository.progress();
}
