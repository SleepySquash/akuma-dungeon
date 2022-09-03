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

import 'package:hive_flutter/hive_flutter.dart';

import '/domain/model_type_id.dart';
import '/domain/model/item/all.dart';
import '/domain/model/item.dart';
import 'base.dart';

/// [Hive] storage for the [MyItem]s.
class ItemHiveProvider extends HiveBaseProvider<MyItem> {
  @override
  Stream<BoxEvent> get boxEvents => box.watch();

  @override
  String get boxName => 'item';

  /// Returns a list of [MyItem]s from the [Hive].
  Iterable<MyItem> get items => valuesSafe;

  @override
  void registerAdapters() {
    Hive.maybeRegisterAdapter(ItemIdAdapter());
    Hive.maybeRegisterAdapter(MyItemAdapter());
  }

  /// Puts the provided [MyItem] to the [Hive].
  Future<void> put(MyItem item) => putSafe(item.id.val, item);

  /// Returns the stored [Item] from the [Hive].
  MyItem? get(ItemId id) => getSafe(id.val);

  /// Removes the stored [Item] from the [Hive].
  Future<void> remove(ItemId id) => deleteSafe(id.val);
}

class MyItemAdapter extends TypeAdapter<MyItem> {
  @override
  final typeId = ModelTypeId.item;

  @override
  MyItem read(BinaryReader reader) {
    final ItemId id = ItemId(reader.read() as String);
    final String type = reader.read() as String;
    final String itemId = reader.read() as String;

    Item? item = Items.get(itemId);
    if (item == null) {
      // ignore: avoid_print
      print('Cannot find `Item` with id: $itemId');
      return MyItem(const NoopItem(0), count: 0);
    }

    if (type == 'MyWeapon') {
      final damage = reader.read() as int;
      return MyWeapon(
        item as Weapon,
        damage: damage,
        id: id,
      );
    } else if (type == 'MyEquipable') {
      final defense = reader.read() as int;
      return MyEquipable(
        item as Equipable,
        defense: defense,
        id: id,
      );
    } else {
      final count = reader.read() as int;
      return MyItem(item, id: id, count: count);
    }
  }

  @override
  void write(BinaryWriter writer, MyItem obj) {
    writer.write(obj.id.val);
    writer.write(obj.runtimeType.toString());
    writer.write(obj.item.id);

    if (obj is MyWeapon) {
      writer.write(obj.damage);
    } else if (obj is MyEquipable) {
      writer.write(obj.defense);
    } else {
      writer.write(obj.count);
    }
  }
}
