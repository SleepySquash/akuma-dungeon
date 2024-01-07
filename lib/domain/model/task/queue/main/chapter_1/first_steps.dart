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
          MusicLine.asset('mixkit-summer-fun-13.mp3'),
          BackgroundLine.asset('location/town.jpg'),
          const DialogueLine(
              'Сказать, что ты представлял жизнь путешественника немного иначе, - значит ничего не сказать.'),
          const DialogueLine('По ощущениям ты пока разнорабочий, плюс-минус.'),
          const DialogueLine(
              'Так сказать, человек с неопределённой рабочей ориентацией.'),
          const DialogueLine('Ты задумываешься, что сервис так-то удобный.'),
          const DialogueLine(
              'В каждом городе есть гильдия путешественников, которая гарантирует выполнение любой услуги.'),
          const DialogueLine(
              'А ты, как работодатель, ставишь свою цену и ждёшь выполнения задания.'),
          const DialogueLine('Фриланс, не иначе.'),
          const DialogueLine(
              'Тем не менее, ты действительно ощущал, что уже внёс какой-то вклад в развитие города.'),
          const DialogueLine(
              'И денюжка в кармане имеется - мелочь, а приятно.'),
          const DialogueLine(
              'Зарабатывать деньги чудесно, но с доступом к взрослым средствам твои первые мысли - это заказать в дом несколько дакимакур и фигурок.'),
          const DialogueLine('Ох, не к добру ведь это.'),
          const DialogueLine(
              'Совесть пока не позволяет использовать предоставленную гильдией квартиру как тебе хочется.'),
          const DialogueLine(
              'С этими мыслями ты двигался в сторону библиотеки.'),
          BackgroundLine.asset('location/library.jpg'),
          const DialogueLine(
              'Как и всегда, в библиотеке тихо, спокойно и приятно пахнет книгами.'),
          const DialogueLine(
              'Ты знаешь этот запах, значит ты неоднократно бывал в библиотеках.'),
          const DialogueLine(
              'Или эти чувства уже передаются в генах по наследству?'),
          const DialogueLine('Про эволюцию всегда интересно поразмышлять.'),
          const DialogueLine(
              'Ты вспоминаешь, как видел ролик на ютубе, в котором парень создал собственной экосистему в террариуме.'),
          const DialogueLine(
              'Амнезия проходит? А, нет, ты смотрел этот ролик вчера перед сном. Видимо, ровно наоборот.'),
          const DialogueLine(
              'Ты решил зайти в библиотеку, чтобы изучить флору и фауну известного об измернии Акумы.'),
          const DialogueLine(
              'Ты проходишь в специализированный отдел и в ходе недолго поиска находишь какую-то энциклопедию.'),
          const DialogueLine(
              'Заняв недалеко столик, ты начинаешь пролистывать книгу страница за страницей.'),
          const DialogueLine('Слаймы - одна из низших форм монстров.'),
          const DialogueLine(
              'Слабыми считаются также гоблины, но они в разы опасней из-за способности использовать оружие.'),
          const DialogueLine(
              'И самое примечательное - они хитрые, боязливые и всегда ходят кучкой.'),
          const DialogueLine(
              'Орки и огры, нежить и зомби, вампиры, тёмные эльфы - картинка за картинкой мелькает перед твоими глазами.'),
          const DialogueLine(
              'Есть и милые создания, вроде определённых рас кошкодевочек, которые остались в измерении и продолжают сражаться с людьми.'),
          const DialogueLine(
              'Призраки и приведения способны вселяться в тела своих жертв.'),
          const DialogueLine('Тут даже драконы есть.'),
          const DialogueLine(
              'Но самой интересной страницей тебе кажется самая неинформативная - статья об Акуме.'),
          const DialogueLine(
              'К сожалению, кроме пары слов о том, что им считается всемогущий властитель тёмных сил, в энциклопедии больше ни слова.'),
          const DialogueLine('А какой мировой устрой в том измерении?'),
          const DialogueLine('Они построили социализм или хотя бы коммунизм?'),
          const DialogueLine('Интересно жуть, а информации ноль.'),
          const DialogueLine(
              'Возможно, дело в библиотеке - всё-таки ты в городке, где людям совсем не до тайн мироздания.'),
          const DialogueLine(
              'Так и не уталив свою любознательность, ты кладёшь книгу на полку и отправляешься в гильдию.'),
          MusicLine.asset('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine.asset('location/guild.jpg'),
          ImageLine.asset('Arda.png'),
          const DialogueLine(
            'Угу-м, благодарю, минутку...',
            by: 'Мастер',
          ),
          const DialogueLine(
              'Ты передал гильдмастеру бланк с печатью об успешно выполненном поручении.'),
          const DialogueLine(
              'Он потыкал что-то в ноутбуке, сравнил печать с чем-то на мониторе, отсканировал.'),
          const DialogueLine(
            'Да, всё замечательно! И того очередное поручение выполнено, ты молодец.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Судя по твоему взгляду, тебе не терпится заняться чем-то более полезным?',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Что-ж, такое тогда тебе задание: сходи к Майе в магазин снаряжения и возьми себе меч.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Её магазинчик недалеко от гильдии, поворот направо, два квартала впердёд и вот уже и он.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Давай, придёшь с мечом, и я дам доступ к опасным поручениям.',
            by: 'Мастер',
          ),
          HideImageLine.asset('Arda.png'),
          const DialogueLine('Ты отправился за снаряжением.'),
          MusicLine.asset('mixkit-summer-fun-13.mp3'),
          BackgroundLine.asset('location/town.jpg'),
          const DialogueLine(
              'Действительно, пройдя всего два квартала, перед тобой красовалась витрина с базовым снаряжением.'),
          const DialogueLine(
              'Бронза, железо, клинки, мечи, лук - всё так сверкало.'),
          const DialogueLine('Ты решаешься зайти внутрь.'),

          //
          BackgroundLine.asset('location/library.jpg'),
          const DialogueLine('Добро пожаловать в Шота-у-Майи!', by: 'Майя'),
          ImageLine.asset('Mai.png'),
          const DialogueLine(
              'За прилавком бодро стояла девушка, явно заинтересовавшаяся в тебе.'),
          const DialogueLine(
            'Я тебя раньше не видела, ты новенький? Ты путешественник? Или просто любишь ролевые игры?',
            by: 'Майя',
          ),
          const DialogueLine(
              'Ты объясняешь ситуацию и просишь дать какой-нибудь меч.'),
          const DialogueLine(
            'Ты бы сразу так и сказал, дорогуша.',
            by: 'Майя',
          ),
          const DialogueLine(
            'Проходи, смотри, вот что у меня пока есть.',
            by: 'Майя',
          ),
        ]),
      ];
}
