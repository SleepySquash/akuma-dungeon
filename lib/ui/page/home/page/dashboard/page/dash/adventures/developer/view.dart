import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/widget/modal_popup.dart';
import 'controller.dart';
import 'queue/view.dart';

class AllQueuesView extends StatelessWidget {
  const AllQueuesView({Key? key}) : super(key: key);

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(
      maxWidth: 450,
      context: context,
      child: const AllQueuesView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init:
            AllQueuesController(Get.find(), Get.find(), Get.find(), Get.find()),
        builder: (AllQueuesController c) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const TabBar(
                  unselectedLabelColor: Colors.black54,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: 'Queues',
                      icon: Icon(Icons.queue),
                      iconMargin: EdgeInsets.zero,
                    ),
                    Tab(
                      text: 'Tasks',
                      icon: Icon(Icons.event),
                      iconMargin: EdgeInsets.zero,
                    ),
                    Tab(
                      text: 'Completed',
                      icon: Icon(Icons.face),
                      iconMargin: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  _queues(c, context),
                  _tasks(c, context),
                  _completed(c, context),
                ],
              ),
            ),
          );
        });
  }

  Widget _queues(AllQueuesController c, BuildContext context) {
    return Obx(() {
      if (c.queues.isEmpty) {
        return const Center(child: Text('No queues yet'));
      }

      return ListView(
        shrinkWrap: true,
        children: [
          ...c.queues.values.map((e) {
            return ListTile(
              title: Text(e.value.queue.name),
              subtitle: Text(
                'Active: ${e.value.active?.task.name} (${e.value.active?.progress}/${e.value.active?.task.steps.length})\n'
                'Next: ${e.value.next?.name}\n'
                'Progress: ${e.value.progress}/${e.value.queue.tasks.length}',
              ),
              trailing: IconButton(
                onPressed: () => QueueDetailsView.show(context, e.value),
                icon: const Icon(Icons.more_horiz),
              ),
              isThreeLine: true,
            );
          }),
        ],
      );
    });
  }

  Widget _tasks(AllQueuesController c, BuildContext context) {
    return Obx(() {
      if (c.tasks.isEmpty) {
        return const Center(child: Text('No active tasks yet'));
      }

      return ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('Un-accept?'),
            onTap: () {},
          ),
          ...c.tasks.values.map((e) {
            return ListTile(
              title: Text(e.value.task.name),
              subtitle: Text(
                'Progress: ${e.value.progress}/${e.value.task.steps.length}',
              ),
            );
          }),
        ],
      );
    });
  }

  Widget _completed(AllQueuesController c, BuildContext context) {
    return Obx(() {
      if (c.completedTasks.isEmpty) {
        return const Center(child: Text('No completed task yet'));
      }

      return ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('Make all un-completed'),
            onTap: c.uncompleteAll,
          ),
          ...c.completedTasks.map((e) {
            return ListTile(
              title: Text(e.id),
              subtitle: Text(
                'Completed ${e.count} times, first at ${e.completedAt}',
              ),
            );
          }),
        ],
      );
    });
  }
}
