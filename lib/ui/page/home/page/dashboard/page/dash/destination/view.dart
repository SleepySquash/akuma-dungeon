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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/task.dart';
import '/router.dart';
import 'controller.dart';

class DestinationView extends StatelessWidget {
  const DestinationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DestinationController(Get.find()),
      builder: (DestinationController c) {
        return Material(
          type: MaterialType.transparency,
          child: Obx(() {
            Iterable<Rx<MyTask>> tasks =
                c.tasks.values.where((e) => !e.value.isCompleted);

            return ListView(
              shrinkWrap: true,
              children: [
                const ListTile(title: Text('Путь к Богине')),
                ListTile(
                  leading: const Icon(Icons.fort),
                  title: const Text('Путь к Богине'),
                  subtitle:
                      const Text('Хватит обороняться, напади на монстров!'),
                  trailing: Obx(() {
                    return Text('${c.progression.value.level}-й этаж');
                  }),
                  onTap: () {
                    router.dungeon(
                      InfiniteDungeon(
                        floor: c.progression.value.level,
                        onProgress: c.progress,
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                ),
                const Divider(),

                const ListTile(title: Text('Путешествия')),
                // const ListTile(
                //   leading: Icon(Icons.auto_awesome),
                //   title: Text('Начало пути'),
                //   subtitle:
                //       Text('Гильдмастер просил подойти к нему по готовности'),
                //   trailing: Text('F'),
                // ),
                if (tasks.isEmpty)
                  const ListTile(
                    title: Center(
                      child: Text('Чтобы взять задания, обратись в гильдию!'),
                    ),
                  ),
                ...tasks.map((m) {
                  Task e = m.value.task;
                  return ListTile(
                    leading: Icon(e.icon),
                    title: Text(e.name),
                    subtitle:
                        e.description == null ? null : Text(e.description!),
                    trailing: Text(
                        '${e.rank.name} (${m.value.progress}/${e.steps.length})'),
                    onTap: () {
                      Navigator.of(context).pop();
                      c.execute(m.value);
                    },
                  );
                }),

                // const Divider(),
                // const ListTile(title: Text('Артефакты')),
                // const ListTile(
                //   leading: Icon(Icons.church),
                //   title: Text('Монастырь ушедшей цивилизации'),
                //   subtitle: Text('Очень холодное и мрачное место...'),
                //   trailing: Icon(Icons.ac_unit),
                // ),
                // const ListTile(
                //   leading: Icon(Icons.auto_awesome),
                //   title: Text('Секта лунатиков'),
                //   subtitle:
                //       Text('Невероятное количество магии привлекает нежить'),
                //   trailing: Icon(Icons.whatshot),
                // ),
              ],
            );
          }),
        );
      },
    );
  }
}
