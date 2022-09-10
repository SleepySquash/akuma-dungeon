import 'package:akuma/domain/model/commission.dart';
import 'package:akuma/domain/model/location.dart';
import 'package:akuma/domain/service/location.dart';
import 'package:get/get.dart';

import '/domain/model/progression.dart';
import '/domain/model/task_queue.dart';
import '/domain/model/task.dart';
import '/domain/repository/player.dart';
import '/domain/service/player.dart';
import '/domain/service/progression.dart';
import '/domain/service/task.dart';
import '/util/obs/obs.dart';

class AdventuresController extends GetxController {
  AdventuresController(
    this._playerService,
    this._taskService,
    this._progressionService,
    this._locationService,
  );

  final PlayerService _playerService;
  final TaskService _taskService;
  final ProgressionService _progressionService;
  final LocationService _locationService;

  RxObsMap<String, Rx<MyTask>> get tasks => _taskService.tasks;
  RxObsMap<String, Rx<MyTaskQueue>> get queues => _taskService.queues;

  Rx<GameProgression> get progression => _progressionService.progression;
  Rx<MyLocation> get location => _locationService.location;

  RxPlayer get player => _playerService.player;

  void accept(Task task) => _taskService.accept(task);
  void executeTask(MyTask task) => _taskService.executeTask(task);
  void executeQueue(MyTaskQueue queue) => _taskService.executeQueue(queue);
  void restartQueue(MyTaskQueue queue) => _taskService.restartQueue(queue);
  void executeCommission(MyCommission commission) =>
      _locationService.executeCommission(commission);
  bool criteriaMet(Task task) =>
      task.criteriaMet(player: _playerService.player.player.value);
  void setGoddessTower(int to) => _progressionService.setGoddessTower(to);
}
