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
import '/util/obs/obs.dart';

class CharacterService extends GetxService {
  CharacterService(this._characterRepository);

  final AbstractCharacterRepository _characterRepository;

  RxObsMap<CharacterId, RxMyCharacter> get characters =>
      _characterRepository.characters;

  void add(Character character) {
    if (!contains(CharacterId(character.id))) {
      _characterRepository.add(MyCharacter(character: character));
    }
  }

  void remove(CharacterId id) => _characterRepository.remove(id);
  bool contains(CharacterId id) => _characterRepository.contains(id);

  void equip(MyCharacter character, MyItem item) =>
      _characterRepository.equip(character.id, item);
  void unequip(MyCharacter character, MyItem item) =>
      _characterRepository.unequip(character.id, item);

  void addExperience(MyCharacter character, int amount) =>
      _characterRepository.addExperience(character.id, amount);
}
