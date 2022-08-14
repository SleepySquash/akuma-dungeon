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

import '/domain/model/item.dart';

abstract class StandardItems {
  static List<Item> get all => [
        ...consumable,
      ];

  static List<Item> get consumable => [
        CupcakeItem(),
        DonutItem(),
        CakeItem(),
        IcecreamItem(),
        WaterBottleItem(),
      ];
}

class CupcakeItem extends Item with Eatable {
  CupcakeItem([super.count = 1]);

  @override
  int get hp => 10;
}

class DonutItem extends Item with Eatable {
  DonutItem([super.count = 1]);

  @override
  int get hp => 10;
}

class CakeItem extends Item with Eatable {
  CakeItem([super.count = 1]);

  @override
  int get hp => 50;
}

class IcecreamItem extends Item with Eatable, Drinkable {
  IcecreamItem([super.count = 1]);

  @override
  int get hp => 10;
}

class WaterBottleItem extends Item with Drinkable {
  WaterBottleItem([super.count = 1]);

  @override
  int get hp => 40;
}
