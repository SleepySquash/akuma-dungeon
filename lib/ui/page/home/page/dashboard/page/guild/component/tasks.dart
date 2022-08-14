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

class TasksModal extends StatelessWidget {
  const TasksModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: const Icon(Icons.park),
            title: const Text('Fields'),
            subtitle: const Text('Defeat slimes wandering through the fields'),
            trailing: const Text('F'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.forest),
            title: const Text('Forest'),
            subtitle: const Text('Defeat slimes wandering through the forest'),
            trailing: const Text('E'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.forest),
            title: const Text('Swarm'),
            subtitle: const Text('Defeat the boss slime'),
            trailing: const Text('E+'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
