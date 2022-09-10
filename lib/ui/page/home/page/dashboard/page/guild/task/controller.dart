import 'dart:async';

import 'package:get/get.dart';

import '/domain/model/commission.dart';
import '/domain/model/location.dart';
import '/domain/service/location.dart';

class TaskController extends GetxController {
  TaskController(this._locationService);

  RxBool ticker = RxBool(false);

  final LocationService _locationService;

  late final Timer _ticker;

  Rx<MyLocation> get location => _locationService.location;

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
