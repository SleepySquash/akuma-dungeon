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

import '/domain/model/flag.dart';
import '/domain/repository/flag.dart';
import '/provider/hive/flag.dart';
import '/util/obs/obs.dart';

class FlagRepository extends DisposableInterface
    implements AbstractFlagRepository {
  FlagRepository(this._local);

  @override
  final RxObsMap<Flag, bool> flags = RxObsMap();

  final FlagHiveProvider _local;

  @override
  void onInit() {
    for (Flag flag in Flag.values) {
      flags[flag] = _local.get(flag) ?? false;
    }

    super.onInit();
  }

  @override
  bool get(Flag flag) => _local.get(flag) ?? false;

  @override
  Future<void> set(Flag flag, bool value) {
    flags[flag] = value;
    flags.refresh();
    return _local.put(flag, value);
  }
}
