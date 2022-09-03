import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import '/domain/model/item.dart';
import '/domain/model/player.dart';
import '/domain/model/rank.dart';
import '/ui/page/home/widget/equipment_tile.dart';
import '/ui/page/home/widget/level.dart';
import '/ui/page/home/widget/stats.dart';
import '/ui/widget/backdrop.dart';
import '/ui/widget/dummy_character.dart';
import '/util/platform_utils.dart';

class ProfileAttributesTab extends StatelessWidget {
  const ProfileAttributesTab(this.c, {Key? key}) : super(key: key);

  final ProfileController c;

  @override
  Widget build(BuildContext context) {
    Widget name() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(4),
            child: ConditionalBackdropFilter(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                ),
                padding: const EdgeInsets.all(8),
                child: DefaultTextStyle.merge(
                  style: const TextStyle(fontSize: 18),
                  child: Text(c.player.player.value.rank.toRank.name),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(4),
            child: ConditionalBackdropFilter(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                ),
                padding: const EdgeInsets.all(8),
                child: DefaultTextStyle.merge(
                  style: const TextStyle(fontSize: 18),
                  child: Text(c.player.player.value.name),
                ),
              ),
            ),
          ),
          LevelWidget(
            exp: c.player.player.value.exp,
            level: c.player.level,
            levels: c.player.levels,
            maxLevel: Player.maxLevel,
          ),
        ],
      );
    }

    return Stack(
      key: const Key('ProfileAttributesTab'),
      children: [
        Obx(() {
          return Align(
            alignment: FractionalOffset(context.isMobile ? 1 : 0.5, 0.5),
            child: DummyCharacter(
              race: c.player.player.value.race,
              gender: c.player.player.value.gender,
            ),
          );
        }),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (context.isMobile) const Spacer(),
                Obx(() {
                  Rx<MyItem>? item = c.player.equipped
                      .where((e) => e.value.item is Head)
                      .firstOrNull;
                  return EquipmentTile(
                    type: EquipmentTileType.head,
                    item: item?.value,
                    onEquipped: (e) =>
                        e == null ? c.unequip(item!.value) : c.equip(e),
                  );
                }),
                Obx(() {
                  Rx<MyItem>? item = c.player.equipped
                      .where((e) => e.value.item is Armor)
                      .firstOrNull;
                  return EquipmentTile(
                    type: EquipmentTileType.armor,
                    item: item?.value,
                    onEquipped: (e) =>
                        e == null ? c.unequip(item!.value) : c.equip(e),
                  );
                }),
                Obx(() {
                  Rx<MyItem>? item = c.player.equipped
                      .where((e) => e.value.item is Shoes)
                      .firstOrNull;
                  return EquipmentTile(
                    type: EquipmentTileType.shoes,
                    item: item?.value,
                    onEquipped: (e) =>
                        e == null ? c.unequip(item!.value) : c.equip(e),
                  );
                }),
                Obx(() {
                  Rx<MyItem>? item = c.player.weapons.firstOrNull;
                  return EquipmentTile(
                    type: EquipmentTileType.weapon,
                    item: item?.value,
                    onEquipped: (e) =>
                        e == null ? c.unequip(item!.value) : c.equip(e),
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(() {
                      return StatsWidget(
                        damage: c.player.damage,
                        defense: c.player.defense,
                        health: c.player.health,
                        critDamage: c.player.critDamage,
                        critRate: c.player.critRate,
                        ultCharge: c.player.ultCharge,
                      );
                    }),
                    Flexible(child: name()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
