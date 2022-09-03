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
import '/domain/model/item.dart';
import '/domain/repository/character.dart';
import '/domain/service/character.dart';

class CharacterController extends GetxController {
  CharacterController(
    this._characterService, {
    this.character,
    this.myCharacter,
  });

  final CharacterService _characterService;

  final Character? character;
  final RxMyCharacter? myCharacter;

  void equip(MyItem item) =>
      _characterService.equip(myCharacter!.character.value, item);
  void unequip(MyItem item) =>
      _characterService.unequip(myCharacter!.character.value, item);
}
