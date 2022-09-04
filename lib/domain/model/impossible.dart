import 'character.dart';
import 'item.dart';
import 'location.dart';
import 'task_queue.dart';
import 'task.dart';

mixin Impossible on Object {}

class ImpossibleTaskQueue extends TaskQueue with Impossible {
  @override
  String get id => 'noop';

  @override
  List<Task> get tasks => [];
}

class ImpossibleTask extends Task with Impossible {
  const ImpossibleTask();

  @override
  String get id => 'noop';

  @override
  List<TaskStep> get steps => [];
}

class ImpossibleCharacter extends Character with Impossible {
  const ImpossibleCharacter();

  @override
  String get id => 'noop';
}

class ImpossibleItem extends Item with Impossible {
  const ImpossibleItem(super.count);
}

class ImpossibleLocation extends Location with Impossible {
  const ImpossibleLocation();

  @override
  String get id => 'noop';
}
