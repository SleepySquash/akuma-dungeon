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

/// Entity dealing damage to the [Player].
abstract class Enemy {
  Enemy();

  /// Unique ID of this [Enemy].
  String get id;

  /// Visible name of this [Enemy].
  String get name => id;

  /// Path to the asset representing this [Enemy].
  String get asset => name;

  /// Maximum health this [Enemy] has.
  int get hp => 10;

  /// Experience to give the [Player] upon slaying this [Enemy].
  int get exp => 1;

  /// Money to give the [Player] upon slaying this [Enemy].
  int get money => 10;

  double get damage => 0.05;
  Duration get interval => const Duration(seconds: 1);
}
