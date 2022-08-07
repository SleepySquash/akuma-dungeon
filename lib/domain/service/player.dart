import 'package:get/get.dart';

import '/domain/model/player.dart';
import '/domain/repository/player.dart';

class PlayerService extends GetxService {
  PlayerService(this._playerRepository);

  final AbstractPlayerRepository _playerRepository;

  Rx<Player?> get player => _playerRepository.player;

  void set(Player player) => _playerRepository.set(player);
  void addExperience(int amount) => _playerRepository.addExperience(amount);
  void addMoney(int amount) => _playerRepository.addMoney(amount);
}
