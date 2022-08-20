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

import '/router.dart';

class ResultModal extends StatelessWidget {
  const ResultModal(this.won, {Key? key}) : super(key: key);

  final bool won;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Text(won ? 'You cleared the dungeon!!' : 'You lost, you retreat :('),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            router.home();
          },
          child: const Text('Home'),
        ),
      ],
    );
  }
}