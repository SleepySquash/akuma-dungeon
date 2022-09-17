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

import 'package:hive_flutter/adapters.dart';

import '/domain/model/character.dart';
import '/domain/model/gender.dart';
import '/domain/model/item.dart';
import '/domain/model/player.dart';
import '/domain/model/race.dart';
import '/provider/hive/character.dart';
import '/provider/hive/item.dart';
import 'base.dart';

/// [Hive] storage for a [Player].
class PlayerHiveProvider extends HiveBaseProvider<Player> {
  @override
  Stream<BoxEvent> get boxEvents => box.watch(key: 0);

  @override
  String get boxName => 'player';

  @override
  void registerAdapters() {
    Hive.maybeRegisterAdapter(DecimalAdapter());
    Hive.maybeRegisterAdapter(CharacterIdAdapter());
    Hive.maybeRegisterAdapter(GenderAdapter());
    Hive.maybeRegisterAdapter(ItemIdAdapter());
    Hive.maybeRegisterAdapter(MyCharacterAdapter());
    Hive.maybeRegisterAdapter(MyItemAdapter());
    Hive.maybeRegisterAdapter(PlayerAdapter());
    Hive.maybeRegisterAdapter(RaceAdapter());
  }

  /// Returns the stored [Player] from the [Hive].
  Player? get() => getSafe(0);

  /// Stores the provided [Player] to the [Hive].
  Future<void> set(Player player) => putSafe(0, player);
}
