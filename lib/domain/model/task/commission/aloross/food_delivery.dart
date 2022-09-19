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

import 'package:akuma/domain/model/enemy/delivery.dart';
import 'package:akuma/domain/model/item/all.dart';
import 'package:akuma/domain/model/location/all.dart';
import 'package:akuma/domain/model/reward.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '../aloross.dart';
import '/domain/model/dungeon.dart';
import '/domain/model/enemy/veggies.dart';
import '/domain/model/task.dart';
import 'restaurant.dart';

class AlorossFoodDeliveryCommission extends AlorossCommission {
  const AlorossFoodDeliveryCommission();

  @override
  String get name => 'Доставка еды';

  @override
  String? get subtitle => 'Ресторан просит помочь с доставкой еды.';

  @override
  String? get description =>
      'ВСЁ ОЧЕНЬ ПЛОХО, СРОЧНО НУЖЕН КТО-НИБУДЬ, КТО ПОМОЖЕТ МНЕ С ДОСТАВКОЙ ЕДЫ!!!';

  @override
  IconData get icon => Icons.restaurant;

  @override
  List<TaskCriteria> get criteria => const [
        CompletedCriteria(task: AlorossRestaurantCommission()),
        NotCompletedCriteria(),
      ];

  @override
  List<Reward> get rewards => const [
        MoneyReward(1600),
        ExpReward(250),
        ItemReward(Ruby(5)),
        RankReward(5),
        ReputationReward(AlorossLocation(), 2),
      ];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          const MusicLine('mixkit-just-kidding-11.mp3'),
          BackgroundLine('location/town.jpg'),
          DialogueLine(
              'Ты снова отправляешься в ресторан в центре Алоросса, где нужна помощь.'),
          DialogueLine('Поручение, достойное твоего внимания.'),
          BackgroundLine('location/chinese_restaurant.jpg'),
          DialogueLine('Внутри ноль людей, вообще никого.'),
          DialogueLine('Казалось бы, что не так?'),
          DialogueLine(
              'Ведь напротив кухни стойками стоят разные блюда в упаковках!'),
          DialogueLine('Ты забегаешь за стойку на кухню, а там...'),
          BackgroundLine('location/kitchen.jpg'),
          CharacterLine('Emiya_Shirou.webp'),
          DialogueLine('УАУАААААХХХХ ХДЫЫЫЩЩЩ АААААА!!', by: 'Эмия'),
          DialogueLine('ВСЕ ОБЛЕНИЛИСЬ И СТАЛИ БРАТЬ ДОСТАВКИ!', by: 'Эмия'),
          DialogueLine(
              'Всё тот же школьник стоял и что-то мямлил себе под нос.'),
          DialogueLine('Ты подходишь и спрашиваешь, что случилось.'),
          DialogueLine(
            'Я не могу одновременно готовить и развозить еду.',
            by: 'Эмия',
          ),
          DialogueLine(
            'Мне нужна помощь, кто-то должен развозить еду, пока я её тут готовлю.',
            by: 'Эмия',
          ),
          DialogueLine(
            'Мысли о тебе заставляют мою БОН ОФ ЗЕ СОРД подниматься и готовить чудесные блюда.',
            by: 'Эмия',
          ),
          DialogueLine(
            'Но кто их будет есть, если никто не приходит?',
            by: 'Эмия',
          ),
          DialogueLine(
            'Я открыл сервис доставки, заказов просто СОТНИ!',
            by: 'Эмия',
          ),
          DialogueLine(
              'Ты спрашиваешь, зачем он открыл сервис доставки, если у него нет доставщика.'),
          DialogueLine(
            'Я хотел увидеть тебя, мой герой.',
            by: 'Эмия',
          ),
          DialogueLine(
              'Ты игнорируешь его и подбираешь удобно лежащую рядом сумку доставщика.'),
          DialogueLine(
              'Наполнив её едой, ты отправляешься относить людям их еду.'),
          DialogueLine(
            'Вперёд!!! АЙ ЭМ ЗЕ БОН ОФ МАЙ СОРД!!!!!',
            by: 'Эмия',
          ),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-comical-2.mp3',
            background: 'town',
            stages: [
              DungeonStage(
                name: 'Сброка',
                enemies: DeliveryEnemies.places,
                conditions: const [
                  SlayedStageCondition(6),
                  TimerStageCondition(Duration(minutes: 2)),
                ],
              ),
              DungeonStage(
                name: 'Доставка',
                enemies: DeliveryEnemies.mans,
                conditions: const [
                  SlayedStageCondition(12),
                  TimerStageCondition(Duration(minutes: 2)),
                ],
              ),
              DungeonStage(
                name: 'Сброка',
                enemies: DeliveryEnemies.places,
                conditions: const [
                  SlayedStageCondition(4),
                  TimerStageCondition(Duration(minutes: 2)),
                ],
              ),
              DungeonStage(
                name: 'Доставка',
                enemies: DeliveryEnemies.mans,
                conditions: const [
                  SlayedStageCondition(9),
                  TimerStageCondition(Duration(minutes: 2)),
                ],
              ),
              DungeonStage(
                name: 'Сброка',
                enemies: DeliveryEnemies.places,
                conditions: const [
                  SlayedStageCondition(3),
                  TimerStageCondition(Duration(minutes: 2)),
                ],
              ),
              DungeonStage(
                name: 'Доставка',
                enemies: DeliveryEnemies.mans,
                conditions: const [
                  SlayedStageCondition(13),
                  TimerStageCondition(Duration(minutes: 2)),
                ],
              ),
            ],
          ),
        ),
        NovelStep([
          const MusicLine('mixkit-just-kidding-11.mp3'),
          BackgroundLine('location/kitchen.jpg'),
          CharacterLine('Emiya_Shirou.webp'),
          DialogueLine('АЙ ЭМ ЗЕ БОН ОФ МАЙ СОРД!!', by: 'Эмия'),
          DialogueLine('Отлично, у нас снова получилось!!', by: 'Эмия'),
          DialogueLine('ДААААА ЫЫЫЫЫ!!', by: 'Эмия'),
          DialogueLine('Приходи снова! Обязательно приходи!', by: 'Эмия'),
          DialogueLine('Ты покинул ресторан.'),
        ]),
      ];
}
