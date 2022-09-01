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

import '/ui/page/home/page/settings/view.dart';
import '/ui/page/home/widget/wide_button.dart';
import '/ui/widget/dummy_character.dart';
import 'adventures/view.dart';
import 'battle_pass/view.dart';
import 'controller.dart';
import 'daily/view.dart';
import 'dungeons/view.dart';
import 'events/view.dart';
import 'goddess/view.dart';
import 'guild/view.dart';
import 'mail/view.dart';
import 'profile_settings/view.dart';
import 'room/view.dart';
import 'social/view.dart';
import 'widget/tile.dart';

class DashView extends StatelessWidget {
  const DashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashController(Get.find(), Get.find(), Get.find()),
      builder: (DashController c) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Obx(() {
                return DummyCharacter(
                  race: c.player.value!.race,
                  gender: c.player.value!.gender,
                );
              }),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FloatingActionButton(
                            onPressed: () => DailyView.show(context),
                            child: const Icon(Icons.bookmark),
                          ),
                          const SizedBox(width: 5),
                          FloatingActionButton(
                            onPressed: () => MailView.show(context),
                            child: const Icon(Icons.mail),
                          ),
                          const SizedBox(width: 5),
                          FloatingActionButton(
                            onPressed: () => SettingsView.show(context),
                            child: const Icon(Icons.settings),
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: WideButton(
                              onPressed: () =>
                                  ProfileSettingsView.show(context),
                              child: Center(
                                widthFactor: 0,
                                child: Text(
                                  '${c.player.value?.name}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Flexible(child: _menu(context, c)),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _menu(BuildContext context, DashController c) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450, maxHeight: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: MenuTile(
                    onPressed: () => EventsView.show(context),
                    child: const Text('События'),
                  ),
                ),
                Expanded(
                  child: MenuTile(
                    onPressed: () => BattlePassView.show(context),
                    child: const Text('Боевой пропуск'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: MenuTile(
              onPressed: () => AdventuresView.show(context),
              child: const Text('Приключения'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: MenuTile(
                    onPressed: () => DungeonsView.show(context),
                    child: const Text('Подземелья'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: MenuTile(
                    onPressed: () => GoddessView.show(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Flexible(child: Text('Путь к Богине')),
                        const SizedBox(height: 4),
                        Text(
                          '${c.progression.value.goddessTowerLevel}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: MenuTile(
                    onPressed: () => SocialView.show(context),
                    child: const Text('Друзья'),
                  ),
                ),
                Expanded(
                  child: MenuTile(
                    onPressed: () => GuildView.show(context),
                    child: const Text('Гильдия'),
                  ),
                ),
                Expanded(
                  child: MenuTile(
                    onPressed: () => RoomView.show(context),
                    child: const Text('Комната'),
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
