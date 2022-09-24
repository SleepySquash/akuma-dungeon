import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';

class UnexpectedEncounterTask extends Task {
  const UnexpectedEncounterTask();

  @override
  String get id => 'chapter1_unexpected_encounter';

  @override
  List<TaskCriteria> get criteria =>
      const [DungeonCommissionsCompletedCriteria(3)];

  @override
  String get name => 'Судьбоносная встреча';

  @override
  String? get subtitle => 'У гильдии есть необычная для тебя просьба';

  @override
  IconData get icon => Icons.church;

  @override
  List<Reward> get rewards => const [
        ExpReward(200),
        RankReward(5),
      ];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/guild.jpg'),
          CharacterLine('Arda.png'),
          DialogueLine(
            'Судя по отчётам, благодаря тебе Алоросс наконец-то начинает выходить на положительный КПД по закрытию данжей.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Это не может не радовать, у тебя в одиночку получается так бодро их закрывать.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Просто поразительно, ты молодец.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Не хочу забегать вперёд, но по правилам ильдия может подарить тебе квартиру, в которой ты сейчас обустроился.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Это произойдёт, опять же, как награда за достаточно высокий уровень контроля.',
            by: 'Мастер',
          ),
          DialogueLine(
            'И я хочу сегодня попросить тебя о кое-какой услуге.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Дело в том, что я утром передал поручение на зачистку данжа одному путешественнику.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Прошло уже 5 часов, а путешественник не вернулся.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Телефон недоступен, связаться с ним я никак не могу.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Я боюсь, что могло случиться ужасное.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Данж обычный, ранг минимальный, красным не оказался.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Красным называется данж, который внешне выглядит как один ранг, а внутри оказывается сильно сложнее.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Посмотри, пожалуйста, что там.',
            by: 'Мастер',
          ),
          DialogueLine(
              'Дело серьёзное, ты незамедлительно соглашаешься и отправляешься напрямую к подземелью.'),
          HideCharacterLine('Arda.png'),
          const MusicLine('mixkit-summer-fun-13.mp3'),
          BackgroundLine('location/town.jpg'),
          DialogueLine('Довольно бодро ты покидаешь гильдию.'),
          BackgroundLine('location/mediterranean_town.jpg'),
          DialogueLine('И вот ты уже рядом с порталом.'),
          DialogueLine('А что, если путешественник мёртв?'),
          DialogueLine('Ты не хочешь думать об этом.'),
          DialogueLine(
              'Сцена, которую ты представляешь увидеть, вызывает мурашки по всему телу.'),
          DialogueLine('Ты начинаешь привыкать к данжам, к монстрам внутри.'),
          DialogueLine('Но этот раз ты колеблешься.'),
          DialogueLine('Не время валять дурака, человек в опасности.'),
          DialogueLine('Ты прыгаешь в портал.'),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-fright-night-871.mp3',
            background: 'mines',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(10)],
              ),
            ],
          ),
          withEntrance: true,
          entranceFrom: 'location/mediterranean_town',
        ),
        NovelStep([
          const MusicLine('mixkit-fright-night-871.mp3'),
          BackgroundLine('location/mines.jpg'),
          DialogueLine('Уже на входе тебя встречают слаймы.'),
          DialogueLine('Плохо дело, ведь почему они тут, у самого входа?'),
          DialogueLine(
              'Ты осматриваешься - видишь чёткие, пусть и очень маленькие, шажки вглубь пещеры.'),
          DialogueLine(
              'Рядом слизь - видимо, эти слаймы пришли сюда уже после того, как путешественник прошёл дальше.'),
          DialogueLine('Но если они здесь, то что же с путешественником?!'),
          DialogueLine('Ты аккуратно, но не сильно осторожно, спешишь дальше.'),
          DialogueLine('Завернув за угол...'),
          BackgroundLine('location/underground_waterfall.jpg'),
          DialogueLine('Слаймы, много слаймов.'),
          DialogueLine(
              'Они скачут по всей пещере, своим хлюпаньем сводят с ума.'),
          DialogueLine('И внутри одного из слаймов чей-то меч!'),
          DialogueLine('Слайм проглотил оружие путешественника?'),
          DialogueLine('Где же сам путешественник?'),
          DialogueLine(
              'Ты осматриваешься внимательно в поисках хоть каких-то знаков.'),
          DialogueLine(
            'Эй!',
            by: '???',
          ),
          DialogueLine(
            'На помощь! Я тут, наверху!',
            by: '???',
          ),
          DialogueLine('Ты смотришь наверх.'),
          DialogueLine(
            'Они забрали мой меч, помоги!',
            by: '???',
          ),
          DialogueLine(
              'На камнях у самого потолка пещеры сидела маленькая женская фигура.'),
          DialogueLine(
              'Обхватив себя за ноги, она дрожала - то ли от холода, то ли от страха.'),
          DialogueLine('Ага, картина резко обрела смысл.'),
          DialogueLine('Путешественник жив, ты вздохнул с облегчением.'),
          DialogueLine(
              '...но этого вздоха было достаточно, чтобы слаймы заметили тебя и начали двигаться в твою сторону.'),
          DialogueLine('Никак вы, блять, не научитесь.'),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-fright-night-871.mp3',
            background: 'underground_waterfall',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [
                  SlayedStageCondition(30),
                  TimerStageCondition(Duration(seconds: 120)),
                ],
              ),
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [
                  SlayedStageCondition(20),
                  TimerStageCondition(Duration(seconds: 90)),
                ],
              ),
              DungeonStage(
                enemies: SlimeEnemies.fPlus,
                conditions: const [
                  SlayedStageCondition(2),
                  TimerStageCondition(Duration(seconds: 45)),
                ],
              ),
            ],
          ),
        ),
        NovelStep([
          const MusicLine('mixkit-fright-night-871.mp3'),
          BackgroundLine('location/underground_waterfall.jpg'),
          DialogueLine(
              'Ты рубишь последнего, после чего всю пещеру окутывает слабое светлое свечение.'),
          DialogueLine('Это был босс.'),
          DialogueLine(
              'Закинув меч за спину, ты бежишь к той куче камней, на которых сидит девушка.'),
          DialogueLine(
              'Ты говоришь, что разобрался со слаймами и теперь можно спускаться.'),
          DialogueLine(
              'Она аккуратно еле-еле, шажок за шажком, начинает спуск.'),
          DialogueLine(
              'Всё ещё дрожит, поэтому ты стараешься, если что, подловить её, мало ли что.'),
          DialogueLine('И вот звук касания обуви о камни на полу пещеры.'),
          CharacterLine('Kyaru.webp'),
          DialogueLine('Она оборачивается к тебе, готовая расплакаться.'),
          DialogueLine('Ты успеваешь осмотреть её получше вблизи.'),
          DialogueLine(
              'Это антропоморф, кошачьи ушки, хвост, длинные тёмные волосы и большие-большие глаза.'),
          DialogueLine(
              'Девушка, хотя скорее девочка, невысокая, на ней даже брони нет!'),
          DialogueLine(
              'Ну, на тебе, конечно, ты бы тоже не сказал, что доспехи дракона, но всё же.'),
          DialogueLine(
            'Божечки-кошечки, с-спасибо!',
            by: '???',
          ),
          DialogueLine(
            'Он съел мой меч!',
            by: '???',
          ),
          DialogueLine(
            'Такое впервые случилось, я не знала, что делать, я с-совсем растерялась.',
            by: '???',
          ),
          DialogueLine(
            'Они липкие и скользкие, оставляют за собой эту слизь, фу.',
            by: '???',
          ),
          DialogueLine(
            'И ты спас меня-я, божечки-и!',
            by: '???',
          ),
          DialogueLine('Ты пытаешься успокоить её.'),
          DialogueLine(
              'Подбордив и сказав, что теперь всё хорошо, ты предлагаешь скорее выйти отсюда на свежий воздух.'),
          const MusicLine('mixkit-beautiful-dream-493.mp3'),
          BackgroundLine('location/mediterranean_town_dawn.jpg'),
          DialogueLine(
            'Я Киару.',
            by: 'Киару',
          ),
          DialogueLine(
              'Ты спрашиваешь у Киару, почему она вообще решила стать путешественником.'),
          DialogueLine(
            'А мне... Ну, я родилась в деревне недалеко, и на нас постоянно нападали монстры.',
            by: 'Киару',
          ),
          DialogueLine(
            'Однажды открылся данж высокого ранга, они и... того.',
            by: 'Киару',
          ),
          DialogueLine(
            'Он был далеко от нас, но его не успели закрыть.',
            by: 'Киару',
          ),
          DialogueLine(
            'Почему-то монстры пришли именно в нашу деревню.',
            by: 'Киару',
          ),
          DialogueLine(
            'Я помню их шаги, их дыхание, это были минотавры.',
            by: 'Киару',
          ),
          DialogueLine(
            'Помню эти жуткие картины перед глазами, когда я пряталась под кроватью в надежде, что меня не найдут.',
            by: 'Киару',
          ),
          DialogueLine(
            'И меня не тронули, из Алоросса пришли путешественники и спасли меня.',
            by: 'Киару',
          ),
          DialogueLine(
            'Но прошло столько времени, они сильно опоздали...',
            by: 'Киару',
          ),
          DialogueLine(
            'Крики на улице, крики родителей... Всё это до сих пор стоит в ушах.',
            by: 'Киару',
          ),
          DialogueLine('...'),
          HideCharacterLine('Kyaru.webp'),
          DialogueLine('В этой беготне ты и забыл, что мир - жестокое место.'),
          DialogueLine(
              'Твои проблемы просто ничтожны по сравнению с ужасом, происходящим каждый день в неимоверных масштабах.'),
          DialogueLine('А если прямо сейчас где-то кого-то съедают заживо?'),
          DialogueLine('Нет, так и есть. Прямо сейчас где-то кто-то умирает.'),
          DialogueLine('Где-то кого-то насилуют, избивают.'),
          DialogueLine('Ты испытываешь смешанные эмоции.'),
          DialogueLine('Может, ты просто забыл всё это?'),
          DialogueLine(
              'В городе настолько спокойно, что об этих вещах и не думаешь.'),
          DialogueLine(
              'Ты винишь себя за то, что до сих пор бьёшь каких-то там слаймов.'),
          DialogueLine('Путешественниками становятся не от жизни хорошей?'),
          DialogueLine('Сколько ещё таких ужасных историй ты услышишь?'),
          DialogueLine('Сколько ещё ужаса произойдёт?'),
          DialogueLine('Ты должен работать лучше и больше.'),
          DialogueLine('Ты должен.'),
          CharacterLine('Kyaru.webp'),
          DialogueLine(
            'Мне дали комнатку в общижитии, с тех пор я учусь.',
            by: 'Киару',
          ),
          DialogueLine(
            'Я не могу сидеть и делать вид, что всё хорошо.',
            by: 'Киару',
          ),
          DialogueLine(
            'Ведь что, если бы путешественников было бы больше?',
            by: 'Киару',
          ),
          DialogueLine(
            'Что, если данжи закрывались бы быстрее?',
            by: 'Киару',
          ),
          DialogueLine(
            'Тогда тот данж закрыли бы раньше, тогда все были бы живы...',
            by: 'Киару',
          ),
          DialogueLine(
            'В подземелья мне разрешили ходить совсем недавно, это моё третье.',
            by: 'Киару',
          ),
          DialogueLine(
            'Я безумно рада, что могу помогать их закрывать.',
            by: 'Киару',
          ),
          DialogueLine(
            'И буду делать всё, чего бы мне это не стоило, чтобы стать сильнее.',
            by: 'Киару',
          ),
          DialogueLine(
            'Чтобы Акума перестал существовать.',
            by: 'Киару',
          ),
          DialogueLine('...'),
          DialogueLine('Ты просишь прощения за вопрос.'),
          DialogueLine(
            'Это нормально, такая жизнь.',
            by: 'Киару',
          ),
          DialogueLine('Отвечает тебе эта кошечка с улыбкой на лице.'),
          DialogueLine('Сколько боли в этой улыбке?'),
          HideCharacterLine('Kyaru.webp'),
          DialogueLine('Путь до гильдии вы держите молча.'),
          DialogueLine(
              'Лишь изредко обмениваетесь взглядами, словно ты хочешь что-то сказать, дополнить, обнадёжить.'),
          DialogueLine('Но понимаешь, что не имеешь права.'),
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/guild.jpg'),
          CharacterLine('Arda.png'),
          DialogueLine(
            'Киару, путешественник!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Уф, как я рад вас видеть!',
            by: 'Мастер',
          ),
          DialogueLine('Почему здесь всегда играет такая весёлая музыка?'),
          DialogueLine(
            'Я люблю весёлую музыку, она успокаивает.',
            by: 'Мастер',
          ),
          DialogueLine('Киару рассказывает всё, что произошло.'),
          DialogueLine(
            'Боже правый, это же ужасно!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Нет-нет-нет, с этого дня я запрещаю сольные данжи новичкам.',
            by: 'Мастер',
          ),
          DialogueLine(
              'Девушка сразу начинает спорить и убеждать гильдмастера, что это единичный случай.'),
          DialogueLine(
              'Ты тоже напрягся, ведь без сопартийца ты не сможешь ходить в данжи.'),
          DialogueLine(
            'Я знаю, что у нас не хватает рук.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Но я не могу подвергать имеющиеся руки опасности.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Это сложное решение, очень сложное.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Данжей слишком много, даже по одиночке мы не успеваем с ними справляться.',
            by: 'Мастер',
          ),
          DialogueLine(
            'В гильдии много путешественников ходят в одиночку, но за большинство я могу быть спокойным.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Но даже безобидные слаймы могут запросто убить!',
            by: 'Мастер',
          ),
          DialogueLine(
            'И из двух зол я бы всё-таки выбрал безопасность путешественников.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Вокруг города патрулит полиция, она обезопасит население, если что.',
            by: 'Мастер',
          ),
          DialogueLine('Девушка замолкла, ты тоже не знаешь, что сказать.'),
          DialogueLine(
              'Судя по выражению лица, она явно опечалена таким решением гильдмастера.'),
          DialogueLine(
              'Ты вспоминаешь всё, что она сказала, и понимаешь, о чём она может сейчас думать.'),
          DialogueLine(
              'Ведь какая разница, будет ли Алоросс чувствовать себя безопасно, если вокруг города тысячи жизней?'),
          DialogueLine('Тысячи жизней, что ждут своей ужасной участи?'),
          HideCharacterLine('Arda.png'),
          const MusicLine('mixkit-beautiful-dream-493.mp3'),
          BackgroundLine('location/town.jpg'),
          DialogueLine('Вы выходите из гильдии.'),
          DialogueLine('У тебя словно ком в горле.'),
          CharacterLine('Kyaru.webp'),
          DialogueLine(
            'А т-ты не против объединиться?',
            by: 'Киару',
          ),
          DialogueLine(
            'Н-ну, может, будем вместе, в одной пати?',
            by: 'Киару',
          ),
          DialogueLine(
            'Ты не п-против?',
            by: 'Киару',
          ),
          DialogueLine(
              'Ты наблюдаешь, как девушка, пытаясь сдержать в себе эмоции, выдавливает слово за словом.'),
          DialogueLine(
              'И понимаешь, что вот она, прямо перед тобой, - кто-то, кого ты хочешь спасти от ужасов этого мира.'),
          DialogueLine('И ты можешь это сделать.'),
          DialogueLine(
              'Поэтому ты улыбаешься и говоришь, что конечно, ты был бы очень рад.'),
          DialogueLine(
            'Правда?',
            by: 'Киару',
          ),
          DialogueLine(
            'Спасибо!',
            by: 'Киару',
          ),
          DialogueLine(
            'Давай тогда я добавлю тебя в контакты.',
            by: 'Киару',
          ),
          DialogueLine('Вы обмениваетесь контактами.'),
          DialogueLine('Ты предлагаешь провести её.'),
          DialogueLine(
            'А... П-прости, не стоит, давай завтра?',
            by: 'Киару',
          ),
          DialogueLine('Ты понимаешь, что настаивать не стоит.'),
          HideCharacterLine('Kyaru.webp'),
          DialogueLine('Вы потихоньку расходитесь кто куда.'),
          DialogueLine('What a day, huh?'),
          DialogueLine('Тем не менее, ты очень рад сегодняшней встрече.'),
          DialogueLine(
              'Киару открыла тебе глаза на то, что мир не такой забавный и безобидный, каким ты успел его посчитать.'),
          DialogueLine(
              'И это милое создание само предложило объединиться в пати.'),
          DialogueLine('Ты не знаешь, из-за нового ли правила гильдии.'),
          DialogueLine('Поэтому свои надежды не поднимаешь.'),
          DialogueLine(
              'Но в глубине души ты счастлив, что можешь кого-то защищать хотя бы таким образом.'),
          DialogueLine(
              'И ещё больше уверен в том, что обязательно изменишь этот мир.'),
          DialogueLine('Теперь это твоя цель.'),
          DialogueLine(
              'С такими мыслями ты возвращаешься домой и сразу ложишься спать.'),
        ]),
      ];
}
