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

class BronzeDaggerItem extends Weapon with Dagger {
  const BronzeDaggerItem([super.count = 1]);

  @override
  String get id => 'dagger_bronze';

  @override
  String get name => 'Бронзовый клинок';

  @override
  Decimal get damage => Decimal.fromInt(10);
}

class IronDaggerItem extends Weapon with Dagger {
  const IronDaggerItem([super.count = 1]);

  @override
  String get id => 'dagger_iron';

  @override
  String get name => 'Железный клинок';

  @override
  Rarity get rarity => Rarity.useful;

  @override
  Decimal get damage => Decimal.fromInt(50);

  @override
  List<Stat> get stats => [
        Stat.atkPercent(Decimal.fromInt(5)),
        Stat.defPercent(Decimal.fromInt(5)),
      ];
}

class PracticeOakSwordItem extends Weapon with Sword {
  const PracticeOakSwordItem([super.count = 1]);

  @override
  String get id => 'sword_practice_oak';

  @override
  String get name => 'Деревянный меч';

  @override
  Decimal get damage => Decimal.fromInt(1);

  @override
  Decimal? get price => Decimal.fromInt(1600);
}

class PracticeWillowSwordItem extends Weapon with Sword {
  const PracticeWillowSwordItem([super.count = 1]);

  @override
  String get id => 'sword_practice_willow';

  @override
  String get name => 'Деревянный меч из ивы';

  @override
  Decimal get damage => Decimal.fromInt(2);

  @override
  Decimal? get price => Decimal.fromInt(6000);
}

class BronzeSwordItem extends Weapon with Sword {
  const BronzeSwordItem([super.count = 1]);

  @override
  String get id => 'sword_bronze';

  @override
  String get name => 'Бронзовый меч';

  @override
  Decimal get damage => Decimal.fromInt(10);

  @override
  Decimal? get price => Decimal.fromInt(30000);
}
