import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '/domain/model/flag.dart';
import '/domain/model/item/all.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';

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
          MusicLine.asset('mixkit-summer-fun-13.mp3'),
          BackgroundLine.asset('location/town.jpg'),
          const DialogueLine(
              'Ты просыпаешься в тех же апартаментах, что любезно предоставила тебе гильдия.'),
          const DialogueLine(
              'Как-то слишком приветливо, я бы не стал доверять так незнакомцам.'),
          const DialogueLine(
              'В таком жилье трудно думать мысли, поэтому ты наконец решаешь пройтись вокруг.'),
          const DialogueLine(
              'Ты довольно бодро записался в гильдию, так ли часто сюда приходят путешественники?'),
          const DialogueLine(
              'Гильдмастер неоднократно повторял, что рук здесь не хватает.'),
          const DialogueLine(
              'Ты знал это и раньше, Алоросс - небольшой городок на границе.'),
          const DialogueLine(
              'В городе есть школа, церковь, гильдия, несколько магазинов и ресторанов.'),
          const DialogueLine(
              'Есть всё, что нужно для комфортной современной жизни.'),
          const DialogueLine(
              'Сам город получает деньги из шахт, что расположены надалеко, плюс есть несколько полей с посевами.'),
          const DialogueLine(
              'Так-то в целом и неудивительно, что рук не хватает - монстрам есть, где покуробесить.'),
          BackgroundLine.asset('location/mediterranean_town.jpg'),
          const DialogueLine(
              'Неспешно ты вышел за пределы города, откуда ты и начал.'),
          const DialogueLine(
              'Дорога из города проходит через лес, а лес - отличная флора для укрытия монстров.'),
          const DialogueLine(
              'Монстры без проблем прыгают на любой вид транспорта.'),
          const DialogueLine(
              'Если ты в машине, то одного слайма на скорости 50 км/ч достаточно для того, чтобы у тебя больше не было лобового стекла.'),
          const DialogueLine(
              'Поэтому незакрытые данжи представляют серьёзную угрозу даже для современного мира.'),
          const DialogueLine('Не говоря уже и о более опасных формах жизни.'),
          const DialogueLine(
              'Ты понимаешь, что проблема с поиском себя займёт некоторое время, поэтому решаешь отдать себя приключениям.'),
          const DialogueLine(
              'И помощь людям, и заработок средств - вин-вин ситуэйшин.'),
          const DialogueLine('С этими мыслями ты готов начать свою карьеру.'),
          ImageLine.asset('Arda.png'),
          MusicLine.asset('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine.asset('location/guild.jpg'),
          ImageLine.asset('Arda.png'),
          const DialogueLine(
            'Ага, уже разобрался чуть-чуть со всем?',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Отлично. Тогда давай начнём твою карьеру путешественника!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Просмотри на список поручений, которые не связаны с опасностями, и подходи ко мне.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Я запишу это поручение на тебя и ты сможешь приступить к его выполнению.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Я запишу это поручение на тебя и ты сможешь приступить к его выполнению.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Для начала нужно найти тебе оружие, а то что ты как этот.',
            by: 'Мастер',
          ),
          HideImageLine.asset('Arda.png'),
          const DialogueLine(
              'Вместе с гильдмастером вы отправляетесь на улицу.'),
          BackgroundLine.asset('location/town.jpg'),
          ImageLine.asset('Arda.png'),
          const DialogueLine(
            'Познакомлю тебя с нашим местным шопкипером.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Она просто душка, но смею предупредить: выбор невелик.',
            by: 'Мастер',
          ),
          HideImageLine.asset('Arda.png'),
          BackgroundLine.asset('location/library.jpg'),
          const DialogueLine('Вы заходите в библиотеку.'),
          ImageLine.asset('Arda.png'),
          const DialogueLine(
            'Бэкграунда под магазин пока нет, поэтому мы в библиотеке!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Сделай вид, что ты в магазине по-братски, ладно?',
            by: 'Мастер',
          ),
          const DialogueLine(
              'Ты делаешь вид, что вы в магазине. Да, это работает.'),
          const DialogueLine(
              'Представь себе такой уютненький небольшой магазинчик.'),
          const DialogueLine(
            'Кхм, Майа, солнышко, нам нужно снаряжение!!',
            by: 'Мастер',
          ),
          ImageLine.asset('Mai.png'),
          const DialogueLine(
            'Никита, ты ведь знаешь, что у нас его нет!',
            by: 'Майа',
          ),
          const DialogueLine(
            'Ух ты, новое лицо! Добро пожаловать!!',
            by: 'Майа',
          ),
          const DialogueLine(
            'А ты тут надолго??',
            by: 'Майа',
          ),
          const DialogueLine(
            'Он наша новая надежда, путешественник!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Ваааай, неужели он справится с тучей данжей вокруг города??',
            by: 'Майа',
          ),
          const DialogueLine(
            'Если сможет, то это же все посылочки с алиэкспресса доедут!',
            by: 'Майа',
          ),
          const DialogueLine(
            'Мейк Алоросс грейт агейн, мой юный путешественник, мой герой!',
            by: 'Майа',
          ),
          const DialogueLine(
            'Этому герою нужно снаряжение!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Снаряжение... Ладно, сейчас что-нибудь поищу...',
            by: 'Майа',
          ),
          HideImageLine.asset('Mai.png'),
          const DialogueLine('Девушка ушла куда-то в подсобку искать оружие.'),
          const DialogueLine(
              'Воспользовавшись моментом, ты решил оглядеться вокруг.'),
          HideImageLine.asset('Arda.png'),
          const DialogueLine(
              'Прямо перед тобой висела лёгкая повседневная одежда.'),
          const DialogueLine(
              'Что-то крайне простое и скудное, от удара монстра никак не защитит.'),
          const DialogueLine(
              'Чуть дальше ты заметил хозяйственные товары: мыло, шампуни.'),
          const DialogueLine(
              'Всё как-то подозрительно дорого, но товара немного.'),
          ImageLine.asset('Arda.png'),
          const DialogueLine(
            'Что-то как-то дофига за кусок мыла, думаешь?',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Это последствия отсутствия торговцев в наших краях',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Постоянные нападения отбивают желание возить сюда товары, знаешь ли',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Только пара караванов, которая готова позволить себе путешественников выского класса, доезжает до нас',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Они нанимают B+ ранги и те справляются без проблем с живностью Алоросса',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Очень надеюсь, что ты поможешь исправить эту ситуацию.',
            by: 'Мастер',
          ),
          HideImageLine.asset('Arda.png'),
          const DialogueLine(
            'К-к сожалению, это всё, что я смогла найти...',
            by: 'Майа',
          ),
          const DialogueLine('Девушка наконец вышла из коморки.'),
          ImageLine.asset('Mai.png'),
          const DialogueLine(
            'В-вот...',
            by: 'Майа',
          ),
          HideImageLine.asset('Mai.png'),
          const DialogueLine(
              'Майа положила на стол деревянный меч для тренировок.'),
          const DialogueLine('Гнилой, зараза, с занозами.'),
          ImageLine.asset('Arda.png'),
          const DialogueLine(
            'Н-да, но это лучше, чем ничего!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'С таким мечом ты сможешь слаймов без проблем мутузить.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Кстати, вокруг города у нас их полно, данжи с ними открываются каждый день.',
            by: 'Мастер',
          ),
          const DialogueLine('Ты берёшь в руки деревянный меч.'),
          const DialogueLine('Лёгкий.'),
          const DialogueLine(
              'С таким можно будет быстро двигаться и уворачиваться от атак.'),
          const DialogueLine(
            'Спасибо большое, Майа, дорогуша!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Сегодня наступил тот день, когда ты вложилась в спасенье нашего города от монстров!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Бу-га-га-га-га!!!',
            by: 'Мастер',
          ),
          HideImageLine.asset('Arda.png'),
          const DialogueLine('Вы отправляетесь обратно в гильдию.'),
          BackgroundLine.asset('location/guild.jpg'),
          ImageLine.asset('Arda.png'),
          const DialogueLine(
            'Теперь по поводу поручений.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Каждый день гильдия вывешивает список поручений, за выполнение которых полагается награда.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Поручения могут быть двух типов: квест или данж.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Квесты - это просьбы, которые оплачивают нуждающиеся в какой-либо услуге люди.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Например, помочь торговцу пройти через наш лес, зачистить дом от слаймов и так далее.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Такие поручения дают репутацию - признательность граждан.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'С достаточным уровнем репутации ты сможешь получать скидки, жильё и даже подцепить тяночек.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'И за квесты ты получаешь больше денег, но меньше опыта и ранга.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'С другой стороны подземелья или данжи.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Их вывешивает гильдия, оплата за зачистку идёт из казны города и иногда финансируется бизнесом.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Подземелья появляются довольно часто в абсолютно случайных локациях.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Точнее, появляется портал в подземелье, гейт, врата или как хочешь можешь называть это.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Если за два дня не закрыть этот портал, то из него выйдут монстры и будут атаковать граждан.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Сила вышедших монстров зависит от ранга данжа.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Ранг данжа мы умеем определять специальными камнями: F, E, D, C, B, A, S, SS, SSS, Akuma.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Выше, чем S, определить точно невозможно - камень просто взрывается от силы подземелья.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Порталы связывают наше измерение с измерением Акумы - лорда тёмных сил, который и создаёт данжи.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Мы уверены, что существует портал напрямую к нему, но его пока никто не смог обнаружить.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Да даже если и смогли бы, то победить Акуму практически невозможно.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'К слову, именно победа над Акумой считается главной целью всех путешественников.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Считается, что если мы его победим, то все данжи пропадут и человечество будет спать спокойно.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Почему так неуверенно? Да потому что я не знаю, никто не знает.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Это предстоит выяснить тебе, путешественник!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'За закрытие порталов увеличивается контроль в городе.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Чем выше контроль, тем обильнее полки с товарами, тем больше награды за поручения и данжи.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'За определённый уровень контроля город может вознаградить тебя разными привелегиями.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'А сейчас выполни пару поручений, они несложные, твоей силы хватит.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Когда закончишь, не забудь обязательно отчитаться мне и сдать эти поручения, чтобы получить награду!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'И не забудь надеть деревянный меч!',
            by: 'Мастер',
          ),
        ]),
      ];
}
