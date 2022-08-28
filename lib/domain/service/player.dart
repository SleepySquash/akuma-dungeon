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

import 'package:akuma/domain/model/character.dart';
import 'package:akuma/domain/model/item.dart';
import 'package:get/get.dart';

import '/domain/model/player.dart';
import '/domain/repository/player.dart';

class PlayerService extends GetxService {
  PlayerService(this._playerRepository);

  final AbstractPlayerRepository _playerRepository;

  Rx<Player?> get player => _playerRepository.player;

  void set(Player player) => _playerRepository.set(player);

  void addExperience(int amount) => _playerRepository.addExperience(amount);

  void addRank(int amount) => _playerRepository.addRank(amount);

  void equip(MyItem item) {
    if (item is MyWeapon) {
      if (player.value?.weapon.isEmpty == false) {
        for (var e in List.from(player.value!.weapon, growable: false)) {
          unequip(e);
        }
      }

      if (player.value?.weapon.isEmpty == true) {
        _playerRepository.equip(item);
      }
    } else if (item is MyEquipable) {
      if (item.item is Head) {
        if (player.value?.equipped.where((e) => e.item is Head).isEmpty ==
            true) {
          _playerRepository.equip(item);
        }
      } else if (item.item is Armor) {
        if (player.value?.equipped.where((e) => e.item is Armor).isEmpty ==
            true) {
          _playerRepository.equip(item);
        }
      } else if (item.item is Shoes) {
        if (player.value?.equipped.where((e) => e.item is Shoes).isEmpty ==
            true) {
          _playerRepository.equip(item);
        }
      }
    }
  }

  void unequip(MyItem item) {
    _playerRepository.unequip(item);
  }

  void addToParty(MyCharacter character) {
    if ((player.value?.party.length ?? 5) < 5) {
      if (player.value?.party
              .where((e) => e.character.id == character.character.id)
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
