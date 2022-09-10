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

import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';

import '/domain/model/skill.dart';

// TODO: Make generator generating `Map`: `{'id': Skill()}`.
abstract class Skills {
  static List<Skill> get all => [
        const HealingSkill(),
        const HittingSkill(),
        const ShieldSkill(),
      ];

  static Skill? get(String id) => all.firstWhereOrNull((e) => e.id == id);
}

abstract class CooldownSkill extends Skill {
  const CooldownSkill(this.cooldown);

  final Duration cooldown;

  List<Duration> get cooldowns => List.generate(
        Skill.maxLevel,
        (i) => Duration(milliseconds: cooldown.inMilliseconds - i * 5),
      );
}

class HealingSkill extends Skill with PrimarySkill {
  const HealingSkill({
    this.health = 1,
    this.period = const Duration(seconds: 1),
  });

  final int health;
  final Duration period;

  @override
  String get name => 'Лечение';

  List<int> get healths => List.generate(Skill.maxLevel, (i) => health + i);
  List<Duration> get periods => List.generate(
        Skill.maxLevel,
        (i) => Duration(milliseconds: period.inMilliseconds - i * 5),
      );
}

class HittingSkill extends Skill with PrimarySkill {
  const HittingSkill({
    this.damage = 20,
    this.period = const Duration(seconds: 1),
  });

  final int damage;
  final Duration period;

  @override
  String get name => 'Атака';

  List<int> get damages => List.generate(Skill.maxLevel, (i) => damage + i);
  List<Duration> get periods => List.generate(
        Skill.maxLevel,
        (i) => Duration(milliseconds: period.inMilliseconds - i * 5),
      );
}

class TankHittingSkill extends HittingSkill with PrimarySkill {
  const TankHittingSkill({
    super.damage = 20,
    super.period = const Duration(seconds: 1),
  });

  @override
  String get name => 'Атака';

  @override
  String get asset => 'HittingSkill';

  @override
  List<int> get damages => List.generate(
        Skill.maxLevel,
        (i) => damage + (i * 0.5).toInt(),
      );

  @override
  List<Duration> get periods => List.generate(
        Skill.maxLevel,
        (i) => Duration(milliseconds: period.inMilliseconds - i * 5),
      );
}

class ShieldSkill extends Skill with PrimarySkill {
  const ShieldSkill({this.shield = 10});

  final int shield;

  @override
  String get name => 'Защита';

  List<int> get shields => List.generate(Skill.maxLevel, (i) => shield + i);
}

class ProvocationSkill extends Skill with PrimarySkill {
  const ProvocationSkill({this.health = 10});

  final int health;

  @override
  String get name => 'Провокация';

  List<int> get healths => List.generate(Skill.maxLevel, (i) => health + i);
}

class SilentShotSkill extends CooldownSkill {
  const SilentShotSkill({
    this.damage = 100,
    this.count = 3,
    Duration cooldown = const Duration(seconds: 15),
  }) : super(cooldown);

  final int damage;
  final int count;

  @override
  String get name => 'Тихий выстрел';

  @override
  List<Source>? get sounds => [AssetSource('voice/Rozzi/skill.wav')];

  List<int> get damages => List.generate(Skill.maxLevel, (i) => damage + i);
  List<int> get counts =>
      List.generate(Skill.maxLevel, (i) => count + (i * 0.1).toInt());
}
