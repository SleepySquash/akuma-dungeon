import 'package:flutter/material.dart';

import '../controller.dart';
import '/ui/page/home/widget/backdrop_plate.dart';
import '/ui/page/home/widget/skill.dart';

class CharacterSkillsTab extends StatelessWidget {
  const CharacterSkillsTab(this.c, {super.key});

  final CharacterController c;

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const Key('CharacterSkillsTab'),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                if ((c.myCharacter?.character.value.character ?? c.character)
                        ?.skills
                        .isEmpty !=
                    false)
                  const BackdropPlate(child: Text('None yet!')),
                if (c.myCharacter != null)
                  ...c.myCharacter!.character.value.skills.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: SkillWidget(mySkill: e),
                    ),
                  ),
                if (c.character != null && c.myCharacter == null)
                  ...c.character!.skills.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: SkillWidget(skill: e),
                    ),
                  ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
