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

import 'package:akuma/domain/model/rarity.dart';
import 'package:akuma/domain/model/stat.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:log_me/log_me.dart';

void main() {
  void checkStat(StatType type) {
    const int first = 0;
    const int last = 100;

    final Stat stat = Stat(type);
    final int pad =
        stat.constrain(last, last, Rarity.values.last).toString().length;
    for (Rarity rarity in Rarity.values) {
      final String min = stat.constrain(first, last, rarity).toString();
      final String minNext = stat.constrain(first + 1, last, rarity).toString();
      final String maxPrev = stat.constrain(last - 1, last, rarity).toString();
      final String max = stat.constrain(last, last, rarity).toString();
      Log.info(
        '[${type.name}][${rarity.name.padRight(9)}] ${min.padLeft(pad)}, ${minNext.padLeft(pad)} -> ${maxPrev.padLeft(pad)}, $max',
      );
    }
  }

  test('ATK', () => checkStat(StatType.atk));
  test('ATK%', () => checkStat(StatType.atkPercent));
  test('DEF', () => checkStat(StatType.def));
  test('DEF%', () => checkStat(StatType.defPercent));
  test('HP', () => checkStat(StatType.hp));
  test('HP%', () => checkStat(StatType.hpPercent));
  test('Crit', () => checkStat(StatType.critDamage));
  test('Crit%', () => checkStat(StatType.critRate));
  test('ULT', () => checkStat(StatType.ult));
  test('ULT%', () => checkStat(StatType.ultPercent));
}
