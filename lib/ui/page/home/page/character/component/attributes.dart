import 'package:akuma/ui/page/home/widget/backdrop_plate.dart';
import 'package:akuma/util/platform_utils.dart';
import 'package:flutter/material.dart';

import '../controller.dart';
import '/domain/model/character.dart';
import '/ui/page/home/widget/level.dart';
import '/ui/page/home/widget/stats.dart';

class CharacterAttributesTab extends StatelessWidget {
  const CharacterAttributesTab(this.c, {Key? key}) : super(key: key);

  final CharacterController c;

  @override
  Widget build(BuildContext context) {
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
                        (c.myCharacter?.character ?? c.character)
                            ?.role
                            .toIcon(),
                        size: 21,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            (c.myCharacter?.character ?? c.character)?.name ??
                                '...',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (c.myCharacter != null) ...[
                  LevelWidget(
                    exp: c.myCharacter!.exp,
                    level: c.myCharacter!.level,
                    levels: c.myCharacter!.character.levels,
                    maxLevel: Character.maxLevel,
                  ),
                  StatsWidget(
                    damage:
                        c.myCharacter?.character.damages[c.myCharacter!.level],
                    defense:
                        c.myCharacter?.character.defenses[c.myCharacter!.level],
                    health:
                        c.myCharacter?.character.healths[c.myCharacter!.level],
                    ultCharge: c.myCharacter?.character
                        .ultCharges[c.myCharacter!.level],
                  ),
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
