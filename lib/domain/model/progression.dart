import 'package:akuma/domain/model/character.dart';
import 'package:akuma/domain/model_type_id.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'progression.g.dart';

@HiveType(typeId: ModelTypeId.gameProgression)
class GameProgression extends HiveObject {
  GameProgression({
    this.goddessTowerLevel = 0,
    this.storyChapter = 1,
    this.secretary,
    this.questsDone = 0,
    this.dungeonsCleared = 0,
  });

  @HiveField(0)
  int goddessTowerLevel;

  @HiveField(1)
  int storyChapter;

  @HiveField(2)
  CharacterId? secretary;

  @HiveField(3)
  int questsDone;

  @HiveField(4)
  int dungeonsCleared;
}
