import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/item.dart';
import '/domain/model/rarity.dart';
import '/theme.dart';
import '/ui/page/home/page/item/view.dart';
import '/ui/widget/button.dart';
import '/util/platform_utils.dart';

enum InventoryCategory {
  weapon,
  equip,
  artifact,
  food,
  stuff,
}

class ItemGrid extends StatelessWidget {
  const ItemGrid({
    Key? key,
    this.category,
    this.items = const [],
    this.filter,
    this.first,
    this.onPressed,
  }) : super(key: key);

  final Iterable<Rx<MyItem>> Function(Iterable<Rx<MyItem>> items)? filter;
  final InventoryCategory? category;
  final Iterable<Rx<MyItem>> items;

  final dynamic first;

  final void Function(dynamic item)? onPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Obx(() {
        Iterable<Rx<MyItem>> iterable = filter?.call(items) ?? {};

        if (filter == null) {
          switch (category) {
            case InventoryCategory.weapon:
              iterable = items.where((e) => e.value is MyWeapon).toList()
                ..sort((a, b) {
                  int levels = (b.value as MyWeapon)
                      .level
                      .compareTo((a.value as MyWeapon).level);

                  if (levels == 0) {
                    return b.value.item.rarity.index
                        .compareTo(a.value.item.rarity.index);
                  }

                  return levels;
                });
              break;

            case InventoryCategory.equip:
              iterable = items.where((e) => e.value is MyEquipable).toList()
                ..sort((a, b) {
                  int levels = (b.value as MyEquipable)
                      .level
                      .compareTo((a.value as MyEquipable).level);

                  if (levels == 0) {
                    return b.value.item.rarity.index
                        .compareTo(a.value.item.rarity.index);
                  }

                  return levels;
                });
              break;

            case InventoryCategory.artifact:
              iterable = items.where((e) => e.value.item is Artifact);
              break;

            case InventoryCategory.food:
              iterable = items.where((e) => e.value.item is Consumable);
              break;

            case InventoryCategory.stuff:
              iterable = items.where((e) =>
                  e.value is! MyWeapon &&
                  e.value is! MyEquipable &&
                  e.value.item is! Artifact &&
                  e.value.item is! Consumable);
              break;

            default:
              iterable = items;
              break;
          }
        }

        if (iterable.isEmpty) {
          return Center(
            key: Key('Category_${category?.name}'),
            child: const Text('Empty'),
          );
        }

        Iterable<dynamic> objects = iterable;
        if (first != null) {
          objects = [
            first,
            ...iterable,
          ];
        }

        int width = context.isMobile ? 80 + 4 : 100 + 8;
        int rows = constraints.maxWidth ~/ width;

        return Center(
          key: Key('Category_${category?.name}'),
          child: ListView.builder(
            itemCount: (objects.length / rows).floor() + 1,
            itemBuilder: (context, i) {
              int from = i * rows;
              int to = min((i + 1) * rows, objects.length);

              return Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: objects.toList().sublist(from, to).map((e) {
                    if (e is Rx<MyItem>) {
                      return WidgetButton(
                        onPressed: () async {
                          if (onPressed != null) {
                            onPressed?.call(e);
                          } else {
                            await ItemView.show(
                                context: context, item: e.value);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(context.isMobile ? 2 : 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              CustomBoxShadow(
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.2),
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                          ),
                          child: Container(
                            width: context.isMobile ? 80 : 100,
                            height: context.isMobile ? 100 : 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  (e.value.item.rarity.color).withOpacity(0.56),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Hero(
                                    tag: e.value.id,
                                    child: Image.asset(
                                      'assets/item/${e.value.item.asset}.png',
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Center(
                                    child: e.value is MyWeapon
                                        ? Text(
                                            'Lv. ${(e.value as MyWeapon).level}',
                                          )
                                        : e.value is MyEquipable
                                            ? Text(
                                                'Lv. ${(e.value as MyEquipable).level}',
                                              )
                                            : Text('${e.value.count}'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return WidgetButton(
                        onPressed: () => onPressed?.call(e),
                        child: Container(
                          margin: EdgeInsets.all(context.isMobile ? 2 : 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              CustomBoxShadow(
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.2),
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                          ),
                          child: Container(
                            width: context.isMobile ? 80 : 100,
                            height: context.isMobile ? 100 : 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.56),
                            ),
                            child: Column(
                              children: [
                                const Expanded(
                                  child: Icon(Icons.remove_circle, size: 48),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: const Center(child: Text('Unequip')),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }).toList(),
                ),
              );
            },
            shrinkWrap: true,
          ),
        );
      });
    });
  }
}
