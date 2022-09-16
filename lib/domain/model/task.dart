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

  Future<bool> criteriaMet({
    RxPlayer? player,
    GameProgression? progression,
    bool Function(String id)? isTaskCompleted,
    Future<CompletedTask?> Function(String id)? getCompleted,
  }) async {
    bool met = true;

    Future<bool> resolve(TaskCriteria c) async {
      if (c is OrCriteria) {
        for (TaskCriteria m in c.criteria) {
          bool result = await resolve(m);
          if (result) {
            return true;
          }
        }

        return false;
      } else if (c is LevelCriteria) {
        return (player?.level ?? 0) >= c.level;
      } else if (c is RankCriteria) {
        return (player?.rank ?? 0) >= c.rank.index;
      } else if (c is WeaponEquippedCriteria) {
        if (c.weapon == null) {
          return player?.weapons.isNotEmpty == true;
        } else {
          return player?.weapons
                  .firstWhereOrNull((e) => e.value.item.id == c.weapon!.id) !=
              null;
        }
      } else if (c is DungeonCommissionsCompletedCriteria) {
        return (progression?.dungeonsCleared ?? 0) >= c.amount;
      } else if (c is QuestCommissionsCompletedCriteria) {
        return (progression?.questsDone ?? 0) >= c.amount;
      } else if (c is NotCompletedCriteria) {
        return !(isTaskCompleted?.call((c.task ?? this).id) ?? false);
      } else if (c is CompletedCriteria) {
        bool met = (isTaskCompleted?.call((c.task ?? this).id) ?? false);
        if (met) {
          if (c.sinceFirst != null ||
              c.sinceLast != null ||
              c.noMoreThan != null) {
            CompletedTask? task = await getCompleted?.call((c.task ?? this).id);
            if (task != null) {
              if (c.sinceFirst != null) {
                met = met &&
                    DateTime.now().difference(task.completedAt) > c.sinceFirst!;
              } else if (c.sinceLast != null) {
                met = met &&
                    DateTime.now().difference(task.completedAt) > c.sinceLast!;
              } else if (c.noMoreThan != null) {
                met = met && task.count <= c.noMoreThan!;
              }
            } else {
              return false;
            }
          }
        }

        return met;
      } else {
        return true;
      }
    }

    for (TaskCriteria c in criteria) {
      met = met && await resolve(c);
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
    DateTime? updatedAt,
    this.count = 0,
  })  : completedAt = completedAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  final String id;
  final DateTime completedAt;
  DateTime updatedAt;
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
  final FutureOr<bool> Function() function;
}

abstract class TaskCriteria {
  const TaskCriteria();
}

class OrCriteria extends TaskCriteria {
  const OrCriteria(this.criteria);
  final List<TaskCriteria> criteria;
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

/// [TaskCriteria] whether the specified [task] has not been completed.
///
/// If [task] is `null`, this task will be used.
class NotCompletedCriteria extends TaskCriteria {
  const NotCompletedCriteria({this.task});
  final Task? task;
}

/// [TaskCriteria] whether the specified [task] has been completed.
///
/// If [task] is `null`, this task will be used.
///
/// [sinceFirst] may be specified to add requirement for the
/// [MyCommission.completedAt] difference with [DateTime.now] to exceed the
/// specified [sinceFirst].
///
/// [sinceLast] may be specified to add requirement for the
/// [MyCommission.updatedAt] difference with [DateTime.now] to exceed the
/// specified [sinceFirst].
class CompletedCriteria extends TaskCriteria {
  const CompletedCriteria({
    this.task,
    this.sinceFirst,
    this.sinceLast,
    this.noMoreThan,
  });
  final Task? task;
  final Duration? sinceFirst;
  final Duration? sinceLast;
  final int? noMoreThan;
}
