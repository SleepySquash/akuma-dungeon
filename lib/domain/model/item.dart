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

import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '/domain/model_type_id.dart';
import '/util/new_type.dart';
import 'rarity.dart';
import 'stat.dart';

part 'item.g.dart';

/// Entity in the [Player]'s inventory.
abstract class Item {
  const Item([this.count = 1]);

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
  Decimal? get max => null;

  Decimal? get price => Decimal.fromInt(100);

  /// Amount of this [Item].
  final int count;
}

@HiveType(typeId: ModelTypeId.itemId)
class ItemId extends NewType<String> {
  const ItemId(super.val);
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
  ///
  /// This [Stat] is constrained, meaning its min and max values can be
  /// balanced.
  List<StatChance> get stat;

  /// Maximum number of additional [stats] this [Artifact] might have.
  int get maxStats => 1;

  /// Additional [StatChance]s of this [Artifact].
  ///
  /// [Artifact] is allowed to have maximum [maxStats] of these [Stat]s.
  ///
  /// These [Stat]s are not constrained, meaning no balancing is possible.
  List<StatChance> get stats => [
        StatChance(Stat.hp(Decimal.one), 1),
        StatChance(Stat.hpPercent(Decimal.one), 1),
        StatChance(Stat.def(Decimal.one), 1),
        StatChance(Stat.defPercent(Decimal.one), 1),
        StatChance(Stat.atk(Decimal.one), 1),
        StatChance(Stat.atkPercent(Decimal.one), 1),
        StatChance(Stat.critDamage(Decimal.one), 1),
        StatChance(Stat.critRate(Decimal.one), 1),
        StatChance(Stat.ult(Decimal.one), 1),
        StatChance(Stat.ultPercent(Decimal.one), 1),
      ];

  @override
  Decimal? get max => Decimal.one;

  String? get set => null;

  /// Maximum allowed level for an [Artifact] to have.
  static const int maxLevel = 100;

  List<Decimal> get levels =>
      List.generate(maxLevel, (i) => (1000 + i * 2000).toDecimal());
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

  Decimal get defense => Decimal.one;

  List<Stat> get stats => [];

  @override
  Decimal? get max => Decimal.one;

  /// Maximum allowed level for an [Equipable] to have.
  static const int maxLevel = 100;

  List<Decimal> get levels =>
      List.generate(maxLevel, (i) => (1000 + i * 2000).toDecimal());

  List<Decimal> get defenses => List.generate(
        maxLevel,
        (i) => defense * (Decimal.fromInt(i) + Decimal.one),
      );
}

mixin Head on Equipable {}
mixin Armor on Equipable {}
mixin Shoes on Equipable {}
mixin Shield on Equipable {}

abstract class Weapon extends Item {
  const Weapon(super.count);

  @override
  String get asset => 'weapon/$id';

  Decimal get damage => Decimal.one;

  List<Stat> get stats => [];

  @override
  Decimal? get max => Decimal.one;

  /// Maximum allowed level for a [Weapon] to have.
  static const int maxLevel = 100;

  List<Decimal> get levels =>
      List.generate(maxLevel, (i) => (1000 + i * 2000).toDecimal());

  List<Decimal> get damages => List.generate(
        maxLevel,
        (i) => damage * (Decimal.fromInt(i) + Decimal.one),
      );
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
  Decimal get hp => Decimal.zero;
}

/// [Item] drinkable by the [Player].
mixin Drinkable on Consumable {
  /// Health restored by consuming this [Item].
  Decimal get hp => Decimal.zero;
}

class MyItem {
  MyItem(
    this.item, {
    ItemId? id,
    Decimal? count,
  })  : count = count ?? Decimal.fromInt(item.count),
        id = id ??
            (item.max == null ? ItemId(item.id) : ItemId(const Uuid().v4()));

  final ItemId id;
  final Item item;

  Decimal count;
}

// TODO: Store [Stat]s
class MyEquipable extends MyItem {
  MyEquipable(
    Equipable super.equipable, {
    Decimal? exp,
    super.id,
  })  : exp = exp ?? Decimal.zero,
        super(count: Decimal.one);

  Decimal exp;

  Decimal get currentExp {
    if (level > 1) {
      return exp - levels[level - 1];
    }
    return exp;
  }

  Decimal? get nextExp {
    if (level <= Equipable.maxLevel) {
      if (level > 1) {
        return levels[level] - levels[level - 1];
      } else {
        return levels[level];
      }
    }

    return null;
  }

  int get level => (item as Equipable).levels.indexWhere((e) => exp < e);

  List<Decimal> get defenses => (item as Equipable).defenses;
  List<Decimal> get levels => (item as Equipable).levels;

  Decimal get defense {
    Decimal def = defenses[level];

    for (Stat s in stats(StatType.def)) {
      def += s.amount;
    }

    for (Stat s in stats(StatType.defPercent)) {
      def *= (Decimal.one + (s.amount * Decimal.parse('0.01')));
    }

    return def;
  }

  List<Stat> stats(StatType type) {
    return [...(item as Equipable).stats].where((e) => e.type == type).toList();
  }
}

class MyWeapon extends MyItem {
  MyWeapon(
    Weapon super.weapon, {
    Decimal? exp,
    super.id,
  })  : exp = exp ?? Decimal.zero,
        super(count: Decimal.one);

  Decimal exp;

  Decimal get currentExp {
    if (level > 1) {
      return exp - levels[level - 1];
    }
    return exp;
  }

  Decimal? get nextExp {
    if (level <= Weapon.maxLevel) {
      if (level > 1) {
        return levels[level] - levels[level - 1];
      } else {
        return levels[level];
      }
    }

    return null;
  }

  int get level => (item as Weapon).levels.indexWhere((e) => exp < e);

  List<Decimal> get damages => (item as Weapon).damages;
  List<Decimal> get levels => (item as Weapon).levels;

  Decimal get damage {
    Decimal dmg = damages[level];

    for (Stat s in stats(StatType.atk)) {
      dmg += s.amount;
    }

    for (Stat s in stats(StatType.atkPercent)) {
      dmg *= (Decimal.one + (s.amount * Decimal.parse('0.01')));
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
    Decimal? exp,
    Stat? stat,
    List<Stat>? stats,
    ItemId? id,
  })  : exp = exp ?? Decimal.zero,
        super(artifact, id: id, count: Decimal.one) {
    if (stat != null) {
      this.stat = stat;
    } else {
      this.stat = artifact.stat.resolve(1).first;
    }

    this.stat.amount =
        this.stat.constrain(level, Artifact.maxLevel, artifact.rarity);

    if (stats != null) {
      this.stats = stats;
    } else {
      int i = artifact.rarity.index ~/ 2;
      while (i < artifact.maxStats && Random().nextBool()) {
        ++i;
      }
      this.stats = artifact.stats.resolve(min(artifact.maxStats, i));
    }
  }

  late Stat stat;
  late List<Stat> stats;

  Decimal exp;

  Decimal get currentExp {
    if (level > 1) {
      return exp - levels[level - 1];
    }
    return exp;
  }

  Decimal? get nextExp {
    if (level <= Artifact.maxLevel) {
      if (level > 1) {
        return levels[level] - levels[level - 1];
      } else {
        return levels[level];
      }
    }

    return null;
  }

  int get level => (item as Artifact).levels.indexWhere((e) => exp < e);

  List<Decimal> get levels => (item as Artifact).levels;
  List<Stat> get allStats => [stat, ...stats];
}
