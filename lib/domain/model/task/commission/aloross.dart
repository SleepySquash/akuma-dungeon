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

import 'package:akuma/domain/model/enemy/veggies.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '/domain/model/commission.dart';
import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/item/all.dart';
import '/domain/model/location/all.dart';
import '/domain/model/rank.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';

abstract class AlorossCommissions {
  static List<QuestCommission> get tasks => const [
        AlorossSlimeFieldsCommission(),
        AlorossSlimeFields2Commission(),
        AlorossMerchantForestCommission(),
        AlorossSlimeSwampCommission(),
        AlorossRestaurantCommission(),
      ];
}

abstract class AlorossCommission extends Task with QuestCommission {
  const AlorossCommission();

  @override
  String? get location => 'aloross';

  @override
  Rank get rank => Rank.F;

  @override
  List<TaskCriteria> get criteria => const [NotCompletedCriteria()];

  @override
  List<Reward> get rewards => const [
        MoneyReward(12000),
        ExpReward(250),
        ItemReward(Ruby(20)),
        RankReward(5),
        ReputationReward(AlorossLocation(), 3),
      ];
}

class AlorossSlimeFieldsCommission extends AlorossCommission {
  const AlorossSlimeFieldsCommission();

  @override
  String get name => 'Слаймы вокруг города';

  @override
  String? get subtitle => 'Вокруг города поселились слаймы, разберись с ними';

  @override
  IconData get icon => Icons.landslide;

  @override
  List<TaskCriteria> get criteria => [];

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const ControlReward(AlorossLocation(), 1),
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
        const CompletedCriteria(AlorossSlimeFieldsCommission()),
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
            music: AssetSource('music/mixkit-games-worldbeat-466.mp3'),
            background: 'fields',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(30)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(35)],
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
            music: AssetSource('music/mixkit-forest-treasure-138.mp3'),
            background: 'forest',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(15)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.fPlus,
                conditions: const [SlayedStageCondition(4)],
              ),
              DungeonStage(
                background: 'forest2',
                enemies: SlimeEnemies.e,
                conditions: const [SlayedStageCondition(25)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.ePlus,
                conditions: const [SlayedStageCondition(5)],
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

class AlorossSlimeSwampCommission extends AlorossCommission {
  const AlorossSlimeSwampCommission();

  @override
  String get name => 'Слаймы на болоте';

  @override
  String? get subtitle => 'Победи слаймов на болоте';

  @override
  IconData get icon => Icons.forest;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        const ControlReward(AlorossLocation(), 1),
      ];

  @override
  List<TaskStep> get steps => [
        DungeonStep(
          Dungeon(
            music: AssetSource('music/mixkit-games-worldbeat-466.mp3'),
            background: 'swamp',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(1)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(2)],
              ),
            ],
          ),
        ),
      ];
}

class AlorossRestaurantCommission extends AlorossCommission {
  const AlorossRestaurantCommission();

  @override
  String get name => 'Помощь на кухне';

  @override
  String? get subtitle => 'Ресторану нужна смешная нарезка продуктов.';

  @override
  String? get description =>
      'ВСЁ ОЧЕНЬ ПЛОХО, СРОЧНО НУЖЕН КТО-НИБУДЬ, КТО ПОМОЖЕТ МНЕ С ПРОДУКТАМИ!!!';

  @override
  IconData get icon => Icons.restaurant;

  @override
  List<Reward> get rewards => [
        ...super.rewards,
        ItemReward(Items.consumable.sample(1).first),
      ];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/town.jpg'),
          DialogueLine(
              'Ты отправляешься в ресторан в центре Алоросса, где нужна помощь.'),
          DialogueLine(
              'Ты ведь путешественник, а не официант или повар, что же может пойти не так?'),
          BackgroundLine('location/chinese_restaurant.jpg'),
          DialogueLine('Внутри довольно оживлённо.'),
          DialogueLine(
              'На удивление, людей в ресторане полно, но что-то уже явно не так.'),
          DialogueLine('Ни у кого не столе нет еды!'),
          DialogueLine(
              'Люди негодуют от отсутствия пищи, слышны раздражённые разговоры.'),
          DialogueLine('Ты забегаешь за стойку на кухню, а там...'),
          BackgroundLine('location/kitchen.jpg'),
          CharacterLine('Emiya_Shirou.webp'),
          DialogueLine('АЙ ЭМ ЗЕ БОН ОФ МАЙ СОРД!!', by: 'Эмия'),
          DialogueLine('УАУАААААХХХХ ХДЫЫЫЩЩЩ АААААА!!', by: 'Эмия'),
          DialogueLine('АЙ ЭМ ЗЕ БОН ОФ МАЙ СОРД, Я СКАЗАЛ!!!!!!', by: 'Эмия'),
          DialogueLine('Какой-то школьник стоял и что-то мямлил себе под нос.'),
          DialogueLine('Ты подходишь и спрашиваешь, что случилось с поваром.'),
          DialogueLine('Я и есть повар!', by: 'Эмия'),
          DialogueLine(
            'Но у меня не получается справиться с продуктами, сегодня не стоит моя БОН ОФ ЗЕ СОРД...',
            by: 'Эмия',
          ),
          DialogueLine(
            'Она не встаёт!! Я не знаю, что делать!',
            by: 'Эмия',
          ),
          DialogueLine(
              'Ты спрашиваешь, всегда ли она не вставала или только сегодня.'),
          DialogueLine(
            'Нет, обычно встаёт, и я могу готовить своей БОН ОФ ЗЕ СОРД без проблем.',
            by: 'Эмия',
          ),
          DialogueLine(
            'А сегодня... Я не знаю, что не так, но мне нужно, чтобы ты помог мне!',
            by: 'Эмия',
          ),
          DialogueLine(
            'Нам нужна смешная нарезка продуктов.',
            by: 'Эмия',
          ),
          DialogueLine(
            'Вперёд!!! АЙ ЭМ ЗЕ БОН ОФ МАЙ СОРД!!!!!',
            by: 'Эмия',
          ),
        ]),
        DungeonStep(
          Dungeon(
            music: AssetSource('music/mixkit-games-worldbeat-466.mp3'),
            background: 'kitchen',
            stages: [
              DungeonStage(
                enemies: VeggieEnemies.f,
                conditions: const [SlayedStageCondition(20)],
              ),
              DungeonStage(
                enemies: VeggieEnemies.f,
                conditions: const [SlayedStageCondition(30)],
              ),
              DungeonStage(
                enemies: VeggieEnemies.fPlus,
                conditions: const [SlayedStageCondition(1)],
              ),
            ],
          ),
        ),
        NovelStep([
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/kitchen.jpg'),
          CharacterLine('Emiya_Shirou.webp'),
          DialogueLine('АЙ ЭМ ЗЕ БОН ОФ МАЙ СОРД!!', by: 'Эмия'),
          DialogueLine('Отлично, у нас получается!!', by: 'Эмия'),
          DialogueLine(
              'Всё это время Эмия стоял и пытался поднять свою БОН ОФ ЗЕ СОРД.'),
          DialogueLine('ДААААА ЫЫЫЫЫ!!', by: 'Эмия'),
          DialogueLine(
              'Кажется, ему нравилось наблюдать за тем, как ты рубишь овощи.'),
          DialogueLine(
              'Параллельно при этом он просто накидывал в тарелки нарезанные тобой овощи и разносил посетителям.'),
          DialogueLine(
            'Мы смогли, путешественник, мы всем приготовили блюда.',
            by: 'Эмия',
          ),
          DialogueLine(
            'Я думаю, это успех...',
            by: 'Эмия',
          ),
          HideCharacterLine('Emiya_Shirou.webp'),
          CharacterLine('Kotomine_Kirei.webp'),
          DialogueLine('Не так быстро, господа.', by: 'КОТОМИНЕ КИРЭЙ'),
          DialogueLine('Я.', by: 'КОТОМИНЕ КИРЭЙ'),
          DialogueLine('Хочу.', by: 'КОТОМИНЕ КИРЭЙ'),
          DialogueLine('Карри.', by: 'КОТОМИНЕ КИРЭЙ'),
          DialogueLine('Кажется, сейчас будет босс батл.'),
        ]),
        DungeonStep(
          Dungeon(
            music: AssetSource('music/juhani-junkala-epic-boss-battle.mp3'),
            background: 'akuma',
            stages: [
              const DungeonStage(
                enemies: [PotatoEnemy(), CarrotEnemy(), CucumberEnemy()],
                multiplier: 2,
                conditions: [SlayedStageCondition(5)],
              ),
              const DungeonStage(
                enemies: [ChiliEnemy()],
                multiplier: 2,
                conditions: [SlayedStageCondition(20)],
              ),
              DungeonStage(
                enemies: VeggieEnemies.fPlus,
                multiplier: 2,
                conditions: const [SlayedStageCondition(5)],
              ),
            ],
          ),
          withEntrance: true,
        ),
        NovelStep([
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/kitchen.jpg'),
          CharacterLine('Kotomine_Kirei.webp'),
          DialogueLine('Сойдёт.', by: 'КОТОМИНЕ КИРЭЙ'),
          HideCharacterLine('Kotomine_Kirei.webp'),
          CharacterLine('Emiya_Shirou.webp'),
          DialogueLine('ДААААА ЫЫЫЫ!!', by: 'Эмия'),
          DialogueLine('С твоей помощью Эмия смог приготовить людям свою еду.'),
          DialogueLine('Приходи снова! Обязательно приходи!', by: 'Эмия'),
          DialogueLine(
            'Кажется, моя БОН ОФ ЗЕ СОРД чуть-чуть увеличиалсь, когда я смотрел на то, как ты работаешь...',
            by: 'Эмия',
          ),
          DialogueLine(
            'Возможно, ты - моё лекарство, путешественник!!',
            by: 'Эмия',
          ),
          HideCharacterLine('Emiya_Shirou.webp'),
          DialogueLine(
            'Ты сделал вид, что ты смотрел фейт и знаешь, что ничего пошлого тут нет, ну не встаёт БОН у человека.',
          ),
          DialogueLine('Вполне себе нормальное явление.'),
          DialogueLine('Perfectly sized BONE OF THE SWORD, как говорится.'),
          DialogueLine('С этими мыслями ты покинул ресторан.'),
        ]),
      ];
}
