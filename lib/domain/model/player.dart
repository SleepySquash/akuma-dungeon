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

import 'package:akuma/domain/model/character.dart';
import 'package:akuma/domain/model/gender.dart';
import 'package:akuma/domain/model/item.dart';
import 'package:akuma/domain/model/race.dart';
import 'package:akuma/domain/model_type_id.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'player.g.dart';

@HiveType(typeId: ModelTypeId.player)
class Player {
  Player({
    this.name = 'Player',
    this.race = Race.ningen,
    this.gender = Gender.female,
    this.exp = 0,
    this.money = 0,
    this.hp = 10,
    this.mp = 10,
    this.equipped = const [],
    this.party = const [],
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final Race race;

  @HiveField(2)
  final Gender gender;

  @HiveField(3)
  int exp;

  @HiveField(4)
  int money;

  @HiveField(5)
  int hp;

  @HiveField(6)
  int mp;

  @HiveField(7)
  List<Item> equipped;

  @HiveField(8)
  List<Character> party;
}
