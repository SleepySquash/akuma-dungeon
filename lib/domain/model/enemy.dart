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
import 'package:flutter/widgets.dart' show GlobalKey;
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'reward.dart';

/// Entity dealing damage to the [Player].
abstract class Enemy {
  const Enemy();

  /// Unique ID of this [Enemy].
  String get id => runtimeType.toString();

  /// Visible name of this [Enemy].
  String get name => id;

  /// Path to the asset representing this [Enemy].
  String get asset => name;
  String get ext => '.png';

  /// Maximum health this [Enemy] has.
  Decimal get hp => Decimal.fromInt(10);

  /// Experience to give the [Player] upon slaying this [Enemy].
  Decimal get exp => Decimal.one;

  /// Money to give the [Player] upon slaying this [Enemy].
  Decimal get money => Decimal.zero;

  /// Sounds to play when hitting this [Enemy].
  List<String>? get hitSounds => null;

  /// Sounds to play when slaying this [Enemy].
  List<String>? get slayedSounds => null;

  /// Sounds played by this [Enemy] over some time periods.
  List<String>? get idleSounds => null;

  List<Reward> get drops => [];

  Decimal get damage => Decimal.fromInt(1);
  Duration get interval => const Duration(seconds: 1);
}

class MyEnemy {
  MyEnemy(this.enemy, {Decimal? multiplier})
      : multiplier = multiplier ?? Decimal.one,
        hp = Rx(enemy.hp * (multiplier ?? Decimal.one));

  final GlobalKey globalKey = GlobalKey();
  final String key = const Uuid().v4();
  final Decimal multiplier;

  final Enemy enemy;

  final Rx<Decimal> hp;

  bool get isDead => hp.value <= Decimal.zero;

  Decimal get damage => enemy.damage * multiplier;
  Decimal get money => enemy.money * multiplier;
  Decimal get exp => enemy.exp * multiplier;
  Decimal get maxHp => enemy.hp * multiplier;

  void hit([Decimal? amount]) {
    hp.value -= (amount ?? Decimal.one);
  }
}
