import 'dart:async';

import 'package:akuma/router.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soundpool/soundpool.dart';

import '/domain/model/application_settings.dart';
import '/domain/repository/settings.dart';

class MusicWorker extends DisposableInterface {
  MusicWorker(this._settingsRepository);

  final AudioPlayer audio = AudioPlayer(playerId: 'music');

  bool isPlaying = false;

  final AbstractSettingsRepository _settingsRepository;

  Soundpool? _soundpool, _voicepool;
  int? _soundStream, _voiceStream;
  final Map<String, int> _pooledSounds = {}, _voiceSounds = {};
  final Map<String, Timer> _pooledTimers = {};

  double? _lastMusicVolume;
  late final Worker _settingsWorker;

  Source? _source;

  static const double _volumeCorrections = 0.5;

  late final Worker _lifecycleWorker;

  Rx<ApplicationSettings?> get _settings =>
      _settingsRepository.applicationSettings;

  @override
  void onInit() {
    _settingsWorker = ever(_settings, (ApplicationSettings? settings) {
      double musicVolume = _settings.value?.musicVolume ?? 1;
      if (_lastMusicVolume != musicVolume) {
        if (isPlaying) {
          if (musicVolume > 0) {
            if ((_lastMusicVolume ?? 0) <= 0) {
              resume();
            } else {
              audio.setVolume(musicVolume * _volumeCorrections);
            }
          } else {
            stop();
            isPlaying = true;
          }
        }

        _lastMusicVolume = musicVolume;
      }
    });

    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
      try {
        _soundpool = Soundpool.fromOptions(
          options: const SoundpoolOptions(streamType: StreamType.notification),
        );

        _voicepool = Soundpool.fromOptions(
          options: const SoundpoolOptions(streamType: StreamType.notification),
        );
      } catch (_) {
        // No-op.
      }
    }

    _lifecycleWorker = ever(router.lifecycle, (AppLifecycleState state) {
      print(state);
      switch (state) {
        case AppLifecycleState.resumed:
          if (_soundStream != null) {
            _soundpool?.resume(_soundStream!);
          }

          if (_voiceStream != null) {
            _voicepool?.resume(_voiceStream!);
          }

          audio.resume();
          break;

        case AppLifecycleState.inactive:
        case AppLifecycleState.paused:
        case AppLifecycleState.detached:
          if (_soundStream != null) {
            _soundpool?.pause(_soundStream!);
          }

          if (_voiceStream != null) {
            _voicepool?.pause(_voiceStream!);
          }

          audio.pause();
          break;
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    audio.dispose();
    _settingsWorker.dispose();
    _lifecycleWorker.dispose();
    _soundpool?.dispose();
    _voicepool?.dispose();
    super.onClose();
  }

  void once(Source source) async {
    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
      if (source is AssetSource) {
        if (_pooledSounds.containsKey(source.path)) {
          _soundStream = await _soundpool!.play(_pooledSounds[source.path]!);
        } else {
          _pooledSounds[source.path] = -1;
          _pooledSounds[source.path] = await _soundpool!
              .load(await rootBundle.load('assets/${source.path}'));
          _soundStream = await _soundpool!.play(_pooledSounds[source.path]!);
        }

        _pooledTimers[source.path]?.cancel();
        _pooledTimers[source.path] = Timer(
          const Duration(minutes: 1),
          () {
            // Release the unused sound?
            // soundpool.unload();
          },
        );
      }
    } else {
      _playOnce(source);
    }
  }

  void voice(Source source) async {
    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
      if (source is AssetSource) {
        if (_voiceSounds.containsKey(source.path)) {
          _voiceStream = await _voicepool!.play(_voiceSounds[source.path]!);
        } else {
          _voiceSounds[source.path] = -1;
          _voiceSounds[source.path] = await _voicepool!
              .load(await rootBundle.load('assets/${source.path}'));
          _voiceStream = await _soundpool!.play(_pooledSounds[source.path]!);
        }

        _pooledTimers[source.path]?.cancel();
        _pooledTimers[source.path] = Timer(
          const Duration(minutes: 1),
          () {
            // Release the unused sound?
            // soundpool.unload();
          },
        );
      }
    } else {
      _playOnce(source);
    }
  }

  void play(Source source) {
    _source = source;

    double volume = _settings.value?.musicVolume ?? 1;
    if (volume > 0) {
      audio.setReleaseMode(ReleaseMode.loop);
      audio.play(source, volume: volume * _volumeCorrections);
    }

    isPlaying = true;
  }

  void resume() {
    if (_source != null) {
      double volume = _settings.value?.musicVolume ?? 1;
      if (volume > 0) {
        audio.setReleaseMode(ReleaseMode.loop);
        audio.play(_source!, volume: volume * _volumeCorrections);
      }

      isPlaying = true;
    }
  }

  void stop([Source? source]) {
    if (_source == source || source == null) {
      audio.setReleaseMode(ReleaseMode.release);
      audio.stop();
      isPlaying = false;
    }
  }

  void _playOnce(Source source) {
    double volume = _settings.value?.soundVolume ?? 1;
    if (volume > 0) {
      final AudioPlayer player = AudioPlayer();
      player.play(source, volume: volume);
    }
  }
}
