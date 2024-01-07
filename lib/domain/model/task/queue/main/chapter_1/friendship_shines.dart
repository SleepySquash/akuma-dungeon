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
          MusicLine.asset('mixkit-summer-fun-13.mp3'),
          BackgroundLine.asset('room/renovation.jpg'),
          const DialogueLine(
              'Ты просыпаешься от очередного уведомления на телефоне.'),
          const DialogueLine('Откуда на твоём телефоне уведомления?'),
          const DialogueLine(
              'Ты отдупляешься, пытаешься придти в себя и понимаешь, что произошедшее вчера - не сон.'),
          const DialogueLine('Ты шустро вчитываешься в уведомления.'),
          const DialogueLine('Киару, Киару, Киару...'),
          const DialogueLine('Вау, какая общительная девушка.'),
          const DialogueLine(
              'Она предлагает встретиться, пообщаться, узнать друг друга лучше и уже скинула несколько анкет.'),
          const DialogueLine(
              'Ты, окрылённый твоей первой возможной дружбой, с удовольствием соглашаешься.'),
          const DialogueLine(
              'Ну, сначала нужно пройти все опросники, всё-таки неудобно оставлять без ответа.'),
          BackgroundLine.asset('location/town.jpg'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine(
            'Доброе утро!',
            by: 'Киару',
          ),
          const DialogueLine(
            'Пойдём завтракать!',
            by: 'Киару',
          ),
          const DialogueLine(
              'Ты не показываешь, но рад видеть девушку в добром здравии.'),
          HideImageLine.asset('Kyaru.webp'),
          const DialogueLine('Вы отправляетесь в ресторан.'),
          const DialogueLine(
              'Даже подумать страшно, насколько же это похоже на свидание.'),
          const DialogueLine('А что, если у тебя есть жена? А ты не помнишь?'),
          const DialogueLine(
              'Хотя будем честны: ты настолько человек культуры, что один этот факт делает тебя девственником.'),
          BackgroundLine.asset('location/chinese_restaurant.jpg'),
          ImageLine.asset('Emiya_Shirou.webp'),
          const DialogueLine('Чего пожелаете, юные господа?', by: 'Эмия'),
          const DialogueLine('Ты просишь еду, Киару тоже.'),
          const DialogueLine('No shit, Sherlok, какую еду?', by: 'Эмия'),
          const DialogueLine('Вы оба в растерянности.'),
          const DialogueLine(
              'Ты смотришь на Киару - она явно испытывает шок и не была готова к тому, что в ресторане нужно выбирать еду.'),
          const DialogueLine(
              'Ты тоже впервые в ресторане, поэтому и растерян.'),
          const DialogueLine(
              'Тем не менее, ты помнишь все те мемы из тиктока, поэтому пытаешься спасти ситуацию.'),
          const DialogueLine('Ты просишь повара удивить вас.'),
          const DialogueLine('Ух, я так вас удивлю, ваще жесть.', by: 'Эмия'),
          HideImageLine.asset('Emiya_Shirou.webp'),
          const DialogueLine(
              'Он удаляется что-то готовить, уже через секунду ты начал слышать такие знакомые тобой восклики.'),
          const DialogueLine('АЙ ЭМ ЗЕ БОН ОФ МАЙ СОРД.', by: 'Эмия'),
          const DialogueLine('Время идёт, что-то остаётся вечным.'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine(
            'Уф, прости, я совсем не знаю, как тут что надо, хотя это я и позвала нас сюда.',
            by: 'Киару',
          ),
          const DialogueLine(
              'Ты говоришь, что всё в порядке, ты тоже способен думать сейчас только о мемах из тиктока.'),
          const DialogueLine('Вы остались вдвоём.'),
          const DialogueLine('Буквально. Вы единственные в ресторане.'),
          const DialogueLine('Чёртова доставка, все обленились.'),
          const DialogueLine(
              'Ты понимаешь, что стоит начать какой-нибудь разговор.'),
          const DialogueLine(
              'Но не успеваешь ты открыть рот, как Киару сама нашла тему для разговора.'),
          const DialogueLine(
            'Мы ведь теперь отряд, да, пати?',
            by: 'Киару',
          ),
          const DialogueLine(
            'Давай тогда сегодня вместе повыполняем поручения?',
            by: 'Киару',
          ),
          const DialogueLine(
            'И можно даже в данж сходить, было бы славно, в-вот.',
            by: 'Киару',
          ),
          const DialogueLine(
              'Девушка явно нервничает, ты замечаешь это и спрашиваешь, всё ли в порядке.'),
          const DialogueLine(
            'Да, конечно, мне просто нужно немножко времени.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Я впервые с кем-то в пати, поэтому боюсь, что могу оказаться бесполезной.',
            by: 'Киару',
          ),
          const DialogueLine('Ты попросил её не волноваться об этом.'),
          const DialogueLine('Всё обязательно будет хорошо, ты обещаешь.'),
          HideImageLine.asset('Kyaru.webp'),
          ImageLine.asset('Emiya_Shirou.webp'),
          const DialogueLine('Готово, ёпта.', by: 'Эмия'),
          const DialogueLine('Повар подвозит к вам небольшую тележку.'),
          const DialogueLine(
              'На тележке разделочная доска, продукты, переносная горелка...'),
          const DialogueLine(
            'Хотели удивиться? Ну удивляйтесь, вот вам продукты, готовьте сами.',
            by: 'Эмия',
          ),
          const DialogueLine('Ну что ж ты за человек-то такой.'),
          HideImageLine.asset('Emiya_Shirou.webp'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine('Киару же взбудоражена.'),
          const DialogueLine(
            'Это наше первое совместное поручение!',
            by: 'Киару',
          ),
          const DialogueLine(
            'Это так... романтично!',
            by: 'Киару',
          ),
          const DialogueLine('Так, теперь взбудоражен и ты.'),
          const DialogueLine(
              'Это возможность завоевать флажок в руте с Киару.'),
          const DialogueLine(
              'Прошло всего мгновение, а ты уже представил вашу с ней свадьбу, двух детей, спокойную счастливую жизнь.'),
          HideImageLine.asset('Kyaru.webp'),
          const DialogueLine(
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
          MusicLine.asset('mixkit-summer-fun-13.mp3'),
          BackgroundLine.asset('location/chinese_restaurant.jpg'),
          const DialogueLine(
              'Один за другим, ты рубишь овощи аки профессионал.'),
          const DialogueLine('Ты так не старался никогда.'),
          const DialogueLine(
              'Это будет лучшая шаверма в мире, а именно её ты и планируешь накрутить для дамы своего сердца.'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine(
            'Вау, у тебя так хорошо получается!',
            by: 'Киару',
          ),
          const DialogueLine(
              'Ты хочешь поправить очки, которых у тебя нет, поэтому поправляешь очко - оно-то у тебя есть.'),
          const DialogueLine('Киару делает вид, что ничего не заметила.'),
          HideImageLine.asset('Kyaru.webp'),
          const DialogueLine(
              'Твои ловкие движения пальцев, рук и ног - всё было натренировано только для этого момента.'),
          const DialogueLine(
              'Широ, которого ты успел обругать, уже и не так уж-то плох, малаца, продумал ситуацию.'),
          const DialogueLine(
              'Ты берёшь лаваш, крутишь в него овощи, льёшь соусец, курочку добавляешь и получается адовая смесь.'),
          const DialogueLine(
              'Ладно, может и нормально так получилось, шавуху из готовых компонентов собрать уже несложно.'),
          const DialogueLine('Кстати, откуда ты вообще знаешь о шаверме?'),
          const DialogueLine('И почему шаверма, а не шаурма?'),
          const DialogueLine('Может, ты был шавермастером из Лахтабурга?'),
          const DialogueLine(
              'Ведь только в Лахтабурге шаверму называют шавермой.'),
          const DialogueLine(
              'Хм, вообще звучит как зацепка, куда отправиться дальше.'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine(
              'Хотя ты смотришь на это милейшее личико и уже как-то неуверен.'),
          const DialogueLine('Закончив свой шедевр, ты передаёшь Киару ролл.'),
          const DialogueLine(
            'Выглядит очень вкусно, ух ты!!',
            by: 'Киару',
          ),
          const DialogueLine(
            'Спасибо большое!',
            by: 'Киару',
          ),
          const DialogueLine(
              'Она приступает к трапезе, потихоньку откусывая кусочек за кусочком.'),
          const DialogueLine(
              'Ты довольный наблюдаешь, как она мурчит себе под нос.'),
          const DialogueLine('Антропоморфы мурчат?'),
          const DialogueLine('Как.'),
          const DialogueLine('Же.'),
          const DialogueLine('Это.'),
          const DialogueLine('Мило.'),
          HideImageLine.asset('Kyaru.webp'),
          const DialogueLine(
              'Иметь друзей, возлюбленную, какую-то цель в жизни - и твоё восприятие жизни переворачивается с ног на голову.'),
          const DialogueLine(
              'Поразительно, как небольшой социум способен даровать столько эмоций.'),
          const DialogueLine(
              'И ты рад, что можешь вот так своими усилиями радовать одного человечка.'),
          const DialogueLine('Да, это всего лишь еда.'),
          const DialogueLine(
              'Но в таких мелочах и заключается счастье, разве нет?'),
          const DialogueLine(
              'Кормить, согревать, защищать - это те самые первые необходимости, которые нужны каждому.'),
          const DialogueLine(
              'Живи и наслаждайся жизнью, дари кому-нибудь рядышком приятные эмоции.'),
          const DialogueLine(
              'Помогай, в конце концов, людям, ведь это так приятно.'),
          const DialogueLine(
              'Ты приходишь к каким-то выводам, продолжая наблюдать за Киару.'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine('Девушка дожевала твою шаверму.'),
          const DialogueLine('И, кажется, ей понравилось.'),
          const DialogueLine(
            'Было очень вкусно!',
            by: 'Киару',
          ),
          const DialogueLine(
            'Я такого никогда не пробовала, интересная штука.',
            by: 'Киару',
          ),
          const DialogueLine(
            'А, это, приготовишь ещё как-нибудь??',
            by: 'Киару',
          ),
          const DialogueLine('Обязательно.'),
          const DialogueLine(
            'А, это, приготовишь ещё как-нибудь??',
            by: 'Киару',
          ),
          HideImageLine.asset('Kyaru.webp'),
          ImageLine.asset('Emiya_Shirou.webp'),
          const DialogueLine('Мощно.', by: 'Эмия'),
          HideImageLine.asset('Emiya_Shirou.webp'),
          const DialogueLine('Вы ничего не платите, ибо нехуй выёбываться.'),
          const DialogueLine('И спокойно выходите из ресторана под Skillet.'),
          const DialogueLine('I need a hero, всё такое, локальный мемчик.'),
          BackgroundLine.asset('location/town.jpg'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine(
            'Мне очень неловко, что ты по итогу что-то внезапно начал готовить.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Но я благодарна тебе за это!',
            by: 'Киару',
          ),
          const DialogueLine(
            'Пусть я и совсем чуть-чуть всего помогла, это было наша первая совместная работа.',
            by: 'Киару',
          ),
          const DialogueLine(
            'И мне очень п-понравилось.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Пойдём погуляем ещё.',
            by: 'Киару',
          ),
          HideImageLine.asset('Kyaru.webp'),
          const DialogueLine(
              'Ты, безусловно, с радостью отправляешься вслед за этими ушками.'),
          const DialogueLine('Вы забрели в парк.'),
          BackgroundLine.asset('location/town_park.jpg'),
          const DialogueLine('Здесь очень спокойно, людей почти и нет.'),
          const DialogueLine(
              'Вы прошли по дорожке и так и не обнаружили ни одной скамейки.'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine(
            'А для чего тут парк вообще, если посидеть негде? >.<',
            by: 'Киару',
          ),
          HideImageLine.asset('Kyaru.webp'),
          const DialogueLine(
              'Ты соглашаешься, мэр этого города явно девственник и не шарит, насколько парк способствует поднятию флажков в рутах.'),
          const DialogueLine('Вот при тебе такой фигни не было бы.'),
          const DialogueLine('Может, баллотироваться в местный муниципалитет?'),
          const DialogueLine('Как тут вообще выборы происходят?'),
          const DialogueLine(
              'В демократии ли мы вообще живём? Или в тоталитаризме??'),
          const DialogueLine('Нет, ты прям серьёзно напрягся.'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine(
            'У нас строится социализм, ты правда забыл и это?',
            by: 'Киару',
          ),
          const DialogueLine('Бля. Это же ещё хуже, нет?'),
          const DialogueLine(
            'Правда, до нас мало чего добирается из политики, да и я сама не разбираюсь совсем.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Вот в Столицаграде, я слышала, всё серьёзно.',
            by: 'Киару',
          ),
          const DialogueLine('Тебя ждёт босс-коммунист?'),
          const DialogueLine('Уф, это будет сложнее, чем босс-вертолёт.'),
          HideImageLine.asset('Kyaru.webp'),
          const DialogueLine('Прошли через весь парк, вы отправились дальше.'),
          BackgroundLine.asset('location/market_stalls.jpg'),
          const DialogueLine('Рынок.'),
          const DialogueLine(
              'Мясо, хлеб, сыры, одежда - всё, что людям нужно, можно приорести здесь.'),
          const DialogueLine(
              'Цены выше, чем в местной шестёрочке, но качество, судя по быстрому взгляду, лучше.'),
          const DialogueLine(
              'Кроме того, тут товары, которые в шестёрочке и не найдёшь.'),
          const DialogueLine('Рынок побеждает сетевые магазины?'),
          const DialogueLine('Сейчас бы курс экономики, а не игры писать...'),
          const DialogueLine(
              'Киару подбегает то к одному стенду, то к другому.'),
          const DialogueLine(
              'Её любознательность искренне умиляет, и ты просто следуешь хвостиком.'),
          HideBackgroundLine(),
          const StopMusicLine(),
          const DialogueLine(
              'И так минута за минутой ваших странствий прошёл весь день.'),
          BackgroundLine.asset('location/fields_sunset.jpg'),
          MusicLine.asset('mixkit-beautiful-dream-493.mp3'),
          const DialogueLine('Вы вышли за город к речке.'),
          const DialogueLine(
              'Отсюда видно начало леса, через которой ты однажды провожал торговца.'),
          const DialogueLine(
              'Совсем лишённая сил, Киару, аккуратно поправив юбку, приземлилась прямо на траву.'),
          const DialogueLine('Ты сел рядом.'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine(
              'Краем глаза ты заметил, что девушка пристально рассматривала тебя.'),
          const DialogueLine('Ты обернулся, ваши взгляды встретились.'),
          const DialogueLine(
            'Сегодня было очень весело, спасибо тебе большое за проведённое со мной время.',
            by: 'Киару',
          ),
          const DialogueLine('Ты спрашиваешь, как она обычно проводит время.'),
          const DialogueLine(
            'Я редко выхожу вот так на улицу.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Обычно я сидела читала или изучала что-нибудь.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Монстры, магия, зоология - я должна быть подготовлена.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Детство сильно сформировало мою жизнь, я готовилась стать путешественником.',
            by: 'Киару',
          ),
          const DialogueLine(
            'И, вот, последние пару недель даются пока тяжеловато.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Времени на такое спокойное времяпрепровождение совсем не остаётся.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Мне дают, наверное, из-за внешности максимально простые поручения!',
            by: 'Киару',
          ),
          const DialogueLine(
            'Сходить за продуктами для бабушки, найти кота (тыж кошечка, тебе проще), посидеть с питомцем.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Когда я наконец доказала, что могу идти сражаться с монстрами, то...',
            by: 'Киару',
          ),
          const DialogueLine('Она прижала ноги поближе к себе.'),
          const DialogueLine(
            'Стало страшно.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Стыдно признавать, я ведь к этому и шла, но сражаться страшно.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Первые два раза было даже весело, а в третий, когда ты пришёл, я не знала, что делать.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Они могут отбирать оружие, они бьют в ответ.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Об этом я не читала, этого нигде не пишут!',
            by: 'Киару',
          ),
          const DialogueLine(
              'Ты успокаиваешь её, что теперь всё будет хорошо.'),
          const DialogueLine(
              'Всё-таки вы в пати, поэтому ты обещаешь, что таких ситуаций больше не повторится.'),
          const DialogueLine(
              'Хотя прекрасно знаешь, что ты не всемогущ, ты не рыцарь на коне.'),
          const DialogueLine('Ты сам слаб.'),
          const DialogueLine('Всё ещё слаб.'),
          const DialogueLine(
              'Grind gets real, ещё вчера ты пообещал себе стать сильнее.'),
          const DialogueLine(
            'Спасибо.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Правда, мне приятно, что я теперь не одна.',
            by: 'Киару',
          ),
          const DialogueLine(
            'И за сегодня мы провели достаточно времени, чтобы мне стало спокойнее рядом с тобой.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Кстати, я совсем ничего о тебе знаю.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Я очень полагаться на тебя и доверять тебе, т-ты понимаешь...',
            by: 'Киару',
          ),
          const DialogueLine(
            'Поэтому я очень хочу знать тебя, пожалуйста, расскажи о себе что-нибудь.',
            by: 'Киару',
          ),
          const DialogueLine(
              'Ты рассказываешь, что помнишь только последние 1-2 недели.'),
          const DialogueLine(
              'И путешественником ты стал изначально ради того, чтобы найти кого-нибудь, кто поможет тебе вспомнить себя.'),
          const DialogueLine('Хотя сейчас тебе уже не так и важно, кто ты.'),
          const DialogueLine(
              'Ты говоришь, что сердце ведёт тебя на верный путь.'),
          const DialogueLine(
              'Твои чувства, твоё желание изменить мир, защитить всех от ужасов, которые постоянно происходят вокруг.'),
          const DialogueLine(
              'Ты хочешь сказать, что хочешь защитить Киару, но ты ссылко тряпочное, поэтому молчишь.'),
          const DialogueLine(
            'И ты об этом раньше не сказал?',
            by: 'Киару',
          ),
          const DialogueLine(
            'Божечки-кошечки, ты всё это время искал себя.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Это такая романтичная цель быть путешественником.',
            by: 'Киару',
          ),
          const DialogueLine(
              'Ты умалчиваешь тот факт, что выбора у тебя не было.'),
          const DialogueLine(
              'Но говоришь, что в твоём телефоне была только заметка с гильдией Алоросса.'),
          const DialogueLine(
            'Звучит так... мистически.',
            by: 'Киару',
          ),
          const DialogueLine('Глаза девушки загорелись.'),
          const DialogueLine(
            'Я очень-очень-очень хочу помочь тебе вспомнить себя.',
            by: 'Киару',
          ),
          const DialogueLine(
            'У меня есть несколько вариантов: нужно обязательно зайти в школу, вдруг ты у нас учился.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Потом в церковь - там иногда на попечительство принимают оставшихся без жилья.',
            by: 'Киару',
          ),
          const DialogueLine(
            'И на шахты Алоросса, шахтёры могли видеть тебя, ты мог проходить мимо.',
            by: 'Киару',
          ),
          const DialogueLine(
            'Поэтому предлагаю завтрашний день посвятить нашим путешествиям!',
            by: 'Киару',
          ),
          const DialogueLine('Ты с радостью соглашаешься.'),
          const DialogueLine(
            'А сейчас пойдём потихоньку?',
            by: 'Киару',
          ),
          HideImageLine.asset('Kyaru.webp'),
          const DialogueLine(
              'Ты бордо встаёшь, отряхиваясь от листьев и прочей грязи.'),
          const DialogueLine('Шорох за спиной.'),
          const DialogueLine('Ещё один.'),
          const DialogueLine('Хлюпанье.'),
          const DialogueLine('Сзади.'),
          const DialogueLine('Слева.'),
          const DialogueLine('Справа.'),
          const DialogueLine('Кто посмел испорить наше свидание?'),
          const DialogueLine(
              'Ты, не оборачиваясь, одним движением достаёшь меч.'),
          const DialogueLine('Ты просишь Киару держаться рядом.'),
          const DialogueLine(
            'Нет, я с тобой.',
            by: 'Киару',
          ),
          const DialogueLine('Она встаёт рядом.'),
          const DialogueLine('Десятки глаз смотрят на вас.'),
          const DialogueLine(
              'Наконец, из кустов просачивается эта мерзкая слизь.'),
          const DialogueLine('Выползли под вечер?'),
          const DialogueLine('Ты сжимаешь рукоять покрепче.'),
          const DialogueLine(
              'Ты теперь не один и не можешь позволить себе рашить.'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine(
              'Киару стоит рядом - ты замечаешь, как шевелятся её ушки.'),
          const DialogueLine(
              'Интересное наблюдение - они реагируют на любой шорох.'),
          const DialogueLine(
              'Уши у антромопорфов заметно больше человеческих.'),
          const DialogueLine(
              'Логично предположить, что и сильно чувствительнее.'),
          const DialogueLine('Киару ориентируется на звуки.'),
          HideImageLine.asset('Kyaru.webp'),
          const DialogueLine(
              'Один из слаймов приближается на расстояние удара.'),
          const DialogueLine('Вы нападаете.'),
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
          BackgroundLine.asset('location/fields_sunset.jpg'),
          MusicLine.asset('mixkit-beautiful-dream-493.mp3'),
          const DialogueLine('Последний down (даун).'),
          const DialogueLine(
              'Ты отряхиваешь слизь с кончика твоего меча и заносишь его обратно в ножны.'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine('Ты спрашиваешь у Киару, всё ли в порядке.'),
          const DialogueLine(
            'Д-да, ты справился с ними так просто.',
            by: 'Киару',
          ),
          const DialogueLine('Мы справились.'),
          const DialogueLine(
            'Мы работали как команда, это было... так необычно.',
            by: 'Киару',
          ),
          const DialogueLine('Ты польщён это слышать, конечно.'),
          const DialogueLine(
            'И было... весело!',
            by: 'Киару',
          ),
          const DialogueLine(
              'Ты соглашаешься и предлагаешь скорее пойти в город.'),
          const DialogueLine(
            'Да, конечно.',
            by: 'Киару',
          ),
          HideImageLine.asset('Kyaru.webp'),
          BackgroundLine.asset('location/town_dawn.jpg'),
          const DialogueLine('Вечер, снова та же площадь, что и вчера.'),
          ImageLine.asset('Kyaru.webp'),
          const DialogueLine(
            'Сегодня было весело, спасибо тебе.',
            by: 'Киару',
          ),
          const DialogueLine(
              'Она улыбнулась тебе и побежала домой, иногда оглядываясь и махая рукой.'),
          const DialogueLine(
              'Сегодня день заканчивается явно приятнее, чем вчера.'),
          const DialogueLine('Поэтому никаких what a day, ты рад.'),
          const DialogueLine('Сегодня вы однозначно сблизились.'),
          const DialogueLine('И с этими мыслями ты отправился домой.'),
          HideBackgroundLine(),
        ]),
      ];
}
