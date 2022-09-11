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

class Dogecoin extends Item {
  const Dogecoin([super.count = 1]);

  @override
  String get id => 'dogecoin';

  @override
  String get asset => 'resource/$id';

  @override
  String get name => 'Dogecoin';
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
}

class SwordBookMinor extends Item {
  const SwordBookMinor([super.count = 1]);

  @override
  String get id => 'spell_sword_minor';

  @override
  String get asset => 'skill/$id';

  @override
  String get name => 'Чтиво Меча';

  @override
  String get description =>
      'В ней содержится достаточно знаний, чтобы научиться махать мечом.';
}

class SwordBookMajor extends Item {
  const SwordBookMajor([super.count = 1]);

  @override
  String get id => 'spell_sword_major';

  @override
  String get asset => 'skill/$id';

  @override
  String get name => 'Книга Меча';

  @override
  String get description => 'Техники, приёмы, всё об искусстве меча от А до Я.';

  @override
  Rarity get rarity => Rarity.useful;
}

class SwordBookSuperior extends Item {
  const SwordBookSuperior([super.count = 1]);

  @override
  String get id => 'spell_sword_superior';

  @override
  String get asset => 'skill/$id';

  @override
  String get name => 'Мемуары Меча';

  @override
  String get description => 'Стань мечом.';

  @override
  Rarity get rarity => Rarity.rare;
}
