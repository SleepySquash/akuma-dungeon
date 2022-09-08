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

import 'dart:math';

import 'package:akuma/domain/model/stat.dart';
import 'package:get/get.dart';

import '/domain/model/item.dart';
import '/domain/repository/item.dart';
import '/util/obs/obs.dart';

class ItemService extends GetxService {
  ItemService(this._itemRepository);

  final AbstractItemRepository _itemRepository;

  RxObsMap<ItemId, Rx<MyItem>> get items => _itemRepository.items;

  void add(Item item, [int amount = 1]) => _itemRepository.add(item, amount);
  void update(MyItem item) => _itemRepository.update(item);
  void take(ItemId id, [int amount = 1]) => _itemRepository.take(id, amount);
  int amount(Item item) => _itemRepository.amount(item);

  EnhanceResult? enhance(MyItem item, int exp) {
    Rx<MyItem>? myItem = items[item.id];

    if (myItem != null) {
      StatTween? stat;
      List<StatTween> stats = [];

      final List<Stat> additional = [];

      if (myItem.value is MyArtifact) {
        MyArtifact artifact = myItem.value as MyArtifact;

        stat =
            StatTween.unchanged(Stat(artifact.stat.type, artifact.stat.amount));
        stats = artifact.stats
            .map((e) => StatTween.unchanged(Stat(e.type, e.amount)))
            .toList();

        int previous = artifact.level;
        artifact.exp += exp;
        int next = artifact.level;

        if (next != previous) {
          if (artifact.stats.isNotEmpty) {
            int vacant =
                (artifact.item as Artifact).maxStats - artifact.stats.length;
            for (int i = previous + 1; i <= next; ++i) {
              if ((i + 1) % 4 == 0) {
                if (vacant > 0) {
                  List<Stat> resolved =
                      (artifact.item as Artifact).stats.resolve(
                    1,
                    [artifact.stat.type, ...artifact.stats.map((e) => e.type)],
                  );
                  if (resolved.isNotEmpty) {
                    artifact.stats.addAll(resolved);
                    additional.addAll(resolved);
                  }
                  --vacant;
                } else {
                  if (artifact.stats.isNotEmpty) {
                    int i = Random().nextInt(artifact.stats.length);
                    Stat stat = artifact.stats[i];

                    stat.amount =
                        stat.amount + stat.improve(artifact.item.rarity);

                    stats[i].amount = stat.amount;
                  }
                }
              }
            }
          }

          artifact.stat.amount = artifact.stat.constrain(
            artifact.level,
            Artifact.maxLevel,
            artifact.item.rarity,
          );
          stat.amount = artifact.stat.amount;
        }

        update(artifact);
      } else if (myItem.value is MyEquipable) {
        MyEquipable equipable = myItem.value as MyEquipable;

        stat = StatTween.unchanged(Stat.def(equipable.defense));
        stats = [];

        equipable.exp += exp;
        stat.amount = equipable.defense;

        update(equipable);
      } else if (myItem.value is MyWeapon) {
        MyWeapon weapon = myItem.value as MyWeapon;
        stat = StatTween.unchanged(Stat.atk(weapon.damage));
        stats = [];

        weapon.exp += exp;
        stat.amount = weapon.damage;

        update(weapon);
      }

      myItem.refresh();

      return EnhanceResult(stat: stat, stats: stats, additional: additional);
    }

    return null;
  }
}

class EnhanceResult {
  EnhanceResult({
    this.stat,
    this.stats = const [],
    this.additional = const [],
  });

  final StatTween? stat;
  final List<StatTween> stats;
  final List<Stat> additional;
}
