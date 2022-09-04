import 'package:akuma/domain/model/location.dart';
import 'package:akuma/domain/service/progression.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class CityController extends GetxController {
  CityController(this._progressionService);

  final PanelController panelController = PanelController();

  final ProgressionService _progressionService;

  Rx<MyLocation> get location => _progressionService.location;

  @override
  void onReady() {
    panelController.open();
    super.onReady();
  }

  void setLocation(Location location) {
    _progressionService.setLocation(location);
    panelController.open();
  }
}
