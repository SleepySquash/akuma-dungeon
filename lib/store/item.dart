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

import 'dart:async';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/domain/model/item.dart';
import '/domain/repository/item.dart';
import '/provider/hive/item.dart';
import '/util/obs/obs.dart';

class ItemRepository extends DisposableInterface
    implements AbstractItemRepository {
  ItemRepository(this._itemHive);

  @override
  late final RxObsMap<String, Rx<MyItem>> items;

  final ItemHiveProvider _itemHive;

  StreamIterator<BoxEvent>? _localSubscription;

  @override
  void onInit() {
    for (var item in _itemHive.items) {
      if (item.item is ImpossibleItem) {
        _itemHive.remove(item.item.id);
      }
    }

    items = RxObsMap(
      Map.fromEntries(_itemHive.items.map((e) => MapEntry(e.id, Rx(e)))),
    );

    _initLocalSubscription();

    super.onInit();
  }

  @override
  void onClose() {
    _localSubscription?.cancel();
    super.onClose();
  }

  @override
  void add(Item item) {
    MyItem? existing = _itemHive.get(item.id);
    if (existing != null) {
      existing.count += item.count;
      _itemHive.put(existing);
    } else {
      if (item is Weapon) {
        _itemHive.put(MyWeapon(item));
      } else if (item is Equipable) {
        _itemHive.put(MyEquipable(item));
      } else {
        _itemHive.put(MyItem(item));
      }
    }
  }

  @override
  void update(MyItem item) => _itemHive.put(item);

  @override
  void take(String id, [int? amount]) {
    MyItem? existing = _itemHive.get(id);
    if (existing != null) {
      existing.count -= amount ?? existing.count;
      if (existing.count <= 0) {
        _itemHive.remove(id);
      } else {
        _itemHive.put(existing);
      }
    }
  }

  @override
  int amount(Item item) {
    MyItem? existing = _itemHive.get(item.id);
    return existing?.count ?? 0;
  }

  Future<void> _initLocalSubscription() async {
    _localSubscription = StreamIterator(_itemHive.boxEvents);
    while (await _localSubscription!.moveNext()) {
      BoxEvent e = _localSubscription!.current;
      if (e.deleted) {
        items.remove(e.key);
      } else {
        Rx<MyItem>? item = items[e.key];
        if (item == null) {
          items[e.key] = Rx(e.value);
        } else {
          item.value = e.value;
          item.refresh();
        }
      }
    }
  }
}
