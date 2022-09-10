import 'package:collection/collection.dart';

import '/domain/model/commission.dart';
import '/domain/model/task.dart';
import 'aloross.dart';

abstract class Commissions {
  static List<QuestCommission> get all => [
        ...AlorossCommissions.tasks,
      ];

  static Task? get(String id) => all.firstWhereOrNull((e) => e.id == id);
}
