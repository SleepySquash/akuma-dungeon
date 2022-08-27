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

import '/ui/page/home/widget/screen_switcher.dart';
import 'component/attributes.dart';
import 'component/inventory.dart';
import 'component/skill.dart';
import 'controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileController(Get.find(), Get.find()),
      builder: (ProfileController c) {
        return ScreenSwitcher(
          tabs: [
            Screen(
              desktop: const Text('Attributes'),
              mobile: const Icon(Icons.person),
              child: ProfileAttributesTab(c),
            ),
            Screen(
              desktop: const Text('Inventory'),
              mobile: const Icon(Icons.inventory),
              child: ProfileInventoryTab(c),
            ),
            const Screen(
              desktop: Text('Constellation'),
              mobile: Icon(Icons.upgrade),
              child: Center(
                key: Key('Constellation'),
                child: Text('Constellation'),
              ),
            ),
            Screen(
              desktop: const Text('Skills'),
              mobile: const Icon(Icons.accessibility),
              child: ProfileSkillsTab(c),
            ),
          ],
        );
      },
    );
  }
}
