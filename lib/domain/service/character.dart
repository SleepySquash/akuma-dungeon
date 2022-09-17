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

import '/domain/model/character.dart';
import '/domain/model/item.dart';
import '/domain/repository/character.dart';
import '/util/obs/obs.dart';

class CharacterService extends DisposableInterface {
  CharacterService(this._characterRepository);

  final AbstractCharacterRepository _characterRepository;

  RxObsMap<CharacterId, RxMyCharacter> get characters =>
      _characterRepository.characters;

  MyCharacter add(Character character) {
    CharacterId id = CharacterId(character.id);
    if (!contains(id)) {
      MyCharacter myCharacter = MyCharacter(character: character);
      _characterRepository.add(myCharacter);
      return myCharacter;
    }

    return characters[id]!.character.value;
  }

  void remove(CharacterId id) => _characterRepository.remove(id);
  bool contains(CharacterId id) => _characterRepository.contains(id);

  void equip(MyCharacter character, MyItem item) {
    RxMyCharacter? myCharacter = characters[character.id];

    if (myCharacter != null) {
      if (item is MyWeapon) {
        for (Rx<MyItem> e in List.from(myCharacter.weapons, growable: false)) {
          unequip(character, e.value);
        }
        _characterRepository.equip(character.id, item);
      } else if (item is MyArtifact) {
        if (myCharacter.artifacts.length < 5) {
          _characterRepository.equip(character.id, item);
        }
      }
    }
  }

  void reequip(MyCharacter character, MyItem current, MyItem to) {
    unequip(character, current);
    equip(character, current);
  }

  void unequip(MyCharacter character, MyItem item) =>
      _characterRepository.unequip(character.id, item);

  void addExperience(MyCharacter character, Decimal amount) =>
      _characterRepository.addExperience(character.id, amount);
}
