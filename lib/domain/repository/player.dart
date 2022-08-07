import 'package:get/get.dart';

import '/domain/model/player.dart';

abstract class AbstractPlayerRepository {
  Rx<Player?> get player;

  void set(Player player);
  void addExperience(int amount);
  void addMoney(int amount);
}
