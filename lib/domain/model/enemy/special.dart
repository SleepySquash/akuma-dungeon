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

abstract class SpecialEnemies {
  static List<Enemy> get all => [
        ...enemies,
        ...unique,
      ];

  static List<Enemy> get enemies => [];

  static List<Enemy> get unique => [
        ...akumaPlus,
      ];

  static List<Enemy> get akumaPlus => const [
        AkumaEnemy(),
      ];
}

class AkumaEnemy extends Enemy {
  const AkumaEnemy();

  @override
  String get id => 'Akuma';

  @override
  String get asset => 'special/$id';

  @override
  int get hp => 99999999999999999;

  @override
  int get exp => 100000;

  @override
  double get damage => 999999999;
}
