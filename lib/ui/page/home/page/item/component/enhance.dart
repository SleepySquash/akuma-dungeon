import 'package:akuma/domain/model/item.dart';
import 'package:akuma/domain/model/stat.dart';
import 'package:akuma/router.dart';
import 'package:akuma/ui/page/home/page/item/widget/enhance_summary.dart';
import 'package:akuma/ui/page/home/widget/wide_button.dart';
import 'package:akuma/ui/widget/backdrop.dart';
import 'package:akuma/ui/widget/item_grid.dart';
import 'package:akuma/util/platform_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class ItemEnhanceTab extends StatelessWidget {
  const ItemEnhanceTab(
    this.c, {
    super.key,
    required this.fading,
    required this.fade,
  });

  final ItemController c;

  final AnimationController fading;
  final Animation<double> fade;

  @override
  Widget build(BuildContext context) {
    InventoryCategory? category;
    Iterable<Rx<MyItem>> Function(Iterable<Rx<MyItem>>)? filter;

    MyArtifact? artifact;
    MyEquipable? equipable;
    MyWeapon? weapon;

    if (c.myItem.value! is MyArtifact) {
      category = InventoryCategory.artifact;
      artifact = c.myItem.value as MyArtifact;
    } else if (c.myItem.value! is MyWeapon) {
      category = InventoryCategory.weapon;
      weapon = c.myItem.value as MyWeapon;
    } else if (c.myItem.value! is MyEquipable) {
      category = InventoryCategory.equip;
      equipable = c.myItem.value as MyEquipable;
    }

    Widget stats() {
      return Obx(() {
        Decimal? exp = artifact?.exp ?? weapon?.exp ?? equipable?.exp;
        Decimal? currentExp =
            artifact?.currentExp ?? weapon?.currentExp ?? equipable?.currentExp;
        Decimal? maxExp =
            weapon?.nextExp ?? equipable?.nextExp ?? artifact?.nextExp;

        Decimal additionalExp = c.selectedItems.exp;

        List<Decimal>? levels =
            artifact?.levels ?? weapon?.levels ?? equipable?.levels;
        int level = artifact?.level ?? weapon?.level ?? equipable?.level ?? 0;
        int nextLevel = (levels?.indexWhere(
                (e) => (exp ?? Decimal.zero) + additionalExp < e) ??
            0);

        final List<Widget> additional = [];
        final List<StatTween> stats = [];
        if (weapon != null) {
          stats.add(
            StatTween(
              Stat.atk(weapon.damages[level]),
              weapon.damages[nextLevel],
            ),
          );
        } else if (equipable != null) {
          stats.add(
            StatTween(
              Stat.def(equipable.defenses[level]),
              equipable.defenses[nextLevel],
            ),
          );
        } else if (artifact != null) {
          stats.add(
            StatTween(
              artifact.stat,
              artifact.stat.constrain(
                nextLevel,
                Artifact.maxLevel,
                artifact.item.rarity,
              ),
            ),
          );

          for (Stat stat in artifact.stats) {
            stats.add(StatTween(stat, stat.amount));
          }

          if (nextLevel > level && artifact.stats.isNotEmpty) {
            int vacant =
                (artifact.item as Artifact).maxStats - artifact.stats.length;
            for (int i = level + 1; i <= nextLevel; ++i) {
              if ((i + 1) % 4 == 0) {
                if (vacant > 0) {
                  additional.add(const Text('+1 new stat'));
                  --vacant;
                } else {
                  additional.add(const Text('+1 stat improvement'));
                }
              }
            }
          }
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (nextLevel != level)
                  Text('Lv. ${level + 1} -> ${nextLevel + 1}')
                else
                  Text('Lv. ${level + 1}'),
                const Spacer(),
                Text('${(currentExp ?? Decimal.zero) + additionalExp}/$maxExp'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('EXP', style: TextStyle(fontSize: 13)),
                const SizedBox(width: 5),
                Expanded(
                  child: LinearProgressIndicator(
                    value: (((currentExp ?? Decimal.zero) + additionalExp) /
                            (maxExp ?? Decimal.one))
                        .toDouble(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...stats.map((e) {
              return Row(
                children: [
                  Text(e.stat.type.localized),
                  const Spacer(),
                  if (e.stat.amount != e.amount)
                    Text('${e.stat.amount} -> ${e.amount}')
                  else
                    Text('${e.stat.amount}'),
                ],
              );
            }),
            ...additional,
          ],
        );
      });
    }

    Widget grid() {
      return Obx(() {
        return ItemGrid(
          key: c.itemsKey.value,
          type: ItemSelectionType.selection,
          heroPrefix: 'enhance',
          items: c.items.values.where((e) => e.value.id != c.myItem.value?.id),
          category: category,
          filter: filter,
          onSelected: (items) {
            c.selectedItems.value = items;
            c.selectedItems.refresh();
          },
        );
      });
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.only(right: context.isMobile ? 40 : 120),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: AnimatedBuilder(
                animation: fading,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: fade,
                    child: Obx(() {
                      return Hero(
                        tag: c.hero ??
                            c.myItem.value?.id ??
                            c.item.value?.id ??
                            '',
                        child: Image.asset(
                          'assets/item/${(c.myItem.value?.item ?? c.item.value)?.asset}.png',
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  AnimatedSize(
                    duration: 300.milliseconds,
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      child: ConditionalBackdropFilter(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: 400,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: DefaultTextStyle.merge(
                            style: const TextStyle(fontSize: 18),
                            child: stats(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(4),
                          child: ConditionalBackdropFilter(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: DefaultTextStyle.merge(
                                style: const TextStyle(fontSize: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Required'),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'assets/item/resource/dogecoin.png',
                                          width: 20,
                                        ),
                                        const SizedBox(width: 4),
                                        Obx(() {
                                          Decimal amount =
                                              c.selectedItems.money;
                                          return Text(
                                            '$amount',
                                            style: TextStyle(
                                              color: c.hasMoney(amount)
                                                  ? Colors.black
                                                  : Colors.red,
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Obx(() {
                          return WideButton(
                            onPressed: c.selectedItems.isNotEmpty
                                ? () {
                                    EnhanceSummary.show(
                                      router.context!,
                                      c.myItem.value!,
                                      c.enhance(),
                                    );

                                    c.selectedItems.clear();
                                    c.itemsKey.value = UniqueKey();
                                  }
                                : null,
                            child: const Text('Enhance'),
                          );
                        }),
                      ],
                    ),
                  ),
                  Expanded(child: grid()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
