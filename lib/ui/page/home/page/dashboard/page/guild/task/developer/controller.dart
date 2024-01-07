import 'package:get/get.dart';

import '/domain/model/commission.dart';
import '/domain/model/location.dart';
import '/domain/model/task.dart';
import '/domain/service/location.dart';
import '/domain/service/player.dart';
import '/domain/service/progression.dart';
import '/domain/service/task.dart';

class AllTasksController extends GetxController {
  AllTasksController(
    this._playerService,
    this._taskService,
    this._locationService,
    this._progressionService,
  );

  final PlayerService _playerService;
  final TaskService _taskService;
  final LocationService _locationService;
  final ProgressionService _progressionService;

  final RxList<CompletedTask> completedTasks = RxList();

  Rx<MyLocation> get location => _locationService.location;

  @override
  void onInit() {
    _populateCompleted();
    super.onInit();
  }

  Future<bool> criteriaMet(Task task) => task.criteriaMet(
        player: _playerService.player,
        progression: _progressionService.progression.value,
        isTaskCompleted: _taskService.isCompleted,
        getCompleted: _taskService.getCompleted,
      );

  void uncompleteAll() {
    for (String id in List.from(_taskService.completedTasks, growable: false)) {
      _taskService.uncomplete(id);
    }
    completedTasks.clear();
  }

  void removeQuests() {
    for (var e in List.from(
      _locationService.location.value.commissions,
      growable: false,
    ).where((e) => e.task is QuestCommission)) {
      _locationService.removeCommission(e);
    }
  }

  void removeDungeons() {
    for (var e in List.from(
      _locationService.location.value.commissions,
      growable: false,
    ).where((e) => e.task is DungeonCommission)) {
      _locationService.removeCommission(e);
    }
  }

  void _populateCompleted() async {
    for (String id in _taskService.completedTasks) {
      CompletedTask? task = await _taskService.getCompleted(id);
      if (task != null) {
        completedTasks.add(task);
      }
    }
  }
}
