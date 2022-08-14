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

import 'package:flutter/material.dart' show Color, Colors;

enum Rarity {
  junk,
  common,
  useful,
  rare,
  superRare,
  ultraRare,
  extraRare,
  unique,
}

extension ColorFromRarity on Rarity {
  Color get color {
    switch (this) {
      case Rarity.junk:
        return Colors.grey;

      case Rarity.common:
        return const Color(0xFFF0F0F0);

      case Rarity.useful:
        return Colors.green;

      case Rarity.rare:
        return Colors.blue;

      case Rarity.superRare:
        return Colors.purple;

      case Rarity.ultraRare:
        return const Color(0xFFFFBC2D);

      case Rarity.extraRare:
        return const Color(0xFFFF00BF);

      case Rarity.unique:
        return const Color(0xFFFF1100);
    }
  }
}
