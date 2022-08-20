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

import 'package:collection/collection.dart';
import 'package:get/get.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/enemy.dart';
import '/domain/model/player.dart';
import '/domain/service/player.dart';
import '/router.dart';
import '/ui/widget/modal_popup.dart';
import 'component/result.dart';

class DungeonController extends GetxController {
  DungeonController(
    this._playerService, {
    required this.settings,
    this.onClear,
  });

  /// [DungeonSettings] controlling this [DungeonController].
  final DungeonSettings settings;

  final void Function()? onClear;

  /// Indicator whether the game has ended.
  final RxBool gameEnded = RxBool(false);

  /// Current [DungeonStage] from the [DungeonSettings.stages].
  final Rx<DungeonStage?> stage = Rx(null);

  /// Current [Enemy] to slay.
  final Rx<MyEnemy?> enemy = Rx(null);

  /// Count of the slayed [Enemy]ies throughout the current [stage].
  final RxInt slayedEnemies = RxInt(0);

  /// [Duration] of the current [stage].
  final Rx<Duration> duration = Rx(Duration.zero);

  late final RxDouble hp;
  late final RxDouble mp;

  /// [PlayerService] maintaining the [Player].
  final PlayerService _playerService;

  /// [DateTime] when the current [stage] has started.
  DateTime? _stageStartedAt;

  /// [Timer]s being active in the current [stage] for checking on some
  /// condition, for example.
  final List<Timer> _conditions = [];

  Timer? _enemyTimer;

  /// [Timer] updating every second (fixed interval of time).
  Timer? _fixedTimer;

  /// Currently authenticated [Player].
  Rx<Player?> get player => _playerService.player;

  @override
  void onInit() {
    hp = RxDouble(player.value?.hp.toDouble() ?? 10);
    mp = RxDouble(player.value?.mp.toDouble() ?? 10);

    _nextStage();
    _nextEnemy();

    _fixedTimer = Timer.periodic(1.seconds, (t) {
      if (_stageStartedAt != null) {
        duration.value = _stageStartedAt!.difference(DateTime.now());
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    _fixedTimer?.cancel();
    _enemyTimer?.cancel();
    for (Timer e in _conditions) {
      e.cancel();
    }

    super.onClose();
  }

  void hitEnemy() {
    if (!gameEnded.value) {
      if (enemy.value != null) {
        enemy.value?.hit();
        if (enemy.value!.isDead) {
          _slayEnemy();
        }
      }
    }
  }

  void _hitPlayer(double amount) {
    if (!gameEnded.value) {
      hp.value -= amount;
      if (hp.value <= 0) {
        hp.value = 0;
        _loseGame();
      }
    }
  }

  void _nextEnemy() {
    Enemy? next = stage.value?.enemies.sample(1).first;
    enemy.value = next == null ? null : MyEnemy(next);

    if (next != null) {
      _enemyTimer?.cancel();
      _enemyTimer = Timer.periodic(next.interval, (t) {
        if (!gameEnded.value) {
          _hitPlayer(next.damage);
        }
      });
    }
  }

  void _slayEnemy() {
    _enemyTimer?.cancel();
    _enemyTimer = null;

    _playerService.addExperience(enemy.value!.enemy.exp);
    _playerService.addMoney(enemy.value!.enemy.money);
    enemy.value = null;
    ++slayedEnemies.value;

    if (_checkIfConditionsAreMet()) {
      _nextStage();
    }

    if (!gameEnded.value) {
      _nextEnemy();
    }
  }

  void _nextStage() {
    for (Timer e in _conditions) {
      e.cancel();
    }
    _conditions.clear();

    int index =
        (stage.value == null ? -1 : settings.stages.indexOf(stage.value!)) + 1;

    if (index >= settings.stages.length) {
      _winGame();
    } else {
      stage.value = settings.stages[index];
      slayedEnemies.value = 0;
      _stageStartedAt = DateTime.now();

      for (var condition in stage.value?.conditions ?? []) {
        if (condition is TimerStageCondition) {
          _conditions.add(Timer(condition.duration, _loseGame));
        }
      }
    }
  }

  bool _checkIfConditionsAreMet() {
    bool met = stage.value?.conditions.isEmpty == false;

    for (var condition in stage.value?.conditions ?? []) {
      if (condition is SlayedStageCondition) {
        met = met && slayedEnemies.value >= condition.amount;
      } else if (condition is TimerStageCondition) {
        met = met &&
            _stageStartedAt!.difference(DateTime.now()) < condition.duration;
      }
    }

    return met;
  }

  Future<void> _winGame() async {
    if (!gameEnded.value) {
      gameEnded.value = true;
      await ModalPopup.show(
        context: router.context!,
        isDismissible: false,
        child: const ResultModal(true),
      );

      onClear?.call();
    }
  }

  void _loseGame() {
    if (!gameEnded.value) {
      gameEnded.value = true;
      ModalPopup.show(
        context: router.context!,
        isDismissible: false,
        child: const ResultModal(false),
      );
    }
  }
}
