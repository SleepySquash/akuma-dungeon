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

import '/domain/model/enemy.dart';
import 'slime/d.dart';
import 'slime/e.dart';
import 'slime/f.dart';

abstract class SlimeEnemies {
  static List<Enemy> get all => [
        ...enemies,
        ...unique,
      ];

  static List<Enemy> get enemies => [
        ...f,
        ...e,
        ...d,
      ];

  static List<Enemy> get unique => [
        ...fPlus,
        ...ePlus,
      ];

  static List<Enemy> get f => const [
        GreenSlimeEnemy(),
        BlueSlimeEnemy(),
        RedSlimeEnemy(),
        CatSlimeEnemy(),
      ];

  static List<Enemy> get fPlus => const [
        RedLongSlimeEnemy(),
      ];

  static List<Enemy> get e => const [
        ChickenSlime(),
        DendroSlime(),
        DirtSlime(),
        FireSlime(),
        GemSlime(),
        GoldSlime(),
        GooSlime(),
        IceSlime(),
        MoneySlime(),
        PlanetSlime(),
        SlimeGroup(),
        SparkSlime(),
        ThunderSlime(),
      ];

  static List<Enemy> get ePlus => const [
        OctopusSlime(),
        VenomSlime(),
      ];

  static List<Enemy> get d => const [
        CatSlimeChan(),
        DirtSlimeChan(),
        FlyingSlimeChan(),
        IceSlimeChan(),
        LavaSlimeChan(),
      ];
}

abstract class Slime extends Enemy {
  const Slime();

  @override
  String get asset => 'slime/$id';

  @override
  List<String>? get hitSounds => [
        'sound/slime1.mp3',
        'sound/slime2.wav',
      ];

  @override
  List<String>? get slayedSounds => null;
}
