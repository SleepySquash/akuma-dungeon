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
import 'artifact.dart';
import 'consumable.dart';
import 'equipable.dart';
import 'resource.dart';
import 'weapon.dart';

export 'artifact.dart';
export 'consumable.dart';
export 'equipable.dart';
export 'resource.dart';
export 'weapon.dart';

// TODO: Make generator generating `Map`: `{'id': Item()}`.
abstract class Items {
  static List<Item> get all => [
        ...artifacts,
        ...consumable,
        ...equipable,
        ...resource,
        ...skills,
        ...weapon,
      ];

  static List<Item> get consumable => const [
        AppleGreenItem(),
        AppleRedItem(),
        BananaItem(),
        BeefItem(),
        ChickenItem(),
        RedPotionBigItem(),
        RedPotionMediumItem(),
        RedPotionSmallItem(),
      ];

  static List<Item> get weapon => const [
        BronzeDaggerItem(),
        BronzeSwordItem(),
        IronDaggerItem(),
        PracticeOakSwordItem(),
        PracticeWillowSwordItem(),
      ];

  static List<Item> get equipable => const [
        BootItem(),
        ChainmailBronzeItem(),
        HelmetLightBronzeItem(),
      ];

  static List<Item> get resource => const [
        Dogecoin(),
        HeartCard(),
        Ruby(),
      ];

  static List<Item> get skills => const [
        SwordBookMajor(),
        SwordBookMinor(),
        SwordBookSuperior(),
      ];

  static List<Item> get artifacts => const [
        InitiateFeather(),
        InitiateFlower(),
        AdventurerWatch(),
      ];

  static Item? get(String id) => all.firstWhereOrNull((e) => e.id == id);
}
