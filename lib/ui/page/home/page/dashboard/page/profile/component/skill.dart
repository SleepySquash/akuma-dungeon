import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import '/domain/service/player.dart';

class ProfileSkillsTab extends StatelessWidget {
  const ProfileSkillsTab(this.c, {Key? key}) : super(key: key);

  final ProfileController c;

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const Key('ProfileSkillsTab'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              Get.find<PlayerService>().addExperience(1000);
            },
            child: const Text('+1000 exp'),
          ),
          ElevatedButton(
            onPressed: () {
              var s = Get.find<PlayerService>();
              s.addExperience(-s.player.player.value.exp);
            },
            child: const Text('Reset to first level'),
          ),
        ],
      ),
      // child: Text('Skill'),
    );
  }
}
