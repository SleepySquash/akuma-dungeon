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

import 'package:akuma/domain/model/stat.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  test('StatChance resolves different stats', () {
    List<Stat> equalResolved = [
      StatChance(Stat.atk(Decimal.one)),
      StatChance(Stat.atkPercent(Decimal.one)),
      StatChance(Stat.def(Decimal.one)),
      StatChance(Stat.defPercent(Decimal.one)),
      StatChance(Stat.hp(Decimal.one)),
      StatChance(Stat.hpPercent(Decimal.one)),
      StatChance(Stat.critDamage(Decimal.one)),
      StatChance(Stat.critRate(Decimal.one)),
      StatChance(Stat.ult(Decimal.one)),
      StatChance(Stat.ultPercent(Decimal.one)),
    ].resolve(10);

    expect(
      equalResolved.length,
      equalResolved.map((e) => e.type).toSet().length,
    );
  });

  test('StatChance accounts chances', () {
    List<Stat> hp = [
      StatChance(Stat.atk(Decimal.one)),
      StatChance(Stat.atkPercent(Decimal.one)),
      StatChance(Stat.def(Decimal.one)),
      StatChance(Stat.defPercent(Decimal.one)),
      StatChance(Stat.hp(Decimal.one), 1000000),
      StatChance(Stat.hpPercent(Decimal.one)),
      StatChance(Stat.critDamage(Decimal.one)),
      StatChance(Stat.critRate(Decimal.one)),
      StatChance(Stat.ult(Decimal.one)),
      StatChance(Stat.ultPercent(Decimal.one)),
    ].resolve(1);

    expect(
      hp.firstWhereOrNull((e) => e.type == StatType.hp) != null,
      true,
    );

    List<Stat> def = [
      StatChance(Stat.atk(Decimal.one)),
      StatChance(Stat.atkPercent(Decimal.one)),
      StatChance(Stat.def(Decimal.one), 1000000),
      StatChance(Stat.defPercent(Decimal.one)),
      StatChance(Stat.hp(Decimal.one)),
      StatChance(Stat.hpPercent(Decimal.one)),
      StatChance(Stat.critDamage(Decimal.one)),
      StatChance(Stat.critRate(Decimal.one)),
      StatChance(Stat.ult(Decimal.one)),
      StatChance(Stat.ultPercent(Decimal.one)),
    ].resolve(1);

    expect(
      def.firstWhereOrNull((e) => e.type == StatType.def) != null,
      true,
    );
  });

  test('StatChance edge cases', () {
    expect(<StatChance>[].resolve(10).length, 0);
    expect([StatChance(Stat.atk(Decimal.one))].resolve(10).length, 1);
    expect(
      [StatChance(Stat.atk(Decimal.one))].resolve(10).first.type ==
          StatType.atk,
      true,
    );
  });
}
