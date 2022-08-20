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

import 'rarity.dart';

/// Entity in the [Player]'s inventory.
abstract class Item {
  Item(this.count);

  /// Unique [String] identifying this [Item].
  String get id => runtimeType.toString();

  /// Visible name of this [Item].
  String get name => id;

  /// Path to the asset representing this [Item].
  String get asset => id;

  /// Description of this [Item].
  String? get description => null;

  /// [Rarity] this [Item] has.
  Rarity get rarity => Rarity.common;

  /// Amount of this [Item].
  int count;
}

mixin Artifact on Item {}

/// [Item] equipable by the [Player].
mixin Equipable on Item {}

mixin Head on Equipable {
  int get defense => 1;
}

mixin Armor on Equipable {
  int get defense => 1;
}

mixin Shoes on Equipable {
  int get defense => 1;
}

mixin Weapon on Equipable {
  int get damage => 1;
}

mixin Shield on Equipable {
  int get defense => 1;
}

mixin Sword on Weapon {}
mixin Bow on Weapon {}
mixin Catalyst on Weapon {}
mixin BigSword on Weapon {}
mixin Dagger on Weapon {}

abstract class Consumable extends Item {
  Consumable(super.count);

  @override
  String get asset => 'consumable/$id';
}

mixin Giftable on Item {}

/// [Item] edible by the [Player].
mixin Eatable on Consumable {
  /// Hunger satisfied by consuming this [Item].
  int get hp => 0;
}

/// [Item] drinkable by the [Player].
mixin Drinkable on Consumable {
  /// Health restored by consuming this [Item].
  int get hp => 0;
}
