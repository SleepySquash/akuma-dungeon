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

import 'package:akuma/domain/model/commission.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/task_queue.dart';
import '/domain/model/task.dart';
import '/ui/widget/locked.dart';
import '/ui/widget/modal_popup.dart';
import 'controller.dart';

class AdventuresView extends StatelessWidget {
  const AdventuresView({Key? key}) : super(key: key);

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(context: context, child: const AdventuresView());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AdventuresController(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
      builder: (AdventuresController c) {
        return Material(
          type: MaterialType.transparency,
          child: Obx(() {
            Iterable<MyCommission> tasks = c.location.value.commissions
                .where((e) => e.accepted && !e.isCompleted);

            return ListView(
              shrinkWrap: true,
              children: [
                if (c.queues.isEmpty && tasks.isEmpty)
                  const ListTile(
                    title: Center(
                      child: Text('Чтобы взять задания, обратись в гильдию!'),
                    ),
                  ),
                if (tasks.isNotEmpty) ...[
                  const ListTile(title: Text('Поручения')),
                  ...tasks.map((e) {
                    return ListTile(
                      leading: Icon(e.task.icon),
                      title: Text(e.task.name),
                      subtitle: e.task.description == null
                          ? null
                          : Text(e.task.description!),
                      trailing: Text(
                          '${e.task.rank.name} (${e.progress}/${e.task.steps.length})'),
                      onTap: () {
                        Navigator.of(context).pop();
                        c.executeCommission(e);
                      },
                    );
                  }),
                ],
                if (c.queues.isNotEmpty && tasks.isNotEmpty) const Divider(),
                if (c.queues.isNotEmpty) ...[
                  const ListTile(title: Text('Приключения')),
                  ...c.queues.values.map((m) {
                    MyTaskQueue e = m.value;

                    if (e.isCompleted || (e.active == null && e.next == null)) {
                      return ListTile(
                        leading: const Icon(Icons.question_answer),
                        title: Text(e.queue.name),
                        subtitle: const Text('Продолжение следует...'),
                        trailing: IconButton(
                          onPressed: () => c.restartQueue(e),
                          icon: const Icon(Icons.restart_alt),
                        ),
                        onTap: null,
                      );
                    }

                    Task task = e.active?.task ?? e.next!;
                    bool met = c.criteriaMet(task);

                    return LockedWidget(
                      locked: !met,
                      additional: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: task.criteria.map((e) {
                            if (e is LevelCriteria) {
                              if (c.player.player.value.level < e.level) {
                                return Text(
                                  'Level: ${e.level} or higher',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                              }
                            } else if (e is RankCriteria) {
                              if (c.player.player.value.rank < e.rank.index) {
                                return Text(
                                  'Rank: ${e.rank.name} or higher',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                              }
                            }

                            return Container();
                          }).toList(),
                        ),
                      ],
                      child: ListTile(
                        leading: Icon(task.icon),
                        title: Text(e.queue.name),
                        subtitle: Text(task.description ?? task.name),
                        trailing: const Icon(Icons.forward),
                        onTap: met
                            ? () {
                                Navigator.of(context).pop();
                                c.executeQueue(m.value);
                              }
                            : null,
                      ),
                    );
                  }),
                ],
              ],
            );
          }),
        );
      },
    );
  }
}
