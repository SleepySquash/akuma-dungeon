import 'package:get/get.dart';

import '/domain/model/flag.dart';
import '/domain/repository/flag.dart';
import '/util/obs/obs.dart';

class FlagService extends DisposableInterface {
  FlagService(this._flagRepository);

  final AbstractFlagRepository _flagRepository;

  RxObsMap<Flag, bool> get flags => _flagRepository.flags;

  bool get(Flag flag) => _flagRepository.get(flag);

  Future<void> set(Flag flag, bool value) => _flagRepository.set(flag, value);
}
