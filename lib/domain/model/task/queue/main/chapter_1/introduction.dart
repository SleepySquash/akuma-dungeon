import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '/domain/model/flag.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';

class IntroductionTask extends Task {
  const IntroductionTask();

  @override
  String get id => 'chapter1_introduction';

  @override
  String get name => 'Знакомство';

  @override
  String? get subtitle => 'Гильдмастер просил подойти...';

  @override
  IconData get icon => Icons.interests;

  @override
  List<Reward> get rewards => const [
        ExpReward(50),
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
            'Каждый день гильдия вывешивает список поручений, за выполнение которых полагается награда.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Поручения бывают двух типов: квесты и данжи.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Квесты - это просьбы, которые заказчики оплачивают самостоятельно.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Например, помочь торговцу пройти через наш лес, зачистить дом от слаймов и так далее.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Гильдия гарантирует, что поручение будет выполнено или возврат средств, если что не так, - выступает посредником, другими словами.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Такие поручения кроме того, что хорошо оплачиваются, дают репутацию - признательность граждан.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'С достаточным уровнем репутации ты сможешь получать скидки, жильё и даже подцепить тяночек.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'С другой стороны данжи.',
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
            'Точнее, появляется портал в данж, гейт, врата или как хочешь можешь называть это.',
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
            'Порталы связывают наше измерение с измерением Акумы - лорда тёмных сил, который и создаёт данжи.',
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
            'Просмотри на список поручений, которые не связаны с опасностями, и подходи ко мне.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Я запишу это поручение на тебя и ты сможешь приступить к его выполнению.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Когда закончишь, не забудь отчитаться и сдать эти поручения, чтобы получить награду!',
            by: 'Мастер',
          ),
        ]),
      ];
}
