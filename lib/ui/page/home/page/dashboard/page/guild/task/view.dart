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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/commission.dart';
import '/domain/model/flag.dart';
import '/ui/widget/locked.dart';
import '/ui/widget/modal_popup.dart';
import '/util/extensions.dart';
import 'commission_preview/view.dart';
import 'controller.dart';
import 'developer/view.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(context: context, child: const TaskView());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TaskController(Get.find(), Get.find()),
      builder: (TaskController c) {
        Widget commission(MyCommission e) {
          return Obx(() {
            // Used to update the durations every second.
            // ignore: unused_local_variable
            bool tick = c.ticker.value;

            Duration? remaining;
            if (!e.isCompleted && e.task.timeout != null) {
              Duration diff = DateTime.now().difference(e.appearedAt);
              if (diff > e.task.timeout!) {
                remaining = Duration.zero;
              } else {
                remaining = e.task.timeout! - diff;
              }
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: LockedWidget(
                locked: e.task is DungeonCommission &&
                    !c.flags.dungeonCommissionsUnlocked,
                child: ListTile(
                  leading: Icon(e.task.icon),
                  title: remaining == null
                      ? Text(e.task.name)
                      : Text(
                          '${e.task.name} [Осталось: ${remaining.hhMmSs()}]'),
                  subtitle:
                      e.task.subtitle == null ? null : Text(e.task.subtitle!),
                  trailing: e.isCompleted
                      ? const Icon(Icons.done_outline, color: Colors.green)
                      : Text(e.task.rank.name),
                  onTap: () => CommissionPreviewView.show(
                    context,
                    commission: e,
                    onComplete: () => c.finish(e),
                    onAccept: () => c.accept(e),
                  ),
                ),
              ),
            );
          });
        }

        return Material(
          type: MaterialType.transparency,
          child: Obx(() {
            Iterable<MyCommission> completed =
                c.location.value.commissions.where((e) => e.isCompleted);
            Iterable<MyCommission> quests = c.location.value.commissions
                .where((e) => !e.accepted && e.task is! DungeonCommission);
            Iterable<MyCommission> dungeons = c.location.value.commissions
                .where((e) => !e.accepted && e.task is DungeonCommission);
            Iterable<MyCommission> accepted = c.location.value.commissions
                .where((e) => !e.isCompleted && e.accepted);

            return ListView(
              shrinkWrap: true,
              children: [
                if (kDebugMode)
                  ListTile(
                    leading: const Icon(Icons.developer_mode),
                    title: const Text('Developer'),
                    onTap: () => AllTasksView.show(context),
                  ),
                if (completed.isNotEmpty)
                  const ListTile(title: Text('Завершённые')),
                ...completed.map(commission),
                if (quests.isNotEmpty) const ListTile(title: Text('Квесты')),
                ...quests.map(commission),
                if (dungeons.isNotEmpty) const ListTile(title: Text('Данжи')),
                ...dungeons.map(commission),
                if (accepted.isNotEmpty)
                  const ListTile(title: Text('Принятые')),
                ...accepted.map(commission),
              ],
            );
          }),
        );
      },
    );
  }
}
