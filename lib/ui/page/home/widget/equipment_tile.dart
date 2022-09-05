import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '/domain/model/impossible.dart';
import '/domain/model/item.dart';
import '/domain/model/rarity.dart';
import '/ui/page/home/page/item/controller.dart';
import '/ui/page/home/page/item/view.dart';
import '/ui/widget/backdrop.dart';
import '/ui/widget/item_grid.dart';
import '/ui/widget/item_selector/view.dart';

enum EquipmentTileType {
  artifact,
  weapon,
  head,
  armor,
  shoes,
}

class EquipmentTile extends StatelessWidget {
  const EquipmentTile({
    Key? key,
    this.type = EquipmentTileType.artifact,
    this.onEquipped,
    this.item,
  }) : super(key: key);

  final EquipmentTileType type;

  final MyItem? item;

  final void Function(MyItem?)? onEquipped;

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (item != null) {
      MyArtifact? artifact;
      MyWeapon? weapon;
      MyEquipable? equipable;

      switch (type) {
        case EquipmentTileType.artifact:
          artifact = item as MyArtifact;
          break;

        case EquipmentTileType.weapon:
          weapon = item as MyWeapon;
          break;

        case EquipmentTileType.head:
        case EquipmentTileType.armor:
        case EquipmentTileType.shoes:
          equipable = item as MyEquipable;
          break;
      }

      child = Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Transform.scale(
              scale: 2,
              child: Hero(
                tag: item!.id,
                child: Image.asset(
                  'assets/item/${item?.item.asset}.png',
                ),
              ),
            ),
          ),
          Row(
            children: [
              Flexible(flex: 2, child: Container()),
              Flexible(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: BorderedText(
                        strokeWidth: 6,
                        strokeColor: const Color(0xFF350047),
                        child: Text(
                          item?.item.name ?? '...',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: BorderedText(
                        strokeWidth: 6,
                        strokeColor: const Color(0xFF707070),
                        child: Text(
                          'Lv. ${artifact?.level ?? weapon?.level ?? equipable?.level}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      String title;
      switch (type) {
        case EquipmentTileType.artifact:
          title = 'Артефакт';
          break;

        case EquipmentTileType.weapon:
          title = 'Оружие';
          break;

        case EquipmentTileType.head:
          title = 'Головняк';
          break;

        case EquipmentTileType.armor:
          title = 'Броник';
          break;

        case EquipmentTileType.shoes:
          title = 'Обувка';
          break;
      }

      child = Row(
        children: [
          const SizedBox(width: 8),
          Icon(
            Icons.library_add,
            size: 42,
            color: Colors.black.withOpacity(0.7),
          ),
          const Spacer(),
          Text(title, style: const TextStyle(fontSize: 18))
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.all(4),
      child: Material(
        type: MaterialType.transparency,
        child: ConditionalBackdropFilter(
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () async {
              dynamic selected;
              if (item == null) {
                selected = await ItemSelector.show(
                  context: context,
                  empty: const ImpossibleItem(0),
                  category: type.toCategory(),
                  filter: type.toFilter(),
                );

                if (selected is Rx<MyItem>) {
                  onEquipped?.call(selected.value);
                } else if (selected is Impossible && item != null) {
                  onEquipped?.call(null);
                }
              } else {
                await ItemView.show(
                  context: context,
                  myItem: item!,
                  exchangeItemSettings: ExchangeItemSettings(
                    onExchange: onEquipped,
                    category: type.toCategory(),
                    filter: type.toFilter(),
                  ),
                );
              }
            },
            child: Container(
              width: 210,
              height: 80,
              decoration: BoxDecoration(
                color:
                    (item?.item.rarity.color ?? Colors.white).withOpacity(0.4),
              ),
              padding: const EdgeInsets.only(right: 8),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

extension EquipmentTileTypeConversions on EquipmentTileType {
  InventoryCategory? toCategory() {
    switch (this) {
      case EquipmentTileType.artifact:
        return InventoryCategory.artifact;

      case EquipmentTileType.weapon:
        return InventoryCategory.weapon;

      case EquipmentTileType.head:
      case EquipmentTileType.armor:
      case EquipmentTileType.shoes:
        return null;
    }
  }

  Iterable<Rx<MyItem>> Function(Iterable<Rx<MyItem>>)? toFilter() {
    switch (this) {
      case EquipmentTileType.artifact:
      case EquipmentTileType.weapon:
        return null;

      case EquipmentTileType.head:
        return (e) => e.where((e) => e.value.item is Head);

      case EquipmentTileType.armor:
        return (e) => e.where((e) => e.value.item is Armor);

      case EquipmentTileType.shoes:
        return (e) => e.where((e) => e.value.item is Shoes);
    }
  }
}
