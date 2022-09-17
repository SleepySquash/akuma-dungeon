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

import 'package:decimal/decimal.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/domain/model_type_id.dart';
import '/domain/model/impossible.dart';
import '/domain/model/item.dart';
import '/domain/model/item/all.dart';
import '/domain/model/stat.dart';
import '/util/log.dart';
import 'base.dart';

/// [Hive] storage for the [MyItem]s.
class ItemHiveProvider extends HiveBaseProvider<MyItem> {
  @override
  String get boxName => 'item';

  /// Returns a list of [MyItem]s from the [Hive].
  Iterable<MyItem> get items => valuesSafe;

  @override
  void registerAdapters() {
    Hive.maybeRegisterAdapter(DecimalAdapter());
    Hive.maybeRegisterAdapter(ItemIdAdapter());
    Hive.maybeRegisterAdapter(MyItemAdapter());
    Hive.maybeRegisterAdapter(StatAdapter());
    Hive.maybeRegisterAdapter(StatTypeAdapter());
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
      Log.print('[$runtimeType] Cannot find `Item` with id: $itemId');
      return MyItem(const ImpossibleItem(0), count: Decimal.zero);
    }

    if (type == 'MyWeapon') {
      final Decimal exp = reader.read() as Decimal;
      return MyWeapon(item as Weapon, exp: exp, id: id);
    } else if (type == 'MyEquipable') {
      final Decimal exp = reader.read() as Decimal;
      return MyEquipable(item as Equipable, exp: exp, id: id);
    } else if (type == 'MyArtifact') {
      final Decimal exp = reader.read() as Decimal;
      final Stat stat = reader.read() as Stat;
      final int statsLength = reader.read() as int;

      final List<Stat> stats = [];
      for (var i = 0; i < statsLength; ++i) {
        stats.add(reader.read() as Stat);
      }

      return MyArtifact(
        item as Artifact,
        exp: exp,
        stat: stat,
        stats: stats,
        id: id,
      );
    } else {
      final Decimal count = reader.read() as Decimal;
      return MyItem(item, id: id, count: count);
    }
  }

  @override
  void write(BinaryWriter writer, MyItem obj) {
    writer.write(obj.id.val);
    writer.write(obj.runtimeType.toString());
    writer.write(obj.item.id);

    if (obj is MyWeapon) {
      writer.write(obj.exp);
    } else if (obj is MyEquipable) {
      writer.write(obj.exp);
    } else if (obj is MyArtifact) {
      writer.write(obj.exp);
      writer.write(obj.stat);
      writer.write(obj.stats.length);
      for (Stat s in obj.stats) {
        writer.write(s);
      }
    } else {
      writer.write(obj.count);
    }
  }
}
