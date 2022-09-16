import 'package:akuma/domain/model/character.dart';
import 'package:akuma/domain/model/character/standard.dart';
import 'package:akuma/domain/model/item.dart';
import 'package:akuma/domain/model/item/all.dart';
import 'package:akuma/domain/service/character.dart';
import 'package:akuma/domain/service/item.dart';
import 'package:akuma/domain/service/player.dart';
import 'package:get/get.dart';

class NaksiasraassBuyController extends GetxController {
  NaksiasraassBuyController(this._itemService);

  final ItemService _itemService;
  final int amount = 10000;

  int get money => _itemService.amount(const Dogecoin());

  void buy() {
    if (money >= amount) {
      _itemService.take(ItemId((const Dogecoin()).id), 10000);
    }
  }
}
