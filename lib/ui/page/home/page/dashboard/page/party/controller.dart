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
import '/domain/model/flag.dart';
import '/domain/repository/character.dart';
import '/domain/repository/player.dart';
import '/domain/service/character.dart';
import '/domain/service/flag.dart';
import '/domain/service/player.dart';
import '/util/obs/obs.dart';

class PartyController extends GetxController {
  PartyController(
    this._flagService,
    this._playerService,
    this._characterService,
  );

  final FlagService _flagService;
  final PlayerService _playerService;
  final CharacterService _characterService;

  RxPlayer get player => _playerService.player;
  RxObsMap<CharacterId, RxMyCharacter> get characters =>
      _characterService.characters;
  RxObsMap<Flag, bool> get flags => _flagService.flags;

  bool contains(CharacterId id) => _characterService.contains(id);

  void addToParty(RxMyCharacter character) =>
      _playerService.addToParty(character.character.value);

  void removeFromParty(RxMyCharacter character) =>
      _playerService.removeFromParty(character.character.value);
}
