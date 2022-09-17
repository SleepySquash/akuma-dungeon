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

import 'package:decimal/decimal.dart';
import 'package:get/get.dart';

import '/domain/model/flag.dart';
import '/domain/model/location.dart';
import '/domain/model/progression.dart';
import '/domain/repository/character.dart';
import '/domain/repository/player.dart';
import '/domain/service/auth.dart';
import '/domain/service/flag.dart';
import '/domain/service/location.dart';
import '/domain/service/player.dart';
import '/domain/service/progression.dart';
import '/router.dart';
import '/util/obs/obs.dart';

class DashController extends GetxController {
  DashController(
    this._flagService,
    this._authService,
    this._playerService,
    this._progressionService,
    this._locationService,
  );

  final FlagService _flagService;
  final AuthService _authService;
  final PlayerService _playerService;
  final ProgressionService _progressionService;
  final LocationService _locationService;

  RxPlayer get player => _playerService.player;
  Rx<GameProgression> get progression => _progressionService.progression;
  Rx<RxMyCharacter?> get secretary => _progressionService.secretary;
  Rx<MyLocation> get location => _locationService.location;
  RxObsMap<Flag, bool> get flags => _flagService.flags;

  void logout() {
    _authService.logout();
    router.auth();
  }

  void addLevel() => _playerService.addExperience(Decimal.fromInt(1000));
}
