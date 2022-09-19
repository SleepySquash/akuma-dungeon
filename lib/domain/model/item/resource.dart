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

import 'package:decimal/decimal.dart';

import '/domain/model/item.dart';
import '/domain/model/rarity.dart';

class Dogecoin extends Item {
  const Dogecoin([super.count = 1]);

  @override
  String get id => 'dogecoin';

  @override
  String get asset => 'resource/$id';

  @override
  String get name => 'Dogecoin';

  @override
  Decimal? get price => null;
}

class Ruby extends Item {
  const Ruby([super.count = 1]);

  @override
  String get id => 'ruby';

  @override
  String get asset => 'resource/ruby_2';

  @override
  String get name => 'Рубин';

  @override
  String get description =>
      'Очень ценный камень, который любой торговец с удовольствием обменяет на очень полезные предметы.';

  @override
  Rarity get rarity => Rarity.rare;

  @override
  Decimal? get price => null;
}

class HeartCard extends Item {
  const HeartCard([super.count = 1]);

  @override
  String get id => 'card_heart';

  @override
  String get asset => 'misc/$id';

  @override
  String get name => 'Карта черви';

  @override
  String get description => 'Быть может, удача ляжет нужной стороной?';

  @override
  Rarity get rarity => Rarity.superRare;

  @override
  Decimal? get price => null;
}

class SlimeCondensateItem extends Item {
  const SlimeCondensateItem([super.count = 1]);

  @override
  String get id => 'Slime Condensate';

  @override
  String get asset => 'resource/$id';

  @override
  String get name => 'Slime Condensate';

  @override
  String get description =>
      'A thick coating found on slimes. Most commonly seen material in elemental workshops.';

  @override
  Rarity get rarity => Rarity.common;
}

class SlimeSecretionsItem extends Item {
  const SlimeSecretionsItem([super.count = 1]);

  @override
  String get id => 'Slime Secretions';

  @override
  String get asset => 'resource/$id';

  @override
  String get name => 'Slime Secretions';

  @override
  String get description =>
      'Mildly purified slime secretions. Harmful to the skin. Please avoid direct exposure.';

  @override
  Rarity get rarity => Rarity.useful;
}

class SlimeConcentrateItem extends Item {
  const SlimeConcentrateItem([super.count = 1]);

  @override
  String get id => 'Slime Concentrate';

  @override
  String get asset => 'resource/$id';

  @override
  String get name => 'Slime Concentrate';

  @override
  String get description =>
      'Concentrated slime essence. When left alone, it will begin to move on its own.';

  @override
  Rarity get rarity => Rarity.rare;
}
