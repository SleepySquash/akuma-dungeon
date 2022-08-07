import 'package:get/get.dart';

import '/domain/model/player.dart';
import '/domain/service/auth.dart';
import '/domain/service/player.dart';
import '/router.dart';

class ProfileController extends GetxController {
  ProfileController(this._authService, this._playerService);

  final AuthService _authService;
  final PlayerService _playerService;

  Rx<Player?> get player => _playerService.player;

  void logout() {
    _authService.logout();
    router.auth();
  }
}
