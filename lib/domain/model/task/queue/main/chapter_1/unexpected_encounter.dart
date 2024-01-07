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
      const [DungeonCommissionsCompletedCriteria(1)];

  @override
  String get name => 'Судьбоносная встреча';

  @override
  String? get subtitle => 'У гильдии есть необычная для тебя просьба';

  @override
  IconData get icon => Icons.church;

  @override
  List<Reward> get rewards => const [
        ExpReward(300),
        RankReward(5),
      ];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          MusicLine.asset('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine.asset('location/guild.jpg'),
          ImageLine.asset('Arda.png'),
          const DialogueLine(
            'Судя по отчётам, благодаря тебе Алоросс наконец-то начинает выходить на положительный КПД по закрытию данжей.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Это не может не радовать, у тебя в одиночку получается так бодро их закрывать.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Просто поразительно, ты молодец.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Не хочу забегать вперёд, но по правилам ильдия может подарить тебе квартиру, в которой ты сейчас обустроился.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Это произойдёт, опять же, как награда за достаточно высокий уровень контроля.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'И я хочу сегодня попросить тебя о кое-какой услуге.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Дело в том, что я утром передал поручение на зачистку данжа одному путешественнику.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Прошло уже 5 часов, а путешественник не вернулся.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Телефон недоступен, связаться с ним я никак не могу.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Я боюсь, что могло случиться ужасное.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Данж обычный, ранг минимальный, красным не оказался.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Красным называется данж, который внешне выглядит как один ранг, а внутри оказывается сильно сложнее.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Посмотри, пожалуйста, что там.',
            by: 'Мастер',
          ),
          const DialogueLine(
              'Дело серьёзное, ты незамедлительно соглашаешься и отправляешься напрямую к подземелью.'),
          HideImageLine.asset('Arda.png'),
          MusicLine.asset('mixkit-summer-fun-13.mp3'),
          BackgroundLine.asset('location/town.jpg'),
          const DialogueLine('Довольно бодро ты покидаешь гильдию.'),
          BackgroundLine.asset('location/mediterranean_town.jpg'),
          const DialogueLine('И вот ты уже рядом с порталом.'),
          const DialogueLine('А что, если путешественник мёртв?'),
          const DialogueLine('Ты не хочешь думать об этом.'),
          const DialogueLine(
              'Сцена, которую ты представляешь увидеть, вызывает мурашки по всему телу.'),
          const DialogueLine(
              'Ты начинаешь привыкать к данжам, к монстрам внутри.'),
          const DialogueLine('Но этот раз ты колеблешься.'),
          const DialogueLine('Не время валять дурака, человек в опасности.'),
          const DialogueLine('Ты прыгаешь в портал.'),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-fright-night-871.mp3',
            background: 'mines',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(6)],
              ),
            ],
          ),
          withEntrance: true,
          entranceFrom: 'location/mediterranean_town',
        ),
        NovelStep([
          MusicLine.asset('mixkit-fright-night-871.mp3'),
          BackgroundLine.asset('location/mines.jpg'),
          const DialogueLine('Уже на входе тебя встречают слаймы.'),
          const DialogueLine(
              'Плохо дело, ведь почему они тут, у самого входа?'),
          const DialogueLine(
              'Ты осматриваешься - видишь чёткие, пусть и очень маленькие, шажки вглубь пещеры.'),
          const DialogueLine(
              'Рядом слизь - видимо, эти слаймы пришли сюда уже после того, как путешественник прошёл дальше.'),
          const DialogueLine(
              'Но если они здесь, то что же с путешественником?!'),
          const DialogueLine(
              'Ты аккуратно, но не сильно осторожно, спешишь дальше.'),
          const DialogueLine('Завернув за угол...'),
          BackgroundLine.asset('location/underground_waterfall.jpg'),
          const DialogueLine('Слаймы, много слаймов.'),
          const DialogueLine(
              'Они скачут по всей пещере, своим хлюпаньем сводят с ума.'),
          const DialogueLine('И внутри одного из слаймов чей-то меч!'),
          const DialogueLine('Слайм проглотил оружие путешественника?'),
          const DialogueLine('Где же сам путешественник?'),
          const DialogueLine(
              'Ты осматриваешься внимательно в поисках хоть каких-то знаков.'),
          const DialogueLine(
            'Эй!',
            by: '???',
          ),
          const DialogueLine(
            'На помощь! Я тут, наверху!',
            by: '???',
          ),
          const DialogueLine('Ты смотришь наверх.'),
          const DialogueLine(
            'Они забрали мой меч, помоги!',
            by: '???',
          ),
          const DialogueLine(
              'На камнях у самого потолка пещеры сидела маленькая женская фигура.'),
          const DialogueLine(
              'Обхватив себя за ноги, она дрожала - то ли от холода, то ли от страха.'),
          const DialogueLine('Ага, картина резко обрела смысл.'),
          const DialogueLine('Путешественник жив, ты вздохнул с облегчением.'),
          const DialogueLine(
              '...но этого вздоха было достаточно, чтобы слаймы заметили тебя и начали двигаться в твою сторону.'),
          const DialogueLine('Никак вы, блять, не научитесь.'),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-fright-night-871.mp3',
            background: 'underground_waterfall',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [
                  SlayedStageCondition(10),
                  TimerStageCondition(Duration(seconds: 120)),
                ],
              ),
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [
                  SlayedStageCondition(5),
                  TimerStageCondition(Duration(seconds: 90)),
                ],
              ),
              DungeonStage(
                enemies: SlimeEnemies.fPlus,
                conditions: const [
                  SlayedStageCondition(1),
                  TimerStageCondition(Duration(seconds: 45)),
                ],
              ),
            ],
          ),
        ),
        NovelStep([
          MusicLine.asset('mixkit-fright-night-871.mp3'),
          BackgroundLine.asset('location/underground_waterfall.jpg'),
          const DialogueLine(
              'Ты рубишь последнего, после чего всю пещеру окутывает слабое светлое свечение.'),
          const DialogueLine('Это был босс.'),
          const DialogueLine(
              'Закинув меч за спину, ты бежишь к той куче камней, на которых сидит девушка.'),
          const DialogueLine(
              'Ты говоришь, что разобрался со слаймами и теперь можно спускаться.'),
          const DialogueLine(
              'Она аккуратно еле-еле, шажок за шажком, начинает спуск.'),
          const DialogueLine(
              'Всё ещё дрожит, поэтому ты стараешься, если что, подловить её, мало ли что.'),
          const DialogueLine(
              'И вот звук касания обуви о камни на полу пещеры.'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine('Она оборачивается к тебе, готовая расплакаться.'),
          const DialogueLine('Ты успеваешь осмотреть её получше вблизи.'),
          const DialogueLine(
              'Это антропоморф, кошачьи ушки, хвост, длинные тёмные волосы и большие-большие глаза.'),
          const DialogueLine(
              'Девушка, хотя скорее девочка, невысокая, на ней даже брони нет!'),
          const DialogueLine(
              'Ну, на тебе, конечно, ты бы тоже не сказал, что доспехи дракона, но всё же.'),
          const DialogueLine(
            'Божечки-кошечки, с-спасибо!',
            by: '???',
          ),
          const DialogueLine(
            'Он съел мой меч!',
            by: '???',
          ),
          const DialogueLine(
            'Такое впервые случилось, я не знала, что делать, я с-совсем растерялась.',
            by: '???',
          ),
          const DialogueLine(
            'Они липкие и скользкие, оставляют за собой эту слизь, фу.',
            by: '???',
          ),
          const DialogueLine(
            'И ты спас меня-я, божечки-и!',
            by: '???',
          ),
          const DialogueLine('Ты пытаешься успокоить её.'),
          const DialogueLine(
              'Подбордив и сказав, что теперь всё хорошо, ты предлагаешь скорее выйти отсюда на свежий воздух.'),
          MusicLine.asset('mixkit-beautiful-dream-493.mp3'),
          BackgroundLine.asset('location/mediterranean_town_dawn.jpg'),
          const DialogueLine(
            'Я Киару.',
            by: 'Киару',
          ),
          const DialogueLine(
              'Ты спрашиваешь у Киару, почему она вообще решила стать путешественником.'),
          const DialogueLine(
            'А мне... Ну, я родилась в деревне недалеко, и на нас постоянно нападали монстры.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Однажды открылся данж высокого ранга, они и... того.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Он был далеко от нас, но его не успели закрыть.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Почему-то монстры пришли именно в нашу деревню.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Я помню их шаги, их дыхание, это были минотавры.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Помню эти жуткие картины перед глазами, когда я пряталась под кроватью в надежде, что меня не найдут.',
            by: 'Киару',
          ),
          const DialogueLine(
            'И меня не тронули, из Алоросса пришли путешественники и спасли меня.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Но прошло столько времени, они сильно опоздали...',
            by: 'Киару',
          ),
          const DialogueLine(
            'Крики на улице, крики родителей... Всё это до сих пор стоит в ушах.',
            by: 'Киару',
          ),
          const DialogueLine('...'),
          HideImageLine.asset('Kyaru.webp'),
          const DialogueLine(
              'В этой беготне ты и забыл, что мир - жестокое место.'),
          const DialogueLine(
              'Твои проблемы просто ничтожны по сравнению с ужасом, происходящим каждый день в неимоверных масштабах.'),
          const DialogueLine(
              'А если прямо сейчас где-то кого-то съедают заживо?'),
          const DialogueLine(
              'Нет, так и есть. Прямо сейчас где-то кто-то умирает.'),
          const DialogueLine('Где-то кого-то насилуют, избивают.'),
          const DialogueLine('Ты испытываешь смешанные эмоции.'),
          const DialogueLine('Может, ты просто забыл всё это?'),
          const DialogueLine(
              'В городе настолько спокойно, что об этих вещах и не думаешь.'),
          const DialogueLine(
              'Ты винишь себя за то, что до сих пор бьёшь каких-то там слаймов.'),
          const DialogueLine(
              'Путешественниками становятся не от жизни хорошей?'),
          const DialogueLine('Сколько ещё таких ужасных историй ты услышишь?'),
          const DialogueLine('Сколько ещё ужаса произойдёт?'),
          const DialogueLine('Ты должен работать лучше и больше.'),
          const DialogueLine('Ты должен.'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine(
            'Мне дали комнатку в общижитии, с тех пор я учусь.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Я не могу сидеть и делать вид, что всё хорошо.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Ведь что, если бы путешественников было бы больше?',
            by: 'Киару',
          ),
          const DialogueLine(
            'Что, если данжи закрывались бы быстрее?',
            by: 'Киару',
          ),
          const DialogueLine(
            'Тогда тот данж закрыли бы раньше, тогда все были бы живы...',
            by: 'Киару',
          ),
          const DialogueLine(
            'В подземелья мне разрешили ходить совсем недавно, это моё третье.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Я безумно рада, что могу помогать их закрывать.',
            by: 'Киару',
          ),
          const DialogueLine(
            'И буду делать всё, чего бы мне это не стоило, чтобы стать сильнее.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Чтобы Акума перестал существовать.',
            by: 'Киару',
          ),
          const DialogueLine('...'),
          const DialogueLine('Ты просишь прощения за вопрос.'),
          const DialogueLine(
            'Это нормально, такая жизнь.',
            by: 'Киару',
          ),
          const DialogueLine('Отвечает тебе эта кошечка с улыбкой на лице.'),
          const DialogueLine('Сколько боли в этой улыбке?'),
          HideImageLine.asset('Kyaru.webp'),
          const DialogueLine('Путь до гильдии вы держите молча.'),
          const DialogueLine(
              'Лишь изредко обмениваетесь взглядами, словно ты хочешь что-то сказать, дополнить, обнадёжить.'),
          const DialogueLine('Но понимаешь, что не имеешь права.'),
          MusicLine.asset('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine.asset('location/guild.jpg'),
          ImageLine.asset('Arda.png'),
          const DialogueLine(
            'Киару, путешественник!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Уф, как я рад вас видеть!',
            by: 'Мастер',
          ),
          const DialogueLine(
              'Почему здесь всегда играет такая весёлая музыка?'),
          const DialogueLine(
            'Я люблю весёлую музыку, она успокаивает.',
            by: 'Мастер',
          ),
          const DialogueLine('Киару рассказывает всё, что произошло.'),
          const DialogueLine(
            'Боже правый, это же ужасно!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Нет-нет-нет, с этого дня я запрещаю сольные данжи новичкам.',
            by: 'Мастер',
          ),
          const DialogueLine(
              'Девушка сразу начинает спорить и убеждать гильдмастера, что это единичный случай.'),
          const DialogueLine(
              'Ты тоже напрягся, ведь без сопартийца ты не сможешь ходить в данжи.'),
          const DialogueLine(
            'Я знаю, что у нас не хватает рук.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Но я не могу подвергать имеющиеся руки опасности.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Это сложное решение, очень сложное.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Данжей слишком много, даже по одиночке мы не успеваем с ними справляться.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'В гильдии много путешественников ходят в одиночку, но за большинство я могу быть спокойным.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Но даже безобидные слаймы могут запросто убить!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'И из двух зол я бы всё-таки выбрал безопасность путешественников.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Вокруг города патрулит полиция, она обезопасит население, если что.',
            by: 'Мастер',
          ),
          const DialogueLine(
              'Девушка замолкла, ты тоже не знаешь, что сказать.'),
          const DialogueLine(
              'Судя по выражению лица, она явно опечалена таким решением гильдмастера.'),
          const DialogueLine(
              'Ты вспоминаешь всё, что она сказала, и понимаешь, о чём она может сейчас думать.'),
          const DialogueLine(
              'Ведь какая разница, будет ли Алоросс чувствовать себя безопасно, если вокруг города тысячи жизней?'),
          const DialogueLine('Тысячи жизней, что ждут своей ужасной участи?'),
          HideImageLine.asset('Arda.png'),
          MusicLine.asset('mixkit-beautiful-dream-493.mp3'),
          BackgroundLine.asset('location/town.jpg'),
          const DialogueLine('Вы выходите из гильдии.'),
          const DialogueLine('У тебя словно ком в горле.'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine(
            'А т-ты не против объединиться?',
            by: 'Киару',
          ),
          const DialogueLine(
            'Н-ну, может, будем вместе, в одной пати?',
            by: 'Киару',
          ),
          const DialogueLine(
            'Ты не п-против?',
            by: 'Киару',
          ),
          const DialogueLine(
              'Ты наблюдаешь, как девушка, пытаясь сдержать в себе эмоции, выдавливает слово за словом.'),
          const DialogueLine(
              'И понимаешь, что вот она, прямо перед тобой, - кто-то, кого ты хочешь спасти от ужасов этого мира.'),
          const DialogueLine('И ты можешь это сделать.'),
          const DialogueLine(
              'Поэтому ты улыбаешься и говоришь, что конечно, ты был бы очень рад.'),
          const DialogueLine(
            'Правда?',
            by: 'Киару',
          ),
          const DialogueLine(
            'Спасибо!',
            by: 'Киару',
          ),
          const DialogueLine(
            'Давай тогда я добавлю тебя в контакты.',
            by: 'Киару',
          ),
          const DialogueLine('Вы обмениваетесь контактами.'),
          const DialogueLine('Ты предлагаешь провести её.'),
          const DialogueLine(
            'А... П-прости, не стоит, давай завтра?',
            by: 'Киару',
          ),
          const DialogueLine('Ты понимаешь, что настаивать не стоит.'),
          HideImageLine.asset('Kyaru.webp'),
          const DialogueLine('Вы потихоньку расходитесь кто куда.'),
          const DialogueLine('What a day, huh?'),
          const DialogueLine('Тем не менее, ты очень рад сегодняшней встрече.'),
          const DialogueLine(
              'Киару открыла тебе глаза на то, что мир не такой забавный и безобидный, каким ты успел его посчитать.'),
          const DialogueLine(
              'И это милое создание само предложило объединиться в пати.'),
          const DialogueLine('Ты не знаешь, из-за нового ли правила гильдии.'),
          const DialogueLine('Поэтому свои надежды не поднимаешь.'),
          const DialogueLine(
              'Но в глубине души ты счастлив, что можешь кого-то защищать хотя бы таким образом.'),
          const DialogueLine(
              'И ещё больше уверен в том, что обязательно изменишь этот мир.'),
          const DialogueLine('Теперь это твоя цель.'),
          const DialogueLine(
              'С такими мыслями ты возвращаешься домой и сразу ложишься спать.'),
        ]),
      ];
}
