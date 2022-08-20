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
        ...weapon,
      ];

  static List<Item> get consumable => [
        AppleGreenItem(),
        AppleRedItem(),
        BananaItem(),
        BeefItem(),
        ChickenItem(),
        RedPotionSmallItem(),
        RedPotionMediumItem(),
        RedPotionBigItem(),
      ];

  static List<Item> get weapon => [
        BronzeDaggerItem(),
        IronDaggerItem(),
        PracticeOakSwordItem(),
        PracticeWillowSwordItem(),
        BronzeSwordItem(),
      ];
}

class AppleGreenItem extends Consumable with Eatable {
  AppleGreenItem([super.count = 1]);

  @override
  String get id => 'apple_green';

  @override
  int get hp => 1;
}

class AppleRedItem extends Consumable with Eatable {
  AppleRedItem([super.count = 1]);

  @override
  String get id => 'apple_red';

  @override
  int get hp => 1;
}

class BananaItem extends Consumable with Eatable {
  BananaItem([super.count = 1]);

  @override
  String get id => 'banana';

  @override
  int get hp => 1;
}

class BeefItem extends Consumable with Eatable {
  BeefItem([super.count = 1]);

  @override
  String get id => 'beef';

  @override
  int get hp => 5;
}

class ChickenItem extends Consumable with Eatable {
  ChickenItem([super.count = 1]);

  @override
  String get id => 'chicken';

  @override
  int get hp => 4;
}

class CarrotItem extends Consumable with Eatable {
  CarrotItem([super.count = 1]);

  @override
  String get id => 'carrot';

  @override
  int get hp => 1;
}

class RedPotionSmallItem extends Consumable with Drinkable {
  RedPotionSmallItem([super.count = 1]);

  @override
  String get id => 'potion_red_small';

  @override
  int get hp => 10;
}

class RedPotionMediumItem extends Consumable with Drinkable {
  RedPotionMediumItem([super.count = 1]);

  @override
  String get id => 'potion_red_medium';

  @override
  int get hp => 50;
}

class RedPotionBigItem extends Consumable with Drinkable {
  RedPotionBigItem([super.count = 1]);

  @override
  String get id => 'potion_red_big';

  @override
  int get hp => 150;
}

class BronzeDaggerItem extends Item with Equipable, Weapon, Dagger {
  BronzeDaggerItem([super.count = 1]);

  @override
  String get id => 'dagger_bronze';

  @override
  int get damage => 10;
}

class IronDaggerItem extends Item with Equipable, Weapon, Dagger {
  IronDaggerItem([super.count = 1]);

  @override
  String get id => 'dagger_iron';

  @override
  int get damage => 50;
}

class PracticeOakSwordItem extends Item with Equipable, Weapon, Sword {
  PracticeOakSwordItem([super.count = 1]);

  @override
  String get id => 'sword_practice_oak';

  @override
  int get damage => 1;
}

class PracticeWillowSwordItem extends Item with Equipable, Weapon, Sword {
  PracticeWillowSwordItem([super.count = 1]);

  @override
  String get id => 'sword_practice_willow';

  @override
  int get damage => 2;
}

class BronzeSwordItem extends Item with Equipable, Weapon, Sword {
  BronzeSwordItem([super.count = 1]);

  @override
  String get id => 'sword_bronze';

  @override
  int get damage => 10;
}
