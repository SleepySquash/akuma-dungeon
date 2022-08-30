import 'package:get/get.dart';

import '/domain/model/player.dart';
import '/domain/model/progression.dart';
import '/domain/model/task_queue.dart';
import '/domain/model/task.dart';
import '/domain/service/player.dart';
import '/domain/service/task.dart';
import '/util/obs/obs.dart';

class DestinationController extends GetxController {
  DestinationController(this._playerService, this._taskService);

  final PlayerService _playerService;
  final TaskService _taskService;

  RxObsMap<String, Rx<MyTask>> get tasks => _taskService.tasks;
  RxObsMap<String, Rx<MyTaskQueue>> get queues => _taskService.queues;

  Rx<GameProgression> get progression => _taskService.progression;

  Rx<Player?> get player => _playerService.player;

  void accept(Task task) => _taskService.accept(task);
  void executeTask(MyTask task) => _taskService.executeTask(task);
  void executeQueue(MyTaskQueue queue) => _taskService.executeQueue(queue);
  void restartQueue(MyTaskQueue queue) => _taskService.restartQueue(queue);
  bool criteriaMet(MyTask task) =>
      task.criteriaMet(player: _playerService.player.value);
  void setGoddessTower(int to) => _taskService.setGoddessTower(to);
}
