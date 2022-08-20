import 'dart:async';

import 'package:akuma/domain/model/item.dart';
import 'package:flutter/material.dart' show IconData, Icons;
import 'package:novel/novel.dart';

import 'dungeon.dart';
import 'rank.dart';

abstract class Task {
  String get id;

  String get name => id;
  String? get description => null;
  IconData get icon => Icons.abc;

  Rank get rank => Rank.F;

  List<TaskStep> get steps;
  List<TaskReward> get rewards => const [
        MoneyReward(50),
        ExpReward(10),
        RankReward(1),
      ];
}

class MyTask {
  MyTask({
    required this.task,
    this.progress = 0,
  });

  final Task task;

  int progress;

  bool get isCompleted => progress >= task.steps.length;
}

abstract class TaskStep {
  const TaskStep();
}

class DungeonStep extends TaskStep {
  const DungeonStep(this.settings);
  final DungeonSettings settings;
}

class NovelStep extends TaskStep {
  const NovelStep(this.scenario);
  final List<Line> scenario;
}

class ExecuteStep extends TaskStep {
  const ExecuteStep(this.function);
  final FutureOr<void> Function() function;
}

abstract class TaskReward {
  const TaskReward();
}

class MoneyReward extends TaskReward {
  const MoneyReward(this.amount);
  final int amount;
}

class ExpReward extends TaskReward {
  const ExpReward(this.amount);
  final int amount;
}

class ItemReward extends TaskReward {
  const ItemReward(this.item);
  final Item item;
}

class RankReward extends TaskReward {
  const RankReward(this.amount);
  final int amount;
}
