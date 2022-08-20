import 'enemy.dart';

class DungeonStage {
  const DungeonStage({
    this.name,
    required this.enemies,
    this.conditions = const [],
    this.background,
  });

  final String? name;
  final List<Enemy> enemies;
  final List<NextStageCondition> conditions;
  final String? background;
}

class DungeonSettings {
  const DungeonSettings({
    required this.stages,
    this.background,
  });

  final List<DungeonStage> stages;
  final String? background;
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
