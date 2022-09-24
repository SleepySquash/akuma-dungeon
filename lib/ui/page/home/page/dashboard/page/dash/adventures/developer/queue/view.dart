import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/task_queue.dart';
import '/ui/widget/modal_popup.dart';
import 'controller.dart';

class QueueDetailsView extends StatelessWidget {
  const QueueDetailsView(this.queue, {Key? key}) : super(key: key);

  final MyTaskQueue queue;

  static Future<T?> show<T>(BuildContext context, MyTaskQueue queue) {
    return ModalPopup.show(context: context, child: QueueDetailsView(queue));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: QueueDetailsController(queue: queue),
      builder: (QueueDetailsController c) {
        return ListView(
          shrinkWrap: true,
          children: [
            ...queue.queue.tasks.map((e) {
              bool isActive = queue.active?.task.id == e.id;
              return ListTile(
                leading:
                    isActive ? const Icon(Icons.local_activity_rounded) : null,
                title: Text(e.name),
                subtitle: isActive
                    ? Text(
                        'Progress: ${queue.active?.progress}/${e.steps.length}')
                    : null,
                trailing: isActive
                    ? IconButton(
                        onPressed: c.restart,
                        icon: const Icon(Icons.restore),
                      )
                    : IconButton(
                        onPressed: () => c.start(e),
                        icon: const Icon(Icons.start),
                      ),
              );
            }),
          ],
        );
      },
    );
  }
}
