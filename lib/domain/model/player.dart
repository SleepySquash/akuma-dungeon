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

import 'package:akuma/util/extensions.dart';
import 'package:decimal/decimal.dart';
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
    Decimal? exp,
    Decimal? rank,
    List<ItemId>? equipped,
    List<ItemId>? weapons,
    List<CharacterId>? party,
  })  : exp = exp ?? Decimal.zero,
        rank = rank ?? Decimal.zero,
        equipped = equipped ?? List.empty(growable: true),
        weapons = weapons ?? List.empty(growable: true),
        party = party ?? List.empty(growable: true);

  @HiveField(0)
  final String name;

  @HiveField(1)
  final Race race;

  @HiveField(2)
  final Gender gender;

  @HiveField(3)
  Decimal exp;

  @HiveField(4)
  Decimal rank;

  @HiveField(5)
  List<ItemId> equipped;

  @HiveField(6)
  List<ItemId> weapons;

  @HiveField(7)
  List<CharacterId> party;

  Decimal get currentExp {
    if (level > 1) {
      return exp - levels[level - 1];
    }
    return exp;
  }

  Decimal? get nextExp {
    if (level <= Player.maxLevel) {
      if (level > 1) {
        return levels[level] - levels[level - 1];
      } else {
        return levels[level];
      }
    }

    return null;
  }

  List<Decimal> get levels =>
      List.generate(maxLevel, (i) => (1000 + i * 2000).toDecimal());
  int get level => levels.indexWhere((e) => exp < e);

  /// Maximum allowed level for a [Player] to have.
  static const int maxLevel = 100;

  List<Decimal> get critDamages =>
      List.generate(maxLevel, (i) => ((i + 1) / 10).toDecimal());
  List<Decimal> get critRates =>
      List.generate(maxLevel, (i) => ((i + 1) / 10).toDecimal());
  List<Decimal> get damages =>
      List.generate(maxLevel, (i) => Decimal.fromInt(i + 1));
  List<Decimal> get defenses =>
      List.generate(maxLevel, (i) => Decimal.fromInt(i + 1));
  List<Decimal> get healths =>
      List.generate(maxLevel, (i) => Decimal.fromInt(100 + 50 * i));
  List<Decimal> get ultCharges => List.generate(
        maxLevel,
        (i) => Decimal.fromInt(4) + (1 * (i + 1) / 10).toDecimal(),
      );
}
