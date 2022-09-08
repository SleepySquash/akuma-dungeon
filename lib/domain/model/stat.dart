import 'dart:math';

import 'package:akuma/domain/model/rarity.dart';
import 'package:collection/collection.dart';
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
  Stat(this.type, [this.amount = 1]);

  factory Stat.atk([int amount = 1]) => Stat(StatType.atk, amount);
  factory Stat.atkPercent([int amount = 1]) =>
      Stat(StatType.atkPercent, amount);
  factory Stat.critDamage([int amount = 1]) =>
      Stat(StatType.critDamage, amount);
  factory Stat.critRate([int amount = 1]) => Stat(StatType.critRate, amount);
  factory Stat.def([int amount = 1]) => Stat(StatType.def, amount);
  factory Stat.defPercent([int amount = 1]) =>
      Stat(StatType.defPercent, amount);
  factory Stat.hp([int amount = 1]) => Stat(StatType.hp, amount);
  factory Stat.hpPercent([int amount = 1]) => Stat(StatType.hpPercent, amount);
  factory Stat.ult([int amount = 1]) => Stat(StatType.ult, amount);
  factory Stat.ultPercent([int amount = 1]) =>
      Stat(StatType.ultPercent, amount);

  @HiveField(0)
  final StatType type;

  @HiveField(1)
  int amount;

  int constrain(int value, int max, Rarity rarity) {
    value = value + 1;

    switch (type) {
      case StatType.atk:
        return (1000 * (rarity.index / 2) * (value / max)).toInt();

      case StatType.atkPercent:
        return 1 + (40 * (rarity.index / 3) * (value / max)).toInt();

      case StatType.critDamage:
        return 1 + (50 * (rarity.index / 3) * (value / max)).toInt();

      case StatType.critRate:
        return 1 + (50 * (rarity.index / 3) * (value / max)).toInt();

      case StatType.def:
        return (1000 * (rarity.index / 2) * (value / max)).toInt();

      case StatType.defPercent:
        return 1 + (40 * (rarity.index / 3) * (value / max)).toInt();

      case StatType.hp:
        return (1000 * (rarity.index / 2) * (value / max)).toInt();

      case StatType.hpPercent:
        return 1 + (50 * (rarity.index / 3) * (value / max)).toInt();

      case StatType.ult:
        return (1000 * (rarity.index / 2) * (value / max)).toInt();

      case StatType.ultPercent:
        return 1 + (40 * (rarity.index / 3) * (value / max)).toInt();
    }
  }

  int improve(Rarity rarity) {
    int randomized(List<num> list) {
      return list.map((e) => e * rarity.index * 3).sample(1).first.toInt();
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
  int amount;
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
