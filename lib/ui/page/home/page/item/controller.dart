// Copyright © 2022 NIKITA ISAENKO, <https://github.com/SleepySquash>
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU Affero General Public License v3.0 as published by the
// Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License v3.0 for
// more details.
//
// You should have received a copy of the GNU Affero General Public License v3.0
// along with this program. If not, see
// <https://www.gnu.org/licenses/agpl-3.0.html>.

import 'package:get/get.dart';

import '/domain/model/item.dart';
import '/ui/widget/item_grid.dart' show InventoryCategory;

class ItemController extends GetxController {
  ItemController(
    MyItem item, {
    this.exchangeItemSettings,
  }) : item = Rx(item);

  final Rx<MyItem> item;
  final ExchangeItemSettings? exchangeItemSettings;
}

class ExchangeItemSettings {
  const ExchangeItemSettings({
    this.category,
    this.filter,
    this.onExchange,
  });

  final void Function(MyItem? item)? onExchange;
  final InventoryCategory? category;
  final Iterable<Rx<MyItem>> Function(Iterable<Rx<MyItem>> items)? filter;
}
