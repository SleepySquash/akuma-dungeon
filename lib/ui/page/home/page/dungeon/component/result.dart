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

import '/domain/model/task.dart';
import '/router.dart';
import '/ui/page/home/page/dungeon/controller.dart';

class ResultModal extends StatelessWidget {
  const ResultModal(
    this.c, {
    Key? key,
    this.won = false,
    this.onDismissed,
  }) : super(key: key);

  final DungeonController c;

  final bool won;

  final void Function()? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(won ? 'You cleared the dungeon!!' : 'You lost, you retreat :('),
        if (won && (c.settings.rewards ?? []).isNotEmpty)
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                const ListTile(title: Text('Rewards:')),
                ...(c.settings.rewards ?? []).map((e) {
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
                    if (e.count == 0) {
                      return Container();
                    }

                    icon = Icons.check_box;
                    title = Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/item/${e.item.asset}.png',
                          height: 30,
                        ),
                        const SizedBox(width: 5),
                        Text('${e.item.count * e.count} ${e.item.name}'),
                      ],
                    );
                  } else if (e is ControlReward) {
                    icon = Icons.control_camera;
                    title = Text('${e.amount} control');
                  } else if (e is ReputationReward) {
                    icon = Icons.people;
                    title = Text('${e.amount} reputation');
                  }

                  return ListTile(
                    leading: icon == null ? null : Icon(icon),
                    title: title,
                  );
                }),
              ],
            ),
          ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();

            onDismissed?.call();
            if (onDismissed == null) {
              router.home();
            }
          },
          child:
              onDismissed == null ? const Text('Home') : const Text('Continue'),
        ),
      ],
    );
  }
}
