import 'package:akuma/domain/model/item.dart';
import 'package:akuma/domain/model/item/all.dart';
import 'package:akuma/domain/service/item.dart';
import 'package:decimal/decimal.dart';
import 'package:get/get.dart';

class NaksiasraassBuyController extends GetxController {
  NaksiasraassBuyController(this._itemService);

  final ItemService _itemService;
  final Decimal amount = Decimal.fromInt(10000);

  Decimal get money => _itemService.amount(const Dogecoin());

  void buy() {
    if (money >= amount) {
      _itemService.take(ItemId((const Dogecoin()).id), amount);
    }
  }
}
