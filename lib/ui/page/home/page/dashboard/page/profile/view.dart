import 'package:akuma/router.dart';
import 'package:akuma/ui/widget/dummy_character.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            Row(
              children: [
                IconButton(
                  onPressed: router.settings,
                  icon: const Icon(Icons.settings),
                ),
                const Expanded(child: Center(child: Text('Party'))),
                IconButton(
                  onPressed: c.logout,
                  icon: const Icon(Icons.logout),
                )
              ],
            ),
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
