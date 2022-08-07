import 'package:collection/collection.dart';
import 'package:get/get.dart';

import '/domain/model/enemy.dart';
import '/domain/model/enemy/fields.dart';
import '/domain/model/player.dart';
import '/domain/service/player.dart';

class DungeonController extends GetxController {
  DungeonController(this._playerService);

  final Rx<Enemy?> enemy = Rx(null);

  final PlayerService _playerService;

  Rx<Player?> get player => _playerService.player;

  @override
  void onInit() {
    generateEnemy();
    super.onInit();
  }

  void hitEnemy() {
    if (enemy.value != null) {
      enemy.value?.hp -= 1;
      if (enemy.value!.hp <= 0) {
        _playerService.addExperience(enemy.value!.exp);
        _playerService.addMoney(enemy.value!.money);
        enemy.value = null;

        generateEnemy();
      }

      enemy.refresh();
    }
  }

  void generateEnemy() {
    enemy.value = FieldEnemies.enemies.sample(1).first;
  }
}
