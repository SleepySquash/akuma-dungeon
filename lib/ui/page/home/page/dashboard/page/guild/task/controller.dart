import 'dart:async';

import 'package:get/get.dart';

import '/domain/model/commission.dart';
import '/domain/model/flag.dart';
import '/domain/model/location.dart';
import '/domain/service/flag.dart';
import '/domain/service/location.dart';
import '/util/obs/obs.dart';

class TaskController extends GetxController {
  TaskController(this._flagService, this._locationService);

  RxBool ticker = RxBool(false);

  final FlagService _flagService;
  final LocationService _locationService;

  late final Timer _ticker;

  Rx<MyLocation> get location => _locationService.location;
  RxObsMap<Flag, bool> get flags => _flagService.flags;

  @override
  void onInit() {
    _ticker = Timer.periodic(1.seconds, (_) => ticker.toggle());
    super.onInit();
  }

  @override
  void onClose() {
    _ticker.cancel();
    super.onClose();
  }

  void accept(MyCommission commission) =>
      _locationService.acceptCommission(commission);
  void finish(MyCommission commission) =>
      _locationService.finishCommission(commission);
}
