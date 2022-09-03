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

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '/domain/model_type_id.dart';
import '/util/new_type.dart';
import 'rarity.dart';
import 'stat.dart';

part 'item.g.dart';

/// Entity in the [Player]'s inventory.
abstract class Item {
  const Item(this.count);

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

  /// Maximum amount this [Item] can contain.
  int? get max => null;

  /// Amount of this [Item].
  final int count;
}

@HiveType(typeId: ModelTypeId.itemId)
class ItemId extends NewType<String> {
  const ItemId(String val) : super(val);
}

abstract class Artifact extends Item {
  const Artifact(super.count);

  @override
  String get asset => 'artifact/$id';

  List<Stat> get stats => [];

  @override
  int? get max => 1;

  /// Maximum allowed level for an [Artifact] to have.
  static const int maxLevel = 100;
}

/// [Item] equipable by the [Player].
abstract class Equipable extends Item {
  const Equipable(super.count);

  @override
  String get asset => 'equipable/$id';

  int get defense => 1;

  List<Stat> get stats => [];

  @override
  int? get max => 1;

  /// Maximum allowed level for an [Equipable] to have.
  static const int maxLevel = 100;

  List<int> get defenses => List.generate(maxLevel + 1, (i) => defense * i);
}

mixin Head on Equipable {}

mixin Armor on Equipable {}

mixin Shoes on Equipable {}

mixin Shield on Equipable {}

abstract class Weapon extends Item {
  const Weapon(super.count);

  @override
  String get asset => 'weapon/$id';

  int get damage => 1;

  List<Stat> get stats => [];

  @override
  int? get max => 1;

  /// Maximum allowed level for a [Weapon] to have.
  static const int maxLevel = 100;

  List<int> get damages => List.generate(maxLevel + 1, (i) => damage * i);
}

mixin Sword on Weapon {}
mixin Bow on Weapon {}
mixin Catalyst on Weapon {}
mixin BigSword on Weapon {}
mixin Dagger on Weapon {}

abstract class Consumable extends Item {
  const Consumable(super.count);

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

class MyItem {
  MyItem(
    this.item, {
    ItemId? id,
    int? count,
  })  : count = count ?? item.count,
        id = id ??
            (item.max == null ? ItemId(item.id) : ItemId(const Uuid().v4()));

  final ItemId id;
  final Item item;

  int count;
}

class MyEquipable extends MyItem {
  MyEquipable(
    Equipable equipable, {
    int? defense,
    this.level = 1,
    ItemId? id,
  })  : defense = defense ?? equipable.defense,
        super(equipable, id: id, count: 1);

  int level;

  int defense;
}

class MyWeapon extends MyItem {
  MyWeapon(
    Weapon weapon, {
    int? damage,
    this.level = 1,
    ItemId? id,
  })  : damage = damage ?? weapon.damage,
        super(weapon, id: id, count: 1);

  int level;

  int damage;
}

class MyArtifact extends MyItem {
  MyArtifact(
    Artifact artifact, {
    this.level = 1,
    ItemId? id,
  }) : super(artifact, id: id, count: 1);

  int level;
}
