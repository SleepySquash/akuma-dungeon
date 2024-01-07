import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel/novel.dart';

extension NovelExtension on Novel {
  static NovelOptions options() {
    return NovelOptions(
      background: const BackgroundOptions(directories: ['assets/background/']),
      image: const ImageOptions(directories: ['assets/character/']),
      music: const MusicOptions(directories: ['assets/music/']),
      overlay: [
        // `Pause` button in top right.
        (context) {
          final NovelController c = NovelController.of(context);

          return Positioned(
            top: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: c.pause,
                      label: const Text('Pause'),
                      icon: const Icon(Icons.pause),
                    ),
                  ],
                ),
              ),
            ),
          );
        },

        // `Pause` overlay.
        (context) {
          final NovelController c = NovelController.of(context);

          return Obx(() {
            return AnimatedOpacity(
              opacity: c.paused.value ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: IgnorePointer(
                ignoring: !c.paused.value,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black54,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Paused',
                          style: TextStyle(fontSize: 48, color: Colors.white),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton.icon(
                          onPressed: c.resume,
                          label: const Text('Resume'),
                          icon: const Icon(Icons.play_arrow),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () => c.end(false),
                          label: const Text('Exit to menu'),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ],
    );
  }
}
