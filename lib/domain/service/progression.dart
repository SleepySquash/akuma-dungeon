import 'package:get/get.dart';

import '/domain/model/character.dart';
import '/domain/model/progression.dart';
import '/domain/repository/character.dart';
import '/domain/repository/progression.dart';

class ProgressionService extends DisposableInterface {
  ProgressionService(this._progressRepository);

  final AbstractProgressionRepository _progressRepository;

  Rx<GameProgression> get progression => _progressRepository.progression;
  Rx<RxMyCharacter?> get secretary => _progressRepository.secretary;

  void setGoddessTower(int to) => _progressRepository.setGoddessTower(to);
  void setChapter(int to) => _progressRepository.setChapter(to);
  void setSecretary(MyCharacter? character) =>
      _progressRepository.setSecretary(character?.id);
  void addDungeonsCleared() => _progressRepository
      .setDungeonsCleared(progression.value.dungeonsCleared + 1);
  void addQuestsDone() =>
      _progressRepository.setQuestsDone(progression.value.questsDone + 1);
}
