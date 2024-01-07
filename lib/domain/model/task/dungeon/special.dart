import 'package:novel/novel.dart';

import '/domain/model/rank.dart';
import '/domain/model/dungeon.dart';
import '/domain/model/enemy/special.dart';
import '/domain/model/task.dart';

abstract class AkumaDungeon {
  static List<TaskStep> steps() {
    return [
      const NovelStep([
        DialogueLine(
          'Стоя напротив портала, ты чувствуешь что-то неладное...',
        ),
        DialogueLine('Кажется, это будет твоим последним подземельем...'),
      ]),
      DungeonStep(
        Dungeon(
          music: 'music/mixkit-driving-ambition-32.mp3',
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
        withEntrance: true,
      ),
    ];
  }
}

abstract class RedDungeon {
  static List<TaskStep> steps({
    Rank rank = Rank.S,
  }) {
    return [
      const NovelStep([
        DialogueLine(
          'Стоя напротив портала, ты чувствуешь что-то неладное...',
        ),
        DialogueLine('Кажется, это будет твоим последним подземельем...'),
      ]),
      DungeonStep(
        Dungeon(
          music: 'music/mixkit-driving-ambition-32.mp3',
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
        withEntrance: true,
      ),
    ];
  }
}
