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
import 'package:hive/hive.dart';

import '/domain/model_type_id.dart';
import '/util/new_type.dart';

part 'skill.g.dart';

abstract class Skill {
  const Skill();

  static const maxLevel = 100;

  String get id => runtimeType.toString();
  String get asset => id;
  String get name => id;

  String? get description => null;

  /// Sounds to play when this [Skill] is activated.
  List<String>? get sounds => null;

  List<Decimal> get levels =>
      List.generate(maxLevel, (i) => (1000 + i * 2000).toDecimal());
}

@HiveType(typeId: ModelTypeId.itemId)
class SkillId extends NewType<String> {
  const SkillId(String val) : super(val);
}

mixin PrimarySkill on Skill {}

class MySkill {
  MySkill(
    this.skill, {
    Decimal? exp,
  })  : exp = exp ?? Decimal.zero,
        id = SkillId(skill.id);

  final Skill skill;

  Decimal exp;

  final SkillId id;

  List<Decimal> get levels => skill.levels;
  int get level => levels.indexWhere((e) => exp < e);
}
