import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/enemy/slime.dart';
import '/domain/model/flag.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';

class SweetDreamsTask extends Task {
  const SweetDreamsTask();

  @override
  String get id => 'chapter1_sweet_dreams';

  @override
  List<TaskCriteria> get criteria =>
      const [DungeonCommissionsCompletedCriteria(3)];

  @override
  String get name => 'Sweet Dreams';

  @override
  String? get subtitle => 'У гильдии есть необычная для тебя просьба';

  @override
  IconData get icon => Icons.church;

  @override
  List<Reward> get rewards => const [
        ExpReward(200),
        RankReward(5),
        FlagReward(Flag.partyUnlocked),
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
        ]),
      ];
}
