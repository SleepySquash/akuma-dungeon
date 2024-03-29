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

import 'package:akuma/domain/model/location/all.dart';
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
  List<Reward> get rewards => const [
        MoneyReward(1600),
        ExpReward(250),
        ItemReward(Ruby(5)),
        RankReward(2),
        ReputationReward(AlorossLocation(), 1),
      ];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          MusicLine.asset('mixkit-summer-fun-13.mp3'),
          BackgroundLine.asset('location/town.jpg'),
          const DialogueLine(
              'Ты отправляешься в ресторан в центре Алоросса, где нужна помощь.'),
          const DialogueLine(
              'Ты ведь путешественник, а не официант или повар, что же может пойти не так?'),
          BackgroundLine.asset('location/chinese_restaurant.jpg'),
          const DialogueLine('Внутри довольно оживлённо.'),
          const DialogueLine(
              'На удивление, людей в ресторане полно, но что-то уже явно не так.'),
          const DialogueLine('Ни у кого не столе нет еды!'),
          const DialogueLine(
              'Люди негодуют от отсутствия пищи, слышны раздражённые разговоры.'),
          const DialogueLine('Ты забегаешь за стойку на кухню, а там...'),
          BackgroundLine.asset('location/kitchen.jpg'),
          ImageLine.asset('Emiya_Shirou.webp'),
          const DialogueLine('АЙ ЭМ ЗЕ БОН ОФ МАЙ СОРД!!', by: 'Эмия'),
          const DialogueLine('УАУАААААХХХХ ХДЫЫЫЩЩЩ АААААА!!', by: 'Эмия'),
          const DialogueLine('АЙ ЭМ ЗЕ БОН ОФ МАЙ СОРД, Я СКАЗАЛ!!!!!!',
              by: 'Эмия'),
          const DialogueLine(
              'Какой-то школьник стоял и что-то мямлил себе под нос.'),
          const DialogueLine(
              'Ты подходишь и спрашиваешь, что случилось с поваром.'),
          const DialogueLine('Я и есть повар!', by: 'Эмия'),
          const DialogueLine(
            'Но у меня не получается справиться с продуктами, сегодня не стоит моя БОН ОФ ЗЕ СОРД...',
            by: 'Эмия',
          ),
          const DialogueLine(
            'Она не встаёт!! Я не знаю, что делать!',
            by: 'Эмия',
          ),
          const DialogueLine(
              'Ты спрашиваешь, всегда ли она не вставала или только сегодня.'),
          const DialogueLine(
            'Нет, обычно встаёт, и я могу готовить своей БОН ОФ ЗЕ СОРД без проблем.',
            by: 'Эмия',
          ),
          const DialogueLine(
            'А сегодня... Я не знаю, что не так, но мне нужно, чтобы ты помог мне!',
            by: 'Эмия',
          ),
          const DialogueLine(
            'Нам нужна смешная нарезка продуктов.',
            by: 'Эмия',
          ),
          const DialogueLine(
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
                conditions: const [SlayedStageCondition(10)],
              ),
              DungeonStage(
                enemies: VeggieEnemies.f,
                conditions: const [SlayedStageCondition(5)],
              ),
            ],
          ),
        ),
        NovelStep([
          MusicLine.asset('mixkit-summer-fun-13.mp3'),
          BackgroundLine.asset('location/kitchen.jpg'),
          ImageLine.asset('Emiya_Shirou.webp'),
          const DialogueLine('АЙ ЭМ ЗЕ БОН ОФ МАЙ СОРД!!', by: 'Эмия'),
          const DialogueLine('Отлично, у нас получается!!', by: 'Эмия'),
          const DialogueLine(
              'Всё это время Эмия стоял и пытался поднять свою БОН ОФ ЗЕ СОРД.'),
          const DialogueLine('ДААААА ЫЫЫЫЫ!!', by: 'Эмия'),
          const DialogueLine(
              'Кажется, ему нравилось наблюдать за тем, как ты рубишь овощи.'),
          const DialogueLine(
              'Параллельно при этом он просто накидывал в тарелки нарезанные тобой овощи и разносил посетителям.'),
          const DialogueLine(
            'Мы смогли, путешественник, мы всем приготовили блюда.',
            by: 'Эмия',
          ),
          const DialogueLine(
            'Я думаю, это успех...',
            by: 'Эмия',
          ),
          HideImageLine.asset('Emiya_Shirou.webp'),
          ImageLine.asset('Kotomine_Kirei.webp'),
          const DialogueLine('Не так быстро, господа.', by: 'КОТОМИНЕ КИРЭЙ'),
          const DialogueLine('Я.', by: 'КОТОМИНЕ КИРЭЙ'),
          const DialogueLine('Хочу.', by: 'КОТОМИНЕ КИРЭЙ'),
          const DialogueLine('Карри.', by: 'КОТОМИНЕ КИРЭЙ'),
          const DialogueLine('Кажется, сейчас будет босс батл.'),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/juhani-junkala-epic-boss-battle.mp3',
            background: 'akuma',
            stages: [
              DungeonStage(
                enemies: const [PotatoEnemy(), CarrotEnemy(), CucumberEnemy()],
                multiplier: Decimal.fromInt(2),
                conditions: const [SlayedStageCondition(2)],
              ),
              DungeonStage(
                enemies: const [ChiliEnemy()],
                multiplier: Decimal.fromInt(2),
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
          MusicLine.asset('mixkit-summer-fun-13.mp3'),
          BackgroundLine.asset('location/kitchen.jpg'),
          ImageLine.asset('Kotomine_Kirei.webp'),
          const DialogueLine('Сойдёт.', by: 'КОТОМИНЕ КИРЭЙ'),
          HideImageLine.asset('Kotomine_Kirei.webp'),
          ImageLine.asset('Emiya_Shirou.webp'),
          const DialogueLine('ДААААА ЫЫЫЫ!!', by: 'Эмия'),
          const DialogueLine(
              'С твоей помощью Эмия смог приготовить людям свою еду.'),
          const DialogueLine('Приходи снова! Обязательно приходи!', by: 'Эмия'),
          const DialogueLine(
            'Кажется, моя БОН ОФ ЗЕ СОРД чуть-чуть увеличиалсь, когда я смотрел на то, как ты работаешь...',
            by: 'Эмия',
          ),
          const DialogueLine(
            'Возможно, ты - моё лекарство, путешественник!!',
            by: 'Эмия',
          ),
          HideImageLine.asset('Emiya_Shirou.webp'),
          const DialogueLine(
            'Ты сделал вид, что ты смотрел фейт и знаешь, что ничего пошлого тут нет, ну не встаёт БОН у человека.',
          ),
          const DialogueLine('Вполне себе нормальное явление.'),
          const DialogueLine(
              'Perfectly sized BONE OF THE SWORD, как говорится.'),
          const DialogueLine('С этими мыслями ты покинул ресторан.'),
        ]),
      ];
}
