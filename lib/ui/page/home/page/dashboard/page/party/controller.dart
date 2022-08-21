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

import '/domain/model/character.dart';
import '/domain/model/player.dart';
import '/domain/service/character.dart';
import '/domain/service/player.dart';
import '/util/obs/obs.dart';

class PartyController extends GetxController {
  PartyController(this._playerService, this._characterService);

  final PlayerService _playerService;
  final CharacterService _characterService;

  Rx<Player?> get player => _playerService.player;
  RxObsMap<String, MyCharacter> get characters => _characterService.characters;

  bool contains(String id) => _characterService.contains(id);

  void addToParty(MyCharacter character) =>
      _playerService.addToParty(character);

  void removeFromParty(MyCharacter character) =>
      _playerService.removeFromParty(character);
}
