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
}

@HiveType(typeId: ModelTypeId.itemId)
class SkillId extends NewType<String> {
  const SkillId(String val) : super(val);
}

mixin PrimarySkill on Skill {}

class MySkill {
  MySkill(
    this.skill, {
    this.exp = 0,
  }) : id = SkillId(skill.id);

  final Skill skill;

  int exp;

  final SkillId id;

  int get level => exp ~/ 1000;
}
