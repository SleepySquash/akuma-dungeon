import 'package:hive_flutter/adapters.dart';

import '/domain/model/gender.dart';
import '/domain/model/player.dart';
import '/domain/model/race.dart';
import 'base.dart';

/// [Hive] storage for a [Player].
class PlayerHiveProvider extends HiveBaseProvider<Player> {
  @override
  Stream<BoxEvent> get boxEvents => box.watch(key: 0);

  @override
  String get boxName => 'player';

  @override
  void registerAdapters() {
    Hive.maybeRegisterAdapter(GenderAdapter());
    Hive.maybeRegisterAdapter(PlayerAdapter());
    Hive.maybeRegisterAdapter(RaceAdapter());
  }

  /// Returns the stored [Player] from the [Hive].
  Player? get() => getSafe(0);

  /// Stores the provided [Player] to the [Hive].
  Future<void> set(Player player) => putSafe(0, player);
}
