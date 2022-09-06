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

import 'package:get/get.dart';

import '/domain/model/character.dart';
import '/domain/model/item.dart';
import '/domain/model/player.dart';
import '/domain/model/stat.dart';
import 'character.dart';

abstract class AbstractPlayerRepository {
  RxPlayer get player;

  void set(Player player);
  void addExperience(int amount);
  void addRank(int amount);

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

  List<int> get levels => player.value.levels;
  int get level => player.value.level;

  List<int> get healths => player.value.healths;
  List<int> get damages => player.value.damages;
  List<int> get defenses => player.value.defenses;
  List<int> get critRates => player.value.critRates;
  List<int> get critDamages => player.value.critDamages;
  List<int> get ultCharges => player.value.ultCharges;

  int get critDamage {
    int damage = critRates[level];

    for (Stat s in stats(StatType.critDamage)) {
      damage += s.amount;
    }

    return damage;
  }

  int get critRate {
    int rate = critRates[level];

    for (Stat s in stats(StatType.critRate)) {
      rate += s.amount;
    }

    return rate;
  }

  int get damage {
    int dmg = damages[level];

    for (Rx<MyItem> w in weapons) {
      dmg += (w.value as MyWeapon).damage;
    }

    for (Stat s in stats(StatType.atk)) {
      dmg += s.amount;
    }

    for (Stat s in stats(StatType.atkPercent)) {
      double d = dmg * (1 + (s.amount / 100));
      dmg = d.floor();
    }

    return dmg;
  }

  int get defense {
    int def = defenses[level];

    for (Rx<MyItem> w in equipped) {
      def += (w.value as MyEquipable).defense;
    }

    for (Stat s in stats(StatType.def)) {
      def += s.amount;
    }

    for (Stat s in stats(StatType.defPercent)) {
      double d = def * (1 + (s.amount / 100));
      def = d.floor();
    }

    return def;
  }

  int get health {
    int hp = healths[level];

    for (Stat s in stats(StatType.hp)) {
      hp += s.amount;
    }

    for (Stat s in stats(StatType.hpPercent)) {
      double d = hp * (1 + (s.amount / 100));
      hp = d.floor();
    }

    return hp;
  }

  int get ultCharge {
    int ult = ultCharges[level];

    for (Stat s in stats(StatType.ult)) {
      ult += s.amount;
    }

    for (Stat s in stats(StatType.ultPercent)) {
      double d = ult * (1 + (s.amount / 100));
      ult = d.floor();
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
