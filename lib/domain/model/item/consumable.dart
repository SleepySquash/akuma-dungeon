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

class AppleGreenItem extends Consumable with Eatable {
  const AppleGreenItem([super.count = 1]);

  @override
  String get id => 'apple_green';

  @override
  String get name => 'Зелёное яблоко';

  @override
  int get hp => 1;
}

class AppleRedItem extends Consumable with Eatable {
  const AppleRedItem([super.count = 1]);

  @override
  String get id => 'apple_red';

  @override
  String get name => 'Яблоко';

  @override
  int get hp => 1;
}

class BananaItem extends Consumable with Eatable {
  const BananaItem([super.count = 1]);

  @override
  String get id => 'banana';

  @override
  String get name => 'Банан';

  @override
  int get hp => 1;
}

class BeefItem extends Consumable with Eatable {
  const BeefItem([super.count = 1]);

  @override
  String get id => 'beef';

  @override
  String get name => 'Стейк';

  @override
  int get hp => 5;
}

class ChickenItem extends Consumable with Eatable {
  const ChickenItem([super.count = 1]);

  @override
  String get id => 'chicken';

  @override
  String get name => 'Курочка';

  @override
  int get hp => 4;
}

class CarrotItem extends Consumable with Eatable {
  const CarrotItem([super.count = 1]);

  @override
  String get id => 'carrot';

  @override
  String get name => 'Морковка';

  @override
  int get hp => 1;
}

class RedPotionSmallItem extends Consumable with Drinkable {
  const RedPotionSmallItem([super.count = 1]);

  @override
  String get id => 'potion_red_small';

  @override
  String get name => 'Малое зелье лечения';

  @override
  int get hp => 10;

  @override
  Rarity get rarity => Rarity.common;
}

class RedPotionMediumItem extends Consumable with Drinkable {
  const RedPotionMediumItem([super.count = 1]);

  @override
  String get id => 'potion_red_medium';

  @override
  String get name => 'Среднее зелье лечения';

  @override
  int get hp => 50;

  @override
  Rarity get rarity => Rarity.useful;
}

class RedPotionBigItem extends Consumable with Drinkable {
  const RedPotionBigItem([super.count = 1]);

  @override
  String get id => 'potion_red_big';

  @override
  String get name => 'Большое зелье лечения';

  @override
  int get hp => 150;

  @override
  Rarity get rarity => Rarity.rare;
}
