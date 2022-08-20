// Copyright © 2022 NIKITA ISAENKO, <https://github.com/SleepySquash>
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU Affero General Public License v3.0 as published by the
// Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License v3.0 for
// more details.
//
// You should have received a copy of the GNU Affero General Public License v3.0
// along with this program. If not, see
// <https://www.gnu.org/licenses/agpl-3.0.html>.

import 'package:akuma/router.dart';
import 'package:akuma/ui/widget/modal_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/task.dart';
import '/domain/model/task/dungeon/all.dart';
import 'controller.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TaskController(Get.find()),
      builder: (TaskController c) {
        return Material(
          type: MaterialType.transparency,
          child: ListView(
            shrinkWrap: true,
            children: [
              ...DungeonTasks.all.map((e) {
                return Obx(() {
                  Rx<MyTask>? task = c.tasks[e.id];
                  bool taken = task != null;

                  bool done = false;
                  if (task != null) {
                    done = task.value.progress >= task.value.task.steps.length;
                  }

                  return ListTile(
                    leading: done
                        ? const Icon(Icons.check_circle)
                        : taken
                            ? const CircularProgressIndicator.adaptive()
                            : Icon(e.icon),
                    title: Text(e.name),
                    subtitle:
                        e.description == null ? null : Text(e.description!),
                    trailing: Text(e.rank.name),
                    onTap: done
                        ? () {
                            c.finish(task!.value);
                            _rewards(task.value);
                          }
                        : taken
                            ? null
                            : () => c.accept(e),
                  );
                });
              }),
            ],
          ),
        );
      },
    );
  }

  void _rewards(MyTask task) {
    ModalPopup.show(
      context: router.context!,
      maxWidth: 400,
      child: Builder(builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: [
            const ListTile(title: Text('Thank you for your work!')),
            const Divider(),
            const ListTile(title: Text('Rewards:')),
            ...task.task.rewards.map((e) {
              IconData? icon;
              Widget? title;

              if (e is MoneyReward) {
                icon = Icons.money;
                title = Text('${e.amount} gold');
              } else if (e is ExpReward) {
                icon = Icons.person;
                title = Text('${e.amount} experience');
              } else if (e is RankReward) {
                icon = Icons.add_card;
                title = Text('${e.amount} rank progression');
              } else if (e is ItemReward) {
                icon = Icons.check_box;
                title = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/item/${e.item.asset}.png', height: 30),
                    const SizedBox(width: 5),
                    Text('${e.item.count} ${e.item.name}'),
                  ],
                );
              }

              return ListTile(
                leading: icon == null ? null : Icon(icon),
                title: title,
              );
            }),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      }),
    );
  }
}
