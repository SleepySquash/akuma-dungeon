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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/enemy.dart';
import '/domain/model/item/all.dart';
import '/domain/model/player.dart';
import '/domain/model/skill.dart';
import '/domain/model/skill/all.dart';
import '/domain/model/task.dart';
import '/domain/repository/character.dart';
import '/domain/repository/player.dart';
import '/domain/service/character.dart';
import '/domain/service/item.dart';
import '/domain/service/player.dart';
import '/domain/service/progression.dart';
import '/router.dart';
import '/ui/widget/modal_popup.dart';
import '/ui/worker/music.dart';
import '/util/extensions.dart';
import 'component/result.dart';
import 'widget/hit_indicator.dart';

class DungeonController extends GetxController {
  DungeonController(
    this._playerService,
    this._itemService,
    this._characterService,
    this._progressionService,
    this._musicWorker, {
    required this.settings,
    this.onClear,
  });

  /// [DungeonSettings] controlling this [DungeonController].
  final DungeonSettings settings;

  final FutureOr<void> Function()? onClear;

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
  final RxDouble sp = RxDouble(0);
  late final RxDouble mp;

  late final List<PartyMember> party;

  final RxMap<String, Widget> effects = RxMap();

  /// [PlayerService] maintaining the [Player].
  final PlayerService _playerService;

  final ItemService _itemService;

  final CharacterService _characterService;

  final ProgressionService _progressionService;

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
  RxPlayer get player => _playerService.player;

  @override
  void onInit() {
    hp = RxDouble(player.health.toDouble());
    mp = RxDouble(10);

    party = player.party.map((e) {
      GlobalKey key = GlobalKey();
      return PartyMember(
        e,
        key: key,
        onEnemyHit: (hit) {
          if (!gameEnded.value && enemy.value != null) {
            Source? sound = enemy.value?.enemy.hitSounds?.sample(1).firstOrNull;
            if (sound != null) {
              _musicWorker.once(sound);
            }

            enemy.value?.hit(hit.damage);
            if (enemy.value!.isDead) {
              _slayEnemy();
            }

            Rect? bounds = key.globalPaintBounds;

            final String id = const Uuid().v4();
            effects[id] = NumberIndicator(
              direction: HitIndicatorFlowDirection.up,
              position: Offset(
                (bounds?.left ?? 0) + (bounds?.width ?? 0) / 2,
                (bounds?.top ?? 0) + (bounds?.height ?? 0) / 2,
              ),
              number: hit.damage,
              onEnd: () => effects.remove(id),
            );
          }
        },
        onPlayerHeal: (health) {
          hp.value += health;
          hp.value = hp.value.clamp(0, player.health).toDouble();

          Rect? bounds = key.globalPaintBounds;

          final String id = const Uuid().v4();
          effects[id] = NumberIndicator(
            direction: HitIndicatorFlowDirection.up,
            position: Offset(
              (bounds?.left ?? 0) + (bounds?.width ?? 0) / 2,
              (bounds?.top ?? 0) + (bounds?.height ?? 0) / 2,
            ),
            number: health,
            color: Colors.green,
            onEnd: () => effects.remove(id),
          );
        },
        onShield: (defense) {
          sp.value += defense;

          int maxDefense = party
              .map((e) => e.character.character.value.skills)
              .expand((e) => e)
              .map<int>((e) {
            Skill skill = e.skill;
            if (skill is ShieldSkill) {
              return skill.shields[e.level - 1];
            }
            return 0;
          }).fold<int>(0, (p, e) => p + e);

          sp.value = sp.value.clamp(0, maxDefense.toDouble());

          Rect? bounds = key.globalPaintBounds;

          final String id = const Uuid().v4();
          effects[id] = NumberIndicator(
            direction: HitIndicatorFlowDirection.up,
            position: Offset(
              (bounds?.left ?? 0) + (bounds?.width ?? 0) / 2,
              (bounds?.top ?? 0) + (bounds?.height ?? 0) / 2,
            ),
            number: defense,
            color: const Color(0xFFDDDDDD),
            onEnd: () => effects.remove(id),
          );
        },
      );
    }).toList();

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
    _endGame();

    for (OverlayEntry e in entries) {
      if (e.mounted) {
        e.remove();
      }
    }

    _musicWorker.stop(_musicSource);

    super.onClose();
  }

  void hitEnemy({Offset? at}) {
    if (!gameEnded.value && enemy.value != null) {
      int damage = player.damage;
      bool isCrit = false;

      int chance = Random().nextInt(100);
      if (chance < player.critRate) {
        damage = damage + damage * player.critRate ~/ 100;
        isCrit = true;
      }

      Source? hit = enemy.value?.enemy.hitSounds?.sample(1).firstOrNull;
      if (hit != null) {
        _musicWorker.once(hit);
      }

      enemy.value?.hit(damage);
      if (enemy.value!.isDead) {
        _slayEnemy();
      }

      final String id = const Uuid().v4();
      effects[id] = NumberIndicator(
        position: at ??
            Offset(
              MediaQuery.of(router.context!).size.width / 2,
              MediaQuery.of(router.context!).size.height / 2,
            ),
        number: damage,
        color: isCrit ? Colors.yellow : null,
        fontSize: isCrit ? 48 : null,
        onEnd: () => effects.remove(id),
      );
    }
  }

  void _hitPlayer(double amount) {
    if (!gameEnded.value) {
      final int defense = max(player.defense, 1);
      final double damage = max(amount - (defense / 9), 0.1);

      if (sp.value > 0) {
        sp.value -= damage;
        if (sp.value < 0) {
          sp.value = 0;
        }
      } else {
        hp.value -= damage;
        if (hp.value <= 0) {
          hp.value = 0;
          _loseGame();
        }
      }

      final String id = const Uuid().v4();
      effects[id] = NumberIndicator(
        position: Offset(
          MediaQuery.of(router.context!).size.width * 0.1,
          MediaQuery.of(router.context!).size.height * 0.9,
        ),
        direction: HitIndicatorFlowDirection.up,
        number: damage.toInt(),
        color: Colors.orange,
        onEnd: () => effects.remove(id),
      );
    }
  }

  void _nextEnemy() {
    for (PartyMember p in party) {
      p.beforeEnemy();
    }

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
      int milliseconds =
          Random().nextInt(next.enemy.interval.inMilliseconds ~/ 2);
      _enemyTimer = Timer(
        Duration(milliseconds: milliseconds),
        () {
          if (!gameEnded.value) {
            _hitPlayer(next.damage);
            _enemyTimer = Timer.periodic(next.enemy.interval, (t) {
              if (!gameEnded.value) {
                _hitPlayer(next.damage);
              }
            });
          }
        },
      );
    }
  }

  void _slayEnemy() {
    for (PartyMember p in party) {
      p.afterEnemy();
    }

    _enemyTimer?.cancel();
    _enemyTimer = null;

    int exp = enemy.value!.exp ~/ (player.party.length + 1);
    if (exp > 0) {
      _playerService.addExperience(exp);

      for (RxMyCharacter p in player.party) {
        _characterService.addExperience(p.character.value, exp);
      }
    }

    if (enemy.value!.money > 0) {
      _itemService.add(Dogecoin(enemy.value!.money));
    }

    enemy.value = null;
    ++slayedEnemies.value;

    if (_checkIfConditionsAreMet()) {
      for (PartyMember p in party) {
        p.afterStage();
      }
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

      for (PartyMember p in party) {
        p.beforeStage();
      }

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

  void _endGame() {
    gameEnded.value = true;
    for (var p in party) {
      p.dispose();
    }

    _fixedTimer?.cancel();
    _enemyTimer?.cancel();
    for (Timer e in _conditions) {
      e.cancel();
    }
  }

  Future<void> _winGame() async {
    if (!gameEnded.value) {
      _endGame();

      for (var r in settings.rewards ?? []) {
        if (r is MoneyReward) {
          _itemService.add(Dogecoin(r.amount));
        } else if (r is ItemReward) {
          _itemService.add(r.item);
        } else if (r is ExpReward) {
          _playerService.addExperience(r.amount);
        } else if (r is RankReward) {
          _playerService.addRank(r.amount);
        } else if (r is ControlReward) {
          _progressionService.setLocationControl(
            _progressionService.location.value.location,
            _progressionService.location.value.control + r.amount,
          );
        } else if (r is ReputationReward) {
          _progressionService.setLocationReputation(
            _progressionService.location.value.location,
            _progressionService.location.value.reputation + r.amount,
          );
        }
      }

      await ModalPopup.show(
        context: router.context!,
        isDismissible: false,
        child: ResultModal(
          this,
          won: true,
          onDismissed: onClear?.call,
        ),
      );
    }
  }

  void _loseGame() {
    if (!gameEnded.value) {
      _endGame();
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

class PartyMember {
  PartyMember(
    this.character, {
    GlobalKey? key,
    this.onEnemyHit,
    this.onPlayerHeal,
    this.onShield,
  })  : key = key ?? GlobalKey(),
        hp = RxDouble(character.health.toDouble()) {
    init();
  }

  final GlobalKey key;

  final RxMyCharacter character;
  final RxDouble hp;

  final void Function(HitResult hit)? onEnemyHit;
  final void Function(int health)? onPlayerHeal;
  final void Function(int shield)? onShield;

  final List<Timer> _timers = [];

  void init() {}
  void dispose() {
    for (Timer t in _timers) {
      t.cancel();
    }
    _timers.clear();
  }

  void beforeStage() {
    for (MySkill s in character.character.value.skills) {
      if (s.skill is ShieldSkill) {
        ShieldSkill skill = s.skill as ShieldSkill;
        onShield?.call(skill.shields[s.level - 1]);
      }
    }
  }

  void afterStage() {}

  void beforeEnemy() {
    for (MySkill s in character.character.value.skills) {
      if (s.skill is HittingSkill) {
        HittingSkill skill = s.skill as HittingSkill;

        int milliseconds =
            Random().nextInt(skill.periods[s.level - 1].inMilliseconds);
        _timers.add(
          Timer(Duration(milliseconds: milliseconds), () {
            _timers.add(
              Timer.periodic(skill.periods[s.level - 1], (t) {
                double damage =
                    character.damage * (skill.damages[s.level - 1] / 100);
                onEnemyHit?.call(HitResult(damage: max(damage.toInt(), 1)));
              }),
            );
          }),
        );
      } else if (s.skill is HealingSkill) {
        HealingSkill skill = s.skill as HealingSkill;

        int milliseconds =
            Random().nextInt(skill.periods[s.level - 1].inMilliseconds);
        _timers.add(
          Timer(Duration(milliseconds: milliseconds), () {
            _timers.add(
              Timer.periodic(skill.periods[s.level - 1], (t) {
                onPlayerHeal?.call(skill.healths[s.level - 1]);
              }),
            );
          }),
        );
      }
    }
  }

  void afterEnemy() {
    for (Timer t in _timers) {
      t.cancel();
    }
    _timers.clear();
  }
}
