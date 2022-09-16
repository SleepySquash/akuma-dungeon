import 'package:akuma/ui/page/specific/naksiasraass_buy/view.dart';
import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '/domain/model/character.dart' as akuma;
import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/flag.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';
import '/router.dart';
import '../../../../../../ui/page/specific/character_selection/view.dart';

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
          const MusicLine('mixkit-summer-fun-13.mp3'),
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
          DialogueLine(
              'В заведении ты наблюдаешь в основном простых работяг, зашедших сюда отдохнуть.'),
          DialogueLine(
              'И у окна, в самом углу таверны, сидела пара ребят, чьи мечи опасно блестели на свету.'),
          DialogueLine('Набравшись решительности, ты подходишь к их столику.'),
          DialogueLine(
              'Ты пристствуешь странников и спрашиваешь, насколько возможно присоединиться к кому-нибудь в пати.'),
          DialogueLine(
              'Ребята, судя по выражениям лиц, крайне угрюмо отреагировали на твои слова.'),
          CharacterLine('Bernice.png'),
          DialogueLine(
            'Парень, ты тут явно новый и чего-то не понимаешь.',
            by: 'Бернис',
          ),
          DialogueLine(
            'Гильдию здесь не уважают и путешествовать с тобой никто не будет.',
            by: 'Бернис',
          ),
          DialogueLine(
            'C твоим рангом, твоим снаряжением и характером ты тут просто никто.',
            by: 'Бернис',
          ),
          DialogueLine(
              'Ты спрашиваешь, в чём дело и почему никто не закрывает подземелья.'),
          DialogueLine(
            'А там что, деньги какие-то есть?',
            by: 'Бернис',
          ),
          DialogueLine(
            'Парень, деньги берутся у богатых, а не у монстров.',
            by: 'Бернис',
          ),
          DialogueLine(
            'А богатые получают свой бюджет из политики, не из гильдии.',
            by: 'Бернис',
          ),
          DialogueLine(
            'Почитай свиттер, что ли, честное слово.',
            by: 'Бернис',
          ),
          HideCharacterLine('Bernice.png'),
          DialogueLine('Кое-что начинает проясняться.'),
          const MusicLine('mixkit-beautiful-dream-493.mp3'),
          BackgroundLine('location/town.jpg'),
          DialogueLine(
              'Ты обошёл ещё несколько заведений, везде о путешественниках отзываются негативно.'),
          DialogueLine(
              'Значит, какая картина: в Алороссе те, кто могут сражаться, в основном разбойничают и грабят.'),
          DialogueLine('И проблема в том, что администрация знает об этом.'),
          DialogueLine(
              'Кто-то построил свою империю в Алороссе и легализирует преступность.'),
          DialogueLine('Ты ведь vengence, ты не можешь это так оставить.'),
          DialogueLine(
              'Но, к сожалению, без сопартийца тебе действительно будет тяжко.'),
          DialogueLine(
              'Данжи не ограничиваются парой слаймов, это орды - тебе не хватит выносливости.'),
          BackgroundLine('location/ghetto.jpg'),
          DialogueLine('Ты забрёл в некие трущобы под городом.'),
          DialogueLine('Кажется, что они заброшены и здесь никто не живёт.'),
          DialogueLine(
              'Но тебе всего лишь кажется - тут и там торчат чьи-то уши, смотрят чьи-то глаза, пристально кто-то наблюдает.'),
          DialogueLine('В этих домиках живут люди. Или не совсем люди?'),
          DialogueLine(
              'Присмотревшись, ты действительно отмечаешь, что это место - присталище ушастых антропоморфов.'),
          DialogueLine('Они не доверяют тебе, они настроены враждебно.'),
          DialogueLine(
              'Атмосфера явно неприятная и из тебя прёт желанием исправить ситуацию.'),
          DialogueLine(
              'Возможно, тебя обзовут агентом. Может, это даже не будет далеким от правды.'),
          DialogueLine('Но ты добьёшься правосудия.'),
          DialogueLine(
              'В своих размышлениях ты постепенно переходишь на фазу принятия того факта, что ты никого не найдёшь и тут.'),
          DialogueLine(
              'Банально будет неправильно, даже если втереться кому-то в доверие, вести этих бедных существ на убой.'),
          DialogueLine(
              'Хилые, голодные, лишённые смысла жизни и запуганные системой, истощённые людским отношением.'),
          DialogueLine(
              'Ты решил уйти, но уйти ненадолго - ты обязательно вернёшься с едой, когда закроешь этот данж.'),
          DialogueLine(
              'Закрывать подземелья и убивать монстров - пока одна из немногих вещей, которую ты можешь делать, чтобы изменить такой устой.'),
          DialogueLine(
              'И когда ты уже развернулся и начал идти в сторону города, твой путь преградил мужчина.'),
          CharacterLine('Beloukas.webp'),
          DialogueLine('Ты ищешь сопартийца?', by: 'Белыйкавказ'),
          DialogueLine('А? Откуда я знаю?', by: 'Белыйкавказ'),
          DialogueLine(
            'Всё, что происходит в Алороссе, проходит через меня.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Меня зовут Белыйкавказ, и я могу помочь тебе за символическую плату.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Есть категория, мм, граждан, готовая за еду выполнять твои поручения.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Нет-нет, не подумай, я не работорговец, я глава приюта бездомных.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Как ты мог заметить, огромное количество ушастых живёт здесь.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Я, можно сказать, иногда присматриваю за ними и даю возможность выбраться отсюда.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Идея такая: у людей при деньгах часто нет времени на домашние дела.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Они платят мне, я общаюсь с ушастыми и предлагаю им контракт.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Ушастый выполняет домашние дела, в обмен его кормят.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Это бизнес, но бизнес осторожный - пусть у нас тут и разруха, никакое насилие мной не одобряется.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Я слежу за тем, чтобы никто не пострадал в ходе такой работы.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Некоторым ушастым предлагают ночлег - я соглашаюсь только при согласии самого ушастого на такую сделку.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Поверь, благодаря мне свой дом нашли множество питомцев.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
              'Ты проглатываешь тот факт, что он называет разумных антропомофров питомцами.'),
          DialogueLine(
            'Пройдём внутрь.',
            by: 'Белыйкавказ',
          ),
          HideCharacterLine('Beloukas.webp'),
          DialogueLine('Ты следуешь за дедом.'),
          BackgroundLine('location/old_house_zombie.jpg'),
          CharacterLine('Beloukas.webp'),
          DialogueLine(
            'На руку зомби не смотри - это декорация.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Ну, я немножко шутник, обожаю устраивать стендапы.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Эта рука - один из панчлайнов очень смешной шутки, кстати, заходи как-нибудь, расскажу обязательно.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Я содержу этот приют уже больше 20-ти лет.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Те, кто теряют средства на существование или даже семью, приходят сюда.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Всё добровольно, мой товар должен быть надлежащего качества, да и я не монстр какой-нибудь.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Монстров ты, путешественник, с моей помощью будешь уничтожать позже.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Часто мы заключаем договор об опекунстве.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Наверное, именно в таком ты и будешь заинтересован.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Как опекун, ты будешь обязан полностью содержать своего ушастого, но очевидный плюс - получишь сопартийца.',
            by: 'Белыйкавказ',
          ),
          HideCharacterLine('Beloukas.webp'),
          DialogueLine('Вы проходите в одну из комнат приюта.'),
          DialogueLine('Внутри сидели ребята абсолютно разных рас.'),
          DialogueLine(
              'Список их активностей явно ограничен парой книг и несколькими игрушками.'),
          DialogueLine('Что примечательно, людей среди них действительно нет.'),
          DialogueLine(
              'Та прислуга, которую ты видел ранее - вероятно, она вся отсюда и именно Белыйкавказ за этим наблюдает.'),
          DialogueLine('Ты осматриваешь ребят, все осматривают тебя.'),
          DialogueLine(
              'Ты не можешь в любом случае никого из них взять к себе, ты не можешь подвергать их жизнь опасности.'),
          DialogueLine(
              'Все те мысли, что думались чуть ранее, исходили из сердца.'),
          DialogueLine(
              'И если верить хозяину, здесь о них думают и дают крышу над головой.'),
          DialogueLine('Пусть и относятся как к животным.'),
          CharacterLine('Beloukas.webp'),
          DialogueLine(
            'Все конкретно в этом приюте готовы к тому, чтобы их забрали в любую передрягу.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Это те, кому уже нечего терять, а жить такую жизнь им надоело.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Ну, ты согласен? Плата будет чисто символической.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
              'Ты говоришь, что не готов подвергать никого здесь опасности, твоя цель наоборот защитить все эти глазки.'),
          DialogueLine('Белыйкавказ не сильно расстроился.'),
          DialogueLine(
            'Что ж, рано или поздно мои услуги тебе пригодятся, поэтому я всегда здесь.',
            by: 'Белыйкавказ',
          ),
          HideCharacterLine('Beloukas.webp'),
          DialogueLine(
              'Ты благодаришь его за заботу о бездомных и собираешься уходить, но в твои глаза бросается девочка в углу комнаты.'),
          CharacterLine('Naksiasraass.png'),
          DialogueLine(
              'Совсем исхудавшая, она забилась в углу и безжизненно смотрела в пустоту, изредка взрагивая.'),
          DialogueLine(
            'А, Накси?',
            by: 'Белыйкавказ',
          ),
          DialogueLine('Ты спрашиваешь, что с ней.'),
          DialogueLine(
            'Едва ли она будет полезна в твоих приключениях.',
            by: 'Белыйкавказ',
          ),
          DialogueLine('Ты напоминаешь, что не рассматриваешь никого в пати.'),
          DialogueLine(
            'Да-да, Накси родилась здесь, родители уже скончались, с тех пор чем-то постоянно болеет, ни ест, ни пьёт почти.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Таких здесь много, не смотри на меня, я ничего не могу поделать.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Большинству не до друзей тут, сам понимаешь.',
            by: 'Белыйкавказ',
          ),
          HideCharacterLine('Naksiasraass.webp'),
          DialogueLine('Ты решаешь отвести её к врачу.'),
          CharacterLine('Beloukas.webp'),
          DialogueLine(
            'Не так быстро, сначала плата.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Ты запросто можешь забрать её и убежать куда-нибудь, так не пойдёт.',
            by: 'Белыйкавказ',
          ),
          DialogueLine(
            'Какой бы обузой она не была, напоминаю, это всё ещё бизнес.',
            by: 'Белыйкавказ',
          ),
          DialogueLine('Придётся платить.'),
        ]),
        ExecuteStep(() async {
          bool? result = await NaksiasraassBuyView.show(router.context!);
          if (result == true) {
            return true;
          }

          return false;
        }),
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
