import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'task.dart';

mixin Commission on Task {}
mixin DungeonCommission implements Commission {
  @override
  IconData get icon => Icons.circle;

  @override
  String get name => 'Портал в подземелье';

  @override
  String? get description =>
      'Рядом с городом открылся портал, из которого вот-вот выйдут монстры';
}
mixin QuestCommission implements Commission {}

class MyCommission {
  MyCommission({
    String? id,
    required this.task,
    this.accepted = false,
    DateTime? appearedAt,
    this.progress = 0,
  })  : id = id ?? const Uuid().v4(),
        appearedAt = appearedAt ?? DateTime.now();

  final String id;
  final Task task;
  final DateTime appearedAt;

  bool accepted;

  int progress;

  bool get isCompleted => progress >= task.steps.length;
}
