import 'package:get/get.dart';

import '/domain/model/progression.dart';
import '/domain/service/progression.dart';

class GoddessController extends GetxController {
  GoddessController(this._progressionService);

  final ProgressionService _progressionService;

  Rx<GameProgression> get progression => _progressionService.progression;

  void setGoddessTower(int to) => _progressionService.setGoddessTower(to);
}
