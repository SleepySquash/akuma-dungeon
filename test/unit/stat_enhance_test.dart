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

import 'package:akuma/domain/model/rarity.dart';
import 'package:akuma/domain/model/stat.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:log_me/log_me.dart';

void main() {
  void checkStat(StatType type) {
    final Stat stat = Stat(type);
    Log.info(stat.improve(Rarity.common));
  }

  test('ATK', () => checkStat(StatType.atk));
}
