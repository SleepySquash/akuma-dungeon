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
        QuestCommissionsCompletedCriteria(3),
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
          MusicLine.asset('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine.asset('location/guild.jpg'),
          ImageLine.asset('Arda.png'),
          const DialogueLine(
            'Благодарю тебя, путешественник!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Твой вклад в Алоросс и поддержку города уже признают жители.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'О тебе начинают говорить, поэтому если кто-то и знает тебя тут, то обязательно окликнется.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Продолжай выполнять квесты, чтобы заработать репутацию и сделать себе имя.',
            by: 'Мастер',
          ),
          const DialogueLine('Ты благодарен гильдмастеру за помощь.'),
          const DialogueLine(
            'Что ж, давай поговорим про данжи.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Напоминаю, данжи открываются постоянно в случайных локациях.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Они опасны, поскольку если за несколько дней данж не закрыть, то монстры выползают наружу.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Большинство данжей спонсирует именно гильдия, хотя некоторые могут быть проблемой и для бизнеса.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'По поводу данжей у Алоросса есть одна проблема - рук совсем не хватает, чтобы их закрывать быстро.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Но подвергать жизни простого населения опасности неправильно, игнорируя большинство данжей.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'И, эх, мне очень не хочется отпускать путешественников самостоятельно закрыть данжи, это слишком опасно.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'К сожалению, я не могу найти никого в пати тебе на данный момент.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Я очень надеюсь, что ты поможешь нам разобраться с ситуацией и повысить контроль над данжами.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Ты показал себя достойно при выполнении опасных поручений, поэтому можешь изучить список поручений и принять несложный данж.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Подходи ко мне, как будешь готов.',
            by: 'Мастер',
          ),
          HideImageLine.asset('Arda.png'),
          const DialogueLine(
              'Ты подходишь и изучаешь список под заголовком "Данжи".'),
          const DialogueLine(
              'И действительно, вокруг города их сильно больше, чем путешественников в рейтинговой таблице.'),
          const DialogueLine(
              'Ты не можешь судить действия гильдмастера - он пытается меньшинством спасти большинство.'),
          const DialogueLine('Возможно, это и правильно.'),
          const DialogueLine(
              'Тем не менее, внутри тебя растёт какое-то чувство справедливости, ты хочешь изменить ситуацию.'),
          const DialogueLine(
              'Ты хочешь, чтобы и жители города жили спокойно, и чтобы никто не пострадал.'),
          const DialogueLine(
              'Наконец, ты хватаешь одну из листовок и подходишь к гильдмастеру.'),
          ImageLine.asset('Arda.png'),
          const DialogueLine(
            'Угу, момент.',
            by: 'Мастер',
          ),
          const DialogueLine('Он что-то щёлкает на компьютере.'),
          const DialogueLine(
            'Да, готово.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Помни, что в данжах самое главное - не спешить.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Если чувствуешь опасность, отступай немедля.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Ни в коем случае не подвергай ни себя, ни окружающих опасности.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'В нормальных пати есть роли: танк, урон и поддержка.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'К сожалению, в соло ты обязан выполнять все три роли, поэтому будь осторожен, пожалуйста.',
            by: 'Мастер',
          ),
          const DialogueLine(
              'Ты заверяешь его, что всё будет хорошо, и отправляешься к данжу.'),
          HideImageLine.asset('Arda.png'),
          const DialogueLine(
              'Когда уже изобретут приложение "Мой Путешественник", где можно будет в AR строить маршрут?'),
          const DialogueLine(
              'Ты негодуешь. Возможно, ты был айтишником. Или негодователем.'),
          MusicLine.asset('mixkit-summer-fun-13.mp3'),
          BackgroundLine.asset('location/town.jpg'),
          const DialogueLine(
              'Пока ты идёшь по городу, ты осматриваешься вокруг.'),
          const DialogueLine(
              'Приятный для глаза пейзаж, очень умиротворённый и милый вид.'),
          const DialogueLine('Ты хочешь видеть это всегда, всю жизнь.'),
          const DialogueLine(
              'Твои глаза всё это время были заострены на проходящей мимо кошкодевочке.'),
          const DialogueLine('Город тоже ничо так.'),
          const DialogueLine(
              'Вообще, интересно, насколько сложно тут завести отношения?'),
          const DialogueLine(
              'Ты, как человек определённого пола, имеешь склонность к людям другого пола.'),
          const DialogueLine('Антропоморфы - мечта любого.'),
          const DialogueLine(
              'Просыпаться каждый день и ощущать в кровати тепло такого родного тебе тела.'),
          const DialogueLine(
              'Засыпать в объятиях, чесать за ушком, наслаждаться радостью в этих глазках.'),
          const DialogueLine(
              'Тебя радует то, насколько мирно все сосуществуют друг с другом.'),
          const DialogueLine(
              'И ты уже начинаешь ставить под сомнения цель твоих путешествий.'),
          const DialogueLine(
              'Какая разница, кто ты, когда просто жить жизнь себе в радость важнее?'),
          const DialogueLine(
              'Путешествия дарят возможность посмотреть на этот чудесный мир, почувствовать его со всех сторон.'),
          const DialogueLine(
              'И, возможно, набрать славу, подняться в ранге, создать себе доброе имя и завести гарем ушастых.'),
          BackgroundLine.asset('location/mediterranean_town.jpg'),
          const DialogueLine('Ты был уже недалеко от данжа.'),
          const DialogueLine(
              'Прибыв на место, ты действительно обнаружил портал.'),
          const DialogueLine(
              'По ту сторону ничего не видно, картинка слишком искажена.'),
          const DialogueLine('Из портала веет холодом.'),
          const DialogueLine(
              'Тем не менее, ты решительно делаешь шаг вперёд...'),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-fright-night-871.mp3',
            background: 'mines',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(5)],
              ),
            ],
          ),
          withEntrance: true,
          entranceFrom: 'location/mediterranean_town',
        ),
        NovelStep([
          MusicLine.asset('mixkit-fright-night-871.mp3'),
          BackgroundLine.asset('location/mines.jpg'),
          const DialogueLine('Тёплое однако приветствие.'),
          const DialogueLine(
              'Ты отбился от кучки слаймов, что стояла прямо на входе.'),
          const DialogueLine(
              'Теперь же у тебя появилась возможность осмотреться.'),
          const DialogueLine('Ты в пещере, есть даже рельсы для вагонетки.'),
          const DialogueLine('Насколько же развито измерение Акумы?'),
          const DialogueLine(
              'И зачем его обитатели вообще нападает на наш мир?'),
          const DialogueLine(
              'Вопросов много, но сейчас стоит проявить бдительность.'),
          const DialogueLine(
              'Слаймы слаймами, но это их дом, тут они чувствуют себя сильно проворнее.'),
          const DialogueLine(
              'Ты вспоминаешь жуткие кадры из той энциклопедии монстров и просто надеешься, что этот данж содержит только слаймов.'),
          const DialogueLine(
              'Аккуратно продвигаясь, чтобы не делать слишком много шума, ты продвигаешься вглубь.'),
          const DialogueLine('Закрыть данж - значит убить босса данжа.'),
          const DialogueLine(
              'Босс является катализатором, сдерживающим своей магической силой переход в наш мир.'),
          const DialogueLine(
              'Соответственно, от ауры босса и зависит то магическое поле вокруг портала, которую гильдия и исследует, чтобы определить ранг данжа.'),
          const DialogueLine(
              'Босс подземелья ранг F имеет ранг F+ и так далее.'),
          const DialogueLine('Наконец, ты видишь просвет.'),
          BackgroundLine.asset('location/underground_waterfall.jpg'),
          const DialogueLine(
              'Перед твоими глазами открывается красивая картина.'),
          const DialogueLine(
              'Данжи являются не только опасностью для человечества, но и источником многих редких минералов и материалов.'),
          const DialogueLine(
              'Вероятно, то, что ты видишь на стенах - вполне себе один их из таких ресурсов.'),
          const DialogueLine(
              'Ты здесь не за этим, конечно, но была бы у тебя кирка, ты бы с удовольствием взял бы с десяток другой этих блестящих камней.'),
          const DialogueLine('Краем уха ты уловил бульканье за углом.'),
          const DialogueLine(
              'Вскоре и по водной глади начали расходиться волны - к тебе кто-то приближался.'),
          const DialogueLine('Слаймы.'),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-fright-night-871.mp3',
            background: 'underground_waterfall',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(10)],
              ),
            ],
          ),
        ),
        NovelStep([
          MusicLine.asset('mixkit-fright-night-871.mp3'),
          BackgroundLine.asset('location/underground_waterfall.jpg'),
          const DialogueLine('Ты справился с очередной пачкой слаймов.'),
          const DialogueLine(
              'Но прежде чем ты успел отдохнуть, перед тобой вылезла целая куча новых.'),
          const DialogueLine(
              'Ты уже выдохся, а без времени на отдых ты чувствовал себя дезориентированно.'),
          const DialogueLine(
              'Но одно бросилось тебе в глаза - за этой ордой слаймов выполз слайм побольше.'),
          const DialogueLine('Может ли быть, что это босс?'),
          const DialogueLine(
              'Нет, так и есть! Ты наблюдаешь босса этого данжа, от него исходит особая аура.'),
          const DialogueLine(
              'И судя по тому, как другие слаймы пресмыкаются перед ним, становится понятно, что он тут главный.'),
          const DialogueLine('Ты сжимаешь своё оружие покрепче.'),
          const DialogueLine('Время для финального удара.'),
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
          MusicLine.asset('mixkit-fright-night-871.mp3'),
          BackgroundLine.asset('location/underground_waterfall.jpg'),
          const DialogueLine(
              'Уверенным, пусть и истощённым, движением ты разрубаешь слайма пополам.'),
          const DialogueLine(
              'Странно, что они прекращают свою жизнидеятельность от этого.'),
          const DialogueLine('Разве слаймы не должны скукоживаться обартно?'),
          const DialogueLine(
              'Возможно, так делают слаймы более высокого ранга?'),
          const DialogueLine(
              'В любом случае, ты больше не слышишь движения рядом, наконец-то можно передохнуть.'),
          const DialogueLine(
              'Только ты начинаешь переводить дыхание, как свет в пещере меняется с тёмного на более светлый.'),
          const DialogueLine('Значит ли это, что данж закрылся?'),
          const DialogueLine(
              'Так-так-так, а если данж закрылся с тобой внутри?'),
          const DialogueLine('Ты спешно отправляешься к выходу.'),
          BackgroundLine.asset('location/mines.jpg'),
          const DialogueLine('К счастью, портал всё ещё здесь.'),
          const DialogueLine('Особо не раздумывая, ты прыгаешь в него.'),
          MusicLine.asset('mixkit-summer-fun-13.mp3'),
          BackgroundLine.asset('location/mediterranean_town.jpg'),
          const DialogueLine('Свобода!'),
          const DialogueLine(
              'Ты смотришь за спину - портал действительно изменил свой цвет на белый.'),
          const DialogueLine(
              'Ты понимаешь, что ничего в устройстве порталов не понимаешь.'),
          const DialogueLine(
              'Следующим шагом тебе обязательно нужно будет почитать или поизучать, как они работают.'),
          const DialogueLine('И, возможно, прихватить где-нибудь кирку.'),
          const DialogueLine('А на сегодня ты закончил, слишком много эмоций.'),
          const DialogueLine('Потихоньку ты отправляешься в город.'),
          BackgroundLine.asset('location/town.jpg'),
          const DialogueLine(
              'Внешне ничего не изменилось, а по ощущениям ты прошёл через Ад.'),
          const DialogueLine(
              'Ты не можешь сказать, что чуть жопу не потерял - жопа на месте и ещё какая.'),
          const DialogueLine(
              'Но тот факт, что вокруг постоянно открываются такие порталы в другое измерения, из которых прут монстры...'),
          const DialogueLine(
              'Теперь ты начинаешь осознавать опасность этих данжей.'),
          const DialogueLine(
              'Ты не замечаешь, как стоишь уже напротив гильдии.'),
          MusicLine.asset('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine.asset('location/guild.jpg'),
          ImageLine.asset('Arda.png'),
          const DialogueLine(
            'Рад тебя видеть, путешественник!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Да, приборы засекли успешное закрытие данжа, благодарю тебя.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'А? Да, данж ещё сутки будет открытым.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Времени, чтобы покинуть данж, просто полно.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Я слышал, в зачищенных данжах устраивали и вечеринки, и сосисочные сходки, и концерты.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Правда, о случаях, чтобы кто-то оставался в данже и не возвращаося, я лично не знаю, но слышал, что такое случается.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Что происходит с такими путешественникам - остаётся лишь гадать.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Как и из загробной жизни, никто после такого не возвращался к нам и не рассказывал, что там как.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Но лучше не попадать в такую ситуацию, естественно.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Вот твоя награда, путешественник, ты молодец.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Помни, что с каждым закрытым данжем растёт контроль, от этого жители чувствуют себя безопаснее.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Будь уверен, слаймы, которых ты себя победил, могли запросто насолить любому.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Возможно, ты спас чью-то жизнь.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Слаймы слаймами, но если тебя прогатывает слайм, то тебе не остаётся ничего, кроме того, чтобы задохнуться.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Но не будем о грустном.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Продолжай в том же духе, а данжи всегда найдутся.',
            by: 'Мастер',
          ),
        ]),
      ];
}
