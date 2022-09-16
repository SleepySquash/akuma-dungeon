import 'package:novel/novel.dart';

import '/domain/model/flag.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';

class ShopUnlockedTask extends Task {
  const ShopUnlockedTask();

  @override
  String get id => 'chapter1_shop_unlocked';

  @override
  String? get subtitle => 'Монстров вокруг города стало меньше';

  @override
  List<TaskCriteria> get criteria => const [
        LevelCriteria(1),
        DungeonCommissionsCompletedCriteria(3),
      ];

  @override
  List<Reward> get rewards => const [FlagReward(Flag.storeUnlocked)];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/town.jpg'),
          DialogueLine(
              'Закрыв очередной данж с слаймами, ты возвращаешься в Алоросс.'),
          DialogueLine(
              'Погода стояла отличная, даже казалось, что с тех пор, как ты начал выполнять поручения, город стал живее.'),
          DialogueLine(
              'Обидно, что тебе дают только слаймов - город терроризируют явно более опасные формы жизни.'),
          DialogueLine(
              'Твоя текущая цель - достичь следующего ранга путешественника, тогда тебе доверят более опасные поручения.'),
          DialogueLine(
              'С этими мыслями ты двигался в сторону гильдии, но путь твой прервал знакомый голос.'),
          DialogueLine('Путешественник!', by: 'Майя'),
          CharacterLine('Mai.png'),
          DialogueLine(
            'Благодаря тому, что кто-то (естественно, ты) начал закрывать подземелья, торговцы стали активнее нас посещать!',
            by: 'Майя',
          ),
          DialogueLine(
            'Это крайне приятное событие, Алоросс встаёт с колен.',
            by: 'Майя',
          ),
          DialogueLine(
            'В связи с этим в моём магазине появляется кое-что более интересное, чем просто деревянный меч.',
            by: 'Майя',
          ),
          DialogueLine(
            'Давай пройдём внутрь, я покажу!',
            by: 'Майя',
          ),
          BackgroundLine('location/library.jpg'),
          DialogueLine(
            'Вот, смотри!',
            by: 'Майя',
          ),
          DialogueLine('Действительно, на прилавке появилось оружие и броня.'),
          DialogueLine(
              'Бронзовый меч, клинок. Лук, даже бронзовое снаряжение.'),
          DialogueLine(
            'Заходи в любой момент, тут всегда найдётся что-нибудь полезное.',
            by: 'Майя',
          ),
        ]),
      ];
}
