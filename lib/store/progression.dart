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
import 'package:hive/hive.dart';

import '/domain/model/character.dart';
import '/domain/model/progression.dart';
import '/domain/repository/character.dart';
import '/domain/repository/progression.dart';
import '/provider/hive/location.dart';
import '/provider/hive/progression.dart';
import '/store/character.dart';
import '/util/log.dart';
import '/util/obs/obs.dart';

class ProgressionRepository extends DisposableInterface
    implements AbstractProgressionRepository {
  ProgressionRepository(
    this._progressHive,
    this._locationHive,
    this._characterRepository,
  );

  final ProgressionHiveProvider _progressHive;

  // ignore: unused_field
  final LocationHiveProvider _locationHive;

  final CharacterRepository _characterRepository;

  StreamIterator? _localSubscription;
  StreamSubscription? _charactersSubscription;

  @override
  late final Rx<GameProgression> progression;

  @override
  late final Rx<RxMyCharacter?> secretary;

  @override
  void onInit() {
    GameProgression? stored = _progressHive.get();

    if (stored?.secretary != null) {
      RxMyCharacter? character =
          _characterRepository.characters[stored!.secretary];
      if (character != null) {
        secretary = Rx(character);
      } else {
        Log.print(
          '[$runtimeType] Cannot find owned `MyCharacter` with id: ${stored.secretary}',
        );
        secretary = Rx(null);
      }
    } else {
      secretary = Rx(null);
    }

    progression = Rx(stored ?? GameProgression());

    _charactersSubscription =
        _characterRepository.characters.changes.listen((e) {
      switch (e.op) {
        case OperationKind.removed:
          CharacterId? id = e.value?.character.value.id;
          if (progression.value.secretary == id) {
            secretary.value = null;
            progression.value.secretary = null;
            _progressHive.set(progression.value);
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
    _charactersSubscription?.cancel();
    super.onClose();
  }

  @override
  void setGoddessTower(int to) {
    GameProgression stored = _progressHive.get() ?? progression.value;
    stored.goddessTowerLevel = to;
    _progressHive.set(stored);
  }

  @override
  void setChapter(int to) {
    GameProgression stored = _progressHive.get() ?? progression.value;
    stored.storyChapter = to;
    _progressHive.set(stored);
  }

  @override
  void setSecretary(CharacterId? characterId) {
    GameProgression stored = _progressHive.get() ?? progression.value;

    if (characterId == null) {
      stored.secretary = null;
      secretary.value = null;
      _progressHive.set(stored);
    } else {
      RxMyCharacter? character = _characterRepository.characters[characterId];
      if (character != null) {
        stored.secretary = characterId;
        secretary.value = character;
        _progressHive.set(stored);
      }
    }
  }

  @override
  void setDungeonsCleared(int to) {
    GameProgression stored = _progressHive.get() ?? progression.value;
    stored.dungeonsCleared = to;
    _progressHive.set(stored);
  }

  @override
  void setQuestsDone(int to) {
    GameProgression stored = _progressHive.get() ?? progression.value;
    stored.questsDone = to;
    _progressHive.set(stored);
  }

  void _initLocalSubscription() async {
    _localSubscription = StreamIterator(_progressHive.boxEvents);
    while (await _localSubscription!.moveNext()) {
      BoxEvent e = _localSubscription!.current;
      if (e.deleted) {
        // No-op.
      } else {
        progression.value = e.value;
        progression.refresh();
      }
    }
  }
}
