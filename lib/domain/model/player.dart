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

import '../model_type_id.dart';
import 'character.dart';
import 'gender.dart';
import 'item.dart';
import 'race.dart';
import 'stat.dart';

part 'player.g.dart';

@HiveType(typeId: ModelTypeId.player)
class Player {
  Player({
    this.name = 'Player',
    this.race = Race.ningen,
    this.gender = Gender.female,
    this.exp = 0,
    this.rank = 0,
    this.money = 0,
    List<MyEquipable>? equipped,
    List<MyWeapon>? weapon,
    List<MyCharacter>? party,
  })  : equipped = equipped ?? List.empty(growable: true),
        weapon = weapon ?? List.empty(growable: true),
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
  int money;

  @HiveField(6)
  List<MyEquipable> equipped;

  @HiveField(7)
  List<MyWeapon> weapon;

  @HiveField(8)
  List<MyCharacter> party;

  List<Stat> get stats {
    List<Stat> list = [];

    for (MyWeapon w in weapon) {
      list.addAll((w.item as Weapon).stats);
    }
    for (MyEquipable e in equipped) {
      list.addAll((e.item as Equipable).stats);
    }

    return list;
  }

  int get level => exp ~/ 1000 + 1;

  int get damage {
    int dmg = damages[level];

    for (MyWeapon w in weapon) {
      dmg += w.damage;
    }

    for (AtkStat s in stats.whereType<AtkStat>()) {
      dmg += s.amount;
    }

    for (AtkPercentStat s in stats.whereType<AtkPercentStat>()) {
      double d = dmg * (1 + (s.amount / 100));
      dmg = d.floor();
    }

    return dmg;
  }

  int get defense {
    int def = defenses[level];

    for (MyEquipable w in equipped) {
      def += w.defense;
    }

    for (DefStat s in stats.whereType<DefStat>()) {
      def += s.amount;
    }

    for (DefPercentStat s in stats.whereType<DefPercentStat>()) {
      double d = def * (1 + (s.amount / 100));
      def = d.floor();
    }

    return def;
  }

  int get health {
    int hp = healths[level];

    for (HpStat s in stats.whereType<HpStat>()) {
      hp += s.amount;
    }

    for (HpPercentStat s in stats.whereType<HpPercentStat>()) {
      double d = hp * (1 + (s.amount / 100));
      hp = d.floor();
    }

    return hp;
  }

  /// Maximum allowed level for a [Player] to have.
  static const int maxLevel = 100;

  List<int> get healths => List.generate(maxLevel + 1, (i) => 10 * i);
  List<int> get damages =>
      List.generate(maxLevel + 1, (i) => 1 * i + (i - 1) * 2);
  List<int> get defenses => List.generate(maxLevel + 1, (i) => 1 * i);
  List<int> get ultCharges =>
      List.generate(maxLevel + 1, (i) => (1 * i / 10).floor());
}
