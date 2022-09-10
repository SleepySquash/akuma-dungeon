import 'package:novel/novel.dart';

import '/domain/model/rank.dart';
import '/domain/model/dungeon.dart';
import '/domain/model/enemy/special.dart';
import '/domain/model/task.dart';

abstract class AkumaDungeon {
  static List<TaskStep> steps() {
    return [
      NovelStep([
        DialogueLine(
          'Стоя напротив портала, ты чувствуешь что-то неладное...',
        ),
        DialogueLine('Кажется, это будет твоим последним подземельем...'),
      ]),
      DungeonStep(
        Dungeon(
          title: 'Akuma Dungeon',
          background: 'akuma',
          stages: [
            DungeonStage(
              enemies: SpecialEnemies.akumaPlus,
              conditions: [
                const SlayedStageCondition(1),
                const TimerStageCondition(Duration(seconds: 120)),
              ],
            ),
          ],
        ),
      ),
    ];
  }
}

abstract class RedDungeon {
  static List<TaskStep> steps({
    Rank rank = Rank.S,
  }) {
    return [
      NovelStep([
        DialogueLine(
          'Стоя напротив портала, ты чувствуешь что-то неладное...',
        ),
        DialogueLine('Кажется, это будет твоим последним подземельем...'),
      ]),
      DungeonStep(
        Dungeon(
          title: 'Red Dungeon',
          background: 'destructed_city',
          stages: [
            DungeonStage(
              enemies: SpecialEnemies.akumaPlus,
              conditions: [
                const SlayedStageCondition(1),
                const TimerStageCondition(Duration(seconds: 120)),
              ],
            ),
          ],
        ),
      ),
    ];
  }
}
