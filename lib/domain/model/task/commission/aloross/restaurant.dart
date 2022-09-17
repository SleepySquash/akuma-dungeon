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

import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '../aloross.dart';
import '/domain/model/dungeon.dart';
import '/domain/model/enemy/veggies.dart';
import '/domain/model/item/all.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';

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
            music: 'music/mixkit-games-worldbeat-466.mp3',
            background: 'kitchen',
            stages: [
              DungeonStage(
                enemies: VeggieEnemies.f,
                conditions: const [SlayedStageCondition(20)],
              ),
              DungeonStage(
                enemies: VeggieEnemies.f,
                conditions: const [SlayedStageCondition(10)],
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
            music: 'music/juhani-junkala-epic-boss-battle.mp3',
            background: 'akuma',
            stages: [
              DungeonStage(
                enemies: const [PotatoEnemy(), CarrotEnemy(), CucumberEnemy()],
                multiplier: Decimal.fromInt(2),
                conditions: const [SlayedStageCondition(5)],
              ),
              DungeonStage(
                enemies: const [ChiliEnemy()],
                multiplier: Decimal.fromInt(2),
                conditions: const [SlayedStageCondition(20)],
              ),
              DungeonStage(
                enemies: VeggieEnemies.fPlus,
                multiplier: Decimal.fromInt(2),
                conditions: const [SlayedStageCondition(2)],
              ),
            ],
          ),
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
