// Copyright © 2022-2023 IT ENGINEERING MANAGEMENT INC,
//                       <https://github.com/team113>
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

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:log_me/log_me.dart';
import 'package:media_kit/media_kit.dart';

/// Global variable to access [AudioUtilsImpl].
///
/// May be reassigned to mock specific functionally.
// ignore: non_constant_identifier_names
AudioUtilsImpl AudioUtils = AudioUtilsImpl();

/// Helper providing direct access to audio playback related resources.
class AudioUtilsImpl {
  /// [Player] lazily initialized to play sounds [once].
  Player? _player;

  /// [Player] lazily initialized to play voices [once].
  Player? _voice;

  /// [StreamController]s of [AudioSource]s added in [play].
  final Map<AudioSource, AudioPlayback> _players = {};

  /// Ensures the underlying resources are initialized to reduce possible delays
  /// when playing [once].
  void ensureInitialized() {
    try {
      _player ??= Player();
      _voice ??= Player();
    } catch (e) {
      // If [Player] isn't available on the current platform, this throws a
      // `null check operator used on a null value`.
      if (e is! TypeError) {
        Log.error('Failed to initialize `Player`: ${e.toString()}');
      }
    }
  }

  /// Plays the provided [sound] once.
  AudioPlayback once(
    AudioSource sound, {
    double? volume,
    bool voice = false,
  }) {
    ensureInitialized();

    StreamController? controller;

    final AudioPlayback playback = AudioPlayback();
    playback._player = (voice ? _voice : _player);

    controller = StreamController.broadcast(
      onListen: () async {
        await (voice ? _voice : _player)?.open(sound.media);
        if (volume != null) {
          await (voice ? _voice : _player)?.setVolume(volume);
        }
      },
      onCancel: () async {
        await playback._player?.stop();
      },
    );

    playback._subscription = controller.stream.listen((_) {});

    return playback;
  }

  /// Plays the provided [sound] as a voice once.
  AudioPlayback voice(AudioSource sound, {double? volume}) =>
      once(sound, volume: volume, voice: true);

  /// Plays the provided [music] looped with the specified [fade].
  ///
  /// Stopping the [music] means canceling the returned [StreamSubscription].
  AudioPlayback play(
    AudioSource music, {
    Duration fade = Duration.zero,
    Duration from = Duration.zero,
    double? volume,
  }) {
    AudioPlayback? playback = _players[music];
    StreamSubscription? position;

    if (playback == null) {
      playback = AudioPlayback();
      Timer? timer;

      StreamController controller = StreamController.broadcast(
        onListen: () async {
          try {
            playback?._player = Player();
          } catch (e) {
            // If [Player] isn't available on the current platform, this throws
            // a `null check operator used on a null value`.
            if (e is! TypeError) {
              Log.error('Failed to initialize `Player`: ${e.toString()}');
            }
          }

          await playback?._player?.open(music.media);

          // TODO: Wait for `media_kit` to improve [PlaylistMode.loop] in Web.
          if (kIsWeb) {
            position = playback?._player?.stream.completed.listen((e) async {
              await playback?._player?.seek(Duration.zero);
              await playback?._player?.play();
            });
          } else {
            await playback?._player?.setPlaylistMode(PlaylistMode.loop);
          }

          await playback?._player?.setVolume(100);

          if (fade != Duration.zero) {
            await playback?._player?.setVolume(0);
            timer = Timer.periodic(
              Duration(microseconds: fade.inMicroseconds ~/ 10),
              (timer) async {
                if (timer.tick > 9) {
                  timer.cancel();
                } else {
                  await playback?._player?.setVolume(
                    (volume ?? 100) * (timer.tick + 1) / 10,
                  );
                }
              },
            );
          } else if (volume != null) {
            await playback?._player?.setVolume(volume);
          }

          if (from != Duration.zero) {
            // TODO: Not seeking when source is from network.
            //       Try https://github.com/media-kit/media-kit/pull/581.
            await playback?._player?.stream.buffer.first;
            await playback?._player?.seek(from);
          }
        },
        onCancel: () async {
          _players.remove(music);
          position?.cancel();
          timer?.cancel();

          Future<void>? dispose = playback?._player?.dispose();
          playback?._player = null;
          await dispose;
        },
      );

      _players[music] = playback;
      playback._subscription = controller.stream.listen((_) {});
    }

    return playback;
  }
}

class AudioPlayback {
  AudioPlayback();

  StreamSubscription? _subscription;

  Player? _player;

  Future<void> pause() async => await _player?.pause();
  Future<void> resume() async => await _player?.play();
  Future<void> setVolume(double value) async => await _player?.setVolume(value);
  void cancel() => _subscription?.cancel();
}

/// Possible [AudioSource] kind.
enum AudioSourceKind { asset, file, url }

/// Source to play an audio stream from.
abstract class AudioSource {
  const AudioSource();

  /// Constructs an [AudioSource] from the provided [asset].
  factory AudioSource.asset(String asset) = AssetAudioSource;

  /// Constructs an [AudioSource] from the provided [file].
  factory AudioSource.file(String file) = FileAudioSource;

  /// Constructs an [AudioSource] from the provided [url].
  factory AudioSource.url(String url) = UrlAudioSource;

  /// Returns a [AudioSourceKind] of this [AudioSource].
  AudioSourceKind get kind;
}

/// [AudioSource] of the provided [asset].
class AssetAudioSource extends AudioSource {
  const AssetAudioSource(this.asset);

  /// Path to an asset to play audio from.
  final String asset;

  @override
  AudioSourceKind get kind => AudioSourceKind.asset;

  @override
  int get hashCode => asset.hashCode;

  @override
  bool operator ==(Object other) =>
      other is AssetAudioSource && other.asset == asset;
}

/// [AudioSource] of the provided [file].
class FileAudioSource extends AudioSource {
  const FileAudioSource(this.file);

  /// Path to a file to play audio from.
  final String file;

  @override
  AudioSourceKind get kind => AudioSourceKind.file;

  @override
  int get hashCode => file.hashCode;

  @override
  bool operator ==(Object other) =>
      other is FileAudioSource && other.file == file;
}

/// [AudioSource] of the provided [url].
class UrlAudioSource extends AudioSource {
  const UrlAudioSource(this.url);

  /// URL to play audio from.
  final String url;

  @override
  AudioSourceKind get kind => AudioSourceKind.url;

  @override
  int get hashCode => url.hashCode;

  @override
  bool operator ==(Object other) => other is UrlAudioSource && other.url == url;
}

/// Extension adding conversion from an [AudioSource] to a [Media].
extension AudioSourceMedia on AudioSource {
  /// Returns a [Media] corresponding to this [AudioSource].
  Media get media {
    return switch (kind) {
      AudioSourceKind.asset => Media(
          'asset:///${kIsWeb ? 'assets/' : ''}${(this as AssetAudioSource).asset}',
        ),
      AudioSourceKind.file =>
        Media('file:///${(this as FileAudioSource).file}'),
      AudioSourceKind.url => Media((this as UrlAudioSource).url),
    };
  }
}
