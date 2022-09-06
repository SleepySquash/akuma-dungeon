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
      MyArtifact? artifact;
      int? maxLevel;

      if (c.myItem.value is MyWeapon) {
        maxLevel = Weapon.maxLevel;
        weapon = c.myItem.value as MyWeapon;
      } else if (c.myItem.value is MyEquipable) {
        maxLevel = Equipable.maxLevel;
        equipable = c.myItem.value as MyEquipable;
      } else if (c.myItem.value is MyArtifact) {
        maxLevel = Artifact.maxLevel;
        artifact = c.myItem.value as MyArtifact;
      }

      maxLevel ??= 1;

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
                    child: Obx(
                      () => Center(
                        child: Text(
                          c.myItem.value?.item.name ??
                              c.item.value?.name ??
                              '...',
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    if ((c.myItem.value?.item ?? c.item.value)?.description ==
                        null) {
                      return Container();
                    }

                    return BackdropPlate(
                      child: Obx(
                        () => Center(
                          child: Text(
                            (c.myItem.value?.item ?? c.item.value)!
                                .description!,
                          ),
                        ),
                      ),
                    );
                  }),
                  if (weapon != null ||
                      equipable != null ||
                      artifact != null) ...[
                    LevelWidget(
                      exp: weapon?.exp ?? equipable?.exp ?? artifact?.exp,
                      level: weapon?.level ??
                          equipable?.level ??
                          artifact?.level ??
                          1,
                      levels: weapon?.levels ??
                          equipable?.levels ??
                          artifact?.levels,
                      maxLevel: maxLevel,
                    ),
                    StatsWidget(
                      damage: weapon?.damage,
                      defense: equipable?.defense,
                      stats: (weapon?.item as Weapon?)?.stats ??
                          (equipable?.item as Equipable?)?.stats ??
                          (artifact)?.allStats ??
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
