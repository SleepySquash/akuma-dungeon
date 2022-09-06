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
import 'character.dart';
import 'gender.dart';
import 'item.dart';
import 'race.dart';

part 'player.g.dart';

@HiveType(typeId: ModelTypeId.player)
class Player {
  Player({
    this.name = 'Player',
    this.race = Race.ningen,
    this.gender = Gender.female,
    this.exp = 0,
    this.rank = 0,
    List<ItemId>? equipped,
    List<ItemId>? weapons,
    List<CharacterId>? party,
  })  : equipped = equipped ?? List.empty(growable: true),
        weapons = weapons ?? List.empty(growable: true),
        party = party ?? List.empty(growable: true);

  @HiveField(0)
  final String name;

  @HiveField(1)
  final Race race;

  @HiveField(2)
  final Gender gender;

  @HiveField(3)
  int exp;

  @HiveField(4)
  int rank;

  @HiveField(5)
  List<ItemId> equipped;

  @HiveField(6)
  List<ItemId> weapons;

  @HiveField(7)
  List<CharacterId> party;

  List<int> get levels =>
      List.generate(maxLevel + 1, (i) => (1000 + i * 2000).floor());
  int get level => levels.indexWhere((e) => exp < e) + 1;

  /// Maximum allowed level for a [Player] to have.
  static const int maxLevel = 100;

  List<int> get critDamages =>
      List.generate(maxLevel + 1, (i) => (1 * i / 10).floor());
  List<int> get critRates =>
      List.generate(maxLevel + 1, (i) => (1 * i / 10).floor());
  List<int> get damages =>
      List.generate(maxLevel + 1, (i) => 1 * i + (i - 1) * 2);
  List<int> get defenses => List.generate(maxLevel + 1, (i) => 1 * i);
  List<int> get healths => List.generate(maxLevel + 1, (i) => 10 * i);
  List<int> get ultCharges =>
      List.generate(maxLevel + 1, (i) => 4 + (1 * i / 10).floor());
}
