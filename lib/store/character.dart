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

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/domain/model/character.dart';
import '/domain/model/item.dart';
import '/domain/repository/character.dart';
import '/provider/hive/character.dart';
import '/store/item.dart';
import '/util/obs/obs.dart';

class CharacterRepository extends DisposableInterface
    implements AbstractCharacterRepository {
  CharacterRepository(this._characterHive, this._itemRepository);

  @override
  late final RxObsMap<CharacterId, HiveRxMyCharacter> characters;

  final CharacterHiveProvider _characterHive;

  final ItemRepository _itemRepository;

  StreamIterator<BoxEvent>? _localSubscription;
  StreamSubscription? _itemsSubscription;

  @override
  void onInit() {
    characters = RxObsMap(
      Map.fromEntries(
        _characterHive.items.map(
          (e) {
            List<Rx<MyItem>> artifacts = [];
            for (ItemId a in e.artifacts) {
              Rx<MyItem>? item = _itemRepository.items[a];
              if (item?.value is MyArtifact) {
                artifacts.add(item!);
              }
            }

            List<Rx<MyItem>> weapons = [];
            for (ItemId w in e.weapons) {
              Rx<MyItem>? item = _itemRepository.items[w];
              if (item?.value is MyWeapon) {
                weapons.add(item!);
              }
            }

            return MapEntry(
              e.id,
              HiveRxMyCharacter(
                e,
                weapons: weapons,
                artifacts: artifacts,
              ),
            );
          },
        ),
      ),
    );

    _itemsSubscription = _itemRepository.items.changes.listen((e) {
      switch (e.op) {
        case OperationKind.removed:
          ItemId? id = e.value?.value.id;

          if (e.value?.value is MyWeapon) {
            for (var c in characters.values) {
              if (c.character.value.weapons.contains(id)) {
                c.character.value.weapons.remove(id);
                c.weapons.removeWhere((i) => i.value.id == id);
              }
            }
          }

          if (e.value?.value is MyArtifact) {
            for (var c in characters.values) {
              if (c.character.value.artifacts.contains(id)) {
                c.character.value.artifacts.remove(id);
                c.artifacts.removeWhere((i) => i.value.id == id);
              }
            }
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
    super.onClose();
  }

  @override
  void add(MyCharacter character) => _characterHive.put(character);

  @override
  void remove(CharacterId id) => _characterHive.remove(id);

  @override
  bool contains(CharacterId id) => _characterHive.contains(id);

  @override
  void equip(CharacterId id, MyItem item) {
    MyCharacter? stored = _characterHive.get(id);
    RxMyCharacter? character = characters[id];
    if (character != null && stored != null) {
      if (item is MyWeapon) {
        Rx<MyItem>? reactive = _itemRepository.items[item.id];
        if (reactive?.value is MyWeapon) {
          character.weapons.add(reactive!);
          stored.weapons.add(item.id);
          _characterHive.put(stored);
        }
      } else if (item is MyArtifact) {
        Rx<MyItem>? reactive = _itemRepository.items[item.id];
        if (reactive?.value is MyArtifact) {
          character.artifacts.add(reactive!);
          stored.artifacts.add(item.id);
          _characterHive.put(stored);
        }
      }
    }
  }

  @override
  void unequip(CharacterId id, MyItem item) {
    MyCharacter? stored = _characterHive.get(id);
    RxMyCharacter? character = characters[id];
    if (character != null && stored != null) {
      if (item is MyWeapon) {
        stored.weapons.removeWhere((e) => e == item.id);
        character.weapons.removeWhere((e) => e.value.id == item.id);
      } else if (item is MyArtifact) {
        stored.artifacts.removeWhere((e) => e == item.id);
        character.artifacts.removeWhere((e) => e.value.id == item.id);
      }
      _characterHive.put(stored);
    }
  }

  @override
  void addExperience(CharacterId id, int amount) {
    final MyCharacter? stored = _characterHive.get(id);
    if (stored != null) {
      stored.exp += amount;
      _characterHive.put(stored);
    }
  }

  Future<void> _initLocalSubscription() async {
    _localSubscription = StreamIterator(_characterHive.boxEvents);
    while (await _localSubscription!.moveNext()) {
      BoxEvent e = _localSubscription!.current;
      if (e.deleted) {
        characters.remove(CharacterId(e.key));
      } else {
        final HiveRxMyCharacter? character = characters[CharacterId(e.key)];
        if (character == null) {
          characters[CharacterId(e.key)] = HiveRxMyCharacter(e.value);
        } else {
          character.character.value = e.value;
          character.character.refresh();
        }
      }
    }
  }
}

class HiveRxMyCharacter implements RxMyCharacter {
  HiveRxMyCharacter(
    MyCharacter character, {
    List<Rx<MyItem>> artifacts = const [],
    List<Rx<MyItem>> weapons = const [],
  })  : character = Rx(character),
        artifacts = RxList(artifacts),
        weapons = RxList(weapons);

  @override
  final Rx<MyCharacter> character;

  @override
  final RxList<Rx<MyItem>> artifacts;

  @override
  final RxList<Rx<MyItem>> weapons;
}
