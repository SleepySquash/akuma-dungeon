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
import 'package:akuma/ui/page/home/page/dashboard/page/guild/task/commission_preview/view.dart';
import 'package:akuma/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/reward.dart';
import '/domain/model/task.dart';
import '/domain/model/task/dungeon/all.dart';
import '/router.dart';
import '/ui/widget/modal_popup.dart';
import 'controller.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(context: context, child: const TaskView());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TaskController(Get.find()),
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

            return ListTile(
              leading: Icon(e.task.icon),
              title: remaining == null
                  ? Text(e.task.name)
                  : Text('${e.task.name} [Осталось: ${remaining.hhMmSs()}]'),
              subtitle:
                  e.task.description == null ? null : Text(e.task.description!),
              trailing: e.isCompleted
                  ? const Icon(Icons.done_outline, color: Colors.green)
                  : Text(e.task.rank.name),
              onTap: () => CommissionPreviewView.show(
                context,
                commission: e,
                onComplete: () => c.finish(e),
                onAccept: () => c.accept(e),
              ),
            );
          });
        }

        return Material(
          type: MaterialType.transparency,
          child: Obx(() {
            Iterable<MyCommission> completed =
                c.location.value.commissions.where((e) => e.isCompleted);
            Iterable<MyCommission> available =
                c.location.value.commissions.where((e) => !e.accepted);
            Iterable<MyCommission> accepted = c.location.value.commissions
                .where((e) => !e.isCompleted && e.accepted);

            return ListView(
              shrinkWrap: true,
              children: [
                if (completed.isNotEmpty)
                  const ListTile(title: Text('Завершённые')),
                ...completed.map(commission),
                if (available.isNotEmpty)
                  const ListTile(title: Text('Доступные')),
                ...available.map(commission),
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
