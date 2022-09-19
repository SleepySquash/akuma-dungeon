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

import 'package:akuma/domain/model/flag.dart';
import 'package:akuma/ui/page/home/widget/backdrop_plate.dart';
import 'package:akuma/ui/page/home/widget/menu_tile.dart';
import 'package:akuma/ui/page/home/widget/wide_button.dart';
import 'package:akuma/ui/widget/item_grid.dart';
import 'package:akuma/ui/widget/locked.dart';
import 'package:akuma/util/platform_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/service/gacha.dart';
import '/ui/widget/backdrop.dart';
import 'controller.dart';
import 'gacha/view.dart';

class StoreView extends StatefulWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StoreController(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        tabController: _tabController,
      ),
      builder: (StoreController c) {
        return Obx(() {
          return LockedWidget(
            locked: !c.flags.storeUnlocked,
            borderRadius: BorderRadius.zero,
            additional: const [
              Flexible(
                child: BackdropPlate(
                  width: 500,
                  child: Text(
                    'Выполни `Первое подземелье` основной сюжетной линии',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                preferredSize: const Size(double.infinity, 56),
                child: ConditionalBackdropFilter(
                  child: AppBar(
                    backgroundColor: Colors.white.withOpacity(0.4),
                    automaticallyImplyLeading: false,
                    title: TabBar(
                      controller: c.tabController,
                      unselectedLabelColor: Colors.black54,
                      labelColor: Colors.black,
                      tabs: const [
                        Tab(
                          text: 'Featured',
                          icon: Icon(Icons.star),
                          iconMargin: EdgeInsets.zero,
                        ),
                        Tab(
                          text: 'Event',
                          icon: Icon(Icons.event),
                          iconMargin: EdgeInsets.zero,
                        ),
                        Tab(
                          text: 'Standard',
                          icon: Icon(Icons.face),
                          iconMargin: EdgeInsets.zero,
                        ),
                        Tab(
                          text: 'Buy',
                          icon: Icon(Icons.attach_money),
                          iconMargin: EdgeInsets.zero,
                        ),
                        Tab(
                          text: 'Sell',
                          icon: Icon(Icons.money_off),
                          iconMargin: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: Stack(
                children: [
                  Positioned.fill(child: Obx(() {
                    return Image.asset(
                      'assets/background/${c.location.value.location.asset}.jpg',
                      fit: BoxFit.cover,
                    );
                  })),
                  SafeArea(
                    child: TabBarView(
                      controller: c.tabController,
                      children: [
                        _featured(c, context),
                        LockedWidget(
                          locked: !c.flags.gachaUnlocked,
                          borderRadius: BorderRadius.zero,
                          additional: const [
                            Flexible(
                              child: BackdropPlate(
                                width: 500,
                                child: Text(
                                  'Выполни `Первое подземелье` основной сюжетной линии',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                          child: _event(c, context),
                        ),
                        LockedWidget(
                          locked: !c.flags.gachaUnlocked,
                          borderRadius: BorderRadius.zero,
                          additional: const [
                            Flexible(
                              child: BackdropPlate(
                                width: 500,
                                child: Text(
                                  'Выполни `Первое подземелье` основной сюжетной линии',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                          child: _standard(c, context),
                        ),
                        _buy(c, context),
                        _sell(c, context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget _featured(StoreController c, BuildContext context) {
    return _tripleLayout(
      child1: MenuTile(
        locked: !c.flags.gachaUnlocked,
        onPressed: () => c.tabController.animateTo(1),
        child: const Text('Recruit'),
      ),
      child2: MenuTile(
        onPressed: () => c.tabController.animateTo(3),
        child: const Text('Buy'),
      ),
      child3: MenuTile(
        onPressed: () => c.tabController.animateTo(4),
        child: const Text('Sell'),
      ),
    );
  }

  Widget _event(StoreController c, BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          Widget child;

          if (c.eventTab.value) {
            child = Container(
              key: const Key('EventCharacterBanner'),
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(16),
              color: Colors.blue,
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset('assets/item/weapon/sword_iron.png'),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: const [
                        ListTile(title: Text('+ 10 ещё!')),
                        ListTile(
                          title:
                              Text('Каждое 80-е оружие - гарантированно SSR'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            child = Container(
              key: const Key('EventWeaponBanner'),
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(16),
              color: Colors.blue,
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/character/Arda.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: const [
                        ListTile(title: Text('+ 10 ещё!')),
                        ListTile(
                          title:
                              Text('Каждый 80-й персонаж - гарантированно SSR'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }

          return AnimatedSwitcher(
            duration: 600.milliseconds,
            switchInCurve: Curves.easeOutQuad,
            switchOutCurve: Curves.easeInQuad,
            transitionBuilder: (child, animation) => SlideTransition(
              position: Tween(begin: const Offset(0, -0.2), end: Offset.zero)
                  .animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: child,
          );
        }),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.fromLTRB(8, 0, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 0),
                        child: Image.asset('assets/item/misc/card_heart.png'),
                      ),
                      const SizedBox(width: 0),
                      Text(
                        '${c.heartCards}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.fromLTRB(8, 0, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, -1),
                        child: Image.asset('assets/item/resource/ruby_2.png'),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${c.rubies}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 64),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  return _tab(
                    onTap: () => c.eventTab.value = false,
                    selected: c.eventTab.isFalse,
                    child: const Text('Character'),
                  );
                }),
                const SizedBox(height: 10),
                Obx(() {
                  return _tab(
                    onTap: () => c.eventTab.value = true,
                    selected: c.eventTab.isTrue,
                    child: const Text('Weapon'),
                  );
                }),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32, right: 32),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => GachaView(
                        type: c.eventTab.isTrue
                            ? GachaType.weapon
                            : GachaType.character,
                        amount: 10,
                      ),
                    );
                  },
                  child: const Text('Крутить x10'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      useSafeArea: false,
                      useRootNavigator: true,
                      barrierDismissible: false,
                      builder: (context) => GachaView(
                        type: c.eventTab.isTrue
                            ? GachaType.weapon
                            : GachaType.character,
                        amount: 1,
                      ),
                    );
                  },
                  child: const Text('Крутить x1'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _standard(StoreController c, BuildContext context) {
    return const Text('Standard');
  }

  Widget _buy(StoreController c, BuildContext context) {
    List<Widget> children = [
      Expanded(
        child: Obx(() {
          return ListView(
            children: c.range.map((e) {
              return ListTile(
                leading: Image.asset('assets/item/${e.asset}.png'),
                title: Text(e.name),
                trailing: Text('${e.price}'),
                onTap: () => c.selectedItem.value = e,
              );
            }).toList(),
          );
        }),
      ),
      Obx(() {
        Widget child = SizedBox(
          width: context.isMobile ? double.infinity : 0,
          height: context.isMobile ? 0 : double.infinity,
        );

        if (c.selectedItem.value != null) {
          child = Stack(
            children: [
              Container(
                width: 200,
                height: 300,
                color: Colors.red,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/item/${c.selectedItem.value!.asset}.png',
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(c.selectedItem.value!.name),
                          if (c.selectedItem.value!.description != null)
                            Text(c.selectedItem.value!.description!),
                          WideButton(
                            onPressed: () {
                              if (c.money > c.selectedItem.value!.price!) {
                                c.buy();
                              }
                            },
                            child: const Text('Buy'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => c.selectedItem.value = null,
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ],
          );
        }

        return AnimatedSize(duration: 300.milliseconds, child: child);
      }),
    ];

    return Flex(
      direction: context.isMobile ? Axis.vertical : Axis.horizontal,
      children: context.isMobile ? children.reversed.toList() : children,
    );
  }

  Widget _sell(StoreController c, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            return ItemGrid(
              key: c.itemsKey.value,
              type: ItemSelectionType.selection,
              items: c.items.values.where((e) => e.value.item.price != null),
              category: c.itemsCategory.value,
              onSelected: (items) {
                c.selectedItems.value = items;
                c.selectedItems.refresh();
              },
            );
          }),
        ),
        Row(
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
                        const Text('Total'),
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
                              Decimal amount = c.selectedItems.price;
                              return Text(
                                '$amount',
                                style: const TextStyle(color: Colors.black),
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
                        c.sell();
                        c.selectedItems.clear();
                        c.itemsKey.value = UniqueKey();
                      }
                    : null,
                child: const Text('Sell'),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _tripleLayout({
    Widget? child1,
    Widget? child2,
    Widget? child3,
  }) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return Column(
          children: [
            Expanded(flex: 2, child: child1 ?? Container()),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(flex: 2, child: child2 ?? Container()),
                  Expanded(flex: 1, child: child3 ?? Container()),
                ],
              ),
            ),
          ],
        );
      }

      return Row(
        children: [
          Expanded(flex: 2, child: child1 ?? Container()),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(flex: 2, child: child2 ?? Container()),
                Expanded(flex: 1, child: child3 ?? Container()),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _tab({
    required Widget child,
    final void Function()? onTap,
    bool selected = false,
  }) {
    return Material(
      type: MaterialType.card,
      elevation: 4,
      shadowColor: Colors.black,
      color: selected ? Colors.blue : Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        child: SizedBox(
          width: 128,
          height: 40,
          child: DefaultTextStyle.merge(
            style: TextStyle(color: selected ? Colors.white : null),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
