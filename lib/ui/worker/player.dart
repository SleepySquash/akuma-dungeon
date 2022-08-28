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

import 'dart:math';

import 'package:audioplayers/audioplayers.dart' show AssetSource;
import 'package:get/get.dart';

import '/domain/model/player.dart';
import '/domain/service/notification.dart';
import '/domain/service/player.dart';
import '/ui/worker/music.dart';

class PlayerWorker extends DisposableInterface {
  PlayerWorker(
    this._playerService,
    this._notificationService,
    this._musicWorker,
  );

  final PlayerService _playerService;
  final NotificationService _notificationService;
  final MusicWorker _musicWorker;

  late int _levelUpSound;

  Worker? _worker;

  Rx<Player?> get player => _playerService.player;

  @override
  void onInit() {
    _levelUpSound = Random().nextInt(3) + 1;

    int oldLevel = player.value?.level ?? 0;
    _worker = ever(
      player,
      (Player? player) {
        int newLevel = player?.level ?? 0;
        if (newLevel != oldLevel) {
          oldLevel = newLevel;

          _musicWorker
              .once(AssetSource('voice/sfx/newlevel_$_levelUpSound.m4a'));
          ++_levelUpSound;
          if (_levelUpSound > 3) {
            _levelUpSound = 1;
          }

          _notificationService.notify(
            LocalNotification(
              title: '$newLevel',
              subtitle: 'Новый уровень',
              type: LocalNotificationType.centered,
            ),
          );
        }
      },
    );

    super.onInit();
  }

  @override
  void onClose() {
    _worker?.dispose();
    super.onClose();
  }
}
