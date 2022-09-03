// Copyright © 2022 NIKITA ISAENKO, <https://github.com/SleepySquash>
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU Affero General Public License v3.0 as published by the
// Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License v3.0 for
// more details.
//
// You should have received a copy of the GNU Affero General Public License v3.0
// along with this program. If not, see
// <https://www.gnu.org/licenses/agpl-3.0.html>.

import 'package:get/get.dart';

import '/domain/model/progression.dart';
import '/domain/repository/player.dart';
import '/domain/service/auth.dart';
import '/domain/service/player.dart';
import '/domain/service/task.dart';
import '/router.dart';

class DashController extends GetxController {
  DashController(this._authService, this._playerService, this._taskService);

  final AuthService _authService;
  final PlayerService _playerService;
  final TaskService _taskService;

  RxPlayer get player => _playerService.player;
  Rx<GameProgression> get progression => _taskService.progression;

  void logout() {
    _authService.logout();
    router.auth();
  }

  void addLevel() => _playerService.addExperience(1000);
}