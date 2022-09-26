import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '/domain/model/flag.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';

class FirstStepsTask extends Task {
  const FirstStepsTask();

  @override
  String get id => 'chapter1_first_steps';

  @override
  String get name => 'Первые шаги';

  @override
  String? get subtitle => 'Ты привыкаешь к выполнению базовых поручений';

  @override
  IconData get icon => Icons.store;

  @override
  List<TaskCriteria> get criteria => const [
        QuestCommissionsCompletedCriteria(1),
      ];

  @override
  List<Reward> get rewards => const [FlagReward(Flag.storeUnlocked)];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          const MusicLine('mixkit-summer-fun-13.mp3'),
          BackgroundLine('location/town.jpg'),
          DialogueLine(
              'Сказать, что ты представлял жизнь путешественника немного иначе, - значит ничего не сказать.'),
          DialogueLine('По ощущениям ты пока разнорабочий, плюс-минус.'),
          DialogueLine(
              'Так сказать, человек с неопределённой рабочей ориентацией.'),
          DialogueLine('Ты задумываешься, что сервис так-то удобный.'),
          DialogueLine(
              'В каждом городе есть гильдия путешественников, которая гарантирует выполнение любой услуги.'),
          DialogueLine(
              'А ты, как работодатель, ставишь свою цену и ждёшь выполнения задания.'),
          DialogueLine('Фриланс, не иначе.'),
          DialogueLine(
              'Тем не менее, ты действительно ощущал, что уже внёс какой-то вклад в развитие города.'),
          DialogueLine('И денюжка в кармане имеется - мелочь, а приятно.'),
          DialogueLine(
              'Зарабатывать деньги чудесно, но с доступом к взрослым средствам твои первые мысли - это заказать в дом несколько дакимакур и фигурок.'),
          DialogueLine('Ох, не к добру ведь это.'),
          DialogueLine(
              'Совесть пока не позволяет использовать предоставленную гильдией квартиру как тебе хочется.'),
          DialogueLine('С этими мыслями ты двигался в сторону библиотеки.'),
          BackgroundLine('location/library.jpg'),
          DialogueLine(
              'Как и всегда, в библиотеке тихо, спокойно и приятно пахнет книгами.'),
          DialogueLine(
              'Ты знаешь этот запах, значит ты неоднократно бывал в библиотеках.'),
          DialogueLine('Или эти чувства уже передаются в генах по наследству?'),
          DialogueLine('Про эволюцию всегда интересно поразмышлять.'),
          DialogueLine(
              'Ты вспоминаешь, как видел ролик на ютубе, в котором парень создал собственной экосистему в террариуме.'),
          DialogueLine(
              'Амнезия проходит? А, нет, ты смотрел этот ролик вчера перед сном. Видимо, ровно наоборот.'),
          DialogueLine(
              'Ты решил зайти в библиотеку, чтобы изучить флору и фауну известного об измернии Акумы.'),
          DialogueLine(
              'Ты проходишь в специализированный отдел и в ходе недолго поиска находишь какую-то энциклопедию.'),
          DialogueLine(
              'Заняв недалеко столик, ты начинаешь пролистывать книгу страница за страницей.'),
          DialogueLine('Слаймы - одна из низших форм монстров.'),
          DialogueLine(
              'Слабыми считаются также гоблины, но они в разы опасней из-за способности использовать оружие.'),
          DialogueLine(
              'И самое примечательное - они хитрые, боязливые и всегда ходят кучкой.'),
          DialogueLine(
              'Орки и огры, нежить и зомби, вампиры, тёмные эльфы - картинка за картинкой мелькает перед твоими глазами.'),
          DialogueLine(
              'Есть и милые создания, вроде определённых рас кошкодевочек, которые остались в измерении и продолжают сражаться с людьми.'),
          DialogueLine(
              'Призраки и приведения способны вселяться в тела своих жертв.'),
          DialogueLine('Тут даже драконы есть.'),
          DialogueLine(
              'Но самой интересной страницей тебе кажется самая неинформативная - статья об Акуме.'),
          DialogueLine(
              'К сожалению, кроме пары слов о том, что им считается всемогущий властитель тёмных сил, в энциклопедии больше ни слова.'),
          DialogueLine('А какой мировой устрой в том измерении?'),
          DialogueLine('Они построили социализм или хотя бы коммунизм?'),
          DialogueLine('Интересно жуть, а информации ноль.'),
          DialogueLine(
              'Возможно, дело в библиотеке - всё-таки ты в городке, где людям совсем не до тайн мироздания.'),
          DialogueLine(
              'Так и не уталив свою любознательность, ты кладёшь книгу на полку и отправляешься в гильдию.'),
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/guild.jpg'),
          CharacterLine('Arda.png'),
          DialogueLine(
            'Угу-м, благодарю, минутку...',
            by: 'Мастер',
          ),
          DialogueLine(
              'Ты передал гильдмастеру бланк с печатью об успешно выполненном поручении.'),
          DialogueLine(
              'Он потыкал что-то в ноутбуке, сравнил печать с чем-то на мониторе, отсканировал.'),
          DialogueLine(
            'Да, всё замечательно! И того очередное поручение выполнено, ты молодец.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Судя по твоему взгляду, тебе не терпится заняться чем-то более полезным?',
            by: 'Мастер',
          ),
          DialogueLine(
            'Что-ж, такое тогда тебе задание: сходи к Майе в магазин снаряжения и возьми себе меч.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Её магазинчик недалеко от гильдии, поворот направо, два квартала впердёд и вот уже и он.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Давай, придёшь с мечом, и я дам доступ к опасным поручениям.',
            by: 'Мастер',
          ),
          HideCharacterLine('Arda.png'),
          DialogueLine('Ты отправился за снаряжением.'),
          const MusicLine('mixkit-summer-fun-13.mp3'),
          BackgroundLine('location/town.jpg'),
          DialogueLine(
              'Действительно, пройдя всего два квартала, перед тобой красовалась витрина с базовым снаряжением.'),
          DialogueLine('Бронза, железо, клинки, мечи, лук - всё так сверкало.'),
          DialogueLine('Ты решаешься зайти внутрь.'),

          //
          BackgroundLine('location/library.jpg'),
          DialogueLine('Добро пожаловать в Шота-у-Майи!', by: 'Майя'),
          CharacterLine('Mai.png'),
          DialogueLine(
              'За прилавком бодро стояла девушка, явно заинтересовавшаяся в тебе.'),
          DialogueLine(
            'Я тебя раньше не видела, ты новенький? Ты путешественник? Или просто любишь ролевые игры?',
            by: 'Майя',
          ),
          DialogueLine(
              'Ты объясняешь ситуацию и просишь дать какой-нибудь меч.'),
          DialogueLine(
            'Ты бы сразу так и сказал, дорогуша.',
            by: 'Майя',
          ),
          DialogueLine(
            'Проходи, смотри, вот что у меня пока есть.',
            by: 'Майя',
          ),
        ]),
      ];
}
