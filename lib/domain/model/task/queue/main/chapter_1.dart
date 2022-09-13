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

import 'package:akuma/domain/model/flag.dart';
import 'package:akuma/router.dart';
import 'package:akuma/ui/page/home/page/character/selection/view.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart' show IconData, Icons;
import 'package:novel/novel.dart';

import '/domain/model/character.dart' as akuma;
import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/item/all.dart';
import '/domain/model/reward.dart';
import '/domain/model/task_queue.dart';
import '/domain/model/task.dart';

abstract class ChapterOneTasks {
  static List<Task> get tasks => [
        ...const ChapterOne().tasks,
      ];

  static List<TaskQueue> get queues => const [
        ChapterOne(),
      ];
}

class ChapterOne extends TaskQueue {
  const ChapterOne();

  @override
  String get id => 'chapter_one';

  @override
  String get name => 'Основная история. Глава I';

  @override
  List<Task> get tasks => const [
        IntroductionTask(),
        FirstDungeonTask(),
        ShopUnlockedTask(),
      ];
}

class IntroductionTask extends Task {
  const IntroductionTask();

  @override
  String get id => 'chapter1_introduction';

  @override
  String get name => 'Знакомство';

  @override
  String? get subtitle => 'Гильдмастер просил подойти по готовности...';

  @override
  IconData get icon => Icons.interests;

  @override
  List<Reward> get rewards => const [
        ExpReward(10),
        ItemReward(PracticeOakSwordItem()),
        FlagReward(Flag.commissionUnlocked),
      ];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/guild.jpg'),
          CharacterLine('Arda.png'),
          DialogueLine(
            'Ага, уже разобрался чуть-чуть со всем?',
            by: 'Мастер',
          ),
          DialogueLine(
            'Отлично. Тогда давай начнём твою карьеру путешественника!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Для начала нужно найти тебе оружие, а то что ты как этот.',
            by: 'Мастер',
          ),
          HideCharacterLine('Arda.png'),
          DialogueLine('Вместе с гильдмастером вы отправляетесь на улицу.'),
          BackgroundLine('location/town.jpg'),
          CharacterLine('Arda.png'),
          DialogueLine(
            'Познакомлю тебя с нашим местным шопкипером.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Она просто душка, но смею предупредить: ресурсов в городе нет, поэтому и выбор будет невелик.',
            by: 'Мастер',
          ),
          HideCharacterLine('Arda.png'),
          BackgroundLine('location/library.jpg'),
          DialogueLine('Вы заходите в библиотеку.'),
          CharacterLine('Arda.png'),
          DialogueLine(
            'Бэкграунда под магазин пока нет, поэтому мы в библиотеке!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Сделай вид, что ты в магазине по-братски, ладно?',
            by: 'Мастер',
          ),
          DialogueLine('Ты делаешь вид, что вы в магазине. Да, это работает.'),
          DialogueLine('Представь себе такой уютненький небольшой магазинчик.'),
          DialogueLine(
            'Кхм, Майа, солнышко, нам нужно снаряжение!!',
            by: 'Мастер',
          ),
          CharacterLine('Mai.png'),
          DialogueLine(
            'Никита, ты ведь знаешь, что у нас его нет!',
            by: 'Майа',
          ),
          DialogueLine(
            'Ух ты, новое лицо! Добро пожаловать!!',
            by: 'Майа',
          ),
          DialogueLine(
            'А ты тут надолго??',
            by: 'Майа',
          ),
          DialogueLine(
            'Он наша новая надежда, путешественник!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Ваааай, неужели он справится с тучей данжей вокруг города??',
            by: 'Майа',
          ),
          DialogueLine(
            'Если сможет, то это же все посылочки с алиэкспресса доедут!',
            by: 'Майа',
          ),
          DialogueLine(
            'Мейк Алоросс грейт агейн, мой юный путешественник, мой герой!',
            by: 'Майа',
          ),
          DialogueLine(
            'Этому герою нужно снаряжение!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Снаряжение... Ладно, сейчас что-нибудь поищу...',
            by: 'Майа',
          ),
          HideCharacterLine('Mai.png'),
          DialogueLine('Девушка ушла куда-то в подсобку искать оружие.'),
          DialogueLine(
              'Воспользовавшись моментом, ты решил оглядеться вокруг.'),
          HideCharacterLine('Arda.png'),
          DialogueLine('Прямо перед тобой висела лёгкая повседневная одежда.'),
          DialogueLine(
              'Что-то крайне простое и скудное, от удара монстра никак не защитит.'),
          DialogueLine(
              'Чуть дальше ты заметил хозяйственные товары: мыло, шампуни.'),
          DialogueLine('Всё как-то подозрительно дорого, но товара немного.'),
          CharacterLine('Arda.png'),
          DialogueLine(
            'Что-то как-то дофига за кусок мыла, думаешь?',
            by: 'Мастер',
          ),
          DialogueLine(
            'Это последствия отсутствия торговцев в наших краях',
            by: 'Мастер',
          ),
          DialogueLine(
            'Постоянные нападения отбивают желание возить сюда товары, знаешь ли',
            by: 'Мастер',
          ),
          DialogueLine(
            'Только пара караванов, которая готова позволить себе путешественников выского класса, доезжает до нас',
            by: 'Мастер',
          ),
          DialogueLine(
            'Они нанимают B+ ранги и те справляются без проблем с живностью Алоросса',
            by: 'Мастер',
          ),
          DialogueLine(
            'Очень надеюсь, что ты поможешь исправить эту ситуацию.',
            by: 'Мастер',
          ),
          HideCharacterLine('Arda.png'),
          DialogueLine(
            'К-к сожалению, это всё, что я смогла найти...',
            by: 'Майа',
          ),
          DialogueLine('Девушка наконец вышла из коморки.'),
          CharacterLine('Mai.png'),
          DialogueLine(
            'В-вот...',
            by: 'Майа',
          ),
          HideCharacterLine('Mai.png'),
          DialogueLine('Майа положила на стол деревянный меч для тренировок.'),
          DialogueLine('Гнилой, зараза, с занозами.'),
          CharacterLine('Arda.png'),
          DialogueLine(
            'Н-да, но это лучше, чем ничего!',
            by: 'Мастер',
          ),
          DialogueLine(
            'С таким мечом ты сможешь слаймов без проблем мутузить.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Кстати, вокруг города у нас их полно, данжи с ними открываются каждый день.',
            by: 'Мастер',
          ),
          DialogueLine('Ты берёшь в руки деревянный меч.'),
          DialogueLine('Лёгкий.'),
          DialogueLine(
              'С таким можно будет быстро двигаться и уворачиваться от атак.'),
          DialogueLine(
            'Спасибо большое, Майа, дорогуша!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Сегодня наступил тот день, когда ты вложилась в спасенье нашего города от монстров!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Бу-га-га-га-га!!!',
            by: 'Мастер',
          ),
          HideCharacterLine('Arda.png'),
          DialogueLine('Вы отправляетесь обратно в гильдию.'),
          BackgroundLine('location/guild.jpg'),
          CharacterLine('Arda.png'),
          DialogueLine(
            'Теперь по поводу поручений.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Каждый день гильдия вывешивает список поручений, за выполнение которых полагается награда.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Поручения могут быть двух типов: квест или данж.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Квесты - это просьбы, которые оплачивают нуждающиеся в какой-либо услуге люди.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Например, помочь торговцу пройти через наш лес, зачистить дом от слаймов и так далее.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Такие поручения дают репутацию - признательность граждан.',
            by: 'Мастер',
          ),
          DialogueLine(
            'С достаточным уровнем репутации ты сможешь получать скидки, жильё и даже подцепить тяночек.',
            by: 'Мастер',
          ),
          DialogueLine(
            'И за квесты ты получаешь больше денег, но меньше опыта и ранга.',
            by: 'Мастер',
          ),
          DialogueLine(
            'С другой стороны подземелья или данжи.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Их вывешивает гильдия, оплата за зачистку идёт из казны города и иногда финансируется бизнесом.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Подземелья появляются довольно часто в абсолютно случайных локациях.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Точнее, появляется портал в подземелье, гейт, врата или как хочешь можешь называть это.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Если за два дня не закрыть этот портал, то из него выйдут монстры и будут атаковать граждан.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Сила вышедших монстров зависит от ранга данжа.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Ранг данжа мы умеем определять специальными камнями: F, E, D, C, B, A, S, SS, SSS, Akuma.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Выше, чем S, определить точно невозможно - камень просто взрывается от силы подземелья.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Порталы связывают наше измерение с измерением Акумы - лорда тёмных сил, который и создаёт данжи.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Мы уверены, что существует портал напрямую к нему, но его пока никто не смог обнаружить.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Да даже если и смогли бы, то победить Акуму практически невозможно.',
            by: 'Мастер',
          ),
          DialogueLine(
            'К слову, именно победа над Акумой считается главной целью всех путешественников.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Считается, что если мы его победим, то все данжи пропадут и человечество будет спать спокойно.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Почему так неуверенно? Да потому что я не знаю, никто не знает.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Это предстоит выяснить тебе, путешественник!',
            by: 'Мастер',
          ),
          DialogueLine(
            'За закрытие порталов увеличивается контроль в городе.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Чем выше контроль, тем обильнее полки с товарами, тем больше награды за поручения и данжи.',
            by: 'Мастер',
          ),
          DialogueLine(
            'За определённый уровень контроля город может вознаградить тебя разными привелегиями.',
            by: 'Мастер',
          ),
          DialogueLine(
            'А сейчас выполни пару поручений, они несложные, твоей силы хватит.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Когда закончишь, не забудь обязательно отчитаться мне и сдать эти поручения, чтобы получить награду!',
            by: 'Мастер',
          ),
          DialogueLine(
            'И не забудь надеть деревянный меч!',
            by: 'Мастер',
          ),
        ]),
      ];
}

class FirstDungeonTask extends Task {
  const FirstDungeonTask();

  @override
  String get id => 'chapter1_first_dungeon';

  @override
  List<TaskCriteria> get criteria => const [
        QuestCommissionsCompletedCriteria(2),
        WeaponEquippedCriteria(null),
      ];

  @override
  String get name => 'Первый данж';

  @override
  String? get subtitle => 'Поручения сделаны, что дальше?';

  @override
  IconData get icon => Icons.dangerous_rounded;

  @override
  List<Reward> get rewards => const [
        ExpReward(10),
        FlagReward(Flag.dungeonCommissionsUnlocked),
        FlagReward(Flag.partyUnlocked),
      ];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/guild.jpg'),
          CharacterLine('Arda.png'),
          DialogueLine(
            'Жители уже вовсю обсуждают тебя и твой вклад в Алоросс!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Благодарю тебя, путешественник!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Продолжай выполнять квесты, чтобы получать репутацию среди населения.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Что ж, давай поговорим про данжи.',
            by: 'Мастер',
          ),
          DialogueLine(
            'К сожалению, именно данжей вокруг Алоросса полно.',
            by: 'Мастер',
          ),
          DialogueLine(
            'И некоторые поручения, связанные с монстрами, - результат отсутствия путешественников, которые закрыли бы данжи вовремя.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Надеюсь, ты готов морально отправиться в путешествие в один из таких данжей.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Но одного тебя я не отпущу, ещё бы не хватало потерять нашего нового путешественника.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Твоя первая задача - отправиться в таверну и найти себе напарника!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Таверна прямо напротив гильдии, так уж исторически сложилось.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Давай, удачи.',
            by: 'Мастер',
          ),
          HideCharacterLine('Arda.png'),
          BackgroundLine('location/town.jpg'),
          DialogueLine('Ты покидаешь гильдию путешественников.'),
          DialogueLine('Прямо напротив неё, действительно, стояла таверна.'),
          DialogueLine(
              'Видимо, ты был слишком занят, чтобы разглядеть её раньше.'),
          DialogueLine('Уверенно ты входишь внутрь.'),
          BackgroundLine('location/living_room_pink.jpg'),
          DialogueLine('Вау, вот это роскошь!'),
          DialogueLine(
              'Ладно, шучу, на самом деле бэкграунда под таверну тоже пока нет, поэтому представь её себе, пожалуйста.'),
          DialogueLine('Внутри за разными столами сидели разные группы людей.'),
          DialogueLine(
              'Путешественников всего три штука - остальные явно зашли расслабиться.'),
          DialogueLine('Набравшись решительности, ты подходишь к...'),
        ]),
        ExecuteStep(() async {
          akuma.Character? character =
              await CharacterSelectionView.show(router.context!);
          if (character == null) {
            throw Exception('Returned character should not be `null`.');
          }

          await Novel.show(
            context: router.context!,
            scenario: [
              const MusicLine('MOSAICWAV_she_already_gone.mp3'),
              BackgroundLine('location/living_room_pink.jpg'),
              DialogueLine('Ты уверенно подходишь к ${character.name}.'),
              CharacterLine('${character.asset}.png'),
              DialogueLine('Ты говоришь, что хотел бы побыть вместе в пати.'),
              if (character.id == 'Rio') ...[
                DialogueLine(
                  'Безусловно, я согласна.',
                  by: character.name,
                ),
                DialogueLine(
                  'Мне будет удовольствием улучшать свои навыки стрельбы из лука.',
                  by: character.name,
                ),
              ] else if (character.id == 'Rozzi') ...[
                DialogueLine(
                  'Хорошо, я не против.',
                  by: character.name,
                ),
                DialogueLine(
                  'Я всё равно устала ходить в одиночку, давай разнообразим процесс.',
                  by: character.name,
                ),
              ] else ...[
                DialogueLine(
                  'Ух ты, какой смелый...',
                  by: character.name,
                ),
                DialogueLine(
                  'Ухуху, хорошо, я согласна присоединиться к тебе.',
                  by: character.name,
                ),
                DialogueLine(
                  'Только помни, что это равносильно свадьбе~',
                  by: character.name,
                ),
                DialogueLine(
                  'Ещё ни один мужчина так резко не предлагал мне свои руку и сердце...',
                  by: character.name,
                ),
                DialogueLine('Кажется, она что-то неправильно поняла.'),
                DialogueLine('Или всё так?'),
              ],
              HideCharacterLine('${character.asset}.png'),
              DialogueLine(
                'Вместе с ${character.name} ты отправляешься в гильдию.',
              ),
              BackgroundLine('location/guild.jpg'),
              CharacterLine('Arda.png'),
              DialogueLine(
                'Вот это ты пикапер!',
                by: 'Мастер',
              ),
              DialogueLine(
                'Честно, не ожидал, что ты кого-то вообще найдёшь!',
                by: 'Мастер',
              ),
              DialogueLine(
                'М-да, это ты молодец, это что-то я искал своего первого сопартийца 5 лет...',
                by: 'Мастер',
              ),
              DialogueLine(
                'И им оказался двухметровый качок...',
                by: 'Мастер',
              ),
              DialogueLine(
                'Так, это, да, тогда я даю тебе поручение.',
                by: 'Мастер',
              ),
              DialogueLine(
                'Рядом с городом открылся данж F ранга два дня назад.',
                by: 'Мастер',
              ),
              DialogueLine(
                'Вот-вот монстры выйдут наружу и снова будут нападать на город.',
                by: 'Мастер',
              ),
              DialogueLine(
                'Судя по оценке, там внутри слабенькие слаймы, поэтому как раз то, что нужно для первого данжа.',
                by: 'Мастер',
              ),
              DialogueLine(
                'Вперёд, ребята, не умирайте!',
                by: 'Мастер',
              ),
            ],
          );
        }),
        DungeonStep(
          Dungeon(
            music: AssetSource('music/mixkit-games-worldbeat-466.mp3'),
            background: 'mines',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(20)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(20)],
              ),
              DungeonStage(
                background: 'underground_waterfall',
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(20)],
              ),
              DungeonStage(
                background: 'underground_waterfall',
                enemies: SlimeEnemies.fPlus,
                conditions: const [SlayedStageCondition(1)],
              ),
            ],
          ),
          withEntrance: true,
        ),
        NovelStep([
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/guild.jpg'),
          CharacterLine('Arda.png'),
          DialogueLine(
            'Отлично, путешественник!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Я горжусь тобой!',
            by: 'Мастер',
          ),
          DialogueLine(
            'С твоей помощью мы сможем очистить Алоросс от монстров!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Продолжай выполнять поручения на зачистку данжей, чтобы повысить контроль в городе.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Вперёд, герой!',
            by: 'Мастер',
          ),
        ]),
      ];
}

class ShopUnlockedTask extends Task {
  const ShopUnlockedTask();

  @override
  String get id => 'chapter1_shop_unlocked';

  @override
  String? get subtitle => 'Монстров вокруг города стало меньше';

  @override
  List<TaskCriteria> get criteria => const [
        LevelCriteria(2),
        DungeonCommissionsCompletedCriteria(3),
      ];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/town.jpg'),
          DialogueLine(
              'Закрыв очередной данж с слаймами, ты возвращаешься в Алоросс.'),
          DialogueLine(
              'Погода стояла отличная, даже казалось, что с тех пор, как ты начал выполнять поручения, город стал живее.'),
          DialogueLine(
              'Обидно, что тебе дают только слаймов - город терроризируют явно более опасные формы жизни.'),
          DialogueLine(
              'Твоя текущая цель - достичь следующего ранга путешественника, тогда тебе доверят более опасные поручения.'),
          DialogueLine(
              'С этими мыслями ты двигался в сторону гильдии, но путь твой прервал знакомый голос.'),
          DialogueLine('Путешественник!', by: 'Майя'),
          CharacterLine('Mai.png'),
          DialogueLine(
            'Благодаря тому, что кто-то (естественно, ты) начал закрывать подземелья, торговцы стали активнее нас посещать!',
            by: 'Майя',
          ),
        ]),
        DungeonStep(
          Dungeon(
            stages: [
              DungeonStage(
                background: 'fields',
                enemies: SlimeEnemies.unique,
                conditions: const [SlayedStageCondition(1)],
                multiplier: 1,
              ),
            ],
          ),
        ),
      ];
}
