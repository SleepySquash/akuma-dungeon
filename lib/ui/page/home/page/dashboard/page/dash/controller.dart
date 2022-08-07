import 'package:get/get.dart';

import '/domain/model/player.dart';
import '/domain/service/player.dart';

class DashController extends GetxController {
  DashController(this._playerService);

  final PlayerService _playerService;

  Rx<Player?> get player => _playerService.player;
}
