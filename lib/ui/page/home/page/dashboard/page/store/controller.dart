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

import 'package:akuma/domain/model/item.dart';
import 'package:akuma/ui/widget/item_grid.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/flag.dart';
import '/domain/model/item/all.dart';
import '/domain/model/location.dart';
import '/domain/repository/player.dart';
import '/domain/service/flag.dart';
import '/domain/service/item.dart';
import '/domain/service/location.dart';
import '/domain/service/player.dart';
import '/util/obs/obs.dart';

class StoreController extends GetxController {
  StoreController(
    this._flagService,
    this._playerService,
    this._itemService,
    this._locationService, {
    required this.tabController,
  });

  final TabController tabController;
  final RxBool eventTab = RxBool(false);

  final RxList<SelectedItem> selectedItems = RxList();
  final Rx<UniqueKey> itemsKey = Rx(UniqueKey());
  final Rx<InventoryCategory?> itemsCategory = Rx(null);

  late final RxList<Item> range;
  final Rx<Item?> selectedItem = Rx(null);

  final FlagService _flagService;
  final PlayerService _playerService;
  final ItemService _itemService;
  final LocationService _locationService;

  RxPlayer get player => _playerService.player;
  Decimal get money => _itemService.amount(const Dogecoin());
  Decimal get rubies => _itemService.amount(const Ruby());
  Decimal get heartCards => _itemService.amount(const HeartCard());
  RxObsMap<Flag, bool> get flags => _flagService.flags;
  RxObsMap<ItemId, Rx<MyItem>> get items => _itemService.items;

  Rx<MyLocation> get location => _locationService.location;

  @override
  void onInit() {
    range = RxList(const [
      PracticeOakSwordItem(),
      PracticeWillowSwordItem(),
      RedPotionSmallItem(),
      HelmetLightBronzeItem(),
      ChainmailBronzeItem(),
      BootItem(),
    ]);

    super.onInit();
  }

  void buy() {
    _itemService.take(
      ItemId((const Dogecoin()).id),
      selectedItem.value!.price!,
    );

    _itemService.add(selectedItem.value!);
  }

  void sell() {
    Decimal price = selectedItems.price;

    for (SelectedItem item in selectedItems) {
      _itemService.take(
        item.item.value.id,
        item.count,
      );
    }

    _itemService.add(const Dogecoin(), price);
  }
}

extension SelectedItemsExp on List<SelectedItem> {
  Decimal get price {
    return map(
      (e) {
        Decimal exp = Decimal.zero;
        if (e.item.value is MyWeapon) {
          exp = (e.item.value as MyWeapon).exp;
        } else if (e.item.value is MyEquipable) {
          exp = (e.item.value as MyEquipable).exp;
        } else if (e.item.value is MyArtifact) {
          exp = (e.item.value as MyArtifact).exp;
        }

        return ((exp * Decimal.parse('0.1'))).round() +
            (e.item.value.item.price! * Decimal.parse('0.3')).round() * e.count;
      },
    ).fold(Decimal.zero, (p, e) => p + e);
  }
}
