import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:soundpool/soundpool.dart';

import '/router.dart';
import '/domain/model/application_settings.dart';
import '/domain/repository/settings.dart';

class MusicWorker extends DisposableInterface {
  MusicWorker(this._settingsRepository);

  bool isPlaying = false;

  final AbstractSettingsRepository _settingsRepository;

  late final bool usePool;
  Soundpool? _soundpool, _voicepool;
  int? _soundStream, _voiceStream;
  final Map<String, int> _pooledSounds = {}, _voiceSounds = {};

  double? _lastMusicVolume;
  late final Worker _settingsWorker;

  final AudioPlayer _audio = AudioPlayer();

  String? _asset;

  static const double _volumeCorrections = 0.5;

  late final Worker _lifecycleWorker;

  Rx<ApplicationSettings?> get _settings =>
      _settingsRepository.applicationSettings;

  @override
  void onInit() {
    usePool =
        (GetPlatform.isAndroid || GetPlatform.isIOS || GetPlatform.isMacOS) &&
            !GetPlatform.isWeb;

    if (usePool) {
      release();
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

    _settingsWorker = ever(_settings, (ApplicationSettings? settings) async {
      double musicVolume = _settings.value?.musicVolume ?? 1;
      if (_lastMusicVolume != musicVolume) {
        if (isPlaying) {
          if (musicVolume > 0) {
            if ((_lastMusicVolume ?? 0) <= 0) {
              _lastMusicVolume = musicVolume;
              await resume();
            } else {
              await _audio.setVolume(musicVolume * _volumeCorrections);
            }
          } else {
            await stop();
            isPlaying = true;
          }
        }

        _lastMusicVolume = musicVolume;
      }
    });

    _lifecycleWorker = ever(router.lifecycle, (AppLifecycleState state) async {
      switch (state) {
        case AppLifecycleState.resumed:
          if (_soundStream != null) {
            _soundpool?.resume(_soundStream!);
          }

          if (_voiceStream != null) {
            _voicepool?.resume(_voiceStream!);
          }

          _audio.play();
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

          await _audio.pause();
          break;
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    _audio.dispose();
    _settingsWorker.dispose();
    _lifecycleWorker.dispose();
    _soundpool?.dispose();
    _voicepool?.dispose();
    super.onClose();
  }

  Future<void> release() async {
    await _soundpool?.release();
    await _voicepool?.release();
    _pooledSounds.clear();
    _voiceSounds.clear();
  }

  Future<void> once(String asset) async {
    double volume = _settings.value?.soundVolume ?? 1;
    if (volume > 0) {
      if (usePool) {
        _soundStream = await _playPool(
          asset,
          pool: _soundpool!,
          sounds: _pooledSounds,
        );
      } else {
        final AudioPlayer player = AudioPlayer();
        await player.setVolume(volume);
        await player.setAsset('assets/$asset');
        await player.play();
        await player.dispose();
      }
    }
  }

  Future<void> voice(String asset) async {
    double volume = _settings.value?.soundVolume ?? 1;
    if (volume > 0) {
      if (usePool) {
        _voiceStream = await _playPool(
          asset,
          pool: _voicepool!,
          sounds: _voiceSounds,
        );
      } else {
        final AudioPlayer player = AudioPlayer();
        await player.setVolume(volume);
        await player.setAsset('assets/$asset');
        await player.play();
        await player.dispose();
      }
    }
  }

  Future<void> play(String asset) async {
    if (_asset != asset || !isPlaying) {
      _asset = asset;

      double volume = _settings.value?.musicVolume ?? 1;
      if (volume > 0) {
        await _audio.setLoopMode(LoopMode.one);
        await _audio.setAsset('assets/$asset');
        await _audio.setVolume(volume * _volumeCorrections);
        _audio.play();
      }

      isPlaying = true;
    }
  }

  Future<void> resume() async {
    if (_asset != null) {
      double volume = _settings.value?.musicVolume ?? 1;
      if (volume > 0) {
        await _audio.setVolume(volume * _volumeCorrections);
        await _audio.setAsset('assets/$_asset');
        _audio.play();
      }

      isPlaying = true;
    }
  }

  Future<void> stop([String? asset]) async {
    if (_asset == asset || asset == null) {
      await _audio.stop();
      isPlaying = false;
    }
  }

  Future<int> _playPool(String asset,
      {required Soundpool pool, required Map<String, int> sounds}) async {
    int stream;

    if (sounds.containsKey(asset)) {
      stream = await pool.play(sounds[asset]!);
    } else {
      sounds[asset] = -1;
      sounds[asset] = await pool.load(await rootBundle.load('assets/$asset'));
      stream = await pool.play(sounds[asset]!);
    }

    return stream;
  }
}
