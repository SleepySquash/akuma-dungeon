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
import 'package:get/get.dart';

import '/domain/model/character.dart';
import '/domain/model/item.dart';
import '/domain/model/player.dart';
import '/domain/model/stat.dart';
import 'character.dart';

abstract class AbstractPlayerRepository {
  RxPlayer get player;

  void set(Player player);
  void addExperience(Decimal amount);
  void addRank(Decimal amount);

  void equip(MyItem item);
  void unequip(MyItem item);
  void addToParty(MyCharacter character);
  void removeFromParty(MyCharacter character);
}

abstract class RxPlayer {
  Rx<Player> get player;

  RxList<RxMyCharacter> get party;

  RxList<Rx<MyItem>> get weapons;
  RxList<Rx<MyItem>> get equipped;

  List<Decimal> get levels => player.value.levels;
  int get level => player.value.level;
  Decimal get rank => player.value.rank;

  List<Decimal> get healths => player.value.healths;
  List<Decimal> get damages => player.value.damages;
  List<Decimal> get defenses => player.value.defenses;
  List<Decimal> get critRates => player.value.critRates;
  List<Decimal> get critDamages => player.value.critDamages;
  List<Decimal> get ultCharges => player.value.ultCharges;

  Decimal get critDamage {
    Decimal damage = critRates[level];

    for (Stat s in stats(StatType.critDamage)) {
      damage += s.amount;
    }

    return damage;
  }

  Decimal get critRate {
    Decimal rate = critRates[level];

    for (Stat s in stats(StatType.critRate)) {
      rate += s.amount;
    }

    return rate;
  }

  Decimal get damage {
    Decimal dmg = damages[level];

    for (Rx<MyItem> w in weapons) {
      dmg += (w.value as MyWeapon).damage;
    }

    for (Stat s in stats(StatType.atk)) {
      dmg += s.amount;
    }

    for (Stat s in stats(StatType.atkPercent)) {
      dmg *= (Decimal.one + (s.amount * Decimal.parse('0.01')));
    }

    return dmg;
  }

  Decimal get defense {
    Decimal def = defenses[level];

    for (Rx<MyItem> w in equipped) {
      def += (w.value as MyEquipable).defense;
    }

    for (Stat s in stats(StatType.def)) {
      def += s.amount;
    }

    for (Stat s in stats(StatType.defPercent)) {
      def *= (Decimal.one + (s.amount * Decimal.parse('0.01')));
    }

    return def;
  }

  Decimal get health {
    Decimal hp = healths[level];

    for (Stat s in stats(StatType.hp)) {
      hp += s.amount;
    }

    for (Stat s in stats(StatType.hpPercent)) {
      hp *= (Decimal.one + (s.amount * Decimal.parse('0.01')));
    }

    return hp;
  }

  Decimal get ultCharge {
    Decimal ult = ultCharges[level];

    for (Stat s in stats(StatType.ult)) {
      ult += s.amount;
    }

    for (Stat s in stats(StatType.ultPercent)) {
      ult *= (Decimal.one + (s.amount * Decimal.parse('0.01')));
    }

    return ult;
  }

  List<Stat> stats(StatType type) {
    List<Stat> list = [];

    for (Rx<MyItem> w in weapons) {
      list.addAll((w.value.item as Weapon).stats.where((e) => e.type == type));
    }
    for (Rx<MyItem> e in equipped) {
      list.addAll(
          (e.value.item as Equipable).stats.where((e) => e.type == type));
    }

    return list;
  }
}
