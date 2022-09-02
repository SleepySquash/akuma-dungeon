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

import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart' show OverlayEntry;
import 'package:get/get.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/enemy.dart';
import '/domain/model/item/standard.dart';
import '/domain/model/player.dart';
import '/domain/model/task.dart';
import '/domain/service/item.dart';
import '/domain/service/player.dart';
import '/router.dart';
import '/ui/widget/modal_popup.dart';
import '/ui/worker/music.dart';
import 'component/result.dart';

class DungeonController extends GetxController {
  DungeonController(
    this._playerService,
    this._itemService,
    this._musicWorker, {
    required this.settings,
    this.onClear,
    this.onHitTaken,
  });

  /// [DungeonSettings] controlling this [DungeonController].
  final DungeonSettings settings;

  final FutureOr<void> Function()? onClear;
  final void Function(HitResult, List<OverlayEntry>)? onHitTaken;

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

  final List<OverlayEntry> entries = [];

  late final RxDouble hp;
  late final RxDouble mp;

  /// [PlayerService] maintaining the [Player].
  final PlayerService _playerService;

  final ItemService _itemService;

  final MusicWorker _musicWorker;

  /// [DateTime] when the current [stage] has started.
  DateTime? _stageStartedAt;

  /// [Timer]s being active in the current [stage] for checking on some
  /// condition, for example.
  final List<Timer> _conditions = [];

  Timer? _enemyTimer;

  /// [Timer] updating every second (fixed interval of time).
  Timer? _fixedTimer;

  Source? _musicSource;

  /// Currently authenticated [Player].
  Rx<Player?> get player => _playerService.player;

  @override
  void onInit() {
    hp = RxDouble(player.value?.health.toDouble() ?? 10);
    mp = RxDouble(10);

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
    gameEnded.value = true;
    _fixedTimer?.cancel();
    _enemyTimer?.cancel();
    for (Timer e in _conditions) {
      e.cancel();
    }

    for (var e in entries) {
      if (e.mounted) {
        e.remove();
      }
    }

    _musicWorker.stop(_musicSource);

    super.onClose();
  }

  HitResult? hitEnemy() {
    if (!gameEnded.value) {
      if (enemy.value != null) {
        int damage = player.value?.damage ?? 0;
        bool isCrit = false;
        bool isSlayed = false;

        int chance = Random().nextInt(100);
        if (chance < (player.value?.critRate ?? 0)) {
          damage = damage + damage * (player.value?.critRate ?? 0) ~/ 100;
          isCrit = true;
        }

        Source? hit = enemy.value?.enemy.hitSounds?.sample(1).firstOrNull;
        if (hit != null) {
          _musicWorker.once(hit);
        }

        enemy.value?.hit(damage);
        if (enemy.value!.isDead) {
          isSlayed = true;
          _slayEnemy();
        }

        return HitResult(
          damage: damage,
          isCrit: isCrit,
          isSlayed: isSlayed,
        );
      }
    }

    return null;
  }

  void _hitPlayer(double amount) {
    if (!gameEnded.value) {
      final int defense = max(player.value?.defense ?? 0, 1);
      final double damage = max(amount - (defense / 9), 0);

      hp.value -= damage;

      if (hp.value <= 0) {
        hp.value = 0;
        _loseGame();
      }

      onHitTaken?.call(HitResult(damage: damage.toInt()), entries);
    }
  }

  void _nextEnemy() {
    Enemy? sample = stage.value?.enemies.sample(1).first;
    MyEnemy? next = sample == null
        ? null
        : MyEnemy(
            sample,
            multiplier: stage.value?.multiplier ?? 1,
          );

    enemy.value = next;

    if (next != null) {
      _enemyTimer?.cancel();
      _enemyTimer = Timer.periodic(next.enemy.interval, (t) {
        if (!gameEnded.value) {
          _hitPlayer(next.damage);
        }
      });
    }
  }

  void _slayEnemy() {
    _enemyTimer?.cancel();
    _enemyTimer = null;

    _playerService.addExperience(enemy.value!.exp);
    _itemService.add(Dogecoin(enemy.value!.money));
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

    stage.value?.onPass?.call();
    DungeonStage? next = settings.next();

    if (next == null) {
      _winGame();
    } else {
      stage.value = next;

      slayedEnemies.value = 0;
      _stageStartedAt = DateTime.now();

      Source? source = stage.value?.music ?? settings.music;
      if (source != null) {
        _musicSource = source;
        _musicWorker.play(_musicSource!);
      } else if (_musicSource != null) {
        _musicWorker.stop(_musicSource);
      }

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

      for (var r in settings.rewards ?? []) {
        if (r is MoneyReward) {
          _itemService.add(Dogecoin(r.amount));
        } else if (r is ItemReward) {
          _itemService.add(r.item);
        } else if (r is ExpReward) {
          _playerService.addExperience(r.amount);
        } else if (r is RankReward) {
          _playerService.addRank(r.amount);
        }
      }

      if (onClear == null) {
        await ModalPopup.show(
          context: router.context!,
          isDismissible: false,
          child: ResultModal(this, won: true),
        );
      }

      await onClear?.call();
    }
  }

  void _loseGame() {
    if (!gameEnded.value) {
      gameEnded.value = true;
      ModalPopup.show(
        context: router.context!,
        isDismissible: false,
        child: ResultModal(this),
      );
    }
  }
}

class HitResult {
  const HitResult({
    required this.damage,
    this.isCrit = false,
    this.isSlayed = false,
  });

  final int damage;
  final bool isCrit;
  final bool isSlayed;
}
