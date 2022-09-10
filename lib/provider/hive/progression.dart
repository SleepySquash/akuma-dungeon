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
import '/domain/model/progression.dart';
import 'base.dart';

/// [Hive] storage for a [Player].
class ProgressionHiveProvider extends HiveBaseProvider<GameProgression> {
  @override
  Stream<BoxEvent> get boxEvents => box.watch(key: 0);

  @override
  String get boxName => 'progression';

  @override
  void registerAdapters() {
    Hive.maybeRegisterAdapter(CharacterIdAdapter());
    Hive.maybeRegisterAdapter(GameProgressionAdapter());
  }

  /// Returns the stored [GameProgression] from the [Hive].
  GameProgression? get() => getSafe(0);

  /// Stores the provided [GameProgression] to the [Hive].
  Future<void> set(GameProgression progression) => putSafe(0, progression);
}
