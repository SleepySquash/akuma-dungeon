import 'dart:math';

import 'package:decimal/decimal.dart';
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

enum ItemSelectionType {
  single,
  selection,
}

class ItemGrid extends StatefulWidget {
  const ItemGrid({
    Key? key,
    this.category,
    this.items = const [],
    this.filter,
    this.first,
    this.heroPrefix,
    this.type = ItemSelectionType.single,
    this.onPressed,
    this.onSelected,
  }) : super(key: key);

  final Iterable<Rx<MyItem>> Function(Iterable<Rx<MyItem>> items)? filter;

  final InventoryCategory? category;

  final Iterable<Rx<MyItem>> items;

  final String? heroPrefix;

  final dynamic first;

  final ItemSelectionType type;

  final void Function(dynamic item)? onPressed;
  final void Function(List<SelectedItem> items)? onSelected;

  @override
  State<ItemGrid> createState() => ItemGridState();
}

class ItemGridState extends State<ItemGrid> {
  final List<SelectedItem> selected = [];

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const Center(child: Text('Empty'));
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Obx(() {
        Iterable<Rx<MyItem>> iterable = widget.filter?.call(widget.items) ?? {};

        if (widget.filter == null) {
          switch (widget.category) {
            case InventoryCategory.weapon:
              iterable = widget.items.where((e) => e.value is MyWeapon).toList()
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
              iterable =
                  widget.items.where((e) => e.value is MyEquipable).toList()
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
              iterable = widget.items.where((e) => e.value is MyArtifact);
              break;

            case InventoryCategory.food:
              iterable = widget.items.where((e) => e.value.item is Consumable);
              break;

            case InventoryCategory.stuff:
              iterable = widget.items.where((e) =>
                  e.value is! MyWeapon &&
                  e.value is! MyEquipable &&
                  e.value is! MyArtifact &&
                  e.value.item is! Consumable);
              break;

            default:
              iterable = widget.items;
              break;
          }
        }

        if (iterable.isEmpty) {
          return Center(
            key: Key('Category_${widget.category?.name}'),
            child: const Text('Empty'),
          );
        }

        Iterable<dynamic> objects = iterable;
        if (widget.first != null) {
          objects = [widget.first, ...iterable];
        }

        int width = context.isMobile ? 80 + 4 : 100 + 8;
        int rows = constraints.maxWidth ~/ width;

        return Center(
          key: Key('Category_${widget.category?.name}'),
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
                      SelectedItem? item = selected.firstWhereOrNull(
                          (m) => m.item.value.id == e.value.id);
                      return Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(context.isMobile ? 2 : 4),
                            child: _item(e),
                          ),
                          Positioned.fill(
                            child: IgnorePointer(
                              child: AnimatedContainer(
                                duration: 150.milliseconds,
                                margin:
                                    EdgeInsets.all(context.isMobile ? 2 : 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: item == null
                                      ? null
                                      : Border.all(
                                          color: Colors.green, width: 4),
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: AnimatedSwitcher(
                              duration: 150.milliseconds,
                              child: item == null
                                  ? Container()
                                  : Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 20,
                                        margin: const EdgeInsets.only(
                                          right: 2,
                                          top: 2,
                                        ),
                                        padding: const EdgeInsets.fromLTRB(
                                          4,
                                          2,
                                          4,
                                          2,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.green,
                                        ),
                                        child: Text(
                                          '${item.count}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          Positioned.fill(
                            child: AnimatedSwitcher(
                              duration: 150.milliseconds,
                              child: item == null
                                  ? Container()
                                  : Align(
                                      alignment: Alignment.topLeft,
                                      child: WidgetButton(
                                        onPressed: () {
                                          item.count -= Decimal.one;
                                          if (item.count <= Decimal.zero) {
                                            selected.remove(item);
                                          }

                                          widget.onSelected?.call(selected);

                                          setState(() {});
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.red,
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return _unequip();
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

  Widget _item(Rx<MyItem> e) {
    return WidgetButton(
      onPressed: () async {
        switch (widget.type) {
          case ItemSelectionType.single:
            if (widget.onPressed != null) {
              widget.onPressed?.call(e);
            } else {
              await ItemView.show(
                context: context,
                myItem: e.value,
              );
            }
            break;

          case ItemSelectionType.selection:
            SelectedItem? item =
                selected.firstWhereOrNull((m) => m.item.value.id == e.value.id);

            if (item != null) {
              if (item.count < e.value.count) {
                item.count += Decimal.one;
                widget.onSelected?.call(selected);
              }
            } else {
              selected.add(SelectedItem(e));
              widget.onSelected?.call(selected);
            }

            setState(() {});
            break;
        }
      },
      child: Container(
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
            color: (e.value.item.rarity.color).withOpacity(0.56),
          ),
          child: Column(
            children: [
              Expanded(
                child: Hero(
                  tag: widget.heroPrefix == null
                      ? e.value.id
                      : '${widget.heroPrefix}${e.value.id}',
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
                child: Obx(() {
                  MyItem item = e.value;

                  String subtitle;
                  if (item is MyWeapon) {
                    subtitle = 'Lv. ${item.level + 1}';
                  } else if (item is MyEquipable) {
                    subtitle = 'Lv. ${item.level + 1}';
                  } else if (item is MyArtifact) {
                    subtitle = 'Lv. ${item.level + 1}';
                  } else {
                    subtitle = '${e.value.count}';
                  }

                  return Center(child: Text(subtitle));
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _unequip() {
    return WidgetButton(
      onPressed: () => widget.onPressed?.call(widget.first),
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
}

class SelectedItem {
  SelectedItem(this.item);
  final Rx<MyItem> item;
  Decimal count = Decimal.one;
}
