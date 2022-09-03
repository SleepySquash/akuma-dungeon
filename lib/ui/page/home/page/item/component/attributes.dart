import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import '/domain/model/item.dart';
import '/ui/page/home/widget/backdrop_plate.dart';
import '/ui/page/home/widget/level.dart';
import '/ui/page/home/widget/stats.dart';
import '/util/platform_utils.dart';

class ItemAttributesTab extends StatelessWidget {
  const ItemAttributesTab(this.c, {Key? key}) : super(key: key);

  final ItemController c;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      MyWeapon? weapon;
      MyEquipable? equipable;

      if (c.item.value is MyWeapon) {
        weapon = c.item.value as MyWeapon;
      } else if (c.item.value is MyEquipable) {
        equipable = c.item.value as MyEquipable;
      }

      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  BackdropPlate(
                    child:
                        Obx(() => Center(child: Text(c.item.value.item.name))),
                  ),
                  Obx(() {
                    if (c.item.value.item.description == null) {
                      return Container();
                    }

                    return BackdropPlate(
                      child: Obx(() =>
                          Center(child: Text(c.item.value.item.description!))),
                    );
                  }),
                  if (weapon != null || equipable != null) ...[
                    LevelWidget(
                      level: weapon?.level ?? equipable?.level ?? 1,
                      maxLevel: Weapon.maxLevel,
                    ),
                    StatsWidget(
                      damage: weapon?.damage,
                      defense: equipable?.defense,
                      stats: (weapon?.item as Weapon?)?.stats ??
                          (equipable?.item as Equipable?)?.stats ??
                          [],
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
    });
  }
}
