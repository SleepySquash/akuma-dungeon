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
import '/domain/model/stat.dart';

class HelmetLightBronzeItem extends Equipable with Head {
  const HelmetLightBronzeItem([super.count = 1]);

  @override
  String get id => 'helmet_light_bronze';

  @override
  String get name => 'Лёгкий бронзовый шлем';

  @override
  Decimal get defense => Decimal.fromInt(5);
}

class ChainmailBronzeItem extends Equipable with Armor {
  const ChainmailBronzeItem([super.count = 1]);

  @override
  String get id => 'chainmail_bronze';

  @override
  String get name => 'Бронзовая кольчуга';

  @override
  Decimal get defense => Decimal.fromInt(14);
}

class BootItem extends Equipable with Shoes {
  const BootItem([super.count = 1]);

  @override
  String get id => 'boot';

  @override
  String get name => 'Лёгкие ботинки';

  @override
  Decimal get defense => Decimal.fromInt(4);
}
