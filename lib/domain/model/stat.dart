import 'dart:math';

import 'package:akuma/domain/model/rarity.dart';
import 'package:akuma/util/extensions.dart';
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/domain/model_type_id.dart';

part 'stat.g.dart';

@HiveType(typeId: ModelTypeId.statType)
enum StatType {
  @HiveField(0)
  atk,

  @HiveField(1)
  atkPercent,

  @HiveField(2)
  critDamage,

  @HiveField(3)
  critRate,

  @HiveField(4)
  def,

  @HiveField(5)
  defPercent,

  @HiveField(6)
  hp,

  @HiveField(7)
  hpPercent,

  @HiveField(8)
  ult,

  @HiveField(9)
  ultPercent,
}

@HiveType(typeId: ModelTypeId.stat)
class Stat {
  Stat(this.type, [Decimal? amount]) : amount = amount ?? Decimal.one;

  factory Stat.atk([Decimal? amount]) => Stat(StatType.atk, amount);
  factory Stat.atkPercent([Decimal? amount]) =>
      Stat(StatType.atkPercent, amount);
  factory Stat.critDamage([Decimal? amount]) =>
      Stat(StatType.critDamage, amount);
  factory Stat.critRate([Decimal? amount]) => Stat(StatType.critRate, amount);
  factory Stat.def([Decimal? amount]) => Stat(StatType.def, amount);
  factory Stat.defPercent([Decimal? amount]) =>
      Stat(StatType.defPercent, amount);
  factory Stat.hp([Decimal? amount]) => Stat(StatType.hp, amount);
  factory Stat.hpPercent([Decimal? amount]) => Stat(StatType.hpPercent, amount);
  factory Stat.ult([Decimal? amount]) => Stat(StatType.ult, amount);
  factory Stat.ultPercent([Decimal? amount]) =>
      Stat(StatType.ultPercent, amount);

  @HiveField(0)
  final StatType type;

  @HiveField(1)
  Decimal amount;

  Decimal constrain(int value, int max, Rarity rarity) {
    value = value + 1;

    switch (type) {
      case StatType.atk:
        return (1000 * (rarity.index / 2) * (value / max)).toDecimal();

      case StatType.atkPercent:
        return Decimal.one +
            (40 * (rarity.index / 3) * (value / max)).toDecimal();

      case StatType.critDamage:
        return Decimal.one +
            (50 * (rarity.index / 3) * (value / max)).toDecimal();

      case StatType.critRate:
        return Decimal.one +
            (50 * (rarity.index / 3) * (value / max)).toDecimal();

      case StatType.def:
        return (1000 * (rarity.index / 2) * (value / max)).toDecimal();

      case StatType.defPercent:
        return Decimal.one +
            (40 * (rarity.index / 3) * (value / max)).toDecimal();

      case StatType.hp:
        return (1000 * (rarity.index / 2) * (value / max)).toDecimal();

      case StatType.hpPercent:
        return Decimal.one +
            (50 * (rarity.index / 3) * (value / max)).toDecimal();

      case StatType.ult:
        return (1000 * (rarity.index / 2) * (value / max)).toDecimal();

      case StatType.ultPercent:
        return Decimal.one +
            (40 * (rarity.index / 3) * (value / max)).toDecimal();
    }
  }

  Decimal improve(Rarity rarity) {
    Decimal randomized(List<double> list) {
      return list.map((e) => e * rarity.index * 3).sample(1).first.toDecimal();
    }

    switch (type) {
      case StatType.atk:
        return randomized([0.3, 0.5, 1, 2]);

      case StatType.atkPercent:
        return randomized([1, 2, 3]);

      case StatType.critDamage:
        return randomized([1, 2, 3]);

      case StatType.critRate:
        return randomized([1, 2, 3]);

      case StatType.def:
        return randomized([0.3, 0.5, 1, 2]);

      case StatType.defPercent:
        return randomized([1, 2, 3]);

      case StatType.hp:
        return randomized([0.3, 0.5, 1, 2]);

      case StatType.hpPercent:
        return randomized([1, 2, 3]);

      case StatType.ult:
        return randomized([0.3, 0.5, 1, 2]);

      case StatType.ultPercent:
        return randomized([1, 2, 3]);
    }
  }
}

class StatChance {
  const StatChance(this.stat, [this.chance = 1]);
  final Stat stat;
  final double chance;
}

class StatTween {
  StatTween(this.stat, this.amount);

  factory StatTween.unchanged(Stat stat) => StatTween(stat, stat.amount);

  final Stat stat;
  Decimal amount;
}

extension ResolveStatChance on List<StatChance> {
  List<Stat> resolve(int i, [List<StatType> except = const []]) {
    if (i == 0) {
      return [];
    }

    final List<StatChance> list = List<StatChance>.from(this)
        .where((e) => except.firstWhereOrNull((m) => m == e.stat.type) == null)
        .toList();

    if (list.isEmpty) {
      return [];
    }

    final List<Stat> stats = [];
    for (int j = 0; j < i; ++j) {
      double weights = list.fold(0, (p, e) => p + e.chance);
      double chance = Random().nextDouble() * weights;

      Stat? stat;
      double weight = 0;
      for (int k = 0; k < list.length && stat == null; ++k) {
        StatChance c = list[k];

        if (chance >= weight && chance < weight + c.chance) {
          stat = c.stat;
          stats.add(stat);
          list.removeAt(k);
        }

        weight += c.chance;
      }
    }

    return stats;
  }
}

extension StatTypeLocalized on StatType {
  String get localized {
    switch (this) {
      case StatType.atk:
        return 'ATK';
      case StatType.atkPercent:
        return 'ATK%';
      case StatType.critDamage:
        return 'Crit DMG';
      case StatType.critRate:
        return 'Crit Rate';
      case StatType.def:
        return 'DEF';
      case StatType.defPercent:
        return 'DEF%';
      case StatType.hp:
        return 'HP';
      case StatType.hpPercent:
        return 'HP%';
      case StatType.ult:
        return 'ULT';
      case StatType.ultPercent:
        return 'ULT%';
    }
  }
}
