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

import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '/domain/model/character.dart';
import '/domain/model/item.dart';
import '/domain/model/player.dart';
import '/domain/repository/character.dart';
import '/domain/repository/player.dart';
import '/provider/hive/player.dart';
import '/store/character.dart';
import '/store/item.dart';
import '/util/obs/obs.dart';

class PlayerRepository extends DisposableInterface
    implements AbstractPlayerRepository {
  PlayerRepository(
    this._playerLocal,
    this._itemRepository,
    this._characterRepository, {
    this.initial,
  });

  final Player? initial;

  final PlayerHiveProvider _playerLocal;

  final ItemRepository _itemRepository;
  final CharacterRepository _characterRepository;

  StreamIterator? _localSubscription;
  StreamSubscription? _itemsSubscription;
  StreamSubscription? _charactersSubscription;

  @override
  late final HiveRxPlayer player;

  @override
  void onInit() {
    Player? stored = _playerLocal.get();

    List<RxMyCharacter> party = [];
    List<Rx<MyItem>> equipped = [];
    List<Rx<MyItem>> weapons = [];

    if (stored != null) {
      for (CharacterId a in stored.party) {
        RxMyCharacter? character = _characterRepository.characters[a];
        if (character != null) {
          party.add(character);
        }
      }

      for (ItemId w in stored.equipped) {
        Rx<MyItem>? item = _itemRepository.items[w];
        if (item?.value is MyEquipable) {
          equipped.add(item!);
        }
      }

      for (ItemId w in stored.weapons) {
        Rx<MyItem>? item = _itemRepository.items[w];
        if (item?.value is MyWeapon) {
          weapons.add(item!);
        }
      }
    }

    player = HiveRxPlayer(
      Rx(stored ?? initial ?? Player()),
      equipped: equipped,
      weapons: weapons,
      party: party,
    );

    if (stored == null && initial != null) {
      _playerLocal.set(initial!);
    }

    _itemsSubscription = _itemRepository.items.changes.listen((e) {
      switch (e.op) {
        case OperationKind.removed:
          ItemId? id = e.value?.value.id;

          if (e.value?.value is MyEquipable) {
            if (player.player.value.equipped.contains(id)) {
              player.player.value.equipped.remove(id);
              player.equipped.removeWhere((i) => i.value.id == id);
            }
          }

          if (e.value?.value is MyWeapon) {
            if (player.player.value.weapons.contains(id)) {
              player.player.value.weapons.remove(id);
              player.weapons.removeWhere((i) => i.value.id == id);
            }
          }
          break;

        case OperationKind.added:
        case OperationKind.updated:
          // No-op.
          break;
      }
    });

    _charactersSubscription =
        _characterRepository.characters.changes.listen((e) {
      switch (e.op) {
        case OperationKind.removed:
          CharacterId? id = e.value?.character.value.id;
          if (player.player.value.party.contains(id)) {
            player.player.value.party.remove(id);
            player.equipped.removeWhere((i) => i.value.id == id);
          }

          break;

        case OperationKind.added:
        case OperationKind.updated:
          // No-op.
          break;
      }
    });

    _initLocalSubscription();

    super.onInit();
  }

  @override
  void onClose() {
    _localSubscription?.cancel();
    _itemsSubscription?.cancel();
    _charactersSubscription?.cancel();
    super.onClose();
  }

  @override
  void set(Player player) => _playerLocal.set(player);

  @override
  void addExperience(int amount) {
    Player? player = _playerLocal.get();
    if (player != null) {
      player.exp += amount;
      player.exp = min(player.exp, Player.maxLevel * 1000 - 1);
      _playerLocal.set(player);
    }
  }

  @override
  void addRank(int amount) {
    Player? player = _playerLocal.get();
    if (player != null) {
      player.rank += amount;
      _playerLocal.set(player);
    }
  }

  @override
  void equip(MyItem item) {
    Player? stored = _playerLocal.get();
    if (stored != null) {
      if (item is MyWeapon) {
        Rx<MyItem>? reactive = _itemRepository.items[item.id];
        if (reactive?.value is MyWeapon) {
          player.weapons.add(reactive!);
          stored.weapons.add(item.id);
          _playerLocal.set(stored);
        }
      } else if (item is MyEquipable) {
        Rx<MyItem>? reactive = _itemRepository.items[item.id];
        if (reactive?.value is MyEquipable) {
          player.equipped.add(reactive!);
          stored.equipped.add(item.id);
          _playerLocal.set(stored);
        }
      }
    }
  }

  @override
  void unequip(MyItem item) {
    Player? stored = _playerLocal.get();
    if (stored != null) {
      if (item is MyWeapon) {
        stored.weapons.removeWhere((e) => e == item.id);
        player.weapons.removeWhere((e) => e.value.id == item.id);
      } else if (item is MyEquipable) {
        stored.equipped.removeWhere((e) => e == item.id);
        player.equipped.removeWhere((e) => e.value.id == item.id);
      }
      _playerLocal.set(stored);
    }
  }

  @override
  void addToParty(MyCharacter character) {
    Player? stored = _playerLocal.get();
    if (stored != null) {
      RxMyCharacter? reactive = _characterRepository.characters[character.id];
      if (reactive != null) {
        stored.party.add(reactive.character.value.id);
        player.party.add(reactive);
      }
      _playerLocal.set(stored);
    }
  }

  @override
  void removeFromParty(MyCharacter character) {
    Player? stored = _playerLocal.get();
    if (stored != null) {
      stored.party.removeWhere((e) => e == character.id);
      player.party.removeWhere((e) => e.character.value.id == character.id);
      _playerLocal.set(stored);
    }
  }

  void _initLocalSubscription() async {
    _localSubscription = StreamIterator(_playerLocal.boxEvents);
    while (await _localSubscription!.moveNext()) {
      BoxEvent e = _localSubscription!.current;
      if (e.deleted) {
        throw Exception('Uh-oh, `Player` is deleted, shit is real.');
      } else {
        player.player.value = e.value;
        player.player.refresh();
      }
    }
  }
}

class HiveRxPlayer extends RxPlayer {
  HiveRxPlayer(
    this.player, {
    List<RxMyCharacter> party = const [],
    List<Rx<MyItem>> weapons = const [],
    List<Rx<MyItem>> equipped = const [],
  })  : party = RxList(party),
        weapons = RxList(weapons),
        equipped = RxList(equipped);

  @override
  final Rx<Player> player;

  @override
  final RxList<RxMyCharacter> party;

  @override
  final RxList<Rx<MyItem>> weapons;

  @override
  final RxList<Rx<MyItem>> equipped;
}
