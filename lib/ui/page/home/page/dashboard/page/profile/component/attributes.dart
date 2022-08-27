import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import '/domain/model/item.dart';
import '/domain/model/rank.dart';
import '/domain/model/rarity.dart';
import '/domain/model/stat.dart';
import '/ui/page/home/widget/stats.dart';
import '/ui/widget/backdrop.dart';
import '/ui/widget/dummy_character.dart';
import '/ui/widget/item_grid.dart';
import '/ui/widget/item_selector/view.dart';
import '/util/platform_utils.dart';

class ProfileAttributesTab extends StatelessWidget {
  const ProfileAttributesTab(this.c, {Key? key}) : super(key: key);

  final ProfileController c;

  @override
  Widget build(BuildContext context) {
    Widget _equip({
      String? asset,
      required String title,
      List<Stat>? stats,
      Rarity? rarity,
      int? level,
      void Function()? onPressed,
    }) {
      return Container(
        margin: const EdgeInsets.fromLTRB(8, 4, 0, 4),
        child: Material(
          type: MaterialType.transparency,
          child: ConditionalBackdropFilter(
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: onPressed,
              child: Container(
                width: 210,
                height: 80,
                decoration: BoxDecoration(
                  color: (rarity?.color ?? Colors.white).withOpacity(0.4),
                ),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    if (asset == null)
                      const Icon(
                        Icons.library_add,
                        size: 42,
                        color: Colors.black,
                      )
                    else
                      Image.asset('assets/item/$asset.png'),
                    if (asset == null)
                      Expanded(
                        child: Center(
                          child: Text(
                            title,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: Center(
                          child: Text(
                            title,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget _name() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 0),
            child: ConditionalBackdropFilter(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                ),
                padding: const EdgeInsets.all(8),
                child: DefaultTextStyle.merge(
                  style: const TextStyle(fontSize: 18),
                  child: Text(c.player.value?.rank.toRank.name ?? '...'),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 0),
            child: ConditionalBackdropFilter(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                ),
                padding: const EdgeInsets.all(8),
                child: DefaultTextStyle.merge(
                  style: const TextStyle(fontSize: 18),
                  child: Text('Lv. ${c.player.value?.level ?? 0}'),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 8),
            child: ConditionalBackdropFilter(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                ),
                padding: const EdgeInsets.all(8),
                child: DefaultTextStyle.merge(
                  style: const TextStyle(fontSize: 18),
                  child: Text(c.player.value?.name ?? '...'),
                ),
              ),
            ),
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
              race: c.player.value!.race,
              gender: c.player.value!.gender,
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
                  MyEquipable? item = c.player.value?.equipped
                      .where((e) => e.item is Head)
                      .firstOrNull;
                  return _equip(
                    title: item?.item.name ?? 'Головняк',
                    asset: item?.item.asset,
                    rarity: item?.item.rarity,
                    level: item?.level,
                    stats: (item?.item as Equipable?)?.stats,
                    onPressed: () async {
                      var selected = await ItemSelector.show(
                        context: context,
                        empty: NoopItem(0),
                        filter: (e) => e.where((e) => e.value.item is Head),
                      );

                      if (selected is Rx<MyItem>) {
                        c.equip(selected.value);
                      } else if (selected is NoopItem && item != null) {
                        c.unequip(item);
                      }
                    },
                  );
                }),
                Obx(() {
                  MyEquipable? item = c.player.value?.equipped
                      .where((e) => e.item is Armor)
                      .firstOrNull;
                  return _equip(
                    title: item?.item.name ?? 'Броник',
                    asset: item?.item.asset,
                    rarity: item?.item.rarity,
                    level: item?.level,
                    stats: (item?.item as Equipable?)?.stats,
                    onPressed: () async {
                      var selected = await ItemSelector.show(
                        context: context,
                        empty: NoopItem(0),
                        filter: (e) => e.where((e) => e.value.item is Armor),
                      );

                      if (selected is Rx<MyItem>) {
                        c.equip(selected.value);
                      } else if (selected is NoopItem && item != null) {
                        c.unequip(item);
                      }
                    },
                  );
                }),
                _equip(
                  title: 'Обувка',
                  onPressed: () async {
                    await ItemSelector.show(
                      context: context,
                      filter: (e) => e.where((e) => e.value.item is Shoes),
                    );
                  },
                ),
                Obx(() {
                  MyWeapon? item = c.player.value?.weapon.firstOrNull;
                  return _equip(
                    title: item?.item.name ?? 'Оружие',
                    asset: item?.item.asset,
                    rarity: item?.item.rarity,
                    level: item?.level,
                    stats: (item?.item as Weapon?)?.stats,
                    onPressed: () async {
                      var selected = await ItemSelector.show(
                        context: context,
                        empty: NoopItem(0),
                        category: InventoryCategory.weapon,
                      );

                      if (selected is Rx<MyItem>) {
                        c.equip(selected.value);
                      } else if (selected is NoopItem && item != null) {
                        c.unequip(item);
                      }
                    },
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(() {
                      return StatsWidget(
                        damage: c.player.value?.damage,
                        defense: c.player.value?.defense,
                        health: c.player.value?.health,
                      );
                    }),
                    Flexible(child: _name()),
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
