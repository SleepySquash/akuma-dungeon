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
import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '../aloross.dart';
import '/domain/model/dungeon.dart';
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
          MusicLine.asset('mixkit-just-kidding-11.mp3'),
          BackgroundLine.asset('location/town.jpg'),
          const DialogueLine(
              'Ты снова отправляешься в ресторан в центре Алоросса, где нужна помощь.'),
          const DialogueLine('Поручение, достойное твоего внимания.'),
          BackgroundLine.asset('location/chinese_restaurant.jpg'),
          const DialogueLine('Внутри ноль людей, вообще никого.'),
          const DialogueLine('Казалось бы, что не так?'),
          const DialogueLine(
              'Ведь напротив кухни стойками стоят разные блюда в упаковках!'),
          const DialogueLine('Ты забегаешь за стойку на кухню, а там...'),
          BackgroundLine.asset('location/kitchen.jpg'),
          ImageLine.asset('Emiya_Shirou.webp'),
          const DialogueLine('УАУАААААХХХХ ХДЫЫЫЩЩЩ АААААА!!', by: 'Эмия'),
          const DialogueLine('ВСЕ ОБЛЕНИЛИСЬ И СТАЛИ БРАТЬ ДОСТАВКИ!',
              by: 'Эмия'),
          const DialogueLine(
              'Всё тот же школьник стоял и что-то мямлил себе под нос.'),
          const DialogueLine('Ты подходишь и спрашиваешь, что случилось.'),
          const DialogueLine(
            'Я не могу одновременно готовить и развозить еду.',
            by: 'Эмия',
          ),
          const DialogueLine(
            'Мне нужна помощь, кто-то должен развозить еду, пока я её тут готовлю.',
            by: 'Эмия',
          ),
          const DialogueLine(
            'Мысли о тебе заставляют мою БОН ОФ ЗЕ СОРД подниматься и готовить чудесные блюда.',
            by: 'Эмия',
          ),
          const DialogueLine(
            'Но кто их будет есть, если никто не приходит?',
            by: 'Эмия',
          ),
          const DialogueLine(
            'Я открыл сервис доставки, заказов просто СОТНИ!',
            by: 'Эмия',
          ),
          const DialogueLine(
              'Ты спрашиваешь, зачем он открыл сервис доставки, если у него нет доставщика.'),
          const DialogueLine(
            'Я хотел увидеть тебя, мой герой.',
            by: 'Эмия',
          ),
          const DialogueLine(
              'Ты игнорируешь его и подбираешь удобно лежащую рядом сумку доставщика.'),
          const DialogueLine(
              'Наполнив её едой, ты отправляешься относить людям их еду.'),
          const DialogueLine(
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
                  SlayedStageCondition(3),
                  TimerStageCondition(Duration(minutes: 2)),
                ],
              ),
              DungeonStage(
                name: 'Доставка',
                enemies: DeliveryEnemies.mans,
                conditions: const [
                  SlayedStageCondition(6),
                  TimerStageCondition(Duration(minutes: 2)),
                ],
              ),
              DungeonStage(
                name: 'Сброка',
                enemies: DeliveryEnemies.places,
                conditions: const [
                  SlayedStageCondition(2),
                  TimerStageCondition(Duration(minutes: 2)),
                ],
              ),
              DungeonStage(
                name: 'Доставка',
                enemies: DeliveryEnemies.mans,
                conditions: const [
                  SlayedStageCondition(5),
                  TimerStageCondition(Duration(minutes: 2)),
                ],
              ),
              DungeonStage(
                name: 'Сброка',
                enemies: DeliveryEnemies.places,
                conditions: const [
                  SlayedStageCondition(1),
                  TimerStageCondition(Duration(minutes: 2)),
                ],
              ),
              DungeonStage(
                name: 'Доставка',
                enemies: DeliveryEnemies.mans,
                conditions: const [
                  SlayedStageCondition(5),
                  TimerStageCondition(Duration(minutes: 2)),
                ],
              ),
            ],
          ),
        ),
        NovelStep([
          MusicLine.asset('mixkit-just-kidding-11.mp3'),
          BackgroundLine.asset('location/kitchen.jpg'),
          ImageLine.asset('Emiya_Shirou.webp'),
          const DialogueLine('АЙ ЭМ ЗЕ БОН ОФ МАЙ СОРД!!', by: 'Эмия'),
          const DialogueLine('Отлично, у нас снова получилось!!', by: 'Эмия'),
          const DialogueLine('ДААААА ЫЫЫЫЫ!!', by: 'Эмия'),
          const DialogueLine('Приходи снова! Обязательно приходи!', by: 'Эмия'),
          const DialogueLine('Ты покинул ресторан.'),
        ]),
      ];
}
