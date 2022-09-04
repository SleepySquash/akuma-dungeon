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
import '/domain/model/impossible.dart';
import '/domain/model/location.dart';
import '/domain/model/location/all.dart';
import '/util/log.dart';
import 'base.dart';

/// [Hive] storage for the [MyLocation]s.
class LocationHiveProvider extends HiveBaseProvider<MyLocation> {
  @override
  Stream<BoxEvent> get boxEvents => box.watch();

  @override
  String get boxName => 'location';

  /// Returns the list of [MyLocation]s from the [Hive].
  Iterable<MyLocation> get items => valuesSafe;

  @override
  void registerAdapters() {
    Hive.maybeRegisterAdapter(MyLocationAdapter());
  }

  /// Puts the provided [MyLocation] to the [Hive].
  Future<void> put(MyLocation location) => putSafe(location.id.val, location);

  /// Returns the stored [MyLocation] from the [Hive].
  MyLocation? get(LocationId id) => getSafe(id.val);

  /// Indicates whether the provided [MyLocation] is stored in the [Hive].
  bool contains(LocationId id) => box.containsKey(id.val);

  /// Removes the stored [MyLocation] from the [Hive].
  Future<void> remove(LocationId id) => deleteSafe(id.val);
}

class MyLocationAdapter extends TypeAdapter<MyLocation> {
  @override
  final typeId = ModelTypeId.location;

  @override
  MyLocation read(BinaryReader reader) {
    final String id = reader.read() as String;
    final Location? location = Locations.get(id);
    if (location == null) {
      Log.print('Cannot find `Location` with id: $id');
      return MyLocation(const ImpossibleLocation());
    }

    final int control = reader.read() as int;
    final int reputation = reader.read() as int;

    return MyLocation(
      location,
      control: control,
      reputation: reputation,
    );
  }

  @override
  void write(BinaryWriter writer, MyLocation obj) {
    writer.write(obj.id.val);
    writer.write(obj.control);
    writer.write(obj.reputation);
  }
}
