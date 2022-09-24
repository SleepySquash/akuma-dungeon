import 'package:get/get.dart';

import '/domain/model/task.dart';
import '/domain/model/task_queue.dart';

class QueueDetailsController extends GetxController {
  QueueDetailsController({required this.queue});

  final MyTaskQueue queue;

  void restart() {
    queue.active?.progress = 0;
    refresh();
  }

  void start(Task task) {
    queue.active = MyTask(task: task);
    refresh();
  }
}
