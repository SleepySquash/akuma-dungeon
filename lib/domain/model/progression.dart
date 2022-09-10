import 'package:akuma/domain/model/character.dart';
import 'package:akuma/domain/model/location.dart';
import 'package:akuma/domain/model_type_id.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'progression.g.dart';

@HiveType(typeId: ModelTypeId.gameProgression)
class GameProgression extends HiveObject {
  GameProgression({
    this.goddessTowerLevel = 0,
    this.storyChapter = 1,
    this.secretary,
  });

  @HiveField(0)
  int goddessTowerLevel;

  @HiveField(1)
  int storyChapter;

  @HiveField(2)
  CharacterId? secretary;
}
