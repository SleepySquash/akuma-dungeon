import 'enemy.dart';
import 'enemy/slime.dart';
import 'reward.dart';

/// Single stage of a dungeon.
class DungeonStage {
  const DungeonStage({
    this.name,
    required this.enemies,
    this.conditions = const [],
    this.background,
    this.music,
    this.multiplier = 1,
    this.onPass,
  });

  final String? name;
  final List<Enemy> enemies;
  final List<NextStageCondition> conditions;
  final String? background;
  final String? music;
  final double multiplier;
  final void Function()? onPass;
}

/// Collection of the [DungeonStage]es.
///
/// Implemented via [Dungeon] or [InfiniteDungeon].
abstract class DungeonSettings {
  const DungeonSettings();

  String? get title;
  String? get background;
  String? get music;
  List<Reward>? get rewards => null;
  DungeonStage? next();
}

class Dungeon extends DungeonSettings {
  Dungeon({
    required this.stages,
    this.title,
    this.background,
    this.music,
    this.rewards,
  });

  final List<DungeonStage> stages;

  @override
  final String? title;

  @override
  final String? background;

  @override
  final String? music;

  @override
  final List<Reward>? rewards;

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
  }) {
    background = _next(floor).background;
    music = _next(floor).music;
  }

  /// Current floor of this [InfiniteDungeon].
  int floor;

  /// Callback, called when the [floor] increments.
  final void Function(int)? onProgress;

  @override
  String? title;

  @override
  String? background;

  @override
  String? music;

  List<NextStageCondition> get _conditions {
    return const [SlayedStageCondition(20)];
  }

  List<NextStageCondition> get _bossConditions {
    return const [
      SlayedStageCondition(1),
      TimerStageCondition(Duration(seconds: 30)),
    ];
  }

  Dungeon _next(int stage, [double multiplier = 1]) {
    if (stage >= 16) {
      return _next(stage % 6, multiplier * 4 * (stage ~/ 6));
    }

    List<Enemy> enemies;
    List<Enemy> uniques;
    if (floor > 40) {
      enemies = SlimeEnemies.d;
      uniques = SlimeEnemies.d;
    } else if (floor > 16) {
      enemies = SlimeEnemies.e;
      uniques = SlimeEnemies.ePlus;
    } else {
      enemies = SlimeEnemies.f;
      uniques = SlimeEnemies.fPlus;
    }

    if (stage >= 12) {
      return Dungeon(
        music: 'music/mixkit-forest-treasure-138.mp3',
        background: 'swamp',
        stages: [
          DungeonStage(
            name: 'Болото - $floor',
            enemies: enemies,
            conditions: _conditions,
            multiplier: multiplier * 3,
          ),
          DungeonStage(
            name: 'Болото - Босс Битва - $floor',
            enemies: uniques,
            conditions: _bossConditions,
            multiplier: multiplier * 3,
          ),
        ],
      );
    } else if (stage >= 8) {
      return Dungeon(
        music: 'music/mixkit-forest-treasure-138.mp3',
        background: 'forest2',
        stages: [
          DungeonStage(
            name: 'Глубь леса - $floor',
            enemies: enemies,
            conditions: _conditions,
            multiplier: multiplier * 2,
          ),
          DungeonStage(
            name: 'Глубь леса - Босс Битва - $floor',
            enemies: uniques,
            conditions: _bossConditions,
            multiplier: multiplier * 2,
          ),
        ],
      );
    } else if (stage >= 4) {
      return Dungeon(
        music: 'music/mixkit-games-worldbeat-466.mp3',
        background: 'forest',
        stages: [
          DungeonStage(
            name: 'Лес - $floor',
            enemies: enemies,
            conditions: _conditions,
            multiplier: multiplier * 1.5,
          ),
          DungeonStage(
            name: 'Лес - Босс Битва - $floor',
            enemies: uniques,
            conditions: _bossConditions,
            multiplier: multiplier * 1.5,
          ),
        ],
      );
    }

    return Dungeon(
      music: 'music/mixkit-games-worldbeat-466.mp3',
      background: 'fields',
      stages: [
        DungeonStage(
          name: 'Поля - $floor',
          enemies: enemies,
          conditions: _conditions,
          multiplier: multiplier,
        ),
        DungeonStage(
          name: 'Поля - Босс Битва - $floor',
          enemies: uniques,
          conditions: _bossConditions,
          multiplier: multiplier,
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
      background = _dungeon!.background;
      music = _dungeon!.music;
    }

    return stage;
  }
}
