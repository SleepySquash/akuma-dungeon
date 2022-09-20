import 'package:akuma/domain/model/location/all.dart';
import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/flag.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';

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
  String get name => 'Первое подземелье';

  @override
  String? get subtitle => 'Ты продолжаешь выполнять поручения';

  @override
  IconData get icon => Icons.dangerous_rounded;

  @override
  List<Reward> get rewards => const [
        ExpReward(200),
        RankReward(5),
        ControlReward(AlorossLocation(), 2),
        FlagReward(Flag.dungeonCommissionsUnlocked),
      ];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/guild.jpg'),
          CharacterLine('Arda.png'),
          DialogueLine(
            'Благодарю тебя, путешественник!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Твой вклад в Алоросс и поддержку города уже признают жители.',
            by: 'Мастер',
          ),
          DialogueLine(
            'О тебе начинают говорить, поэтому если кто-то и знает тебя тут, то обязательно окликнется.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Продолжай выполнять квесты, чтобы заработать репутацию и сделать себе имя.',
            by: 'Мастер',
          ),
          DialogueLine('Ты благодарен гильдмастеру за помощь.'),
          DialogueLine(
            'Что ж, давай поговорим про данжи.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Напоминаю, данжи открываются постоянно в случайных локациях.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Они опасны, поскольку если за несколько дней данж не закрыть, то монстры выползают наружу.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Большинство данжей спонсирует именно гильдия, хотя некоторые могут быть проблемой и для бизнеса.',
            by: 'Мастер',
          ),
          DialogueLine(
            'По поводу данжей у Алоросса есть одна проблема - рук совсем не хватает, чтобы их закрывать быстро.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Но подвергать жизни простого населения опасности неправильно, игнорируя большинство данжей.',
            by: 'Мастер',
          ),
          DialogueLine(
            'И, эх, мне очень не хочется отпускать путешественников самостоятельно закрыть данжи, это слишком опасно.',
            by: 'Мастер',
          ),
          DialogueLine(
            'К сожалению, я не могу найти никого в пати тебе на данный момент.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Я очень надеюсь, что ты поможешь нам разобраться с ситуацией и повысить контроль над данжами.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Ты показал себя достойно при выполнении опасных поручений, поэтому можешь изучить список поручений и принять несложный данж.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Подходи ко мне, как будешь готов.',
            by: 'Мастер',
          ),
          HideCharacterLine('Arda.png'),
          DialogueLine(
              'Ты подходишь и изучаешь список под заголовком "Данжи".'),
          DialogueLine(
              'И действительно, вокруг города их сильно больше, чем путешественников в рейтинговой таблице.'),
          DialogueLine(
              'Ты не можешь судить действия гильдмастера - он пытается меньшинством спасти большинство.'),
          DialogueLine('Возможно, это и правильно.'),
          DialogueLine(
              'Тем не менее, внутри тебя растёт какое-то чувство справедливости, ты хочешь изменить ситуацию.'),
          DialogueLine(
              'Ты хочешь, чтобы и жители города жили спокойно, и чтобы никто не пострадал.'),
          DialogueLine(
              'Наконец, ты хватаешь одну из листовок и подходишь к гильдмастеру.'),
          CharacterLine('Arda.png'),
          DialogueLine(
            'Угу, момент.',
            by: 'Мастер',
          ),
          DialogueLine('Он что-то щёлкает на компьютере.'),
          DialogueLine(
            'Да, готово.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Помни, что в данжах самое главное - не спешить.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Если чувствуешь опасность, отступай немедля.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Ни в коем случае не подвергай ни себя, ни окружающих опасности.',
            by: 'Мастер',
          ),
          DialogueLine(
            'В нормальных пати есть роли: танк, урон и поддержка.',
            by: 'Мастер',
          ),
          DialogueLine(
            'К сожалению, в соло ты обязан выполнять все три роли, поэтому будь осторожен, пожалуйста.',
            by: 'Мастер',
          ),
          DialogueLine(
              'Ты заверяешь его, что всё будет хорошо, и отправляешься к данжу.'),
          HideCharacterLine('Arda.png'),
          DialogueLine(
              'Когда уже изобретут приложение "Мой Путешественник", где можно будет в AR строить маршрут?'),
          DialogueLine(
              'Ты негодуешь. Возможно, ты был айтишником. Или неготователем.'),
          const MusicLine('mixkit-summer-fun-13.mp3'),
          BackgroundLine('location/town.jpg'),
          DialogueLine('Пока ты идёшь по городу, ты осматриваешься вокруг.'),
          DialogueLine(
              'Приятный для глаза пейзаж, очень умиротворённый и милый вид.'),
          DialogueLine('Ты хочешь видеть это всегда, всю жизнь.'),
          DialogueLine(
              'Твои глаза всё это время были заострены на проходящей мимо кошкодевочке.'),
          DialogueLine('Город тоже ничо так.'),
          DialogueLine(
              'Вообще, интересно, насколько сложно тут завести отношения?'),
          DialogueLine(
              'Ты, как человек определённого пола, имеешь склонность к людям другого пола.'),
          DialogueLine('Антропоморфы - мечта любого.'),
          DialogueLine(
              'Просыпаться каждый день и ощущать в кровати тепло такого родного тебе тела.'),
          DialogueLine(
              'Засыпать в объятиях, чесать за ушком, наслаждаться радостью в этих глазках.'),
          DialogueLine(
              'Тебя радует то, насколько мирно все сосуществуют друг с другом.'),
          DialogueLine(
              'И ты уже начинаешь ставить под сомнения цель твоих путешествий.'),
          DialogueLine(
              'Какая разница, кто ты, когда просто жить жизнь себе в радость важнее?'),
          DialogueLine(
              'Путешествия дарят возможность посмотреть на этот чудесный мир, почувствовать его со всех сторон.'),
          DialogueLine(
              'И, возможно, набрать славу, подняться в ранге, создать себе доброе имя и завести гарем ушастых.'),
          BackgroundLine('location/mediterranean_town.jpg'),
          DialogueLine('Ты был уже недалеко от данжа.'),
          DialogueLine('Прибыв на место, ты действительно обнаружил портал.'),
          DialogueLine(
              'По ту сторону ничего не видно, картинка слишком искажена.'),
          DialogueLine('Из портала веет холодом.'),
          DialogueLine('Тем не менее, ты решительно делаешь шаг вперёд...'),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-fright-night-871.mp3',
            background: 'mines',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(20)],
              ),
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
          DialogueLine('Тёплое однако приветствие.'),
          DialogueLine(
              'Ты отбился от кучки слаймов, что стояла прямо на входе.'),
          DialogueLine('Теперь же у тебя появилась возможность осмотреться.'),
          DialogueLine('Ты в пещере, есть даже рельсы для вагонетки.'),
          DialogueLine('Насколько же развито измерение Акумы?'),
          DialogueLine('И зачем его обитатели вообще нападает на наш мир?'),
          DialogueLine(
              'Вопросов много, но сейчас стоит проявить бдительность.'),
          DialogueLine(
              'Слаймы слаймами, но это их дом, тут они чувствуют себя сильно проворнее.'),
          DialogueLine(
              'Ты вспоминаешь жуткие кадры из той энциклопедии монстров и просто надеешься, что этот данж содержит только слаймов.'),
          DialogueLine(
              'Аккуратно продвигаясь, чтобы не делать слишком много шума, ты продвигаешься вглубь.'),
          DialogueLine('Закрыть данж - значит убить босса данжа.'),
          DialogueLine(
              'Босс является катализатором, сдерживающим своей магической силой переход в наш мир.'),
          DialogueLine(
              'Соответственно, от ауры босса и зависит то магическое поле вокруг портала, которую гильдия и исследует, чтобы определить ранг данжа.'),
          DialogueLine('Босс подземелья ранг F имеет ранг F+ и так далее.'),
          DialogueLine('Наконец, ты видишь просвет.'),
          BackgroundLine('location/underground_waterfall.jpg'),
          DialogueLine('Перед твоими глазами открывается красивая картина.'),
          DialogueLine(
              'Данжи являются не только опасностью для человечества, но и источником многих редких минералов и материалов.'),
          DialogueLine(
              'Вероятно, то, что ты видишь на стенах - вполне себе один их из таких ресурсов.'),
          DialogueLine(
              'Ты здесь не за этим, конечно, но была бы у тебя кирка, ты бы с удовольствием взял бы с десяток другой этих блестящих камней.'),
          DialogueLine('Краем уха ты уловил бульканье за углом.'),
          DialogueLine(
              'Вскоре и по водной глади начали расходиться волны - к тебе кто-то приближался.'),
          DialogueLine('Слаймы.'),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-fright-night-871.mp3',
            background: 'underground_waterfall',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(25)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(20)],
              ),
            ],
          ),
        ),
        NovelStep([
          const MusicLine('mixkit-fright-night-871.mp3'),
          BackgroundLine('location/underground_waterfall.jpg'),
          DialogueLine('Ты справился с очередной пачкой слаймов.'),
          DialogueLine(
              'Но прежде чем ты успел отдохнуть, перед тобой вылезла целая куча новых.'),
          DialogueLine(
              'Ты уже выдохся, а без времени на отдых ты чувствовал себя дезориентированно.'),
          DialogueLine(
              'Но одно бросилось тебе в глаза - за этой ордой слаймов выполз слайм побольше.'),
          DialogueLine('Может ли быть, что это босс?'),
          DialogueLine(
              'Нет, так и есть! Ты наблюдаешь босса этого данжа, от него исходит особая аура.'),
          DialogueLine(
              'И судя по тому, как другие слаймы пресмыкаются перед ним, становится понятно, что он тут главный.'),
          DialogueLine('Ты сжимаешь своё оружие покрепче.'),
          DialogueLine('Время для финального удара.'),
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
                  SlayedStageCondition(1),
                  TimerStageCondition(Duration(seconds: 40)),
                ],
              ),
            ],
          ),
        ),
        NovelStep([
          const MusicLine('mixkit-fright-night-871.mp3'),
          BackgroundLine('location/underground_waterfall.jpg'),
          DialogueLine(
              'Уверенным, пусть и истощённым, движением ты разрубаешь слайма пополам.'),
          DialogueLine(
              'Странно, что они прекращают свою жизнидеятельность от этого.'),
          DialogueLine('Разве слаймы не должны скокоживаться обартно?'),
          DialogueLine('Возможно, так делают слаймы более высокого ранга?'),
          DialogueLine(
              'В любом случае, ты больше не слышишь движения рядом, наконец-то можно передохнуть.'),
          DialogueLine(
              'Только ты начинаешь переводить дыхание, как свет в пещере меняется с тёмного на более светлый.'),
          DialogueLine('Значит ли это, что данж закрылся?'),
          DialogueLine('Так-так-так, а если данж закрылся с тобой внутри?'),
          DialogueLine('Ты спешно отправляешься к выходу.'),
          BackgroundLine('location/mines.jpg'),
          DialogueLine('К счастью, портал всё ещё здесь.'),
          DialogueLine('Особо не раздумывая, ты прыгаешь в него.'),
          const MusicLine('mixkit-summer-fun-13.mp3'),
          BackgroundLine('location/mediterranean_town.jpg'),
          DialogueLine('Свобода!'),
          DialogueLine(
              'Ты смотришь за спину - портал действительно изменил свой цвет на белый.'),
          DialogueLine(
              'Ты понимаешь, что ничего в устройстве порталов не понимаешь.'),
          DialogueLine(
              'Следующим шагом тебе обязательно нужно будет почитать или поизучать, как они работают.'),
          DialogueLine('И, возможно, прихватить где-нибудь кирку.'),
          DialogueLine('А на сегодня ты закончил, слишком много эмоций.'),
          DialogueLine('Потихоньку ты отправляешься в город.'),
          BackgroundLine('location/town.jpg'),
          DialogueLine(
              'Внешне ничего не изменилось, а по ощущениям ты прошёл через Ад.'),
          DialogueLine(
              'Ты не можешь сказать, что чуть жопу не потерял - жопа на месте и ещё какая.'),
          DialogueLine(
              'Но тот факт, что вокруг постоянно открываются такие порталы в другое измерения, из которых прут монстры...'),
          DialogueLine('Теперь ты начинаешь осознавать опасность этих данжей.'),
          DialogueLine('Ты не замечаешь, как стоишь уже напротив гильдии.'),
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/guild.jpg'),
          CharacterLine('Arda.png'),
          DialogueLine(
            'Рад тебя видеть, путешественник!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Да, приборы засекли успешное закрытие данжа, благодарю тебя.',
            by: 'Мастер',
          ),
          DialogueLine(
            'А? Да, данж ещё сутки будет открытым.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Времени, чтобы покинуть данж, просто полно.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Я слышал, в зачищенных данжах устраивали и вечеринки, и сосисочные сходки, и концерты.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Правда, о случаях, чтобы кто-то оставался в данже и не возвращаося, я лично не знаю, но слышал, что такое случается.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Что происходит с такими путешественникам - остаётся лишь гадать.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Как и из загробной жизни, никто после такого не возвращался к нам и не рассказывал, что там как.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Но лучше не попадать в такую ситуацию, естественно.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Вот твоя награда, путешественник, ты молодец.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Помни, что с каждым закрытым данжем растёт контроль, от этого жители чувствуют себя безопаснее.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Будь уверен, слаймы, которых ты себя победил, могли запросто насолить любому.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Возможно, ты спас чью-то жизнь.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Слаймы слаймами, но если тебя прогатывает слайм, то тебе не остаётся ничего, кроме того, чтобы задохнуться.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Но не будем о грустном.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Продолжай в том же духе, а данжи всегда найдутся.',
            by: 'Мастер',
          ),
        ]),
      ];
}
