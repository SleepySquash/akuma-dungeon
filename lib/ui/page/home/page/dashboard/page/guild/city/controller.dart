import 'package:get/get.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '/domain/model/location.dart';
import '/domain/service/location.dart';

class CityController extends GetxController {
  CityController(this._locationService);

  final PanelController panelController = PanelController();

  final LocationService _locationService;

  Rx<MyLocation> get location => _locationService.location;

  @override
  void onReady() {
    panelController.open();
    super.onReady();
  }

  void setLocation(Location location) {
    _locationService.goTo(location);
    panelController.open();
  }
}
