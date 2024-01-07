import 'package:akuma/util/novel.dart';
import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '/domain/model/character.dart' as akuma;
import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/flag.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';
import '/router.dart';
import '/ui/page/specific/naksiasraass_buy/view.dart';
import '/ui/page/specific/character_selection/view.dart';

class FirstDungeonTask extends Task {
  const FirstDungeonTask();

  @override
  String get id => 'chapter1_first_dungeon';

  @override
  List<TaskCriteria> get criteria => const [
        QuestCommissionsCompletedCriteria(5),
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
          MusicLine.asset('mixkit-summer-fun-13.mp3'),
          BackgroundLine.asset('location/guild.jpg'),
          ImageLine.asset('Arda.png'),
          const DialogueLine(
            'Жители уже вовсю обсуждают тебя и твой вклад в Алоросс!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Благодарю тебя, путешественник!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Продолжай выполнять квесты, чтобы получать репутацию среди населения.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Что ж, давай поговорим про данжи.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'К сожалению, именно данжей вокруг Алоросса полно.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'И некоторые поручения, связанные с монстрами, - результат отсутствия путешественников, которые закрыли бы данжи вовремя.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Надеюсь, ты готов морально отправиться в путешествие в один из таких данжей.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Но одного тебя я не отпущу, ещё бы не хватало потерять нашего нового путешественника.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Твоя первая задача - отправиться в таверну и найти себе напарника!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Таверна прямо напротив гильдии, так уж исторически сложилось.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Давай, удачи.',
            by: 'Мастер',
          ),
          HideImageLine.asset('Arda.png'),
          BackgroundLine.asset('location/town.jpg'),
          const DialogueLine('Ты покидаешь гильдию путешественников.'),
          const DialogueLine(
              'Прямо напротив неё, действительно, стояла таверна.'),
          const DialogueLine(
              'Видимо, ты был слишком занят, чтобы разглядеть её раньше.'),
          const DialogueLine('Уверенно ты входишь внутрь.'),
          BackgroundLine.asset('location/living_room_pink.jpg'),
          const DialogueLine('Вау, вот это роскошь!'),
          const DialogueLine(
              'Ладно, шучу, на самом деле бэкграунда под таверну тоже пока нет, поэтому представь её себе, пожалуйста.'),
          const DialogueLine(
              'В заведении ты наблюдаешь в основном простых работяг, зашедших сюда отдохнуть.'),
          const DialogueLine(
              'И у окна, в самом углу таверны, сидела пара ребят, чьи мечи опасно блестели на свету.'),
          const DialogueLine(
              'Набравшись решительности, ты подходишь к их столику.'),
          const DialogueLine(
              'Ты пристствуешь странников и спрашиваешь, насколько возможно присоединиться к кому-нибудь в пати.'),
          const DialogueLine(
              'Ребята, судя по выражениям лиц, крайне угрюмо отреагировали на твои слова.'),
          ImageLine.asset('Bernice.png'),
          const DialogueLine(
            'Парень, ты тут явно новый и чего-то не понимаешь.',
            by: 'Бернис',
          ),
          const DialogueLine(
            'Гильдию здесь не уважают и путешествовать с тобой никто не будет.',
            by: 'Бернис',
          ),
          const DialogueLine(
            'C твоим рангом, твоим снаряжением и характером ты тут просто никто.',
            by: 'Бернис',
          ),
          const DialogueLine(
              'Ты спрашиваешь, в чём дело и почему никто не закрывает подземелья.'),
          const DialogueLine(
            'А там что, деньги какие-то есть?',
            by: 'Бернис',
          ),
          const DialogueLine(
            'Парень, деньги берутся у богатых, а не у монстров.',
            by: 'Бернис',
          ),
          const DialogueLine(
            'А богатые получают свой бюджет из политики, не из гильдии.',
            by: 'Бернис',
          ),
          const DialogueLine(
            'Почитай свиттер, что ли, честное слово.',
            by: 'Бернис',
          ),
          HideImageLine.asset('Bernice.png'),
          const DialogueLine('Кое-что начинает проясняться.'),
          MusicLine.asset('mixkit-beautiful-dream-493.mp3'),
          BackgroundLine.asset('location/town.jpg'),
          const DialogueLine(
              'Ты обошёл ещё несколько заведений, везде о путешественниках отзываются негативно.'),
          const DialogueLine(
              'Значит, какая картина: в Алороссе те, кто могут сражаться, в основном разбойничают и грабят.'),
          const DialogueLine(
              'И проблема в том, что администрация знает об этом.'),
          const DialogueLine(
              'Кто-то построил свою империю в Алороссе и легализирует преступность.'),
          const DialogueLine(
              'Ты ведь vengence, ты не можешь это так оставить.'),
          const DialogueLine(
              'Но, к сожалению, без сопартийца тебе действительно будет тяжко.'),
          const DialogueLine(
              'Данжи не ограничиваются парой слаймов, это орды - тебе не хватит выносливости.'),
          BackgroundLine.asset('location/ghetto.jpg'),
          const DialogueLine('Ты забрёл в некие трущобы под городом.'),
          const DialogueLine(
              'Кажется, что они заброшены и здесь никто не живёт.'),
          const DialogueLine(
              'Но тебе всего лишь кажется - тут и там торчат чьи-то уши, смотрят чьи-то глаза, пристально кто-то наблюдает.'),
          const DialogueLine('В этих домиках живут люди. Или не совсем люди?'),
          const DialogueLine(
              'Присмотревшись, ты действительно отмечаешь, что это место - присталище ушастых антропоморфов.'),
          const DialogueLine('Они не доверяют тебе, они настроены враждебно.'),
          const DialogueLine(
              'Атмосфера явно неприятная и из тебя прёт желанием исправить ситуацию.'),
          const DialogueLine(
              'Возможно, тебя обзовут агентом. Может, это даже не будет далеким от правды.'),
          const DialogueLine('Но ты добьёшься правосудия.'),
          const DialogueLine(
              'В своих размышлениях ты постепенно переходишь на фазу принятия того факта, что ты никого не найдёшь и тут.'),
          const DialogueLine(
              'Банально будет неправильно, даже если втереться кому-то в доверие, вести этих бедных существ на убой.'),
          const DialogueLine(
              'Хилые, голодные, лишённые смысла жизни и запуганные системой, истощённые людским отношением.'),
          const DialogueLine(
              'Ты решил уйти, но уйти ненадолго - ты обязательно вернёшься с едой, когда закроешь этот данж.'),
          const DialogueLine(
              'Закрывать подземелья и убивать монстров - пока одна из немногих вещей, которую ты можешь делать, чтобы изменить такой устой.'),
          const DialogueLine(
              'И когда ты уже развернулся и начал идти в сторону города, твой путь преградил мужчина.'),
          ImageLine.asset('Beloukas.webp'),
          const DialogueLine('Ты ищешь сопартийца?', by: 'Белыйкавказ'),
          const DialogueLine('А? Откуда я знаю?', by: 'Белыйкавказ'),
          const DialogueLine(
            'Всё, что происходит в Алороссе, проходит через меня.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Меня зовут Белыйкавказ, и я могу помочь тебе за символическую плату.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Есть категория, мм, граждан, готовая за еду выполнять твои поручения.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Нет-нет, не подумай, я не работорговец, я глава приюта бездомных.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Как ты мог заметить, огромное количество ушастых живёт здесь.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Я, можно сказать, иногда присматриваю за ними и даю возможность выбраться отсюда.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Идея такая: у людей при деньгах часто нет времени на домашние дела.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Они платят мне, я общаюсь с ушастыми и предлагаю им контракт.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Ушастый выполняет домашние дела, в обмен его кормят.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Это бизнес, но бизнес осторожный - пусть у нас тут и разруха, никакое насилие мной не одобряется.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Я слежу за тем, чтобы никто не пострадал в ходе такой работы.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Некоторым ушастым предлагают ночлег - я соглашаюсь только при согласии самого ушастого на такую сделку.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Поверь, благодаря мне свой дом нашли множество питомцев.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
              'Ты проглатываешь тот факт, что он называет разумных антропомофров питомцами.'),
          const DialogueLine(
            'Пройдём внутрь.',
            by: 'Белыйкавказ',
          ),
          HideImageLine.asset('Beloukas.webp'),
          const DialogueLine('Ты следуешь за дедом.'),
          BackgroundLine.asset('location/old_house_zombie.jpg'),
          ImageLine.asset('Beloukas.webp'),
          const DialogueLine(
            'На руку зомби не смотри - это декорация.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Ну, я немножко шутник, обожаю устраивать стендапы.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Эта рука - один из панчлайнов очень смешной шутки, кстати, заходи как-нибудь, расскажу обязательно.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Я содержу этот приют уже больше 20-ти лет.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Те, кто теряют средства на существование или даже семью, приходят сюда.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Всё добровольно, мой товар должен быть надлежащего качества, да и я не монстр какой-нибудь.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Монстров ты, путешественник, с моей помощью будешь уничтожать позже.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Часто мы заключаем договор об опекунстве.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Наверное, именно в таком ты и будешь заинтересован.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Как опекун, ты будешь обязан полностью содержать своего ушастого, но очевидный плюс - получишь сопартийца.',
            by: 'Белыйкавказ',
          ),
          HideImageLine.asset('Beloukas.webp'),
          const DialogueLine('Вы проходите в одну из комнат приюта.'),
          const DialogueLine('Внутри сидели ребята абсолютно разных рас.'),
          const DialogueLine(
              'Список их активностей явно ограничен парой книг и несколькими игрушками.'),
          const DialogueLine(
              'Что примечательно, людей среди них действительно нет.'),
          const DialogueLine(
              'Та прислуга, которую ты видел ранее - вероятно, она вся отсюда и именно Белыйкавказ за этим наблюдает.'),
          const DialogueLine('Ты осматриваешь ребят, все осматривают тебя.'),
          const DialogueLine(
              'Ты не можешь в любом случае никого из них взять к себе, ты не можешь подвергать их жизнь опасности.'),
          const DialogueLine(
              'Все те мысли, что думались чуть ранее, исходили из сердца.'),
          const DialogueLine(
              'И если верить хозяину, здесь о них думают и дают крышу над головой.'),
          const DialogueLine('Пусть и относятся как к животным.'),
          ImageLine.asset('Beloukas.webp'),
          const DialogueLine(
            'Все конкретно в этом приюте готовы к тому, чтобы их забрали в любую передрягу.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Это те, кому уже нечего терять, а жить такую жизнь им надоело.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Ну, ты согласен? Плата будет чисто символической.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
              'Ты говоришь, что не готов подвергать никого здесь опасности, твоя цель наоборот защитить все эти глазки.'),
          const DialogueLine('Белыйкавказ не сильно расстроился.'),
          const DialogueLine(
            'Что ж, рано или поздно мои услуги тебе пригодятся, поэтому я всегда здесь.',
            by: 'Белыйкавказ',
          ),
          HideImageLine.asset('Beloukas.webp'),
          const DialogueLine(
              'Ты благодаришь его за заботу о бездомных и собираешься уходить, но в твои глаза бросается девочка в углу комнаты.'),
          ImageLine.asset('Naksiasraass.png'),
          const DialogueLine(
              'Совсем исхудавшая, она забилась в углу и безжизненно смотрела в пустоту, изредка взрагивая.'),
          const DialogueLine(
            'А, Накси?',
            by: 'Белыйкавказ',
          ),
          const DialogueLine('Ты спрашиваешь, что с ней.'),
          const DialogueLine(
            'Едва ли она будет полезна в твоих приключениях.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
              'Ты напоминаешь, что не рассматриваешь никого в пати.'),
          const DialogueLine(
            'Да-да, Накси родилась здесь, родители уже скончались, с тех пор чем-то постоянно болеет, ни ест, ни пьёт почти.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Таких здесь много, не смотри на меня, я ничего не могу поделать.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Большинству не до друзей тут, сам понимаешь.',
            by: 'Белыйкавказ',
          ),
          HideImageLine.asset('Naksiasraass.webp'),
          const DialogueLine('Ты решаешь отвести её к врачу.'),
          ImageLine.asset('Beloukas.webp'),
          const DialogueLine(
            'Не так быстро, сначала плата.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Ты запросто можешь забрать её и убежать куда-нибудь, так не пойдёт.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine(
            'Какой бы обузой она не была, напоминаю, это всё ещё бизнес.',
            by: 'Белыйкавказ',
          ),
          const DialogueLine('Придётся платить.'),
        ]),
        ExecuteStep(() async {
          bool? result = await NaksiasraassBuyView.show(router.context!);
          if (result == true) {
            return true;
          }

          return false;
        }),
        NovelStep([
          MusicLine.asset('mixkit-beautiful-dream-493.mp3'),
          BackgroundLine.asset('location/old_house_zombie.jpg'),
          ImageLine.asset('Beloukas.webp'),
          const DialogueLine(
            '...',
            by: 'Белыйкавказ',
          ),
        ]),
        ExecuteStep(() async {
          akuma.Character? character =
              await CharacterSelectionView.show(router.context!);
          if (character == null) {
            throw Exception('Returned character should not be `null`.');
          }

          await Novel.show(
            context: router.context!,
            options: NovelExtension.options(),
            scenario: [
              MusicLine.asset('MOSAICWAV_she_already_gone.mp3'),
              BackgroundLine.asset('location/living_room_pink.jpg'),
              DialogueLine('Ты уверенно подходишь к ${character.name}.'),
              ImageLine.asset('${character.asset}.png'),
              const DialogueLine(
                  'Ты говоришь, что хотел бы побыть вместе в пати.'),
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
                const DialogueLine('Кажется, она что-то неправильно поняла.'),
                const DialogueLine('Или всё так?'),
              ],
              HideImageLine.asset('${character.asset}.png'),
              DialogueLine(
                'Вместе с ${character.name} ты отправляешься в гильдию.',
              ),
              BackgroundLine.asset('location/guild.jpg'),
              ImageLine.asset('Arda.png'),
              const DialogueLine(
                'Вот это ты пикапер!',
                by: 'Мастер',
              ),
              const DialogueLine(
                'Честно, не ожидал, что ты кого-то вообще найдёшь!',
                by: 'Мастер',
              ),
              const DialogueLine(
                'М-да, это ты молодец, это что-то я искал своего первого сопартийца 5 лет...',
                by: 'Мастер',
              ),
              const DialogueLine(
                'И им оказался двухметровый качок...',
                by: 'Мастер',
              ),
              const DialogueLine(
                'Так, это, да, тогда я даю тебе поручение.',
                by: 'Мастер',
              ),
              const DialogueLine(
                'Рядом с городом открылся данж F ранга два дня назад.',
                by: 'Мастер',
              ),
              const DialogueLine(
                'Вот-вот монстры выйдут наружу и снова будут нападать на город.',
                by: 'Мастер',
              ),
              const DialogueLine(
                'Судя по оценке, там внутри слабенькие слаймы, поэтому как раз то, что нужно для первого данжа.',
                by: 'Мастер',
              ),
              const DialogueLine(
                'Вперёд, ребята, не умирайте!',
                by: 'Мастер',
              ),
            ],
          );

          return true;
        }),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-games-worldbeat-466.mp3',
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
          MusicLine.asset('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine.asset('location/guild.jpg'),
          ImageLine.asset('Arda.png'),
          const DialogueLine(
            'Отлично, путешественник!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Я горжусь тобой!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'С твоей помощью мы сможем очистить Алоросс от монстров!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Продолжай выполнять поручения на зачистку данжей, чтобы повысить контроль в городе.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Вперёд, герой!',
            by: 'Мастер',
          ),
        ]),
      ];
}
