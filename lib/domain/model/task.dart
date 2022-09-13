import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart' show IconData, Icons;
import 'package:novel/novel.dart';

import '/domain/repository/player.dart';
import 'dungeon.dart';
import 'executable.dart';
import 'item.dart';
import 'progression.dart';
import 'rank.dart';
import 'reward.dart';

abstract class Task {
  const Task();

  String get id => runtimeType.toString();

  String get name => id;
  String? get subtitle => null;
  String? get description => subtitle;
  String? get background => null;
  IconData get icon => Icons.abc;

  Rank get rank => Rank.F;
  int get level => 0;
  String? get location => null;

  List<TaskStep> get steps;

  List<Reward> get rewards => const [MoneyReward(50), ExpReward(10)];

  List<TaskCriteria> get criteria => const [];

  Duration? get timeout => null;

  bool criteriaMet({
    RxPlayer? player,
    GameProgression? progression,
    bool Function(String id)? isTaskCompleted,
  }) {
    bool met = true;

    for (var c in criteria) {
      if (c is LevelCriteria) {
        met = met && (player?.level ?? 0) >= c.level;
      } else if (c is RankCriteria) {
        met = met && (player?.rank ?? 0) >= c.rank.index;
      } else if (c is WeaponEquippedCriteria) {
        if (c.weapon == null) {
          met = met && player?.weapons.isNotEmpty == true;
        } else {
          met = met &&
              player?.weapons.firstWhereOrNull(
                      (e) => e.value.item.id == c.weapon!.id) !=
                  null;
        }
      } else if (c is DungeonCommissionsCompletedCriteria) {
        met = met && (progression?.dungeonsCleared ?? 0) >= c.amount;
      } else if (c is QuestCommissionsCompletedCriteria) {
        met = met && (progression?.questsDone ?? 0) >= c.amount;
      } else if (c is NotCompletedCriteria) {
        met = met && !(isTaskCompleted?.call(id) ?? false);
      } else if (c is CompletedCriteria) {
        met = met && (isTaskCompleted?.call(c.task.id) ?? false);
      }
    }

    return met;
  }
}

class MyTask extends ExecutableTask {
  MyTask({
    required this.task,
    this.progress = 0,
    DateTime? acceptedAt,
  }) : acceptedAt = acceptedAt ?? DateTime.now();

  @override
  final Task task;

  @override
  int progress;

  DateTime acceptedAt;
}

class CompletedTask {
  CompletedTask({
    required this.id,
    DateTime? completedAt,
    this.count = 0,
  }) : completedAt = completedAt ?? DateTime.now();

  final String id;
  final DateTime completedAt;
  int count;
}

abstract class TaskStep {
  const TaskStep();
}

class DungeonStep extends TaskStep {
  const DungeonStep(this.settings, {this.withEntrance = false});
  final DungeonSettings settings;
  final bool withEntrance;
}

class NovelStep extends TaskStep {
  const NovelStep(this.scenario);
  final List<Line> scenario;
}

class ExecuteStep extends TaskStep {
  const ExecuteStep(this.function);
  final FutureOr<void> Function() function;
}

abstract class TaskCriteria {
  const TaskCriteria();
}

class LevelCriteria extends TaskCriteria {
  const LevelCriteria(this.level);
  final int level;
}

class RankCriteria extends TaskCriteria {
  const RankCriteria(this.rank);
  final Rank rank;
}

class QuestCommissionsCompletedCriteria extends TaskCriteria {
  const QuestCommissionsCompletedCriteria(this.amount);
  final int amount;
}

class DungeonCommissionsCompletedCriteria extends TaskCriteria {
  const DungeonCommissionsCompletedCriteria(this.amount);
  final int amount;
}

/// `null` means any [Weapon] should be equipped.
class WeaponEquippedCriteria extends TaskCriteria {
  const WeaponEquippedCriteria(this.weapon);
  final Weapon? weapon;
}

class NotCompletedCriteria extends TaskCriteria {
  const NotCompletedCriteria();
}

class CompletedCriteria extends TaskCriteria {
  const CompletedCriteria(this.task);
  final Task task;
}
