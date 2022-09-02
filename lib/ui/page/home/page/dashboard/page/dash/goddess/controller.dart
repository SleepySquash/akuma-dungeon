import 'package:get/get.dart';

import '/domain/model/progression.dart';
import '/domain/service/task.dart';

class GoddessController extends GetxController {
  GoddessController(this._taskService);

  final TaskService _taskService;

  Rx<GameProgression> get progression => _taskService.progression;

  void setGoddessTower(int to) => _taskService.setGoddessTower(to);
}
