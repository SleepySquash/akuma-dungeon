import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'executable.dart';
import 'task.dart';

mixin Commission on Task {}
mixin DungeonCommission implements Commission {
  @override
  IconData get icon => Icons.circle;

  @override
  String get name => 'Портал в подземелье';

  @override
  String? get subtitle =>
      'Рядом с городом открылся портал, из которого вот-вот выйдут монстры';
}
mixin QuestCommission implements Commission {}

class MyCommission extends ExecutableTask {
  MyCommission({
    String? id,
    required this.task,
    this.accepted = false,
    DateTime? appearedAt,
    this.progress = 0,
  })  : id = id ?? const Uuid().v4(),
        appearedAt = appearedAt ?? DateTime.now();

  final String id;

  @override
  final Task task;

  final DateTime appearedAt;

  bool accepted;

  @override
  int progress;
}
