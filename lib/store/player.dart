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

import '/domain/model/player.dart';
import '/domain/repository/player.dart';
import '/provider/hive/player.dart';

class PlayerRepository extends DisposableInterface
    implements AbstractPlayerRepository {
  PlayerRepository(this._playerLocal, {this.initial});

  final Player? initial;

  final PlayerHiveProvider _playerLocal;

  StreamIterator? _localSubscription;

  @override
  late final Rx<Player?> player;

  @override
  void onInit() {
    Player? stored = _playerLocal.get();
    player = Rx(stored ?? initial);
    if (stored == null && initial != null) {
      _playerLocal.set(initial!);
    }

    _initLocalSubscription();

    super.onInit();
  }

  @override
  void onClose() {
    _localSubscription?.cancel();
    super.onClose();
  }

  @override
  void set(Player player) => _playerLocal.set(player);

  @override
  void addExperience(int amount) {
    Player? player = _playerLocal.get();
    if (player != null) {
      player.exp += amount;
      _playerLocal.set(player);
    }
  }

  @override
  void addMoney(int amount) {
    Player? player = _playerLocal.get();
    if (player != null) {
      player.money += amount;
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

  void _initLocalSubscription() async {
    _localSubscription = StreamIterator(_playerLocal.boxEvents);
    while (await _localSubscription!.moveNext()) {
      BoxEvent event = _localSubscription!.current;
      if (event.deleted) {
        player.value = null;
      } else {
        player.value = event.value;
        player.refresh();
      }
    }
  }
}
