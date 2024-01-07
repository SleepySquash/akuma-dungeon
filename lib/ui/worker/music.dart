// Copyright © 2023 Lapuske Team, <https://github.com/lapuske>
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/router.dart';
import '/domain/model/application_settings.dart';
import '/domain/repository/settings.dart';
import '/util/audio_utils.dart';

class MusicWorker extends DisposableInterface {
  MusicWorker(this._settingsRepository);

  bool isPlaying = false;

  final AbstractSettingsRepository _settingsRepository;

  double? _lastMusicVolume;
  late final Worker _settingsWorker;

  AudioPlayback? _music;

  AudioSource? _asset;

  static const double _volumeCorrections = 0.5;

  late final Worker _lifecycleWorker;

  Rx<ApplicationSettings?> get _settings =>
      _settingsRepository.applicationSettings;

  @override
  void onInit() {
    _settingsWorker = ever(_settings, (ApplicationSettings? settings) async {
      double musicVolume = _settings.value?.musicVolume ?? 1;
      if (_lastMusicVolume != musicVolume) {
        if (isPlaying) {
          if (musicVolume > 0) {
            if ((_lastMusicVolume ?? 0) <= 0) {
              _lastMusicVolume = musicVolume;
              await _music?.resume();
            } else {
              await _music?.setVolume(musicVolume * _volumeCorrections * 100);
            }
          } else {
            await _music?.pause();
            isPlaying = true;
          }
        }

        _lastMusicVolume = musicVolume;
      }
    });

    if (GetPlatform.isMobile) {
      _lifecycleWorker =
          ever(router.lifecycle, (AppLifecycleState state) async {
        switch (state) {
          case AppLifecycleState.resumed:
            _music?.resume();
            break;

          case AppLifecycleState.hidden:
          case AppLifecycleState.inactive:
          case AppLifecycleState.paused:
          case AppLifecycleState.detached:
            await _music?.pause();
            break;
        }
      });
    }

    super.onInit();
  }

  @override
  void onClose() {
    _music?.cancel();
    _settingsWorker.dispose();
    _lifecycleWorker.dispose();
    super.onClose();
  }

  void once(AudioSource source, {double? volume}) {
    final double v = volume ?? _settings.value?.soundVolume ?? 1;
    if (v > 0) {
      AudioUtils.once(source, volume: v * 100);
    }
  }

  void voice(AudioSource source, {double? volume}) {
    final double v = volume ?? _settings.value?.soundVolume ?? 1;
    if (v > 0) {
      AudioUtils.once(source, volume: v * 100);
    }
  }

  Future<void> play(AudioSource source, {double? from, double? volume}) async {
    if (_asset != source || !isPlaying) {
      _asset = source;

      volume = volume ?? _settings.value?.musicVolume ?? 1;

      _music?.cancel();
      _music = AudioUtils.play(
        source,
        volume: volume * _volumeCorrections * 100,
        from: from == null
            ? Duration.zero
            : Duration(
                microseconds: (from * Duration.microsecondsPerSecond).toInt(),
              ),
      );

      isPlaying = true;
    }
  }

  Future<void> resume() async {
    if (_asset != null) {
      final double volume = _settings.value?.musicVolume ?? 1;
      if (volume > 0) {
        await _music?.setVolume(volume * _volumeCorrections * 100);
        await _music?.resume();
      }

      isPlaying = true;
    }
  }

  Future<void> stop([AudioSource? asset]) async {
    if (_asset == asset || asset == null) {
      _music?.cancel();
      isPlaying = false;
      _asset = null;
    }
  }
}
