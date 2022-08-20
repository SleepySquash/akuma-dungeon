import 'package:akuma/domain/model/enemy/fields.dart';
import 'package:collection/collection.dart';

import 'enemy.dart';

class DungeonStage {
  const DungeonStage({
    this.name,
    required this.enemies,
    this.conditions = const [],
    this.background,
    this.onPass,
  });

  final String? name;
  final List<Enemy> enemies;
  final List<NextStageCondition> conditions;
  final String? background;
  final void Function()? onPass;
}

/// [Dungeon] or [InfiniteDungeon].
abstract class DungeonSettings {
  const DungeonSettings();

  String? get background;
  DungeonStage? next();
}

class Dungeon extends DungeonSettings {
  Dungeon({
    required this.stages,
    this.background,
  });

  final List<DungeonStage> stages;

  @override
  final String? background;

  int _index = -1;

  @override
  DungeonStage? next() {
    ++_index;
    if (_index >= stages.length) {
      return null;
    }

    DungeonStage stage = stages[_index];
    return stage;
  }
}

abstract class NextStageCondition {}

class SlayedStageCondition implements NextStageCondition {
  const SlayedStageCondition(this.amount);
  final int amount;
}

class TimerStageCondition implements NextStageCondition {
  const TimerStageCondition(this.duration);
  final Duration duration;
}

class InfiniteDungeon extends DungeonSettings {
  InfiniteDungeon({
    required this.floor,
    this.onProgress,
  });

  int floor;

  final void Function()? onProgress;

  @override
  String? get background => null;

  bool boss = false;

  @override
  DungeonStage? next() {
    DungeonStage stage;

    if (boss) {
      boss = false;
      stage = DungeonStage(
        name: 'Поля - Босс ($floor-й этаж)',
        background: 'fields',
        enemies: FieldsEnemies.unique.sample(1),
        conditions: const [
          SlayedStageCondition(1),
          TimerStageCondition(Duration(seconds: 30)),
        ],
        onPass: () {
          floor++;
          onProgress?.call();
        },
      );
    } else {
      stage = DungeonStage(
        name: 'Поля ($floor-й этаж)',
        background: 'fields',
        enemies: FieldsEnemies.enemies,
        conditions: const [
          SlayedStageCondition(20),
          TimerStageCondition(Duration(seconds: 120)),
        ],
      );
    }

    boss = true;

    return stage;
  }
}
