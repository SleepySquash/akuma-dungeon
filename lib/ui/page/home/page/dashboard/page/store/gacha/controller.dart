import 'dart:async';

import 'package:akuma/domain/service/gacha.dart';
import 'package:get/get.dart';

class GachaController extends GetxController {
  GachaController(
    this._gachaService, {
    this.type = GachaType.character,
    this.amount = 1,
  });

  final GachaType type;
  final int amount;

  final RxInt index = RxInt(0);
  final RxBool tapLocked = RxBool(false);

  late final List<dynamic> loot;

  final GachaService _gachaService;

  Timer? _tapTimer;

  @override
  void onInit() {
    loot = _gachaService.get(type: type, amount: amount);
    super.onInit();
  }

  @override
  void onClose() {
    _tapTimer?.cancel();
    super.onClose();
  }

  void lockTap([Duration duration = const Duration(milliseconds: 700)]) {
    tapLocked.value = true;
    _tapTimer?.cancel();
    _tapTimer = Timer(duration, () => tapLocked.value = false);
  }
}
