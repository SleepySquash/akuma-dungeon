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
import '/domain/model/stat.dart';
import '/util/obs/obs.dart';

abstract class AbstractCharacterRepository {
  RxObsMap<CharacterId, RxMyCharacter> get characters;

  void add(MyCharacter character);
  void remove(CharacterId character);
  bool contains(CharacterId character);

  void equip(CharacterId id, MyItem item);
  void unequip(CharacterId id, MyItem item);

  void addExperience(CharacterId id, int amount);
}

abstract class RxMyCharacter {
  Rx<MyCharacter> get character;

  RxList<Rx<MyItem>> get artifacts;
  RxList<Rx<MyItem>> get weapons;

  List<int> get levels => character.value.character.levels;
  int get level => character.value.level;

  List<int> get healths => character.value.character.healths;
  List<int> get damages => character.value.character.damages;
  List<int> get defenses => character.value.character.defenses;
  // List<int> get critRates => character.value.character.critRates;
  // List<int> get critDamages => character.value.character.critDamages;
  List<int> get ultCharges => character.value.character.ultCharges;

  List<Stat> get stats {
    List<Stat> list = [];

    for (Rx<MyItem> w in weapons) {
      list.addAll((w.value.item as Weapon).stats);
    }
    for (Rx<MyItem> e in artifacts) {
      list.addAll((e.value.item as Artifact).stats);
    }

    return list;
  }

  int get damage {
    int dmg = damages[level];

    for (Rx<MyItem> w in weapons) {
      dmg += (w.value as MyWeapon).damage;
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
}
