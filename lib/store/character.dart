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
import '/domain/repository/character.dart';
import '/provider/hive/character.dart';
import '/util/obs/obs.dart';

class CharacterRepository extends DisposableInterface
    implements AbstractCharacterRepository {
  CharacterRepository(this._characterHive);

  @override
  late final RxObsMap<String, RxCharacter> characters;

  final CharacterHiveProvider _characterHive;

  StreamIterator<BoxEvent>? _localSubscription;

  @override
  void onInit() {
    characters = RxObsMap(
      Map.fromEntries(
          _characterHive.items.map((e) => MapEntry(e.character.id, e))),
    );

    _initLocalSubscription();

    super.onInit();
  }

  @override
  void onClose() {
    _localSubscription?.cancel();
    super.onClose();
  }

  @override
  void add(RxCharacter character) => _characterHive.put(character);

  @override
  void remove(String id) => _characterHive.remove(id);

  bool contains(String id) => _characterHive.contains(id);

  Future<void> _initLocalSubscription() async {
    _localSubscription = StreamIterator(_characterHive.boxEvents);
    while (await _localSubscription!.moveNext()) {
      BoxEvent e = _localSubscription!.current;
      if (e.deleted) {
        characters.remove(e.key);
      } else {
        characters[e.key] = e.value;
      }
    }
  }
}
