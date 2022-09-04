import 'package:get/get.dart';

import '/domain/model/character.dart';
import '/domain/model/location.dart';
import '/domain/model/progression.dart';
import '/domain/repository/character.dart';
import '/domain/repository/progression.dart';

class ProgressionService extends DisposableInterface {
  ProgressionService(this._progressRepository);

  final AbstractProgressionRepository _progressRepository;

  Rx<GameProgression> get progression => _progressRepository.progression;
  Rx<RxMyCharacter?> get secretary => _progressRepository.secretary;
  Rx<MyLocation> get location => _progressRepository.location;

  void setGoddessTower(int to) => _progressRepository.setGoddessTower(to);
  void setChapter(int to) => _progressRepository.setChapter(to);
  void setSecretary(MyCharacter? character) =>
      _progressRepository.setSecretary(character?.id);

  void setLocation(Location location) =>
      _progressRepository.setLocation(LocationId(location.id));
  void setLocationControl(Location location, int to) =>
      _progressRepository.setLocationControl(LocationId(location.id), to);
  void setLocationReputation(Location location, int to) =>
      _progressRepository.setLocationReputation(LocationId(location.id), to);
}
