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

class AlorossMerchantForestCommission extends AlorossCommission {
  const AlorossMerchantForestCommission();

  @override
  String get name => 'Провести торговца через лес';

  @override
  String? get subtitle =>
      'Нужно провести торговца через лес, полный слаймов и прочей живности.';

  @override
  String? get description =>
      'Прошу найтись того путешественника, который сможет провести меня и защитить товары от монстров, что поселились в лесу! Дорога опасная, но награда соответствующая.\n\nЛоренц, 25 лет, буду ждать на площади.';

  @override
  IconData get icon => Icons.forest;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const ControlReward(AlorossLocation(), 2),
      ];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/town.jpg'),
          DialogueLine(
              'Взяв поручение, ты отправляешься в назначенное в записке место.'),
          CharacterLine('Lawrence.webp'),
          DialogueLine(
              'Наконец, ты замечаешь старого деда вдалеке рядом с повозкой.'),
          DialogueLine(
              'Приблизившись, ты спрашиваешь у деда, он ли торговец из записки.'),
          DialogueLine(
            'Чел, мне 25.',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'И да, я торговец.',
            by: 'Лоуренс',
          ),
          DialogueLine('Он сразу понимает, что ты пришёл по делу.'),
          DialogueLine(
            'Готов отправляться?',
            by: 'Лоуренс',
          ),
          DialogueLine(
              'Ты кивнул, а торговец бодро запряг лошадь и прыгнул на повозку, приглашая тебя.'),
          HideCharacterLine('Lawrence.webp'),
          DialogueLine(
              'Ты садишься рядом, Лоуренс даёт команду, и вот вы уже отправились в сторону леса.'),
          const WaitLine(Duration(seconds: 1)),
          BackgroundLine('location/fields.jpg'),
          CharacterLine('Lawrence.webp'),
          DialogueLine(
            'Можно задам личный вопрос, пока едем?',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Как ты думаешь, если твоя вайфу не человек, это делает тебя зоофилом?',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Ну, то есть, она как бы человек, но с приколом.',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'И прикол не только в штанах - допустим, у неё есть уши и вообще она превращается в ВОЛЧАРУ огромного.',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Как бы с одной стороны это ВОЛЧАРА огромный, а не тян, а с другой - как бы вроде и человек.',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Вот сколько не путешествую, никак не могу понять.',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Кстати о путешествиях, ты любишь путешествовать?',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Ты ведь путешественник, а я торговец.',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Не находишь некой особой связи между нами?',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Ты не хочешь быть м-моим телохранителем?',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Ну, если ты не против, что у меня фетиш на ВОЛЧАР огромных?',
            by: 'Лоуренс',
          ),
          DialogueLine(
              'Ты снимаешь наушники и спрашиваешь, о чём говорил Лоуренс.'),
          DialogueLine('Однако он не успевает ответить, на вас напали слаймы!'),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-games-worldbeat-466.mp3',
            background: 'fields',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(25)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(20)],
              ),
            ],
          ),
        ),
        NovelStep([
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/fields.jpg'),
          DialogueLine('Наконец, все слаймы были поражены.'),
          CharacterLine('Lawrence.webp'),
          DialogueLine(
            'Мы ещё до леса даже не добрались, а они сразу напрыгнули...',
            by: 'Лоуренс',
          ),
          HideCharacterLine('Lawrence.webp'),
          DialogueLine('Вы продолжили свой путь до леса.'),
          DialogueLine(
              'Оставалось немного, но ты не переставал думать о том, являеется ли вайфу ВОЛЧАРА зоофилией...'),
          DialogueLine('Может, бросить приклюения и стать ВОЛЧАРОЙ?'),
          DialogueLine('Безумно можно быть первым?'),
          BackgroundLine('location/forest.jpg'),
          const MusicLine('mixkit-forest-treasure-138.mp3'),
          DialogueLine('Наконец, вы въезжаете в лес.'),
          DialogueLine('В кустах тут и там то и дело, что шастает кто-то.'),
          CharacterLine('Lawrence.webp'),
          DialogueLine(
            'Алоросс - единственный лес, в котором такое безумное количество монстров.',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Они тут создали свою биосферу и живут как обычные животные.',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Даже странно осознавать, что существа из другого измерения смогли адаптироваться в такую необычную для них жизнь.',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'И такую ли необычную? Я, вот, не знаю, что находится по ту сторону врат.',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Вдруг там живут девочки, способные превращаться в ВОЛЧАР огромных?',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Если это так, то я был бы первым, кто прыгнул бы в данж.',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Ты ведь уже был там, каково это?',
            by: 'Лоуренс',
          ),
          DialogueLine(
              'Ты рассказываешь, что данжах в основном закрытые помещения.'),
          DialogueLine('Но сказать, почему, ты не можешь.'),
          DialogueLine(
            'Эльфиечки-то родом из того измерения, значит, и волкодевочки реальны.',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'И если половые акты с эльфиечками не считаются зоофилией, то и с ВОЛЧАРОЙ не будет, правда?',
            by: 'Лоуренс',
          ),
          DialogueLine(
              'Ваши разговоры о высокой культуре прерывает массивная группировка слаймов.'),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-forest-treasure-138.mp3',
            background: 'forest',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(25)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.fPlus,
                conditions: const [SlayedStageCondition(4)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.e,
                conditions: const [SlayedStageCondition(1)],
              ),
            ],
          ),
        ),
        NovelStep([
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/fields.jpg'),
          DialogueLine('Наконец, вы прошли через лес.'),
          CharacterLine('Lawrence.webp'),
          DialogueLine(
            'Уф, и так каждый раз...',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Что ж, ты меня сильно выручил!',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Спасибо большое за помощь, дальше уже безопасно, в этих краях уже спокойно.',
            by: 'Лоуренс',
          ),
          DialogueLine(
            'Удачи тебе вернуться.',
            by: 'Лоуренс',
          ),
          HideCharacterLine('Lawrence.webp'),
          DialogueLine(
              'Лоренц отправился дальше, а ты возвращаешься обратно через лес в Алоросс.'),
        ]),
      ];
}
