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
import '/domain/model/character.dart';
import '/domain/model/character/all.dart';
import '/domain/model/item.dart';
import 'base.dart';

/// [Hive] storage for the [MyCharacter]s.
class CharacterHiveProvider extends HiveBaseProvider<MyCharacter> {
  @override
  Stream<BoxEvent> get boxEvents => box.watch();

  @override
  String get boxName => 'character';

  /// Returns the list of [MyCharacter]s from the [Hive].
  Iterable<MyCharacter> get items => valuesSafe;

  @override
  void registerAdapters() {
    Hive.maybeRegisterAdapter(CharacterIdAdapter());
    Hive.maybeRegisterAdapter(ItemIdAdapter());
    Hive.maybeRegisterAdapter(MyCharacterAdapter());
  }

  /// Puts the provided [MyCharacter] to the [Hive].
  Future<void> put(MyCharacter character) =>
      putSafe(character.id.val, character);

  /// Returns the stored [MyCharacter] from the [Hive].
  MyCharacter? get(CharacterId id) => getSafe(id.val);

  /// Indicates whether the provided [MyCharacter] is stored in the [Hive].
  bool contains(CharacterId id) => box.containsKey(id.val);

  /// Removes the stored [MyCharacter] from the [Hive].
  Future<void> remove(CharacterId id) => deleteSafe(id.val);
}

class MyCharacterAdapter extends TypeAdapter<MyCharacter> {
  @override
  final typeId = ModelTypeId.character;

  @override
  MyCharacter read(BinaryReader reader) {
    final String id = reader.read() as String;
    final int affinity = reader.read() as int;
    final int exp = reader.read() as int;

    List<ItemId> artifacts = [];
    final int artifactsLength = reader.read() as int;
    for (var i = 0; i < artifactsLength; ++i) {
      artifacts.add(ItemId(reader.read() as String));
    }

    List<ItemId> weapons = [];
    final int weaponsLength = reader.read() as int;
    for (var i = 0; i < weaponsLength; ++i) {
      weapons.add(ItemId(reader.read() as String));
    }

    return MyCharacter(
      character: Characters.get(id),
      affinity: affinity,
      artifacts: artifacts,
      weapons: weapons,
      exp: exp,
    );
  }

  @override
  void write(BinaryWriter writer, MyCharacter obj) {
    writer.write(obj.id.val);
    writer.write(obj.affinity);
    writer.write(obj.exp);

    writer.write(obj.artifacts.length);
    for (ItemId a in obj.artifacts) {
      writer.write(a.val);
    }

    writer.write(obj.weapons.length);
    for (ItemId a in obj.weapons) {
      writer.write(a.val);
    }
  }
}