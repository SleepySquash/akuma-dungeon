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

/// [Hive] storage for the [Item]s.
class ItemHiveProvider extends HiveBaseProvider<Item> {
  @override
  Stream<BoxEvent> get boxEvents => box.watch();

  @override
  String get boxName => 'item';

  /// Returns a list of [Item]s from the [Hive].
  Iterable<Item> get items => valuesSafe;

  @override
  void registerAdapters() {
    Hive.maybeRegisterAdapter(ItemAdapter());
  }

  /// Puts the provided [Item] to the [Hive].
  Future<void> put(Item item) => putSafe(item.id, item);

  /// Returns the stored [Item] from the [Hive].
  Item? get(String id) => getSafe(id);

  /// Removes the stored [Item] from the [Hive].
  Future<void> remove(String id) => deleteSafe(id);
}

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final typeId = ModelTypeId.item;

  @override
  Item read(BinaryReader reader) {
    final id = reader.read() as String;
    final count = reader.read() as int;
    return Items.get(id)..count = count;
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer.write(obj.id);
    writer.write(obj.count);
  }
}
