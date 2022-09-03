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

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/rank.dart';
import '/ui/page/home/widget/menu_tile.dart';
import 'controller.dart';
import 'task/view.dart';

class GuildView extends StatelessWidget {
  const GuildView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: GuildController(Get.find()),
      builder: (GuildController c) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/background/location/guild.jpg',
                alignment: Alignment.centerRight,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/character/Arda.png'),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: _menu(context, c),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _menu(BuildContext context, GuildController c) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 4,
            child: MenuTile(
              onPressed: () => TaskView.show(context),
              child: const Text('Поручения'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: MenuTile(
                    locked: true,
                    onPressed: () {},
                    child: const Text('Подземелья'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: MenuTile(
                    onPressed: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Obx(() {
                            return BorderedText(
                              child: Text(
                                c.player.player.value.rank.toRank.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 4),
                        Obx(() {
                          return Text(
                            '${c.player.player.value.rank}/100',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}