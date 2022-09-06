import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

import '/domain/model/application_settings.dart';
import '/domain/repository/settings.dart';

class MusicWorker extends DisposableInterface {
  MusicWorker(this._settingsRepository);

  final AudioPlayer audio = AudioPlayer(playerId: 'music');

  bool isPlaying = false;

  final AbstractSettingsRepository _settingsRepository;

  double? _lastMusicVolume;
  Worker? _settingsWorker;

  Source? _source;

  static const double _volumeCorrections = 0.5;

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

    super.onInit();
  }

  @override
  void onClose() {
    audio.dispose();
    _settingsWorker?.dispose();
    super.onClose();
  }

  void once(Source source) {
    double volume = _settings.value?.soundVolume ?? 1;
    if (volume > 0) {
      final AudioPlayer player = AudioPlayer();
      player.play(source, volume: volume, mode: PlayerMode.mediaPlayer);
    }
  }

  void play(Source source) {
    _source = source;

    double volume = _settings.value?.musicVolume ?? 1;
    if (volume > 0) {
      audio.setReleaseMode(ReleaseMode.loop);
      audio.play(
        source,
        volume: volume * _volumeCorrections,
        mode: PlayerMode.mediaPlayer,
      );
    }

    isPlaying = true;
  }

  void resume() {
    if (_source != null) {
      double volume = _settings.value?.musicVolume ?? 1;
      if (volume > 0) {
        audio.setReleaseMode(ReleaseMode.loop);
        audio.play(
          _source!,
          volume: volume * _volumeCorrections,
          mode: PlayerMode.mediaPlayer,
        );
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
}
