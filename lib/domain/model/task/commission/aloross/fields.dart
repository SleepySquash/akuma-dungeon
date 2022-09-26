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

import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '../aloross.dart';
import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/location/all.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';
import '/domain/model/task/queue/main/chapter_1.dart';

class AlorossSlimeFieldsCommission extends AlorossCommission {
  const AlorossSlimeFieldsCommission();

  @override
  String get name => 'Слаймы вокруг города';

  @override
  String? get subtitle => 'Вокруг города поселились слаймы, разберись с ними';

  @override
  IconData get icon => Icons.landslide;

  @override
  List<TaskCriteria> get criteria => const [
        NotCompletedCriteria(),
        CompletedCriteria(task: SecondStepsTask()),
      ];

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const ControlReward(AlorossLocation(), 1),
      ];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          const MusicLine('mixkit-just-kidding-11.mp3'),
          BackgroundLine('location/fields.jpg'),
          DialogueLine('Действительно, вокруг города множество слаймов.'),
          DialogueLine(
              'Стояла вполне себе замечательная погода для того, чтобы их ликвидировать.'),
          DialogueLine(
              'Ты бодро пересёк границу города и уже высматривал образования слаймов.'),
          DialogueLine(
              'Вглядываться не приходится - местность ими просто кишит.'),
          DialogueLine(
              'Взяв себя в руки, ты уверенно отправился к первой пачке монстров.'),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-just-kidding-11.mp3',
            background: 'fields',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(10)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(5)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.fPlus,
                conditions: const [SlayedStageCondition(1)],
              ),
            ],
          ),
        ),
        NovelStep([
          const MusicLine('mixkit-just-kidding-11.mp3'),
          BackgroundLine('location/fields.jpg'),
          DialogueLine(
              'Слаймы, которых ты вместе с боссом отправил в нокаут, представляют собой низший подвид слаймов.'),
          DialogueLine(
              'Ты слышал, более высшие слаймы могут даже принимать форму человека.'),
          DialogueLine('А некоторые и вовсе обладают интеллектом!'),
          DialogueLine(
              'Ты и не заметил, как отошёл довольно далеко от города.'),
          DialogueLine('Твои размышления прервали крики неподалёку.'),
          CharacterLine('Aqua.webp'),
          DialogueLine('Получай!!!', by: 'Аква'),
          DialogueLine('Небольшая группа путешественников напала на слаймов.'),
          DialogueLine(
              'Хотя правильнее будет сказать, что на небольшую группу путешественников напали слаймы.'),
          DialogueLine('Девушка напала на водяного слайма водяной магией.'),
          DialogueLine('У них резист к водяному урону, нет?'),
          DialogueLine('А-а, на помощь!!!!', by: 'Аква'),
          HideCharacterLine('Aqua.webp'),
          DialogueLine('Прямо на твоих глазах девушку проглотил слайм.'),
          CharacterLine('Kazuma_Sato.webp'),
          DialogueLine('У них резист к водяному урону, глупая!', by: 'Казума'),
          DialogueLine('Мегумин, сделай что-нибудь!', by: 'Казума'),
          HideCharacterLine('Kazuma_Sato.webp'),
          CharacterLine('Megumin.webp'),
          DialogueLine(
            'Ха-ха, для меня, Мегумин, нет ничего невозможного!',
            by: 'Мегумин',
          ),
          DialogueLine(
            'Узри же мою мощь!',
            by: 'Мегумин',
          ),
          DialogueLine(
            'Во славу Сатане и четырём шестикрылым всадникам аппокалипсиса, да воздай же мне силу, неведомую...',
            by: 'Мегумин',
          ),
          HideCharacterLine('Megumin.webp'),
          DialogueLine(
              'Прямо на твоих глазах и вторую девушку проглотил слайм.'),
          CharacterLine('Kazuma_Sato.webp'),
          DialogueLine('Бля.', by: 'Казума'),
          HideCharacterLine('Kazuma_Sato.webp'),
          DialogueLine('Прямо на твоих глазах и парня проглотил слайм.'),
          DialogueLine('Ну что тут сказать, пойдём спасать?'),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-just-kidding-11.mp3',
            background: 'fields',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(10)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.e,
                conditions: const [SlayedStageCondition(1)],
              ),
            ],
          ),
        ),
        NovelStep([
          const MusicLine('mixkit-just-kidding-11.mp3'),
          BackgroundLine('location/fields.jpg'),
          DialogueLine(
              'Ты добиваешь последнего слайма, из которого аккуратно достаёшь последнюю жертву.'),
          CharacterLine('Megumin.webp'),
          DialogueLine(
            'Сегодня ты спас единственную надежду человечества на светлое будущее!',
            by: 'Мегумин',
          ),
          DialogueLine(
            'Благодаря тебе, о неизвестный, Мегумин будет слагать легенды десятилетиями!',
            by: 'Мегумин',
          ),
          DialogueLine(
            'Переверни меня, пожалуйста, мне нечем дышать...!',
            by: 'Мегумин',
          ),
          DialogueLine('No questions asked, ты переворачиваешь девушку.'),
          HideCharacterLine('Megumin.webp'),
          CharacterLine('Kazuma_Sato.webp'),
          DialogueLine(
            'Не слушай её, у неё имя Мегумин, она явно несерьёзно.',
            by: 'Казума',
          ),
          DialogueLine(
            'Я Казума.',
            by: 'Казума',
          ),
          DialogueLine('Но ты это и так знал, над текстом имя-то пишется.'),
          DialogueLine(
            'Как хорошо, что ты оказался рядом. Если бы не ты, то, ну, ничего бы не случилось, это же слаймы, камон.',
            by: 'Казума',
          ),
          DialogueLine(
            'Но человек культуры не смеет просто так оставить другого человека культуры без трофея.',
            by: 'Казума',
          ),
          DialogueLine(
            'Есть один приём, который резко разнообратит твою жизнь. Но не сейчас.',
            by: 'Казума',
          ),
          DialogueLine(
            'Когда настанет время, я дам тебе знать.',
            by: 'Казума',
          ),
          DialogueLine(
            'И мы встретимся.',
            by: 'Казума',
          ),
          DialogueLine(
            'И я обучу тебя.',
            by: 'Казума',
          ),
          DialogueLine('Казума ушёл в закат.'),
          DialogueLine(
              'А ты помог добраться девушкам до города и отправился по своим делам.'),
        ]),
      ];
}

class AlorossSlimeFields2Commission extends AlorossCommission {
  const AlorossSlimeFields2Commission();

  @override
  String get name => 'Слаймы снова вокруг города';

  @override
  String? get subtitle => 'Вокруг города поселились слаймы, разберись с ними';

  @override
  IconData get icon => Icons.landslide;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const ControlReward(AlorossLocation(), 1),
      ];

  @override
  List<TaskCriteria> get criteria => [
        ...super.criteria,
        const CompletedCriteria(task: AlorossSlimeFieldsCommission()),
      ];

  @override
  List<TaskStep> get steps => [
        DungeonStep(
          Dungeon(
            background: 'fields',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(1)],
              ),
              DungeonStage(
                background: 'forest',
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(2)],
              ),
            ],
          ),
        ),
      ];
}
