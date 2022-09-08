// Copyright © 2022 NIKITA ISAENKO, <https://github.com/SleepySquash>
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU Affero General Public License v3.0 as published by the
// Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License v3.0 for
// more details.
//
// You should have received a copy of the GNU Affero General Public License v3.0
// along with this program. If not, see
// <https://www.gnu.org/licenses/agpl-3.0.html>.

import 'package:akuma/domain/service/item.dart';
import 'package:akuma/util/obs/obs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/item.dart';
import '/ui/widget/item_grid.dart' show InventoryCategory, SelectedItem;

class ItemController extends GetxController {
  ItemController(
    this._itemService, {
    MyItem? myItem,
    Item? item,
    this.hero,
    this.exchangeItemSettings,
  })  : myItem = Rx(myItem),
        item = Rx(item);

  final String? hero;
  final Rx<MyItem?> myItem;
  final Rx<Item?> item;
  final ExchangeItemSettings? exchangeItemSettings;

  final RxList<SelectedItem> selectedItems = RxList();

  Rx<UniqueKey> enhanceKey = Rx(UniqueKey());

  final ItemService _itemService;

  RxObsMap<ItemId, Rx<MyItem>> get items => _itemService.items;

  EnhanceResult? enhance() {
    return _itemService.enhance(myItem.value!, selectedItems.exp);
  }
}

class ExchangeItemSettings {
  const ExchangeItemSettings({
    this.category,
    this.filter,
    this.onExchange,
  });

  final void Function(MyItem? item)? onExchange;
  final InventoryCategory? category;
  final Iterable<Rx<MyItem>> Function(Iterable<Rx<MyItem>> items)? filter;
}

extension SelectedItemsExp on List<SelectedItem> {
  int get exp {
    return map(
      (e) {
        int exp = 0;
        if (e.item.value is MyWeapon) {
          exp = (e.item.value as MyWeapon).exp;
        } else if (e.item.value is MyEquipable) {
          exp = (e.item.value as MyEquipable).exp;
        } else if (e.item.value is MyArtifact) {
          exp = (e.item.value as MyArtifact).exp;
        }

        return exp ~/ 2 + (100 + e.item.value.item.rarity.index * 400);
      },
    ).fold(0, (p, e) => p + e);
  }
}
