import 'package:akuma/domain/model/progression.dart';
import 'package:get/get.dart';

import '/domain/model/task.dart';
import '/domain/service/task.dart';
import '/util/obs/obs.dart';

class DestinationController extends GetxController {
  DestinationController(this._taskService);

  final TaskService _taskService;

  RxObsMap<String, Rx<MyTask>> get tasks => _taskService.tasks;

  Rx<GameProgression> get progression => _taskService.progression;

  void accept(Task task) => _taskService.accept(task);
  Future<void> execute(MyTask task) => _taskService.execute(task);
  void progress(int to) => _taskService.progress(to);
}
