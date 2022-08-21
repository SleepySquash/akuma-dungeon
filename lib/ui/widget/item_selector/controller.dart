import 'package:get/get.dart';

import '/domain/service/item.dart';
import '/domain/model/item.dart';
import '/util/obs/obs.dart';

class ItemSelectorController extends GetxController {
  ItemSelectorController(this._itemService);

  final ItemService _itemService;

  RxObsMap<String, Rx<MyItem>> get items => _itemService.items;
}
