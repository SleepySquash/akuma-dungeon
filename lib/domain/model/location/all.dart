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
import 'package:flutter/material.dart' show IconData, Icons;

import '/domain/model/location.dart';

// TODO: Make generator generating `Map`: `{'id': Location()}`.
abstract class Locations {
  static List<Location> get all => const [
        AlorossLocation(),
        AlorossVillageLocation(),
        CapitalLocation(),
        DarkLandsLocation(),
        LahtaburgLocation(),
      ];

  static Location? get(String id) => all.firstWhereOrNull((e) => e.id == id);
}

class AlorossLocation extends Location {
  const AlorossLocation();

  @override
  String get id => 'aloross';

  @override
  String get name => 'Алоросс';

  @override
  String? get description => 'Небольшой город на границе государства.';

  @override
  String get asset => 'location/town';

  @override
  List<LocationFeature> get features => const [
        AdventurerGuildFeature(),
        RealEstateFeature(),
        StoreFeature(),
      ];

  @override
  IconData get icon => Icons.villa;
}

class AlorossVillageLocation extends Location {
  const AlorossVillageLocation();

  @override
  String get id => 'aloross_village';

  @override
  String get name => 'Деревня Озерище';

  @override
  String? get description => 'Деревня недалеко от Алоросса близ озера.';

  @override
  String get asset => 'dungeon/fields';

  @override
  List<LocationFeature> get features => const [
        RealEstateFeature(type: RealEstateType.villa),
      ];

  @override
  IconData get icon => Icons.house;
}

class CapitalLocation extends Location {
  const CapitalLocation();

  @override
  String get id => 'capital';

  @override
  String get name => 'Столицаград';

  @override
  String? get description => 'Мегаполис-столица государства.';

  @override
  String get asset => 'dungeon/city_street';

  @override
  List<LocationFeature> get features => const [
        AdventurerGuildFeature(),
        RealEstateFeature(),
        StoreFeature(),
      ];

  @override
  IconData get icon => Icons.apartment;
}

class DarkLandsLocation extends Location {
  const DarkLandsLocation();

  @override
  String get id => 'dark_lands';

  @override
  String get name => 'Тёмные земли';

  @override
  String get asset => 'dungeon/destructed_city';

  @override
  IconData get icon => Icons.dark_mode;
}

class LahtaburgLocation extends Location {
  const LahtaburgLocation();

  @override
  String get id => 'lahtaburg';

  @override
  String get name => 'Лахтабург';

  @override
  String get asset => 'dungeon/urban_street';

  @override
  IconData get icon => Icons.sailing;
}
