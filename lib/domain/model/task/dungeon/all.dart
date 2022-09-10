import 'package:collection/collection.dart';

import '/domain/model/commission.dart';
import '/domain/model/task.dart';
import 'aloross.dart';

abstract class Dungeons {
  static List<DungeonCommission> get all => [
        ...AlorossDungeons.all,
      ];

  static Task? get(String id) => all.firstWhereOrNull((e) => e.id == id);
}
