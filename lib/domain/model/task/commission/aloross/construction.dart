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

import 'package:akuma/domain/model/item/all.dart';
import 'package:akuma/domain/model/location/all.dart';
import 'package:akuma/domain/model/reward.dart';
import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '../aloross.dart';
import '/domain/model/dungeon.dart';
import '/domain/model/enemy/construction.dart';
import '/domain/model/task.dart';

class AlorossConstructionCommission extends AlorossCommission {
  const AlorossConstructionCommission();

  @override
  String get name => 'Помощь на стройке';

  @override
  String? get subtitle => 'Застройщик просит помочь со стройкой.';

  @override
  String? get description =>
      'Нужный крепкий парень, чтобы крепко класть киприч на крипич. Крепкая оплата и крепкий коллектив гарантируются.';

  @override
  IconData get icon => Icons.construction;

  @override
  List<TaskCriteria> get criteria => const [NotCompletedCriteria()];

  @override
  List<Reward> get rewards => const [
        MoneyReward(1000),
        ExpReward(250),
        ItemReward(Ruby(5)),
        RankReward(2),
        ReputationReward(AlorossLocation(), 1),
      ];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          const MusicLine('mixkit-just-kidding-11.mp3'),
          BackgroundLine('location/town.jpg'),
          DialogueLine(
              'Ты отправляешься на стройку, где платят крепким парням.'),
          DialogueLine(
              'Это лучше, чем ничего, конечно, но лучше бы ты сражался с монстрами, как и подобает путешественнику.'),
          BackgroundLine('location/town_construction.jpg'),
          CharacterLine('Chads.png'),
          DialogueLine(
            'Вай, дарагой, наконец-то к нам прислали крепкий мужчина.',
            by: 'Гига Чад',
          ),
          DialogueLine(
            'Я так рад видеть крепкий мужчина, что хотеть стать крепче!!!',
            by: 'Гига Чад',
          ),
          DialogueLine(
            'Дыа, брат мой, крепче!',
            by: 'Гига Чад',
          ),
          DialogueLine(
            'Крепкий мужчина, пойдём класть крепкий кирпич.',
            by: 'Гига Чад',
          ),
          DialogueLine(
            'Твоя работа - класть крепкий кирпич крепко, чтобы ничто не упало.',
            by: 'Гига Чад',
          ),
          DialogueLine(
            'Давай, сладенький, за работу.',
            by: 'Гига Чад',
          ),
          DialogueLine(
            'Только не забудь снять футболочку, она тебе тут не нужна.',
            by: 'Гига Чад',
          ),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-just-kidding-11.mp3',
            background: 'town_construction',
            stages: [
              DungeonStage(
                enemies: ConstructionEnemies.brick,
                conditions: const [SlayedStageCondition(30)],
              ),
              DungeonStage(
                enemies: ConstructionEnemies.enemies,
                conditions: const [SlayedStageCondition(20)],
              ),
              DungeonStage(
                enemies: ConstructionEnemies.bricks,
                conditions: const [SlayedStageCondition(15)],
              ),
            ],
          ),
        ),
        NovelStep([
          const MusicLine('mixkit-just-kidding-11.mp3'),
          BackgroundLine('location/town_construction.jpg'),
          CharacterLine('Chads.png'),
          DialogueLine(
            'Вай, мы благодарить крепкий мужчина.',
            by: 'Гига Чад',
          ),
          DialogueLine(
            'Вроде, крепко получилось!',
            by: 'Гига Чад',
          ),
          DialogueLine(
            'Да, крепко, вай как крепко!',
            by: 'Гига Чад',
          ),
          DialogueLine(
            'Твоя награда ждать тебя, мой крепыш.',
            by: 'Гига Чад',
          ),
          HideCharacterLine('Chads.png'),
          DialogueLine('Ты устал и хочешь домой.'),
        ]),
      ];
}
