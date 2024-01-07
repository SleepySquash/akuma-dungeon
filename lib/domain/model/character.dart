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
import 'package:flutter/material.dart' show IconData, Icons;
import 'package:hive/hive.dart';

import '/domain/model_type_id.dart';
import '/util/new_type.dart';
import 'item.dart';
import 'rarity.dart';
import 'skill.dart';

part 'character.g.dart';

/// Person in the [Player]'s party.
abstract class Character {
  const Character();

  /// Maximum allowed level for a [Character] to have.
  static const int maxLevel = 100;

  /// [Role] this [Character] has.
  Role get role => Role.dps;

  /// Unique ID of this [Character].
  String get id;

  /// Visible name of this [Character].
  String get name => id;

  /// Optional path to the asset representing this [Character].
  String? get asset => id;

  /// [Rarity] of this [Character].
  Rarity get rarity => Rarity.useful;

  /// [Skill]s this [Character] possess.
  List<Skill> get skills => [];

  List<Decimal> get levels =>
      List.generate(maxLevel, (i) => (1000 + i * 2000).toDecimal());

  List<Decimal> get critDamages =>
      List.generate(maxLevel, (i) => (1 * (i + 1) / 10).toDecimal());
  List<Decimal> get critRates =>
      List.generate(maxLevel, (i) => (1 * (i + 1) / 10).toDecimal());
  List<Decimal> get damages =>
      List.generate(maxLevel, (i) => Decimal.fromInt(5 * (i + 1) + i * 2));
  List<Decimal> get defenses =>
      List.generate(maxLevel, (i) => Decimal.fromInt(i + 1));
  List<Decimal> get healths =>
      List.generate(maxLevel, (i) => Decimal.fromInt(10 * (i + 1)));
  List<Decimal> get ultCharges =>
      List.generate(maxLevel, (i) => ((i + 1) / 10).toDecimal());
}

@HiveType(typeId: ModelTypeId.characterId)
class CharacterId extends NewType<String> {
  const CharacterId(super.val);
}

class MyCharacter {
  MyCharacter({
    required this.character,
    List<ItemId>? artifacts,
    List<ItemId>? weapons,
    List<MySkill>? skills,
    this.affinity = 0,
    Decimal? exp,
  })  : exp = exp ?? Decimal.zero,
        id = CharacterId(character.id),
        artifacts = artifacts ?? List.empty(growable: true),
        weapons = weapons ?? List.empty(growable: true),
        skills = skills ?? character.skills.map((e) => MySkill(e)).toList();

  final CharacterId id;

  /// [Character] itself.
  final Character character;

  /// [Artifact]s equipped to this [Character].
  final List<ItemId> artifacts;

  /// [Weapon]s equipped to this [Character].
  final List<ItemId> weapons;

  /// [MySkill]s this [MyCharacter] possess.
  final List<MySkill> skills;

  /// Integer representation of how much this [character] loves or respects you.
  int affinity;

  Decimal exp;

  Decimal get currentExp {
    if (level > 1) {
      return exp - levels[level - 1];
    }
    return exp;
  }

  Decimal? get nextExp {
    if (level <= Character.maxLevel) {
      if (level > 1) {
        return levels[level] - levels[level - 1];
      } else {
        return levels[level];
      }
    }

    return null;
  }

  int get level => levels.indexWhere((e) => exp < e);
  List<Decimal> get levels => character.levels;
}

/// Role a certain [Character] has in the battle.
enum Role {
  /// Dealing damage.
  dps,

  /// Taking and reducing damage.
  tank,

  /// Healing.
  support,
}

extension RoleToIcon on Role {
  IconData toIcon() {
    switch (this) {
      case Role.dps:
        return Icons.dangerous;

      case Role.tank:
        return Icons.shield;

      case Role.support:
        return Icons.healing;
    }
  }
}
