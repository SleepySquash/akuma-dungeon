import 'package:get/get.dart';

import '/domain/service/auth.dart';
import '/router.dart';

class ProfileSettingsController extends GetxController {
  ProfileSettingsController(this._authService);

  final AuthService _authService;

  void logout() {
    _authService.logout();
    router.auth();
  }
}
