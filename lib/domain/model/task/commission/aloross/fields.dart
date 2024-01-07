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
          MusicLine.asset('mixkit-just-kidding-11.mp3'),
          BackgroundLine.asset('location/fields.jpg'),
          const DialogueLine('Действительно, вокруг города множество слаймов.'),
          const DialogueLine(
              'Стояла вполне себе замечательная погода для того, чтобы их ликвидировать.'),
          const DialogueLine(
              'Ты бодро пересёк границу города и уже высматривал образования слаймов.'),
          const DialogueLine(
              'Вглядываться не приходится - местность ими просто кишит.'),
          const DialogueLine(
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
          MusicLine.asset('mixkit-just-kidding-11.mp3'),
          BackgroundLine.asset('location/fields.jpg'),
          const DialogueLine(
            'Слаймы, которых ты вместе с боссом отправил в нокаут, представляют собой низший подвид слаймов.',
          ),
          const DialogueLine(
            'Ты слышал, более высшие слаймы могут даже принимать форму человека.',
          ),
          const DialogueLine('А некоторые и вовсе обладают интеллектом!'),
          const DialogueLine(
            'Ты и не заметил, как отошёл довольно далеко от города.',
          ),
          const DialogueLine('Твои размышления прервали крики неподалёку.'),
          ImageLine.asset('Aqua.webp'),
          const DialogueLine('Получай!!!', by: 'Аква'),
          const DialogueLine(
            'Небольшая группа путешественников напала на слаймов.',
          ),
          const DialogueLine(
            'Хотя правильнее будет сказать, что на небольшую группу путешественников напали слаймы.',
          ),
          const DialogueLine(
            'Девушка напала на водяного слайма водяной магией.',
          ),
          const DialogueLine('У них резист к водяному урону, нет?'),
          const DialogueLine('А-а, на помощь!!!!', by: 'Аква'),
          HideImageLine.asset('Aqua.webp'),
          const DialogueLine('Прямо на твоих глазах девушку проглотил слайм.'),
          ImageLine.asset('Kazuma_Sato.webp'),
          const DialogueLine(
            'У них резист к водяному урону, глупая!',
            by: 'Казума',
          ),
          const DialogueLine('Мегумин, сделай что-нибудь!', by: 'Казума'),
          HideImageLine.asset('Kazuma_Sato.webp'),
          ImageLine.asset('Megumin.webp'),
          const DialogueLine(
            'Ха-ха, для меня, Мегумин, нет ничего невозможного!',
            by: 'Мегумин',
          ),
          const DialogueLine(
            'Узри же мою мощь!',
            by: 'Мегумин',
          ),
          const DialogueLine(
            'Во славу Сатане и четырём шестикрылым всадникам аппокалипсиса, да воздай же мне силу, неведомую...',
            by: 'Мегумин',
          ),
          HideImageLine.asset('Megumin.webp'),
          const DialogueLine(
              'Прямо на твоих глазах и вторую девушку проглотил слайм.'),
          ImageLine.asset('Kazuma_Sato.webp'),
          const DialogueLine('Бля.', by: 'Казума'),
          HideImageLine.asset('Kazuma_Sato.webp'),
          const DialogueLine('Прямо на твоих глазах и парня проглотил слайм.'),
          const DialogueLine('Ну что тут сказать, пойдём спасать?'),
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
          MusicLine.asset('mixkit-just-kidding-11.mp3'),
          BackgroundLine.asset('location/fields.jpg'),
          const DialogueLine(
              'Ты добиваешь последнего слайма, из которого аккуратно достаёшь последнюю жертву.'),
          ImageLine.asset('Megumin.webp'),
          const DialogueLine(
            'Сегодня ты спас единственную надежду человечества на светлое будущее!',
            by: 'Мегумин',
          ),
          const DialogueLine(
            'Благодаря тебе, о неизвестный, Мегумин будет слагать легенды десятилетиями!',
            by: 'Мегумин',
          ),
          const DialogueLine(
            'Переверни меня, пожалуйста, мне нечем дышать...!',
            by: 'Мегумин',
          ),
          const DialogueLine('No questions asked, ты переворачиваешь девушку.'),
          HideImageLine.asset('Megumin.webp'),
          ImageLine.asset('Kazuma_Sato.webp'),
          const DialogueLine(
            'Не слушай её, у неё имя Мегумин, она явно несерьёзно.',
            by: 'Казума',
          ),
          const DialogueLine(
            'Я Казума.',
            by: 'Казума',
          ),
          const DialogueLine(
              'Но ты это и так знал, над текстом имя-то пишется.'),
          const DialogueLine(
            'Как хорошо, что ты оказался рядом. Если бы не ты, то, ну, ничего бы не случилось, это же слаймы, камон.',
            by: 'Казума',
          ),
          const DialogueLine(
            'Но человек культуры не смеет просто так оставить другого человека культуры без трофея.',
            by: 'Казума',
          ),
          const DialogueLine(
            'Есть один приём, который резко разнообратит твою жизнь. Но не сейчас.',
            by: 'Казума',
          ),
          const DialogueLine(
            'Когда настанет время, я дам тебе знать.',
            by: 'Казума',
          ),
          const DialogueLine(
            'И мы встретимся.',
            by: 'Казума',
          ),
          const DialogueLine(
            'И я обучу тебя.',
            by: 'Казума',
          ),
          const DialogueLine('Казума ушёл в закат.'),
          const DialogueLine(
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
