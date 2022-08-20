import 'package:akuma/router.dart';
import 'package:akuma/ui/widget/modal_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/task.dart';
import '/domain/service/task.dart';
import '/util/obs/obs.dart';

class TaskController extends GetxController {
  TaskController(this._taskService);

  final TaskService _taskService;

  RxObsMap<String, Rx<MyTask>> get tasks => _taskService.tasks;

  void accept(Task task) => _taskService.accept(task);
  void finish(MyTask task) => _taskService.finish(task);
}
