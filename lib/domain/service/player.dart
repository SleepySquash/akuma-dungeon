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
import '/domain/model/player.dart';
import '/domain/repository/player.dart';

class PlayerService extends GetxService {
  PlayerService(this._playerRepository);

  final AbstractPlayerRepository _playerRepository;

  RxPlayer get player => _playerRepository.player;

  void set(Player player) => _playerRepository.set(player);

  void addExperience(int amount) => _playerRepository.addExperience(amount);

  void addRank(int amount) => _playerRepository.addRank(amount);

  void equip(MyItem item) {
    if (item is MyWeapon) {
      for (Rx<MyItem> e in List.from(player.weapons, growable: false)) {
        unequip(e.value);
      }

      _playerRepository.equip(item);
    } else if (item is MyEquipable) {
      if (item.item is Head) {
        if (player.equipped.where((e) => e.value.item is Head).isEmpty ==
            true) {
          _playerRepository.equip(item);
        }
      } else if (item.item is Armor) {
        if (player.equipped.where((e) => e.value.item is Armor).isEmpty ==
            true) {
          _playerRepository.equip(item);
        }
      } else if (item.item is Shoes) {
        if (player.equipped.where((e) => e.value.item is Shoes).isEmpty ==
            true) {
          _playerRepository.equip(item);
        }
      }
    }
  }

  void unequip(MyItem item) => _playerRepository.unequip(item);

  void addToParty(MyCharacter character) {
    if (player.party.length < 5) {
      if (player.party
              .where((e) => e.character.value.id == character.id)
              .isEmpty ==
          true) {
        _playerRepository.addToParty(character);
      }
    }
  }

  void removeFromParty(MyCharacter character) {
    _playerRepository.removeFromParty(character);
  }
}
