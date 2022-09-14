import 'package:akuma/domain/model/location.dart';
import 'package:akuma/domain/model/task.dart';
import 'package:akuma/domain/service/location.dart';
import 'package:akuma/domain/service/player.dart';
import 'package:akuma/domain/service/progression.dart';
import 'package:akuma/domain/service/task.dart';
import 'package:get/get.dart';

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

  Future<void> criteriaMet(Task task) => task.criteriaMet(
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

  void _populateCompleted() async {
    for (String id in _taskService.completedTasks) {
      CompletedTask? task = await _taskService.getCompleted(id);
      if (task != null) {
        completedTasks.add(task);
      }
    }
  }
}
