import 'dart:async';

import 'package:novel/novel.dart';

import '/router.dart';
import 'location.dart';
import 'task.dart';

abstract class ExecutableTask {
  Task get task;
  int get progress;
  set progress(int i);

  String get id => task.id;
  bool get isCompleted => progress >= task.steps.length;

  void execute({
    void Function()? save,
    void Function()? onEnd,
    Location? location,
  }) {
    if (isCompleted == true) {
      return;
    }

    void next() {
      progress++;
      save?.call();

      if (isCompleted) {
        (onEnd ?? router.home).call();
      } else {
        execute(
          save: save,
          onEnd: onEnd,
          location: location,
        );
      }
    }

    int i = progress;
    TaskStep step = task.steps[i];
    if (step is NovelStep) {
      router.nowhere();
      Novel.show(context: router.context!, scenario: step.scenario)
          .then((_) => next());
    } else if (step is DungeonStep) {
      if (step.withEntrance) {
        router.entrance(
          step.settings,
          step.entranceFrom ?? location?.asset ?? '',
          onClear: () {
            router.nowhere();
            next();
          },
        );
      } else {
        router.dungeon(
          step.settings,
          onClear: () {
            router.nowhere();
            next();
          },
        );
      }
    } else if (step is ExecuteStep) {
      router.nowhere();
      FutureOr<bool> future = step.function.call();
      if (future is Future<bool>) {
        future.then((b) {
          if (b) {
            next();
          }
        });
      }
    }
  }
}
