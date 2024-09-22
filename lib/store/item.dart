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

import 'package:decimal/decimal.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/domain/model/impossible.dart';
import '/domain/model/item.dart';
import '/domain/repository/item.dart';
import '/provider/hive/item.dart';
import '/util/obs/obs.dart';

class ItemRepository extends DisposableInterface
    implements AbstractItemRepository {
  ItemRepository(this._itemHive);

  @override
  late final RxObsMap<ItemId, Rx<MyItem>> items;

  final ItemHiveProvider _itemHive;

  StreamIterator<BoxEvent>? _localSubscription;

  @override
  void onInit() {
    for (MyItem item in _itemHive.items.toList(growable: false)) {
      if (item.item is Impossible) {
        _itemHive.remove(item.id);
      }
    }

    items = RxObsMap(
      Map.fromEntries(
        _itemHive.items
            .toList(growable: false)
            .map((e) => MapEntry(e.id, Rx(e))),
      ),
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
  MyItem add(Item item, [Decimal? amount]) {
    Decimal count = (amount ?? Decimal.one) * Decimal.fromInt(item.count);
    MyItem? existing = _itemHive.get(ItemId(item.id));
    if (existing != null) {
      existing.count += count;
      items.emit(MapChangeNotification.updated(
        existing.id,
        existing.id,
        items[existing.id],
      ));

      items[existing.id]?.value = existing;
      _itemHive.put(existing);
    } else {
      if (item is Weapon) {
        existing = MyWeapon(item);
        _itemHive.put(existing);
      } else if (item is Equipable) {
        existing = MyEquipable(item);
        _itemHive.put(existing);
      } else if (item is Artifact) {
        existing = MyArtifact(item);
        _itemHive.put(existing);
      } else {
        existing = MyItem(item, count: count);
        _itemHive.put(existing);
      }

      items[existing.id] = Rx(existing);
    }

    return existing;
  }

  @override
  void update(MyItem item) {
    if (item is MyArtifact) {
      item.stat.amount =
          item.stat.constrain(item.level, Artifact.maxLevel, item.item.rarity);
    }
    _itemHive.put(item);
  }

  @override
  void take(ItemId id, [Decimal? amount]) {
    MyItem? existing = _itemHive.get(id);
    if (existing != null) {
      existing.count -= amount ?? existing.count;
      if (existing.count <= Decimal.zero) {
        _itemHive.remove(id);
      } else {
        _itemHive.put(existing);
      }

      items.emit(MapChangeNotification.updated(
        existing.id,
        existing.id,
        items[existing.id],
      ));
    }
  }

  @override
  Decimal amount(Item item) {
    MyItem? existing = _itemHive.get(ItemId(item.id));
    return existing?.count ?? Decimal.zero;
  }

  Future<void> _initLocalSubscription() async {
    _localSubscription = StreamIterator(_itemHive.boxEvents);
    while (await _localSubscription!.moveNext()) {
      BoxEvent e = _localSubscription!.current;
      if (e.deleted) {
        items.remove(ItemId(e.key));
      } else {
        Rx<MyItem>? item = items[ItemId(e.key)];
        if (item == null) {
          items[ItemId(e.key)] = Rx(e.value);
        } else {
          item.value = e.value;
          item.refresh();
        }
      }
    }
  }
}
