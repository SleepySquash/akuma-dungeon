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

import 'package:audioplayers/audioplayers.dart' show Source, AssetSource;

import '/domain/model/enemy.dart';
import '/domain/model/item/all.dart';
import '/domain/model/task.dart';

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
  int get hp => 10;

  @override
  int get exp => 1;

  @override
  int get money => 10;

  @override
  List<Source>? get hitSounds => [
        AssetSource('sound/slime1.mp3'),
        AssetSource('sound/slime2.wav'),
      ];

  @override
  List<Source>? get slayedSounds => null;

  @override
  List<TaskReward> get drops => [
        ChanceItemReward(const AppleGreenItem(), 0.4),
        ChanceItemReward(const Dogecoin(), 0.6),
        ChanceItemReward(const Ruby(), 0.1),
      ];

  @override
  double get damage => 1;
}

class GreenSlimeEnemy extends Slime {
  const GreenSlimeEnemy();

  @override
  String get id => 'Green Slime';
}

class BlueSlimeEnemy extends Slime {
  const BlueSlimeEnemy();

  @override
  String get id => 'Blue Slime';

  @override
  int get hp => 14;
}

class RedSlimeEnemy extends Slime {
  const RedSlimeEnemy();

  @override
  String get id => 'Red Slime';

  @override
  int get hp => 17;
}

class CatSlimeEnemy extends Slime {
  const CatSlimeEnemy();

  @override
  String get id => 'Cat Slime';

  @override
  int get money => 10;

  @override
  int get exp => 2;

  @override
  int get hp => 21;
}

class RedLongSlimeEnemy extends Slime {
  const RedLongSlimeEnemy();

  @override
  String get id => 'Red Long Slime';

  @override
  int get money => 20;

  @override
  int get exp => 5;

  @override
  int get hp => 50;
}

class ChickenSlime extends Slime {
  const ChickenSlime();

  @override
  String get id => 'Chicken Slime';

  @override
  int get hp => 17;
}

class DendroSlime extends Slime {
  const DendroSlime();

  @override
  String get id => 'Dendro Slime';

  @override
  int get hp => 17;
}

class DirtSlime extends Slime {
  const DirtSlime();

  @override
  String get id => 'Dirt Slime';

  @override
  int get hp => 17;
}

class FireSlime extends Slime {
  const FireSlime();

  @override
  String get id => 'Fire Slime';

  @override
  int get hp => 17;
}

class GemSlime extends Slime {
  const GemSlime();

  @override
  String get id => 'Gem Slime';

  @override
  int get hp => 17;
}

class GoldSlime extends Slime {
  const GoldSlime();

  @override
  String get id => 'Gold Slime';

  @override
  int get hp => 17;
}

class GooSlime extends Slime {
  const GooSlime();

  @override
  String get id => 'Goo Slime';

  @override
  int get hp => 17;
}

class IceSlime extends Slime {
  const IceSlime();

  @override
  String get id => 'Ice Slime';

  @override
  int get hp => 17;
}

class MoneySlime extends Slime {
  const MoneySlime();

  @override
  String get id => 'Money Slime';

  @override
  int get hp => 17;
}

class OctopusSlime extends Slime {
  const OctopusSlime();

  @override
  String get id => 'Octopus Slime';

  @override
  int get hp => 17;
}

class PlanetSlime extends Slime {
  const PlanetSlime();

  @override
  String get id => 'Planet Slime';

  @override
  int get hp => 17;
}

class SlimeGroup extends Slime {
  const SlimeGroup();

  @override
  String get id => 'Slime Group';

  @override
  int get hp => 17;
}

class SparkSlime extends Slime {
  const SparkSlime();

  @override
  String get id => 'Spark Slime';

  @override
  int get hp => 17;
}

class ThunderSlime extends Slime {
  const ThunderSlime();

  @override
  String get id => 'Thunder Slime';

  @override
  int get hp => 17;
}

class VenomSlime extends Slime {
  const VenomSlime();

  @override
  String get id => 'Venom Slime';

  @override
  int get hp => 17;
}

abstract class SlimeChan extends Slime {
  const SlimeChan();

  @override
  String get asset => 'slime/$id';

  @override
  int get hp => 2000;

  @override
  int get exp => 100;

  @override
  int get money => 100;

  @override
  List<Source>? get hitSounds => [
        AssetSource('voice/darknightprincess/ah.mp3'),
        AssetSource('voice/darknightprincess/oh.mp3'),
        AssetSource('voice/darknightprincess/woah.mp3'),
      ];

  @override
  List<Source>? get slayedSounds => null;

  @override
  double get damage => 100;
}

class CatSlimeChan extends SlimeChan {
  const CatSlimeChan();

  @override
  String get id => 'Cat Slime-chan';
}

class DirtSlimeChan extends SlimeChan {
  const DirtSlimeChan();

  @override
  String get id => 'Dirt Slime-chan';
}

class FlyingSlimeChan extends SlimeChan {
  const FlyingSlimeChan();

  @override
  String get id => 'Flying Slime-chan';
}

class IceSlimeChan extends SlimeChan {
  const IceSlimeChan();

  @override
  String get id => 'Ice Slime-chan';
}

class LavaSlimeChan extends SlimeChan {
  const LavaSlimeChan();

  @override
  String get id => 'Lava Slime-chan';
}
