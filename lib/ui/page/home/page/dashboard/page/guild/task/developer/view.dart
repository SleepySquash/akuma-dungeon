import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/widget/modal_popup.dart';
import 'controller.dart';

class AllTasksView extends StatelessWidget {
  const AllTasksView({Key? key}) : super(key: key);

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(context: context, child: const AllTasksView());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AllTasksController(
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
        ),
        builder: (AllTasksController c) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const TabBar(
                  unselectedLabelColor: Colors.black54,
                  labelColor: Colors.black,
                  tabs: [
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
                  _tasks(c, context),
                  _completed(c, context),
                ],
              ),
            ),
          );
        });
  }

  Widget _tasks(AllTasksController c, BuildContext context) {
    return Obx(() {
      if (c.location.value.location.commissions.isEmpty) {
        return const Center(child: Text('This location has none yet'));
      }

      return ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('Remove all quests'),
            onTap: c.removeQuests,
          ),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('Remove all dungeons'),
            onTap: c.removeDungeons,
          ),
          ...c.location.value.location.commissions.map((e) {
            return FutureBuilder(
                future: c.criteriaMet(e),
                builder: (context, snapshot) {
                  bool met = snapshot.data == true;
                  return ListTile(
                    title: Text(e.name),
                    subtitle: Text('Criteria met: $met'),
                  );
                });
          }),
        ],
      );
    });
  }

  Widget _completed(AllTasksController c, BuildContext context) {
    return Obx(() {
      if (c.completedTasks.isEmpty) {
        return const Center(child: Text('None yet'));
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
