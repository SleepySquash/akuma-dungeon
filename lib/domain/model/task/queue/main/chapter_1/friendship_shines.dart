import 'package:akuma/domain/model/character.dart';
import 'package:akuma/domain/model/character/standard.dart';
import 'package:akuma/domain/model/dungeon.dart';
import 'package:akuma/domain/model/enemy/slime.dart';
import 'package:akuma/domain/model/enemy/veggies.dart';
import 'package:akuma/domain/model/item.dart';
import 'package:akuma/domain/model/item/all.dart';
import 'package:akuma/domain/service/character.dart';
import 'package:akuma/domain/service/item.dart';
import 'package:akuma/domain/service/player.dart';
import 'package:akuma/router.dart';
import 'package:akuma/ui/widget/modal_popup.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:novel/novel.dart';

import '/domain/model/flag.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';

class FriendshipShinesTask extends Task {
  const FriendshipShinesTask();

  @override
  String get id => 'chapter1_friendship_shines';

  @override
  String get name => 'Дружба сияет';

  @override
  String? get subtitle => 'Киару хочет встретиться';

  @override
  IconData get icon => Icons.emoji_emotions;

  @override
  List<Reward> get rewards => const [
        ExpReward(500),
        RankReward(5),
        FlagReward(Flag.partyUnlocked),
      ];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          const MusicLine('mixkit-summer-fun-13.mp3'),
          BackgroundLine('room/renovation.jpg'),
          DialogueLine(
              'Ты просыпаешься от очередного уведомления на телефоне.'),
          DialogueLine('Откуда на твоём телефоне уведомления?'),
          DialogueLine(
              'Ты отдупляешься, пытаешься придти в себя и понимаешь, что произошедшее вчера - не сон.'),
          DialogueLine('Ты шустро вчитываешься в уведомления.'),
          DialogueLine('Киару, Киару, Киару...'),
          DialogueLine('Вау, какая общительная девушка.'),
          DialogueLine(
              'Она предлагает встретиться, пообщаться, узнать друг друга лучше и уже скинула несколько анкет.'),
          DialogueLine(
              'Ты, окрылённый твоей первой возможной дружбой, с удовольствием соглашаешься.'),
          DialogueLine(
              'Ну, сначала нужно пройти все опросники, всё-таки неудобно оставлять без ответа.'),
          BackgroundLine('location/town.jpg'),
          CharacterLine('Kyaru.webp'),
          DialogueLine(
            'Доброе утро!',
            by: 'Киару',
          ),
          DialogueLine(
            'Пойдём завтракать!',
            by: 'Киару',
          ),
          DialogueLine(
              'Ты не показываешь, но рад видеть девушку в добром здравии.'),
          HideCharacterLine('Kyaru.webp'),
          DialogueLine('Вы отправляетесь в ресторан.'),
          DialogueLine(
              'Даже подумать страшно, насколько же это похоже на свидание.'),
          DialogueLine('А что, если у тебя есть жена? А ты не помнишь?'),
          DialogueLine(
              'Хотя будем честны: ты настолько человек культуры, что один этот факт делает тебя девственником.'),
          BackgroundLine('location/chinese_restaurant.jpg'),
          CharacterLine('Emiya_Shirou.webp'),
          DialogueLine('Чего пожелаете, юные господа?', by: 'Эмия'),
          DialogueLine('Ты просишь еду, Киару тоже.'),
          DialogueLine('No shit, Sherlok, какую еду?', by: 'Эмия'),
          DialogueLine('Вы оба в растерянности.'),
          DialogueLine(
              'Ты смотришь на Киару - она явно испытывает шок и не была готова к тому, что в ресторане нужно выбирать еду.'),
          DialogueLine('Ты тоже впервые в ресторане, поэтому и растерян.'),
          DialogueLine(
              'Тем не менее, ты помнишь все те мемы из тиктока, поэтому пытаешься спасти ситуацию.'),
          DialogueLine('Ты просишь повара удивить вас.'),
          DialogueLine('Ух, я так вас удивлю, ваще жесть.', by: 'Эмия'),
          HideCharacterLine('Emiya_Shirou.webp'),
          DialogueLine(
              'Он удаляется что-то готовить, уже через секунду ты начал слышать такие знакомые тобой восклики.'),
          DialogueLine('АЙ ЭМ ЗЕ БОН ОФ МАЙ СОРД.', by: 'Эмия'),
          DialogueLine('Время идёт, что-то остаётся вечным.'),
          CharacterLine('Kyaru.webp'),
          DialogueLine(
            'Уф, прости, я совсем не знаю, как тут что надо, хотя это я и позвала нас сюда.',
            by: 'Киару',
          ),
          DialogueLine(
              'Ты говоришь, что всё в порядке, ты тоже способен думать сейчас только о мемах из тиктока.'),
          DialogueLine('Вы остались вдвоём.'),
          DialogueLine('Буквально. Вы единственные в ресторане.'),
          DialogueLine('Чёртова доставка, все обленились.'),
          DialogueLine('Ты понимаешь, что стоит начать какой-нибудь разговор.'),
          DialogueLine(
              'Но не успеваешь ты открыть рот, как Киару сама нашла тему для разговора.'),
          DialogueLine(
            'Мы ведь теперь отряд, да, пати?',
            by: 'Киару',
          ),
          DialogueLine(
            'Давай тогда сегодня вместе повыполняем поручения?',
            by: 'Киару',
          ),
          DialogueLine(
            'И можно даже в данж сходить, было бы славно, в-вот.',
            by: 'Киару',
          ),
          DialogueLine(
              'Девушка явно нервничает, ты замечаешь это и спрашиваешь, всё ли в порядке.'),
          DialogueLine(
            'Да, конечно, мне просто нужно немножко времени.',
            by: 'Киару',
          ),
          DialogueLine(
            'Я впервые с кем-то в пати, поэтому боюсь, что могу оказаться бесполезной.',
            by: 'Киару',
          ),
          DialogueLine('Ты попросил её не волноваться об этом.'),
          DialogueLine('Всё обязательно будет хорошо, ты обещаешь.'),
          HideCharacterLine('Kyaru.webp'),
          CharacterLine('Emiya_Shirou.webp'),
          DialogueLine('Готово, ёпта.', by: 'Эмия'),
          DialogueLine('Повар подвозит к вам небольшую тележку.'),
          DialogueLine(
              'На тележке разделочная доска, продукты, переносная горелка...'),
          DialogueLine(
            'Хотели удивиться? Ну удивляйтесь, вот вам продукты, готовьте сами.',
            by: 'Эмия',
          ),
          DialogueLine('Ну что ж ты за человек-то такой.'),
          HideCharacterLine('Emiya_Shirou.webp'),
          CharacterLine('Kyaru.webp'),
          DialogueLine('Киару же взбудоражена.'),
          DialogueLine(
            'Это наше первое совместное поручение!',
            by: 'Киару',
          ),
          DialogueLine(
            'Это так... романтично!',
            by: 'Киару',
          ),
          DialogueLine('Так, теперь взбудоражен и ты.'),
          DialogueLine('Это возможность завоевать флажок в руте с Киару.'),
          DialogueLine(
              'Прошло всего мгновение, а ты уже представил вашу с ней свадьбу, двух детей, спокойную счастливую жизнь.'),
          HideCharacterLine('Kyaru.webp'),
          DialogueLine(
              'Пришло время показать, что ты идеальный вариант для неё.'),
          ExecuteLine(() async {
            await ModalPopup.show(
              isDismissible: false,
              context: router.context!,
              child: Builder(builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/character/Kyaru.webp'),
                    const Text('Kyaru joined the party!'),
                    ElevatedButton(
                      onPressed: Navigator.of(context).pop,
                      child: const Text('Nice'),
                    ),
                  ],
                );
              }),
            );

            CharacterService characterService = Get.find<CharacterService>();
            MyCharacter character = characterService.add(const Kyaru());

            if (character.weapons.isEmpty) {
              MyItem item =
                  Get.find<ItemService>().add(const PracticeOakSwordItem());
              characterService.equip(character, item);
            }

            Get.find<PlayerService>().addToParty(character);
          }),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-games-worldbeat-466.mp3',
            background: 'chinese_restaurant',
            stages: [
              DungeonStage(
                enemies: VeggieEnemies.f,
                multiplier: Decimal.fromInt(2),
                conditions: const [SlayedStageCondition(20)],
              ),
              DungeonStage(
                enemies: VeggieEnemies.f,
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
          const MusicLine('mixkit-summer-fun-13.mp3'),
          BackgroundLine('location/chinese_restaurant.jpg'),
          DialogueLine('Один за другим, ты рубишь овощи аки профессионал.'),
          DialogueLine('Ты так не старался никогда.'),
          DialogueLine(
              'Это будет лучшая шаверма в мире, а именно её ты и планируешь накрутить для дамы своего сердца.'),
          CharacterLine('Kyaru.webp'),
          DialogueLine(
            'Вау, у тебя так хорошо получается!',
            by: 'Киару',
          ),
          DialogueLine(
              'Ты хочешь поправить очки, которых у тебя нет, поэтому поправляешь очко - оно-то у тебя есть.'),
          DialogueLine('Киару делает вид, что ничего не заметила.'),
          HideCharacterLine('Kyaru.webp'),
          DialogueLine(
              'Твои ловкие движения пальцев, рук и ног - всё было натренировано только для этого момента.'),
          DialogueLine(
              'Широ, которого ты успел обругать, уже и не так уж-то плох, малаца, продумал ситуацию.'),
          DialogueLine(
              'Ты берёшь лаваш, крутишь в него овощи, льёшь соусец, курочку добавляешь и получается адовая смесь.'),
          DialogueLine(
              'Ладно, может и нормально так получилось, шавуху из готовых компонентов собрать уже несложно.'),
          DialogueLine('Кстати, откуда ты вообще знаешь о шаверме?'),
          DialogueLine('И почему шаверма, а не шаурма?'),
          DialogueLine('Может, ты был шавермастером из Лахтабурга?'),
          DialogueLine('Ведь только в Лахтабурге шаверму называют шавермой.'),
          DialogueLine(
              'Хм, вообще звучит как зацепка, куда отправиться дальше.'),
          CharacterLine('Kyaru.webp'),
          DialogueLine(
              'Хотя ты смотришь на это милейшее личико и уже как-то неуверен.'),
          DialogueLine('Закончив свой шедевр, ты передаёшь Киару ролл.'),
          DialogueLine(
            'Выглядит очень вкусно, ух ты!!',
            by: 'Киару',
          ),
          DialogueLine(
            'Спасибо большое!',
            by: 'Киару',
          ),
          DialogueLine(
              'Она приступает к трапезе, потихоньку откусывая кусочек за кусочком.'),
          DialogueLine('Ты довольный наблюдаешь, как она мурчит себе под нос.'),
          DialogueLine('Антропоморфы мурчат?'),
          DialogueLine('Как.'),
          DialogueLine('Же.'),
          DialogueLine('Это.'),
          DialogueLine('Мило.'),
          HideCharacterLine('Kyaru.webp'),
          DialogueLine(
              'Иметь друзей, возлюбленную, какую-то цель в жизни - и твоё восприятие жизни переворачивается с ног на голову.'),
          DialogueLine(
              'Поразительно, как небольшой социум способен даровать столько эмоций.'),
          DialogueLine(
              'И ты рад, что можешь вот так своими усилиями радовать одного человечка.'),
          DialogueLine('Да, это всего лишь еда.'),
          DialogueLine('Но в таких мелочах и заключается счастье, разве нет?'),
          DialogueLine(
              'Кормить, согревать, защищать - это те самые первые необходимости, которые нужны каждому.'),
          DialogueLine(
              'Живи и наслаждайся жизнью, дари кому-нибудь рядышком приятные эмоции.'),
          DialogueLine('Помогай, в конце концов, людям, ведь это так приятно.'),
          DialogueLine(
              'Ты приходишь к каким-то выводам, продолжая наблюдать за Киару.'),
          CharacterLine('Kyaru.webp'),
          DialogueLine('Девушка дожевала твою шаверму.'),
          DialogueLine('И, кажется, ей понравилось.'),
          DialogueLine(
            'Было очень вкусно!',
            by: 'Киару',
          ),
          DialogueLine(
            'Я такого никогда не пробовала, интересная штука.',
            by: 'Киару',
          ),
          DialogueLine(
            'А, это, приготовишь ещё как-нибудь??',
            by: 'Киару',
          ),
          DialogueLine('Обязательно.'),
          DialogueLine(
            'А, это, приготовишь ещё как-нибудь??',
            by: 'Киару',
          ),
          HideCharacterLine('Kyaru.webp'),
          CharacterLine('Emiya_Shirou.webp'),
          DialogueLine('Мощно.', by: 'Эмия'),
          HideCharacterLine('Emiya_Shirou.webp'),
          DialogueLine('Вы ничего не платите, ибо нехуй выёбываться.'),
          DialogueLine('И спокойно выходите из ресторана под Skillet.'),
          DialogueLine('I need a hero, всё такое, локальный мемчик.'),
          BackgroundLine('location/town.jpg'),
          CharacterLine('Kyaru.webp'),
          DialogueLine(
            'Мне очень неловко, что ты по итогу что-то внезапно начал готовить.',
            by: 'Киару',
          ),
          DialogueLine(
            'Но я благодарна тебе за это!',
            by: 'Киару',
          ),
          DialogueLine(
            'Пусть я и совсем чуть-чуть всего помогла, это было наша первая совместная работа.',
            by: 'Киару',
          ),
          DialogueLine(
            'И мне очень п-понравилось.',
            by: 'Киару',
          ),
          DialogueLine(
            'Пойдём погуляем ещё.',
            by: 'Киару',
          ),
          HideCharacterLine('Kyaru.webp'),
          DialogueLine(
              'Ты, безусловно, с радостью отправляешься вслед за этими ушками.'),
          DialogueLine('Вы забрели в парк.'),
          BackgroundLine('location/town_park.jpg'),
          DialogueLine('Здесь очень спокойно, людей почти и нет.'),
          DialogueLine(
              'Вы прошли по дорожке и так и не обнаружили ни одной скамейки.'),
          CharacterLine('Kyaru.webp'),
          DialogueLine(
            'А для чего тут парк вообще, если посидеть негде? >.<',
            by: 'Киару',
          ),
          HideCharacterLine('Kyaru.webp'),
          DialogueLine(
              'Ты соглашаешься, мэр этого города явно девственник и не шарит, насколько парк способствует поднятию флажков в рутах.'),
          DialogueLine('Вот при тебе такой фигни не было бы.'),
          DialogueLine('Может, баллотироваться в местный муниципалитет?'),
          DialogueLine('Как тут вообще выборы происходят?'),
          DialogueLine(
              'В демократии ли мы вообще живём? Или в тоталитаризме??'),
          DialogueLine('Нет, ты прям серьёзно напрягся.'),
          CharacterLine('Kyaru.webp'),
          DialogueLine(
            'У нас строится социализм, ты правда забыл и это?',
            by: 'Киару',
          ),
          DialogueLine('Бля. Это же ещё хуже, нет?'),
          DialogueLine(
            'Правда, до нас мало чего добирается из политики, да и я сама не разбираюсь совсем.',
            by: 'Киару',
          ),
          DialogueLine(
            'Вот в Столицаграде, я слышала, всё серьёзно.',
            by: 'Киару',
          ),
          DialogueLine('Тебя ждёт босс-коммунист?'),
          DialogueLine('Уф, это будет сложнее, чем босс-вертолёт.'),
          HideCharacterLine('Kyaru.webp'),
          DialogueLine('Прошли через весь парк, вы отправились дальше.'),
          BackgroundLine('location/market_stalls.jpg'),
          DialogueLine('Рынок.'),
          DialogueLine(
              'Мясо, хлеб, сыры, одежда - всё, что людям нужно, можно приорести здесь.'),
          DialogueLine(
              'Цены выше, чем в местной шестёрочке, но качество, судя по быстрому взгляду, лучше.'),
          DialogueLine(
              'Кроме того, тут товары, которые в шестёрочке и не найдёшь.'),
          DialogueLine('Рынок побеждает сетевые магазины?'),
          DialogueLine('Сейчас бы курс экономики, а не игры писать...'),
          DialogueLine('Киару подбегает то к одному стенду, то к другому.'),
          DialogueLine(
              'Её любознательность искренне умиляет, и ты просто следуешь хвостиком.'),
          HideBackgroundLine('location/market_stalls.jpg'),
          const StopMusicLine(),
          DialogueLine(
              'И так минута за минутой ваших странствий прошёл весь день.'),
          BackgroundLine('location/fields_sunset.jpg'),
          const MusicLine('mixkit-beautiful-dream-493.mp3'),
          DialogueLine('Вы вышли за город к речке.'),
          DialogueLine(
              'Отсюда видно начало леса, через которой ты однажды провожал торговца.'),
          DialogueLine(
              'Совсем лишённая сил, Киару, аккуратно поправив юбку, приземлилась прямо на траву.'),
          DialogueLine('Ты сел рядом.'),
          CharacterLine('Kyaru.webp'),
          DialogueLine(
              'Краем глаза ты заметил, что девушка пристально рассматривала тебя.'),
          DialogueLine('Ты обернулся, ваши взгляды встретились.'),
          DialogueLine(
            'Сегодня было очень весело, спасибо тебе большое за проведённое со мной время.',
            by: 'Киару',
          ),
          DialogueLine('Ты спрашиваешь, как она обычно проводит время.'),
          DialogueLine(
            'Я редко выхожу вот так на улицу.',
            by: 'Киару',
          ),
          DialogueLine(
            'Обычно я сидела читала или изучала что-нибудь.',
            by: 'Киару',
          ),
          DialogueLine(
            'Монстры, магия, зоология - я должна быть подготовлена.',
            by: 'Киару',
          ),
          DialogueLine(
            'Детство сильно сформировало мою жизнь, я готовилась стать путешественником.',
            by: 'Киару',
          ),
          DialogueLine(
            'И, вот, последние пару недель даются пока тяжеловато.',
            by: 'Киару',
          ),
          DialogueLine(
            'Времени на такое спокойное времяпрепровождение совсем не остаётся.',
            by: 'Киару',
          ),
          DialogueLine(
            'Мне дают, наверное, из-за внешности максимально простые поручения!',
            by: 'Киару',
          ),
          DialogueLine(
            'Сходить за продуктами для бабушки, найти кота (тыж кошечка, тебе проще), посидеть с питомцем.',
            by: 'Киару',
          ),
          DialogueLine(
            'Когда я наконец доказала, что могу идти сражаться с монстрами, то...',
            by: 'Киару',
          ),
          DialogueLine('Она прижала ноги поближе к себе.'),
          DialogueLine(
            'Стало страшно.',
            by: 'Киару',
          ),
          DialogueLine(
            'Стыдно признавать, я ведь к этому и шла, но сражаться страшно.',
            by: 'Киару',
          ),
          DialogueLine(
            'Первые два раза было даже весело, а в третий, когда ты пришёл, я не знала, что делать.',
            by: 'Киару',
          ),
          DialogueLine(
            'Они могут отбирать оружие, они бьют в ответ.',
            by: 'Киару',
          ),
          DialogueLine(
            'Об этом я не читала, этого нигде не пишут!',
            by: 'Киару',
          ),
          DialogueLine('Ты успокаиваешь её, что теперь всё будет хорошо.'),
          DialogueLine(
              'Всё-таки вы в пати, поэтому ты обещаешь, что таких ситуаций больше не повторится.'),
          DialogueLine(
              'Хотя прекрасно знаешь, что ты не всемогущ, ты не рыцарь на коне.'),
          DialogueLine('Ты сам слаб.'),
          DialogueLine('Всё ещё слаб.'),
          DialogueLine(
              'Grind gets real, ещё вчера ты пообещал себе стать сильнее.'),
          DialogueLine(
            'Спасибо.',
            by: 'Киару',
          ),
          DialogueLine(
            'Правда, мне приятно, что я теперь не одна.',
            by: 'Киару',
          ),
          DialogueLine(
            'И за сегодня мы провели достаточно времени, чтобы мне стало спокойнее рядом с тобой.',
            by: 'Киару',
          ),
          DialogueLine(
            'Кстати, я совсем ничего о тебе знаю.',
            by: 'Киару',
          ),
          DialogueLine(
            'Я очень полагаться на тебя и доверять тебе, т-ты понимаешь...',
            by: 'Киару',
          ),
          DialogueLine(
            'Поэтому я очень хочу знать тебя, пожалуйста, расскажи о себе что-нибудь.',
            by: 'Киару',
          ),
          DialogueLine(
              'Ты рассказываешь, что помнишь только последние 1-2 недели.'),
          DialogueLine(
              'И путешественником ты стал изначально ради того, чтобы найти кого-нибудь, кто поможет тебе вспомнить себя.'),
          DialogueLine('Хотя сейчас тебе уже не так и важно, кто ты.'),
          DialogueLine('Ты говоришь, что сердце ведёт тебя на верный путь.'),
          DialogueLine(
              'Твои чувства, твоё желание изменить мир, защитить всех от ужасов, которые постоянно происходят вокруг.'),
          DialogueLine(
              'Ты хочешь сказать, что хочешь защитить Киару, но ты ссылко тряпочное, поэтому молчишь.'),
          DialogueLine(
            'И ты об этом раньше не сказал?',
            by: 'Киару',
          ),
          DialogueLine(
            'Божечки-кошечки, ты всё это время искал себя.',
            by: 'Киару',
          ),
          DialogueLine(
            'Это такая романтичная цель быть путешественником.',
            by: 'Киару',
          ),
          DialogueLine('Ты умалчиваешь тот факт, что выбора у тебя не было.'),
          DialogueLine(
              'Но говоришь, что в твоём телефоне была только заметка с гильдией Алоросса.'),
          DialogueLine(
            'Звучит так... мистически.',
            by: 'Киару',
          ),
          DialogueLine('Глаза девушки загорелись.'),
          DialogueLine(
            'Я очень-очень-очень хочу помочь тебе вспомнить себя.',
            by: 'Киару',
          ),
          DialogueLine(
            'У меня есть несколько вариантов: нужно обязательно зайти в школу, вдруг ты у нас учился.',
            by: 'Киару',
          ),
          DialogueLine(
            'Потом в церковь - там иногда на попечительство принимают оставшихся без жилья.',
            by: 'Киару',
          ),
          DialogueLine(
            'И на шахты Алоросса, шахтёры могли видеть тебя, ты мог проходить мимо.',
            by: 'Киару',
          ),
          DialogueLine(
            'Поэтому предлагаю завтрашний день посвятить нашим путешествиям!',
            by: 'Киару',
          ),
          DialogueLine('Ты с радостью соглашаешься.'),
          DialogueLine(
            'А сейчас пойдём потихоньку?',
            by: 'Киару',
          ),
          HideCharacterLine('Kyaru.webp'),
          DialogueLine(
              'Ты бордо встаёшь, отряхиваясь от листьев и прочей грязи.'),
          DialogueLine('Шорох за спиной.'),
          DialogueLine('Ещё один.'),
          DialogueLine('Хлюпанье.'),
          DialogueLine('Сзади.'),
          DialogueLine('Слева.'),
          DialogueLine('Справа.'),
          DialogueLine('Кто посмел испорить наше свидание?'),
          DialogueLine('Ты, не оборачиваясь, одним движением достаёшь меч.'),
          DialogueLine('Ты просишь Киару держаться рядом.'),
          DialogueLine(
            'Нет, я с тобой.',
            by: 'Киару',
          ),
          DialogueLine('Она встаёт рядом.'),
          DialogueLine('Десятки глаз смотрят на вас.'),
          DialogueLine('Наконец, из кустов просачивается эта мерзкая слизь.'),
          DialogueLine('Выползли под вечер?'),
          DialogueLine('Ты сжимаешь рукоять покрепче.'),
          DialogueLine('Ты теперь не один и не можешь позволить себе рашить.'),
          CharacterLine('Kyaru.webp'),
          DialogueLine(
              'Киару стоит рядом - ты замечаешь, как шевелятся её ушки.'),
          DialogueLine('Интересное наблюдение - они реагируют на любой шорох.'),
          DialogueLine('Уши у антромопорфов заметно больше человеческих.'),
          DialogueLine('Логично предположить, что и сильно чувствительнее.'),
          DialogueLine('Киару ориентируется на звуки.'),
          HideCharacterLine('Kyaru.webp'),
          DialogueLine('Один из слаймов приближается на расстояние удара.'),
          DialogueLine('Вы нападаете.'),
        ]),
        DungeonStep(
          Dungeon(
            music: 'music/mixkit-beautiful-dream-493.mp3',
            background: 'fields_sunset',
            stages: [
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(10)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.f,
                conditions: const [SlayedStageCondition(5)],
              ),
              DungeonStage(
                enemies: SlimeEnemies.fPlus,
                conditions: const [SlayedStageCondition(1)],
              ),
            ],
          ),
        ),
        NovelStep([
          BackgroundLine('location/fields_sunset.jpg'),
          const MusicLine('mixkit-beautiful-dream-493.mp3'),
          DialogueLine('Последний down (даун).'),
          DialogueLine(
              'Ты отряхиваешь слизь с кончика твоего меча и заносишь его обратно в ножны.'),
          CharacterLine('Kyaru.webp'),
          DialogueLine('Ты спрашиваешь у Киару, всё ли в порядке.'),
          DialogueLine(
            'Д-да, ты справился с ними так просто.',
            by: 'Киару',
          ),
          DialogueLine('Мы справились.'),
          DialogueLine(
            'Мы работали как команда, это было... так необычно.',
            by: 'Киару',
          ),
          DialogueLine('Ты польщён это слышать, конечно.'),
          DialogueLine(
            'И было... весело!',
            by: 'Киару',
          ),
          DialogueLine('Ты соглашаешься и предлагаешь скорее пойти в город.'),
          DialogueLine(
            'Да, конечно.',
            by: 'Киару',
          ),
          HideCharacterLine('Kyaru.webp'),
          BackgroundLine('location/town_dawn.jpg'),
          DialogueLine('Вечер, снова та же площадь, что и вчера.'),
          CharacterLine('Kyaru.webp'),
          DialogueLine(
            'Сегодня было весело, спасибо тебе.',
            by: 'Киару',
          ),
          DialogueLine(
              'Она улыбнулась тебе и побежала домой, иногда оглядываясь и махая рукой.'),
          DialogueLine('Сегодня день заканчивается явно приятнее, чем вчера.'),
          DialogueLine('Поэтому никаких what a day, ты рад.'),
          DialogueLine('Сегодня вы однозначно сблизились.'),
          DialogueLine('И с этими мыслями ты отправился домой.'),
          HideBackgroundLine('location/town_dawn.jpg'),
        ]),
      ];
}
