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

import '../character.dart';
import '/domain/model/rarity.dart';
import '/domain/model/skill.dart';

abstract class StandardCharacters {
  static List<Character> get characters => [
        Chiara(),
        DrNadja(),
        DrThomas(),
        Jan(),
        Magnus(),
        Rio(),
        Zahir(),
        Rozzi(),
      ];
}

class Zahir extends Character {
  @override
  String get id => 'Zahir';

  @override
  Role get role => Role.dps;
}

class Rio extends Character {
  @override
  String get id => 'Rio';

  @override
  Role get role => Role.dps;

  @override
  Rarity get rarity => Rarity.superRare;
}

class Jan extends Character {
  @override
  String get id => 'Jan';

  @override
  Role get role => Role.tank;

  @override
  Rarity get rarity => Rarity.rare;
}

class DrNadja extends Character {
  @override
  String get id => 'Dr._Nadja';

  @override
  String get name => 'Dr. Nadja';

  @override
  Role get role => Role.support;

  @override
  Rarity get rarity => Rarity.superRare;

  @override
  List<Skill> get skills => [Healing(amount: 10)];
}

class DrThomas extends Character {
  @override
  String get id => 'Dr._Thomas';

  @override
  String get name => 'Dr. Thomas';

  @override
  Role get role => Role.support;

  @override
  List<Skill> get skills => [Healing(amount: 5)];
}

class Magnus extends Character {
  @override
  String get id => 'Magnus';

  @override
  Role get role => Role.tank;
}

class Chiara extends Character {
  @override
  String get id => 'Chiara';

  @override
  Role get role => Role.support;

  @override
  Rarity get rarity => Rarity.ultraRare;

  @override
  List<Skill> get skills => [Healing(amount: 60)];
}

class Rozzi extends Character {
  @override
  String get id => 'Rozzi';

  @override
  Role get role => Role.dps;

  @override
  Rarity get rarity => Rarity.rare;
}