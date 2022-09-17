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

import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/enemy.dart';
import '/domain/model/item/all.dart';
import '/domain/model/player.dart';
import '/domain/model/reward.dart';
import '/domain/model/skill.dart';
import '/domain/model/skill/all.dart';
import '/domain/repository/character.dart';
import '/domain/repository/player.dart';
import '/domain/service/character.dart';
import '/domain/service/flag.dart';
import '/domain/service/item.dart';
import '/domain/service/location.dart';
import '/domain/service/player.dart';
import '/router.dart';
import '/ui/widget/modal_popup.dart';
import '/ui/worker/music.dart';
import '/util/extensions.dart';
import '/util/rewards.dart';
import 'component/result.dart';
import 'widget/hit_indicator.dart';
import 'widget/money.dart';
import 'widget/skill2.dart';
import 'widget/title.dart';

class DungeonController extends GetxController {
  DungeonController(
    this._playerService,
    this._flagService,
    this._itemService,
    this._characterService,
    this._locationService,
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

  late final Rx<Decimal> hp;
  late final Rx<Decimal> sp;
  late final Rx<Decimal> mp;

  late final List<PartyMember> party;

  final RxMap<String, Widget> effects = RxMap();

  final Map<String?, Decimal> damages = {};

  Rx<Duration> enemySlideDuration = Rx(const Duration(milliseconds: 150));
  Rx<Offset> enemySlideOffset = Rx(Offset.zero);
  RxDouble enemyScaleY = RxDouble(1);

  /// [PlayerService] maintaining the [Player].
  final PlayerService _playerService;
  final ItemService _itemService;
  final FlagService _flagService;
  final CharacterService _characterService;
  final LocationService _locationService;
  final MusicWorker _musicWorker;

  /// [DateTime] when the current [stage] has started.
  DateTime? _stageStartedAt;

  /// [Timer]s being active in the current [stage] for checking on some
  /// condition, for example.
  final List<Timer> _conditions = [];

  Timer? _enemyTimer;

  /// [Timer] updating every second (fixed interval of time).
  Timer? _fixedTimer;

  String? _musicSource;

  Timer? _initTimer;

  Timer? _enemySlideTimer;

  Timer? _hitTimer;

  /// Currently authenticated [Player].
  RxPlayer get player => _playerService.player;

  @override
  void onInit() {
    hp = Rx(player.health);
    sp = Rx(Decimal.zero);
    mp = Rx(Decimal.ten);

    party = player.party.map((e) {
      GlobalKey key = GlobalKey();
      return PartyMember(
        e,
        key: key,
        onEnemyHit: (hit) {
          if (!gameEnded.value && enemy.value != null) {
            String? sound = enemy.value?.enemy.hitSounds?.sample(1).firstOrNull;
            if (sound != null) {
              _musicWorker.once(sound);
            }

            _enemyAnimation();
            enemy.value?.hit(hit.damage);
            if (enemy.value!.isDead) {
              _slayEnemy();
            }

            damages[e.character.value.id.val] =
                (damages[e.character.value.id.val] ?? Decimal.zero) +
                    hit.damage;

            final String id = const Uuid().v4();
            Rect? bounds = key.globalPaintBounds;
            effects[id] = NumberIndicator(
              direction: HitIndicatorFlowDirection.up,
              position: Offset(
                (bounds?.left ?? 0) + (bounds?.width ?? 0) / 2,
                (bounds?.top ?? 0) + (bounds?.height ?? 0) / 3,
              ),
              number: hit.damage.toString(),
              onEnd: () => effects.remove(id),
            );
          }
        },
        onPlayerHeal: (health) {
          hp.value += health;

          if (hp.value < Decimal.zero) {
            hp.value = Decimal.zero;
          }

          Rect? bounds = key.globalPaintBounds;

          final String id = const Uuid().v4();
          effects[id] = NumberIndicator(
            direction: HitIndicatorFlowDirection.up,
            position: Offset(
              (bounds?.left ?? 0) + (bounds?.width ?? 0) / 2,
              (bounds?.top ?? 0) + (bounds?.height ?? 0) / 3,
            ),
            number: health.toString(),
            color: Colors.green,
            onEnd: () => effects.remove(id),
          );
        },
        onShield: (defense) {
          sp.value += defense;

          Decimal maxDefense = party
              .map((e) => e.character.character.value.skills)
              .expand((e) => e)
              .map<Decimal>((e) {
            Skill skill = e.skill;
            if (skill is ShieldSkill) {
              return skill.shields[e.level];
            }
            return Decimal.zero;
          }).fold<Decimal>(Decimal.zero, (p, e) => p + e);

          if (sp.value < Decimal.zero) {
            sp.value = Decimal.zero;
          } else if (sp.value > maxDefense) {
            sp.value = maxDefense;
          }

          final String id = const Uuid().v4();
          Rect? bounds = key.globalPaintBounds;
          effects[id] = NumberIndicator(
            direction: HitIndicatorFlowDirection.up,
            position: Offset(
              (bounds?.left ?? 0) + (bounds?.width ?? 0) / 2,
              (bounds?.top ?? 0) + (bounds?.height ?? 0) / 3,
            ),
            number: defense.toString(),
            color: const Color(0xFFDDDDDD),
            onEnd: () => effects.remove(id),
          );
        },
        onSkill: (Skill skill) {
          String? sound = skill.sounds?.sample(1).firstOrNull;
          if (sound != null) {
            _musicWorker.voice(sound);
          }

          final String id = const Uuid().v4();
          Rect? bounds = key.globalPaintBounds;
          effects[id] = FloatingSkill(
            direction: HitIndicatorFlowDirection.up,
            position: Offset(
              (bounds?.left ?? 0) + (bounds?.width ?? 0) / 2,
              (bounds?.top ?? 0) + (bounds?.height ?? 0) / 3,
            ),
            asset: 'character/${e.character.value.character.asset}',
            text: skill.name,
            onEnd: () => effects.remove(id),
          );
        },
      );
    }).toList();

    _initTimer = Timer(250.milliseconds, () {
      _nextStage();
      _nextEnemy();

      _fixedTimer = Timer.periodic(1.seconds, (t) {
        if (_stageStartedAt != null) {
          duration.value = _stageStartedAt!.difference(DateTime.now());
        }
      });

      if (settings.title != null) {
        final String id = const Uuid().v4();
        effects[id] = AnimatedTitle(
          title: settings.title!,
          onEnd: () => effects.remove(id),
        );
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    _endGame();

    _initTimer?.cancel();
    for (OverlayEntry e in entries) {
      if (e.mounted) {
        e.remove();
      }
    }

    _musicWorker.stop(_musicSource);
    _musicWorker.release();

    super.onClose();
  }

  void hitEnemy({Offset? at}) {
    if (!gameEnded.value && enemy.value != null) {
      if (_hitTimer?.isActive == true) {
        return;
      }

      _hitTimer = Timer(50.milliseconds, () {});

      _enemyAnimation();

      Decimal damage = player.damage;
      bool isCrit = false;

      Decimal chance = Decimal.fromInt(Random().nextInt(100));
      if (chance < player.critRate) {
        damage = damage + damage * player.critRate * Decimal.parse('0.01');
        isCrit = true;
      }

      String? hit = enemy.value?.enemy.hitSounds?.sample(1).firstOrNull;
      if (hit != null) {
        _musicWorker.once(hit);
      }

      enemy.value?.hit(damage);
      if (enemy.value!.isDead) {
        _slayEnemy();
      }

      damages[null] = (damages[null] ?? Decimal.zero) + damage;

      final String id = const Uuid().v4();
      effects[id] = NumberIndicator(
        position: at ??
            Offset(
              MediaQuery.of(router.context!).size.width / 2,
              MediaQuery.of(router.context!).size.height / 2,
            ),
        offsetMultiplier: 2,
        number: damage.toString(),
        color: isCrit ? Colors.yellow : null,
        fontSize: isCrit ? 48 : null,
        onEnd: () => effects.remove(id),
      );
    }
  }

  void _enemyAnimation() {
    enemySlideDuration.value = const Duration(milliseconds: 40);
    enemySlideOffset.value = Offset(
      0.05 - Random().nextDouble() * 0.1,
      0.05 - Random().nextDouble() * 0.1,
    );
    enemyScaleY.value = 0.9;
    _enemySlideTimer?.cancel();
    _enemySlideTimer = Timer(40.milliseconds, () {
      enemySlideDuration.value = const Duration(milliseconds: 200);
      enemySlideOffset.value = Offset.zero;
      enemyScaleY.value = 1;
    });
  }

  void _hitPlayer(Decimal amount) {
    if (!gameEnded.value) {
      PartyMember? target = party.firstWhereOrNull((e) {
        if (e.isAlive) {
          for (MySkill s in e.character.character.value.skills) {
            if (s.skill is ProvocationSkill) {
              return true;
            }
          }
        }
        return false;
      });

      if (target != null) {
        target.hp.value -= amount;
        if (target.hp.value <= Decimal.zero) {
          target.dispose();
        }

        final String id = const Uuid().v4();
        Rect? bounds = target.key.globalPaintBounds;
        effects[id] = NumberIndicator(
          direction: HitIndicatorFlowDirection.up,
          position: Offset(
            (bounds?.left ?? 0) + (bounds?.width ?? 0) / 2,
            (bounds?.top ?? 0) + (bounds?.height ?? 0) / 3,
          ),
          number: amount.toString(),
          color: Colors.orange,
          onEnd: () => effects.remove(id),
        );
      } else {
        final Decimal damage = amount - (player.defense * Decimal.parse('0.1'));

        if (sp.value > Decimal.zero) {
          sp.value -= damage;
          if (sp.value < Decimal.zero) {
            sp.value = Decimal.zero;
          }
        } else {
          hp.value -= damage;
          if (hp.value <= Decimal.zero) {
            hp.value = Decimal.zero;
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
          number: damage.toString(),
          color: Colors.orange,
          onEnd: () => effects.remove(id),
        );
      }
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
            multiplier: stage.value?.multiplier ?? Decimal.one,
          );

    enemy.value = next;

    if (next != null) {
      _enemyTimer?.cancel();
      int milliseconds =
          Random().nextInt(150 + next.enemy.interval.inMilliseconds ~/ 2);
      _enemyTimer = Timer(
        Duration(milliseconds: milliseconds),
        () {
          if (!gameEnded.value) {
            if (next.damage != Decimal.zero) {
              _hitPlayer(next.damage);
              _enemyTimer = Timer.periodic(next.enemy.interval, (t) {
                if (!gameEnded.value) {
                  _hitPlayer(next.damage);
                }
              });
            }
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

    Decimal exp = (enemy.value!.exp / Decimal.fromInt(player.party.length + 1))
        .toDecimal();

    if (exp > Decimal.zero) {
      _playerService.addExperience(exp);

      for (RxMyCharacter p in player.party) {
        _characterService.addExperience(p.character.value, exp);
      }
    }

    if (enemy.value!.money > Decimal.zero) {
      _itemService.add(const Dogecoin(1), enemy.value!.money);
    }

    if (enemy.value!.enemy.drops.isNotEmpty) {
      for (Reward r in enemy.value!.enemy.drops) {
        if (r is ItemReward) {
          if (r.count > 0) {
            _itemService.add(r.item, Decimal.fromInt(r.count));

            final Rect? bounds = enemy.value!.globalKey.globalPaintBounds;
            final String id2 = const Uuid().v4();
            effects[id2] = DroppedItem(
              r.item,
              from: Offset(
                (bounds?.left ??
                        MediaQuery.of(router.context!).size.width / 2) +
                    (bounds?.width ?? 0) / 2,
                (bounds?.top ??
                        MediaQuery.of(router.context!).size.height / 2) +
                    (bounds?.height ?? 0) / 2,
              ),
              onEnd: () => effects.remove(id2),
            );
          }
        }
      }
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

      String? source = stage.value?.music ?? settings.music;
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

      settings.rewards?.compute(
        itemService: _itemService,
        locationService: _locationService,
        playerService: _playerService,
        flagService: _flagService,
      );

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

  final Decimal damage;
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
    this.onSkill,
  })  : key = key ?? GlobalKey(),
        hp = Rx(character.health) {
    init();
  }

  final GlobalKey key;

  final RxMyCharacter character;
  final Rx<Decimal> hp;

  bool get isAlive => hp.value > Decimal.zero;

  final void Function(HitResult hit)? onEnemyHit;
  final void Function(Decimal health)? onPlayerHeal;
  final void Function(Decimal shield)? onShield;
  final void Function(Skill)? onSkill;

  final List<Timer> _primary = [];
  final List<Timer> _cooldowns = [];

  void init() {
    for (MySkill s in character.character.value.skills) {
      if (s.skill is CooldownSkill) {
        CooldownSkill cooldown = s.skill as CooldownSkill;

        int milliseconds = Random().nextInt(500);
        _cooldowns.add(
          Timer(Duration(milliseconds: milliseconds), () {
            _cooldowns.add(
              Timer.periodic(cooldown.cooldowns[s.level], (t) {
                onSkill?.call(cooldown);
                if (cooldown is SilentShotSkill) {
                  for (int i = 0; i < cooldown.count; ++i) {
                    _cooldowns.add(
                      Timer(
                        Duration(milliseconds: i * 200),
                        () {
                          Decimal damage = character.damage *
                              (cooldown.damages[s.level] *
                                  Decimal.parse('0.01'));
                          onEnemyHit?.call(HitResult(damage: damage));
                        },
                      ),
                    );
                  }
                }
              }),
            );
          }),
        );
      }
    }

    _primaryAttack();
  }

  void dispose() {
    for (Timer t in [..._primary, ..._cooldowns]) {
      t.cancel();
    }
    _primary.clear();
    _cooldowns.clear();
  }

  void beforeStage() {
    if (!isAlive) return;

    for (MySkill s in character.character.value.skills) {
      if (s.skill is ShieldSkill) {
        ShieldSkill skill = s.skill as ShieldSkill;
        onShield?.call(skill.shields[s.level]);
      }
    }
  }

  void afterStage() {
    if (!isAlive) {
      hp.value = character.health * Decimal.parse('0.5');

      for (Timer t in _primary) {
        t.cancel();
      }
      _primary.clear();
      _primaryAttack();
    }
  }

  void beforeEnemy() {}

  void afterEnemy() {}

  void _primaryAttack() {
    for (MySkill s in character.character.value.skills) {
      if (s.skill is HittingSkill) {
        HittingSkill skill = s.skill as HittingSkill;

        int milliseconds =
            Random().nextInt(skill.periods[s.level].inMilliseconds ~/ 2);
        _primary.add(
          Timer(Duration(milliseconds: milliseconds), () {
            _primary.add(
              Timer.periodic(skill.periods[s.level], (t) {
                Decimal damage = character.damage *
                    (skill.damages[s.level] * Decimal.parse('0.01'));
                onEnemyHit?.call(HitResult(damage: damage));
              }),
            );
          }),
        );
      } else if (s.skill is HealingSkill) {
        HealingSkill skill = s.skill as HealingSkill;

        int milliseconds =
            Random().nextInt(skill.periods[s.level].inMilliseconds);
        _primary.add(
          Timer(Duration(milliseconds: milliseconds), () {
            _primary.add(
              Timer.periodic(skill.periods[s.level], (t) {
                onPlayerHeal?.call(skill.healths[s.level]);
              }),
            );
          }),
        );
      }
    }
  }
}
