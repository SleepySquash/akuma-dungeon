import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import '/domain/model/character.dart';
import '/domain/model/item.dart';
import '/ui/page/home/widget/equipment_tile.dart';
import '/ui/page/home/widget/stats.dart';
import '/util/platform_utils.dart';

class CharacterEquipmentTab extends StatelessWidget {
  const CharacterEquipmentTab(this.c, {Key? key}) : super(key: key);

  final CharacterController c;

  @override
  Widget build(BuildContext context) {
    MyCharacter? character = c.myCharacter?.character.value;

    return Center(
      key: const Key('CharacterEquipmentTab'),
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
                if (c.myCharacter != null) ...[
                  ...List.generate(5, (i) {
                    return Obx(() {
                      Rx<MyItem>? item = i < c.myCharacter!.artifacts.length
                          ? c.myCharacter!.artifacts[i]
                          : null;
                      return EquipmentTile(
                        type: EquipmentTileType.artifact,
                        item: item?.value,
                        onEquipped: (e) =>
                            e == null ? c.unequip(item!.value) : c.equip(e),
                      );
                    });
                  }),
                  Obx(() {
                    Rx<MyItem>? item = c.myCharacter!.weapons.firstOrNull;
                    return EquipmentTile(
                      type: EquipmentTileType.weapon,
                      item: item?.value,
                      onEquipped: (e) =>
                          e == null ? c.unequip(item!.value) : c.equip(e),
                    );
                  }),
                  if (character != null)
                    StatsWidget(
                      damage: character.character.damages[character.level],
                      defense: character.character.defenses[character.level],
                      health: character.character.healths[character.level],
                      ultCharge:
                          character.character.ultCharges[character.level],
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
