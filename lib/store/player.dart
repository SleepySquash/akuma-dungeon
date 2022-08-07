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
