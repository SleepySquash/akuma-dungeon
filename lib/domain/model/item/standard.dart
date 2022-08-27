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
import '/domain/model/rarity.dart';
import '/domain/model/stat.dart';

abstract class StandardItems {
  static List<Item> get all => [
        ...consumable,
        ...weapon,
        ...equipable,
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

  static List<Item> get equipable => [
        HelmetLightBronzeItem(),
        ChainmailBronzeItem(),
      ];
}

class AppleGreenItem extends Consumable with Eatable {
  AppleGreenItem([super.count = 1]);

  @override
  String get id => 'apple_green';

  @override
  String get name => 'Зелёное яблоко';

  @override
  int get hp => 1;
}

class AppleRedItem extends Consumable with Eatable {
  AppleRedItem([super.count = 1]);

  @override
  String get id => 'apple_red';

  @override
  String get name => 'Яблоко';

  @override
  int get hp => 1;
}

class BananaItem extends Consumable with Eatable {
  BananaItem([super.count = 1]);

  @override
  String get id => 'banana';

  @override
  String get name => 'Банан';

  @override
  int get hp => 1;
}

class BeefItem extends Consumable with Eatable {
  BeefItem([super.count = 1]);

  @override
  String get id => 'beef';

  @override
  String get name => 'Стейк';

  @override
  int get hp => 5;
}

class ChickenItem extends Consumable with Eatable {
  ChickenItem([super.count = 1]);

  @override
  String get id => 'chicken';

  @override
  String get name => 'Курочка';

  @override
  int get hp => 4;
}

class CarrotItem extends Consumable with Eatable {
  CarrotItem([super.count = 1]);

  @override
  String get id => 'carrot';

  @override
  String get name => 'Морковка';

  @override
  int get hp => 1;
}

class RedPotionSmallItem extends Consumable with Drinkable {
  RedPotionSmallItem([super.count = 1]);

  @override
  String get id => 'potion_red_small';

  @override
  String get name => 'Малое зелье лечения';

  @override
  int get hp => 10;
}

class RedPotionMediumItem extends Consumable with Drinkable {
  RedPotionMediumItem([super.count = 1]);

  @override
  String get id => 'potion_red_medium';

  @override
  String get name => 'Среднее зелье лечения';

  @override
  int get hp => 50;
}

class RedPotionBigItem extends Consumable with Drinkable {
  RedPotionBigItem([super.count = 1]);

  @override
  String get id => 'potion_red_big';

  @override
  String get name => 'Большое зелье лечения';

  @override
  int get hp => 150;
}

class BronzeDaggerItem extends Weapon with Dagger {
  BronzeDaggerItem([super.count = 1]);

  @override
  String get id => 'dagger_bronze';

  @override
  String get name => 'Бронзовый клинок';

  @override
  int get damage => 10;
}

class IronDaggerItem extends Weapon with Dagger {
  IronDaggerItem([super.count = 1]);

  @override
  String get id => 'dagger_iron';

  @override
  String get name => 'Железный клинок';

  @override
  Rarity get rarity => Rarity.useful;

  @override
  int get damage => 50;

  @override
  List<Stat> get stats => [
        const AtkPercentStat(5),
        const DefPercentStat(5),
      ];
}

class PracticeOakSwordItem extends Weapon with Sword {
  PracticeOakSwordItem([super.count = 1]);

  @override
  String get id => 'sword_practice_oak';

  @override
  String get name => 'Деревянный меч';

  @override
  int get damage => 1;
}

class PracticeWillowSwordItem extends Weapon with Sword {
  PracticeWillowSwordItem([super.count = 1]);

  @override
  String get id => 'sword_practice_willow';

  @override
  String get name => 'Деревянный меч из ивы';

  @override
  int get damage => 2;
}

class BronzeSwordItem extends Weapon with Sword {
  BronzeSwordItem([super.count = 1]);

  @override
  String get id => 'sword_bronze';

  @override
  String get name => 'Бронзовый меч';

  @override
  int get damage => 10;
}

class HelmetLightBronzeItem extends Equipable with Head {
  HelmetLightBronzeItem([super.count = 1]);

  @override
  String get id => 'helmet_light_bronze';

  @override
  String get name => 'Лёгкий бронзовый шлем';

  @override
  int get defense => 5;
}

class ChainmailBronzeItem extends Equipable with Armor {
  ChainmailBronzeItem([super.count = 1]);

  @override
  String get id => 'chainmail_bronze';

  @override
  String get name => 'Бронзовая кольчуга';

  @override
  int get defense => 14;
}
