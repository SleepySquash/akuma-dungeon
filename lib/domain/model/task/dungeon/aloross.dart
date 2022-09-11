// Copyright © 2022 NIKITA ISAENKO, <https://github.com/SleepySquash>
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU Affero General Public License v3.0 as published by the
// Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License v3.0 for
// more details.
//
// You should have received a copy of the GNU Affero General Public License v3.0
// along with this program. If not, see
// <https://www.gnu.org/licenses/agpl-3.0.html>.

import 'package:akuma/domain/model/enemy.dart';
import 'package:akuma/domain/model/task/dungeon/special.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';

import '/domain/model/commission.dart';
import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/item/all.dart';
import '/domain/model/location/all.dart';
import '/domain/model/rank.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';

abstract class AlorossDungeons {
  static List<DungeonCommission> get all => const [
        AlorossSlimeMinesFDungeon(),
        AlorossSlimeMinesEDungeon(),
        AlorossSlimeMinesDDungeon(),
        AlorossIceCaveFDungeon(),
        AlorossIceCaveEDungeon(),
        AlorossIceCaveDDungeon(),
        AlorossSlimeExtendedMinesFDungeon(),
        AlorossSlimeExtendedMinesEDungeon(),
        AlorossSlimeExtendedMinesDDungeon(),
        AlorossAkumaDungeon(),
        AlorossRedDungeon(),
      ];
}

abstract class AlorossDungeon extends Task with DungeonCommission {
  const AlorossDungeon();

  @override
  String? get location => 'aloross';

  @override
  Duration? get timeout => const Duration(minutes: 5);

  @override
  Rank get rank => Rank.F;

  @override
  List<Reward> get rewards => const [
        ControlReward(AlorossLocation(), 1),
        ItemReward(Ruby(2)),
      ];
}

mixin Slimes on AlorossDungeon {
  List<Enemy> get enemies {
    switch (rank) {
      case Rank.Akuma:
      case Rank.SSS:
      case Rank.SS:
      case Rank.S:
      case Rank.A:
      case Rank.B:
      case Rank.C:
      case Rank.D:
        return SlimeEnemies.d;
      case Rank.E:
        return SlimeEnemies.e;
      case Rank.F:
        return SlimeEnemies.f;
    }
  }

  List<Enemy> get boss {
    switch (rank) {
      case Rank.Akuma:
      case Rank.SSS:
      case Rank.SS:
      case Rank.S:
      case Rank.A:
      case Rank.B:
      case Rank.C:
      case Rank.D:
        return SlimeEnemies.d;
      case Rank.E:
        return SlimeEnemies.ePlus;
      case Rank.F:
        return SlimeEnemies.fPlus;
    }
  }
}

abstract class AlorossSlimeMinesDungeon extends AlorossDungeon with Slimes {
  const AlorossSlimeMinesDungeon();

  @override
  List<TaskStep> get steps => [
        DungeonStep(
          Dungeon(
            music: AssetSource('music/mixkit-forest-treasure-138.mp3'),
            background: 'mines',
            stages: [
              DungeonStage(
                enemies: enemies,
                conditions: [const SlayedStageCondition(20)],
              ),
              DungeonStage(
                enemies: enemies,
                conditions: [const SlayedStageCondition(20)],
              ),
              DungeonStage(
                enemies: enemies,
                conditions: [const SlayedStageCondition(30)],
              ),
              DungeonStage(
                enemies: boss,
                conditions: [
                  const SlayedStageCondition(1),
                  const TimerStageCondition(Duration(seconds: 30)),
                ],
              ),
            ],
          ),
        ),
      ];
}

class AlorossSlimeMinesFDungeon extends AlorossSlimeMinesDungeon {
  const AlorossSlimeMinesFDungeon();

  @override
  Rank get rank => Rank.F;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const MoneyReward(50),
        const ExpReward(50),
        const RankReward(1),
      ];
}

class AlorossSlimeMinesEDungeon extends AlorossSlimeMinesDungeon {
  const AlorossSlimeMinesEDungeon();

  @override
  Rank get rank => Rank.E;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const MoneyReward(200),
        const ExpReward(100),
        const RankReward(1),
      ];
}

class AlorossSlimeMinesDDungeon extends AlorossSlimeMinesDungeon {
  const AlorossSlimeMinesDDungeon();

  @override
  Rank get rank => Rank.D;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const MoneyReward(1000),
        const ExpReward(200),
        const RankReward(2),
      ];
}

abstract class AlorossIceCaveDungeon extends AlorossDungeon with Slimes {
  const AlorossIceCaveDungeon();

  @override
  List<TaskStep> get steps => [
        DungeonStep(
          Dungeon(
            music: AssetSource('music/mixkit-forest-treasure-138.mp3'),
            background: 'ice_cave',
            stages: [
              DungeonStage(
                enemies: enemies,
                conditions: [const SlayedStageCondition(20)],
              ),
              DungeonStage(
                enemies: enemies,
                conditions: [const SlayedStageCondition(20)],
              ),
              DungeonStage(
                enemies: enemies,
                conditions: [const SlayedStageCondition(20)],
              ),
              DungeonStage(
                enemies: boss,
                conditions: [
                  const SlayedStageCondition(1),
                  const TimerStageCondition(Duration(seconds: 30)),
                ],
              ),
            ],
          ),
        ),
      ];
}

class AlorossIceCaveFDungeon extends AlorossIceCaveDungeon {
  const AlorossIceCaveFDungeon();

  @override
  Rank get rank => Rank.F;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const MoneyReward(50),
        const ExpReward(50),
        const RankReward(1),
      ];
}

class AlorossIceCaveEDungeon extends AlorossIceCaveDungeon {
  const AlorossIceCaveEDungeon();

  @override
  Rank get rank => Rank.E;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const MoneyReward(50),
        const ExpReward(50),
        const RankReward(1),
      ];
}

class AlorossIceCaveDDungeon extends AlorossIceCaveDungeon {
  const AlorossIceCaveDDungeon();

  @override
  Rank get rank => Rank.D;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const MoneyReward(50),
        const ExpReward(50),
        const RankReward(1),
      ];
}

abstract class AlorossSlimeExtendedMinesDungeon extends AlorossDungeon
    with Slimes {
  const AlorossSlimeExtendedMinesDungeon();

  @override
  List<TaskStep> get steps => [
        DungeonStep(
          Dungeon(
            music: AssetSource('music/mixkit-forest-treasure-138.mp3'),
            background: 'mines',
            stages: [
              DungeonStage(
                enemies: enemies,
                conditions: [const SlayedStageCondition(20)],
              ),
              DungeonStage(
                enemies: enemies,
                conditions: [const SlayedStageCondition(20)],
              ),
              DungeonStage(
                enemies: enemies,
                conditions: [const SlayedStageCondition(20)],
              ),
              DungeonStage(
                background: 'underground_waterfall',
                multiplier: 2,
                enemies: enemies,
                conditions: [const SlayedStageCondition(20)],
              ),
              DungeonStage(
                background: 'underground_waterfall',
                multiplier: 2,
                enemies: enemies,
                conditions: [const SlayedStageCondition(20)],
              ),
              DungeonStage(
                background: 'underground_waterfall',
                multiplier: 2,
                enemies: enemies,
                conditions: [const SlayedStageCondition(20)],
              ),
              DungeonStage(
                background: 'underground_waterfall',
                enemies: boss,
                multiplier: 4,
                conditions: [
                  const SlayedStageCondition(1),
                  const TimerStageCondition(Duration(seconds: 30)),
                ],
              ),
            ],
          ),
        ),
      ];
}

class AlorossSlimeExtendedMinesFDungeon extends AlorossSlimeExtendedMinesDungeon
    with Slimes {
  const AlorossSlimeExtendedMinesFDungeon();

  @override
  Rank get rank => Rank.F;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const MoneyReward(100),
        const ExpReward(100),
        const RankReward(2),
      ];
}

class AlorossSlimeExtendedMinesEDungeon extends AlorossSlimeExtendedMinesDungeon
    with Slimes {
  const AlorossSlimeExtendedMinesEDungeon();

  @override
  Rank get rank => Rank.E;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const MoneyReward(200),
        const ExpReward(250),
        const RankReward(5),
      ];
}

class AlorossSlimeExtendedMinesDDungeon extends AlorossSlimeExtendedMinesDungeon
    with Slimes {
  const AlorossSlimeExtendedMinesDDungeon();

  @override
  Rank get rank => Rank.D;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const MoneyReward(500),
        const ExpReward(500),
        const RankReward(15),
      ];
}

class AlorossAkumaDungeon extends AlorossDungeon {
  const AlorossAkumaDungeon();

  @override
  String get name => 'AlorossAkumaDungeon';

  @override
  String? get background => ['mines', 'ice_cave'].sample(1).first;

  @override
  Rank get rank => [Rank.F, Rank.E, Rank.D].sample(1).first;

  @override
  List<TaskStep> get steps => AkumaDungeon.steps();

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        [const MoneyReward(50), const MoneyReward(200)].sample(1).first,
        const ExpReward(50),
        const RankReward(1),
      ];
}

class AlorossRedDungeon extends AlorossDungeon {
  const AlorossRedDungeon();

  @override
  String get name => 'AlorossRedDungeon';

  @override
  String? get background =>
      ['dungeon/mines', 'dungeon/ice_cave'].sample(1).first;

  @override
  Rank get rank => [Rank.F, Rank.E, Rank.D].sample(1).first;

  @override
  List<TaskStep> get steps => RedDungeon.steps();

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        [const MoneyReward(50), const MoneyReward(200)].sample(1).first,
        const ExpReward(50),
        const RankReward(1),
      ];
}
