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

import '../character.dart';
import '/domain/model/rarity.dart';
import '/domain/model/skill.dart';
import '/domain/model/skill/all.dart';

abstract class StandardCharacters {
  static List<Character> get characters => const [
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

abstract class DpsCharacter extends Character {
  const DpsCharacter();

  @override
  Role get role => Role.dps;

  @override
  List<Skill> get skills => [
        HittingSkill(
          damage: Decimal.fromInt(20),
          period: const Duration(seconds: 1),
        )
      ];
}

abstract class TankCharacter extends Character {
  const TankCharacter();

  @override
  Role get role => Role.tank;

  @override
  List<Skill> get skills => [
        ShieldSkill(shield: Decimal.fromInt(10)),
        TankHittingSkill(
          damage: Decimal.fromInt(1),
          period: const Duration(seconds: 1),
        )
      ];
}

abstract class SupportCharacter extends Character {
  const SupportCharacter();

  @override
  Role get role => Role.support;

  @override
  List<Skill> get skills => [
        HealingSkill(
          health: Decimal.fromInt(1),
          period: const Duration(seconds: 2),
        )
      ];
}

class Zahir extends DpsCharacter {
  const Zahir();

  @override
  String get id => 'Zahir';
}

class Rio extends DpsCharacter {
  const Rio();

  @override
  String get id => 'Rio';

  @override
  Rarity get rarity => Rarity.superRare;
}

class Jan extends TankCharacter {
  const Jan();

  @override
  String get id => 'Jan';

  @override
  Rarity get rarity => Rarity.rare;
}

class DrNadja extends SupportCharacter {
  const DrNadja();

  @override
  String get id => 'Dr._Nadja';

  @override
  String get name => 'Dr. Nadja';

  @override
  Rarity get rarity => Rarity.superRare;

  @override
  List<Skill> get skills => [HealingSkill(health: Decimal.fromInt(10))];
}

class DrThomas extends SupportCharacter {
  const DrThomas();

  @override
  String get id => 'Dr._Thomas';

  @override
  String get name => 'Dr. Thomas';

  @override
  List<Skill> get skills => [HealingSkill(health: Decimal.fromInt(5))];
}

class Magnus extends TankCharacter {
  const Magnus();

  @override
  String get id => 'Magnus';

  @override
  List<Skill> get skills => [
        const ProvocationSkill(health: 1),
        TankHittingSkill(
          damage: Decimal.fromInt(1),
          period: const Duration(seconds: 1),
        )
      ];
}

class Chiara extends SupportCharacter {
  const Chiara();

  @override
  String get id => 'Chiara';

  @override
  Rarity get rarity => Rarity.ultraRare;

  @override
  List<Skill> get skills => [HealingSkill(health: Decimal.fromInt(60))];
}

class Rozzi extends DpsCharacter {
  const Rozzi();

  @override
  String get id => 'Rozzi';

  @override
  Rarity get rarity => Rarity.rare;

  @override
  List<Skill> get skills => [
        ...super.skills,
        SilentShotSkill(),
      ];
}
