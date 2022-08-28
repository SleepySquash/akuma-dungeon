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

import '../enemy.dart';

abstract class FieldsEnemies {
  static List<Enemy> get all => [
        ...enemies,
        ...unique,
      ];

  static List<Enemy> get enemies => const [
        GreenSlimeEnemy(),
        BlueSlimeEnemy(),
        RedSlimeEnemy(),
        CatSlimeEnemy(),
      ];

  static List<Enemy> get unique => const [
        RedLongSlimeEnemy(),
      ];
}

abstract class Slime extends Enemy {
  const Slime();

  @override
  String get asset => 'slime/$id';

  @override
  List<Source>? get hitSounds => [
        AssetSource('sound/slime1.mp3'),
        AssetSource('sound/slime2.wav'),
      ];

  @override
  List<Source>? get slayedSounds => null;
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
  int get money => 50;

  @override
  int get exp => 10;

  @override
  int get hp => 60;
}
