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
                  Obx(() {
                    Rx<MyItem>? item = c.myCharacter!.artifacts
                        .where((e) => e.value.item is Flower)
                        .firstOrNull;
                    return EquipmentTile(
                      type: EquipmentTileType.flower,
                      item: item?.value,
                      onEquipped: (e) =>
                          e == null ? c.unequip(item!.value) : c.equip(e),
                    );
                  }),
                  Obx(() {
                    Rx<MyItem>? item = c.myCharacter!.artifacts
                        .where((e) => e.value.item is Feather)
                        .firstOrNull;
                    return EquipmentTile(
                      type: EquipmentTileType.feather,
                      item: item?.value,
                      onEquipped: (e) =>
                          e == null ? c.unequip(item!.value) : c.equip(e),
                    );
                  }),
                  Obx(() {
                    Rx<MyItem>? item = c.myCharacter!.artifacts
                        .where((e) => e.value.item is Watch)
                        .firstOrNull;
                    return EquipmentTile(
                      type: EquipmentTileType.watch,
                      item: item?.value,
                      onEquipped: (e) =>
                          e == null ? c.unequip(item!.value) : c.equip(e),
                    );
                  }),
                  Obx(() {
                    Rx<MyItem>? item = c.myCharacter!.artifacts
                        .where((e) => e.value.item is Goblet)
                        .firstOrNull;
                    return EquipmentTile(
                      type: EquipmentTileType.goblet,
                      item: item?.value,
                      onEquipped: (e) =>
                          e == null ? c.unequip(item!.value) : c.equip(e),
                    );
                  }),
                  Obx(() {
                    Rx<MyItem>? item = c.myCharacter!.artifacts
                        .where((e) => e.value.item is Hat)
                        .firstOrNull;
                    return EquipmentTile(
                      type: EquipmentTileType.hat,
                      item: item?.value,
                      onEquipped: (e) =>
                          e == null ? c.unequip(item!.value) : c.equip(e),
                    );
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
