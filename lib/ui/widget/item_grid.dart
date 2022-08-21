import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/item.dart';
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
    this.onPressed,
  }) : super(key: key);

  final Iterable<Rx<MyItem>> Function(Iterable<Rx<MyItem>> items)? filter;
  final InventoryCategory? category;
  final Iterable<Rx<MyItem>> items;

  final void Function(Rx<MyItem> item)? onPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Obx(() {
        Iterable<Rx<MyItem>> iterable = filter?.call(items) ?? {};

        if (filter == null) {
          switch (category) {
            case InventoryCategory.weapon:
              iterable = items.where((e) => e.value is MyWeapon);
              break;

            case InventoryCategory.equip:
              iterable = items.where((e) => e.value is MyEquipable);
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

        int width = context.isMobile ? 80 + 4 : 100 + 8;
        int rows = constraints.maxWidth ~/ width;

        return Center(
          key: Key('Category_${category?.name}'),
          child: ListView.builder(
            itemCount: (iterable.length / rows).floor() + 1,
            itemBuilder: (context, i) {
              int from = i * rows;
              int to = min((i + 1) * rows, iterable.length);

              return Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: iterable.toList().sublist(from, to).map((e) {
                    return WidgetButton(
                      onPressed: () async {
                        if (onPressed != null) {
                          onPressed?.call(e);
                        } else {
                          await ItemView.show(context: context, item: e.value);
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
                            color: const Color(0x90DDDDDD),
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
                                          'Lv. ${(e.value as MyWeapon).damage}',
                                        )
                                      : Text('${e.value.count}'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
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
