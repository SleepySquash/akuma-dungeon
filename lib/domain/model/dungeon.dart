import 'package:akuma/domain/model/enemy/fields.dart';
import 'package:collection/collection.dart';

import 'enemy.dart';

/// Single stage of a dungeon.
class DungeonStage {
  const DungeonStage({
    this.name,
    required this.enemies,
    this.conditions = const [],
    this.background,
    this.multiplier = 1,
    this.onPass,
  });

  final String? name;
  final List<Enemy> enemies;
  final List<NextStageCondition> conditions;
  final String? background;
  final double multiplier;
  final void Function()? onPass;
}

/// Collection of the [DungeonStage]es.
///
/// Implemented via [Dungeon] or [InfiniteDungeon].
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

/// Condition to move to the next [DungeonStage].
abstract class NextStageCondition {}

/// [NextStageCondition] of slaying the [amount] enemies.
class SlayedStageCondition implements NextStageCondition {
  const SlayedStageCondition(this.amount);
  final int amount;
}

/// [NextStageCondition] of completing the other conditions within the
/// [duration].
class TimerStageCondition implements NextStageCondition {
  const TimerStageCondition(this.duration);
  final Duration duration;
}

/// [DungeonSettings] of an infinite dungeon generating its [next] stage on the
/// fly.
///
/// Difficulty of the generated stage depends on the provided [floor] value.
class InfiniteDungeon extends DungeonSettings {
  InfiniteDungeon({
    required this.floor,
    this.onProgress,
  });

  /// Current floor of this [InfiniteDungeon].
  int floor;

  /// Callback, called when the [floor] increments.
  final void Function(int)? onProgress;

  @override
  String? get background => null;

  List<NextStageCondition> get _conditions {
    return const [
      SlayedStageCondition(20),
      TimerStageCondition(Duration(seconds: 120)),
    ];
  }

  List<NextStageCondition> get _bossConditions {
    return const [
      SlayedStageCondition(1),
      TimerStageCondition(Duration(seconds: 30)),
    ];
  }

  Dungeon _next(int floor, [double multiplier = 1]) {
    if (floor >= 6) {
      return _next(floor % 6, multiplier * 2);
    }

    if (floor >= 4) {
      return Dungeon(
        stages: [
          DungeonStage(
            name: 'Болото',
            background: 'swamp',
            enemies: FieldsEnemies.enemies,
            conditions: _conditions,
            multiplier: 3,
          ),
          DungeonStage(
            name: 'Болото - Босс Битва',
            background: 'swamp',
            enemies: FieldsEnemies.unique,
            conditions: _bossConditions,
            multiplier: 3,
          ),
        ],
      );
    } else if (floor >= 2) {
      return Dungeon(
        stages: [
          DungeonStage(
            name: 'Лес',
            background: 'forest',
            enemies: FieldsEnemies.enemies,
            conditions: _conditions,
            multiplier: 1.5,
          ),
          DungeonStage(
            name: 'Лес - Босс Битва',
            background: 'forest',
            enemies: FieldsEnemies.unique,
            conditions: _bossConditions,
            multiplier: 1.5,
          ),
        ],
      );
    }

    return Dungeon(
      stages: [
        DungeonStage(
          name: 'Поля',
          background: 'fields',
          enemies: FieldsEnemies.enemies,
          conditions: _conditions,
        ),
        DungeonStage(
          name: 'Поля - Босс Битва',
          background: 'fields',
          enemies: FieldsEnemies.unique,
          conditions: _bossConditions,
        ),
      ],
    );
  }

  Dungeon? _dungeon;

  @override
  DungeonStage? next() {
    DungeonStage? stage = _dungeon?.next();
    if (stage == null) {
      if (_dungeon != null) {
        ++floor;
        onProgress?.call(floor);
      }

      _dungeon = _next(floor);
      stage = _dungeon!.next();
    }

    return stage;
  }
}
