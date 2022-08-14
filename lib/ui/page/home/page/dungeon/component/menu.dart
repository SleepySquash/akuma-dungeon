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
import 'package:akuma/ui/page/home/page/dungeon/controller.dart';
import 'package:flutter/material.dart';

class DungeonMenu extends StatelessWidget {
  const DungeonMenu(this.c, {Key? key}) : super(key: key);

  final DungeonController c;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        router.home();
        Navigator.of(context).pop();
      },
      child: const Text('Leave'),
    );
  }
}
