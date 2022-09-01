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

import 'package:collection/collection.dart';

import '/domain/model/item.dart';
import 'standard.dart';

// TODO: Make generator generating `Map`: `{'id': Item()}`.
abstract class Items {
  static List<Item> get all => [
        ...StandardItems.all,
      ];

  static List<Item> get consumable => [
        ...StandardItems.consumable,
      ];

  static List<Item> get weapon => [
        ...StandardItems.weapon,
      ];

  static List<Item> get equipable => [
        ...StandardItems.equipable,
      ];

  static List<Item> get resource => [
        ...StandardItems.resource,
      ];

  static List<Item> get skills => [
        ...StandardItems.skills,
      ];

  static Item? get(String id) => all.firstWhereOrNull((e) => e.id == id);
}
