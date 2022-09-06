import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import '/domain/model/character.dart';
import '/ui/page/home/widget/backdrop_plate.dart';
import '/ui/page/home/widget/level.dart';
import '/ui/page/home/widget/stats.dart';
import '/util/platform_utils.dart';

class CharacterAttributesTab extends StatelessWidget {
  const CharacterAttributesTab(this.c, {Key? key}) : super(key: key);

  final CharacterController c;

  @override
  Widget build(BuildContext context) {
    MyCharacter? character = c.myCharacter?.character.value;

    return Center(
      key: const Key('CharacterAttributesTab'),
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
                BackdropPlate(
                  child: Row(
                    children: [
                      Icon(
                        (character?.character ?? c.character)?.role.toIcon(),
                        size: 21,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            (character?.character ?? c.character)?.name ??
                                '...',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (character != null) ...[
                  LevelWidget(
                    exp: character.exp,
                    level: character.level,
                    levels: character.character.levels,
                    maxLevel: Character.maxLevel,
                  ),
                  Obx(() {
                    return StatsWidget(
                      damage: c.myCharacter?.damage,
                      defense: c.myCharacter?.defense,
                      health: c.myCharacter?.health,
                      critRate: c.myCharacter?.critRate,
                      critDamage: c.myCharacter?.critDamage,
                      ultCharge: c.myCharacter?.ultCharge,
                    );
                  }),
                ],
                if (!context.isMobile) const Spacer(),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
