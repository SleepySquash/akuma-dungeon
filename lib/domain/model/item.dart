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

enum ArtifactType {
  flower,
  feather,
  watch,
  goblet,
  hat,
}

abstract class Artifact extends Item {
  const Artifact(super.count);

  @override
  String get asset => 'artifact/$id';

  /// Main [StatChance] of this [Artifact].
  ///
  /// [Artifact] is allowed to have only one main [Stat], so [Random] will
  /// choose exactly one [Stat].
  List<StatChance> get stat;

  /// Maximum number of additional [stats] this [Artifact] might have.
  int get maxStats => 1;

  /// Additional [StatChance]s of this [Artifact].
  ///
  /// [Artifact] is allowed to have maximum [maxStats] of these [Stat]s.
  List<StatChance> get stats => [
        StatChance(Stat.hp(1), 1),
        StatChance(Stat.hpPercent(1), 1),
        StatChance(Stat.def(1), 1),
        StatChance(Stat.defPercent(1), 1),
        StatChance(Stat.atk(1), 1),
        StatChance(Stat.atkPercent(1), 1),
        StatChance(Stat.critDamage(1), 1),
        StatChance(Stat.critRate(1), 1),
        StatChance(Stat.ult(1), 1),
        StatChance(Stat.ultPercent(1), 1),
      ];

  @override
  int? get max => 1;

  String? get set => null;

  /// Maximum allowed level for an [Artifact] to have.
  static const int maxLevel = 100;

  List<int> get levels =>
      List.generate(maxLevel + 1, (i) => (1000 + i * 2000).floor());
}

mixin Flower on Artifact {}
mixin Feather on Artifact {}
mixin Watch on Artifact {}
mixin Goblet on Artifact {}
mixin Hat on Artifact {}

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

  List<int> get levels =>
      List.generate(maxLevel + 1, (i) => (1000 + i * 2000).floor());
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

  List<int> get levels =>
      List.generate(maxLevel + 1, (i) => (1000 + i * 2000).floor());
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

// TODO: Store [Stat]s
class MyEquipable extends MyItem {
  MyEquipable(
    Equipable equipable, {
    this.exp = 0,
    ItemId? id,
  }) : super(equipable, id: id, count: 1);

  int exp;

  int get level => (item as Equipable).levels.indexWhere((e) => exp < e) + 1;

  List<int> get defenses => (item as Equipable).defenses;
  List<int> get levels => (item as Equipable).levels;

  int get defense {
    int def = defenses[level];

    for (Stat s in stats(StatType.def)) {
      def += s.amount;
    }

    for (Stat s in stats(StatType.defPercent)) {
      double d = def * (1 + (s.amount / 100));
      def = d.floor();
    }

    return def;
  }

  List<Stat> stats(StatType type) {
    return [...(item as Equipable).stats].where((e) => e.type == type).toList();
  }
}

class MyWeapon extends MyItem {
  MyWeapon(
    Weapon weapon, {
    this.exp = 0,
    ItemId? id,
  }) : super(weapon, id: id, count: 1);

  int exp;

  int get level => (item as Weapon).levels.indexWhere((e) => exp < e) + 1;

  List<int> get damages => (item as Weapon).damages;
  List<int> get levels => (item as Weapon).levels;

  int get damage {
    int dmg = damages[level];

    for (Stat s in stats(StatType.atk)) {
      dmg += s.amount;
    }

    for (Stat s in stats(StatType.atkPercent)) {
      double d = dmg * (1 + (s.amount / 100));
      dmg = d.floor();
    }

    return dmg;
  }

  List<Stat> stats(StatType type) {
    return [...(item as Weapon).stats].where((e) => e.type == type).toList();
  }
}

class MyArtifact extends MyItem {
  MyArtifact(
    Artifact artifact, {
    this.exp = 0,
    Stat? stat,
    List<Stat>? stats,
    ItemId? id,
  }) : super(artifact, id: id, count: 1) {
    if (stat != null) {
      this.stat = stat;
    } else {
      this.stat = artifact.stat.resolve(1).first;
    }

    if (stats != null) {
      this.stats = stats;
    } else {
      this.stats = artifact.stat.resolve(artifact.maxStats);
    }
  }

  late Stat stat;
  late List<Stat> stats;

  int exp;

  int get level => (item as Artifact).levels.indexWhere((e) => exp < e) + 1;

  List<int> get levels => (item as Artifact).levels;
  List<Stat> get allStats => [stat, ...stats];
}
