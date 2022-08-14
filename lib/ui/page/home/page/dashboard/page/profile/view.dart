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

import '/ui/widget/dummy_character.dart';
import 'controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileController(Get.find(), Get.find()),
      builder: (ProfileController c) {
        return Column(
          children: [
            const Center(child: Text('Profile')),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Obx(() {
                        return DummyCharacter(
                          race: c.player.value!.race,
                          gender: c.player.value!.gender,
                        );
                      }),
                    ),
                    Obx(() => Text('Name: ${c.player.value?.name}')),
                    Obx(() => Text('EXP: ${c.player.value?.exp}')),
                    Obx(() => Text('Money: ${c.player.value?.money}')),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
