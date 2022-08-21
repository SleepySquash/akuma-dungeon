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

import 'package:akuma/domain/model/item.dart';
import 'package:akuma/domain/model/rank.dart';
import 'package:akuma/domain/model/rarity.dart';
import 'package:akuma/theme.dart';
import 'package:akuma/ui/page/home/page/character/view.dart';
import 'package:akuma/ui/page/home/page/item/view.dart';
import 'package:akuma/ui/widget/backdrop.dart';
import 'package:akuma/ui/widget/button.dart';
import 'package:akuma/util/platform_utils.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/widget/dummy_character.dart';
import 'controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileController(Get.find(), Get.find()),
      builder: (ProfileController c) {
        return Obx(() {
          Widget child;

          switch (c.tab.value) {
            case ProfileTab.attributes:
              Widget _equip({
                String? asset,
                required String title,
                List<String> subtitle = const [],
                Rarity? rarity,
                String? lvl,
              }) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(8, 4, 0, 4),
                  child: ConditionalBackdropFilter(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: 210,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          if (asset == null)
                            const Icon(
                              Icons.library_add,
                              size: 42,
                              color: Colors.black,
                            )
                          else
                            Image.asset('assets/item/$asset.png'),
                          if (asset == null)
                            Expanded(
                              child: Center(
                                child: Text(
                                  title,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              Widget _stats() {
                return Container(
                  margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                  child: ConditionalBackdropFilter(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: DefaultTextStyle.merge(
                        style: const TextStyle(fontSize: 18),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Text('ATK'),
                                Spacer(),
                                Text('20'),
                              ],
                            ),
                            Row(
                              children: const [
                                Text('DEF'),
                                Spacer(),
                                Text('12'),
                              ],
                            ),
                            Row(
                              children: const [
                                Text('HP'),
                                Spacer(),
                                Text('504'),
                              ],
                            ),
                            Row(
                              children: const [
                                Text('CRIT DMG'),
                                Spacer(),
                                Text('40%'),
                              ],
                            ),
                            Row(
                              children: const [
                                Text('CRIT Rate'),
                                Spacer(),
                                Text('4%'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              Widget _name() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 4, 8, 0),
                      child: ConditionalBackdropFilter(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: DefaultTextStyle.merge(
                            style: const TextStyle(fontSize: 18),
                            child:
                                Text(c.player.value?.rank.toRank.name ?? '...'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 4, 8, 0),
                      child: ConditionalBackdropFilter(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: DefaultTextStyle.merge(
                            style: const TextStyle(fontSize: 18),
                            child: Text('Lv. ${c.player.value?.level ?? 0}'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 4, 8, 8),
                      child: ConditionalBackdropFilter(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: DefaultTextStyle.merge(
                            style: const TextStyle(fontSize: 18),
                            child: Text(c.player.value?.name ?? '...'),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              child = Stack(
                children: [
                  Obx(() {
                    return Align(
                      alignment:
                          FractionalOffset(context.isMobile ? 1 : 0.5, 0.5),
                      child: DummyCharacter(
                        race: c.player.value!.race,
                        gender: c.player.value!.gender,
                      ),
                    );
                  }),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (context.isMobile) const Spacer(),
                          _equip(title: 'Головняк'),
                          _equip(title: 'Броник'),
                          _equip(title: 'Обувка'),
                          _equip(title: 'Оружие'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _stats(),
                              Flexible(child: _name()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
              break;

            case ProfileTab.inventory:
              child = DefaultTabController(
                length: 5,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: PreferredSize(
                    preferredSize: const Size(double.infinity, 56),
                    child: ConditionalBackdropFilter(
                      child: AppBar(
                        backgroundColor: Colors.white.withOpacity(0.4),
                        automaticallyImplyLeading: false,
                        title: const TabBar(
                          unselectedLabelColor: Colors.black54,
                          labelColor: Colors.black,
                          tabs: [
                            Tab(
                              text: 'Weapon',
                              icon: Icon(Icons.swipe_rounded),
                            ),
                            Tab(
                              text: 'Equip',
                              icon: Icon(Icons.accessibility_new),
                            ),
                            Tab(
                              text: 'Artifact',
                              icon: Icon(Icons.dashboard),
                            ),
                            Tab(
                              text: 'Food',
                              icon: Icon(Icons.fastfood),
                            ),
                            Tab(
                              text: 'Staff',
                              icon: Icon(Icons.auto_awesome),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  body: SafeArea(
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: context.isMobile ? 40 : 120),
                      child: TabBarView(
                        children: [
                          _buildItems(c, context, InventoryCategory.weapon),
                          _buildItems(c, context, InventoryCategory.equip),
                          _buildItems(c, context, InventoryCategory.artifact),
                          _buildItems(c, context, InventoryCategory.food),
                          _buildItems(c, context, InventoryCategory.stuff),
                        ],
                      ),
                    ),
                  ),
                ),
              );
              break;

            case ProfileTab.constellation:
              child = const Center(child: Text('Constellation'));
              break;

            case ProfileTab.skills:
              child = const Center(child: Text('Skills'));
              break;
          }

          return Stack(
            children: [
              AnimatedSwitcher(
                duration: 300.milliseconds,
                switchInCurve: Curves.easeOutQuad,
                switchOutCurve: Curves.easeInQuad,
                transitionBuilder: (child, animation) => SlideTransition(
                  position:
                      Tween(begin: const Offset(0, -0.2), end: Offset.zero)
                          .animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                ),
                child: KeyedSubtree(key: Key(c.tab.value.name), child: child),
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
                          context: context,
                          onTap: () => c.tab.value = ProfileTab.attributes,
                          selected: c.tab.value == ProfileTab.attributes,
                          desktop: const Text('Attributes'),
                          mobile: const Icon(Icons.person),
                        );
                      }),
                      const SizedBox(height: 10),
                      Obx(() {
                        return _tab(
                          context: context,
                          onTap: () => c.tab.value = ProfileTab.inventory,
                          selected: c.tab.value == ProfileTab.inventory,
                          desktop: const Text('Inventory'),
                          mobile: const Icon(Icons.inventory, size: 20),
                        );
                      }),
                      const SizedBox(height: 10),
                      Obx(() {
                        return _tab(
                          context: context,
                          onTap: () => c.tab.value = ProfileTab.constellation,
                          selected: c.tab.value == ProfileTab.constellation,
                          desktop: const Text('Constellation'),
                          mobile: const Icon(Icons.upgrade),
                        );
                      }),
                      const SizedBox(height: 10),
                      Obx(() {
                        return _tab(
                          context: context,
                          onTap: () => c.tab.value = ProfileTab.skills,
                          selected: c.tab.value == ProfileTab.skills,
                          desktop: const Text('Skills'),
                          mobile: const Icon(Icons.accessibility),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  Widget _tab({
    required BuildContext context,
    Widget? child,
    Widget? desktop,
    Widget? mobile,
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
          width: context.isMobile ? 40 : 120,
          height: 40,
          child: Theme(
            data: ThemeData(
              iconTheme:
                  IconThemeData(color: selected ? Colors.white : Colors.blue),
            ),
            child: DefaultTextStyle.merge(
              style: TextStyle(color: selected ? Colors.white : null),
              child: Center(
                child: context.isMobile ? mobile ?? child : desktop ?? child,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItems(
    ProfileController c,
    BuildContext context,
    InventoryCategory category,
  ) {
    return LayoutBuilder(builder: (context, constraints) {
      return Obx(() {
        Iterable<Rx<MyItem>> items = {};

        switch (category) {
          case InventoryCategory.weapon:
            items = c.items.values.where((e) => e.value is MyWeapon);
            break;

          case InventoryCategory.equip:
            items = c.items.values.where((e) => e.value is MyEquipable);
            break;

          case InventoryCategory.artifact:
            items = c.items.values.where((e) => e.value.item is Artifact);
            break;

          case InventoryCategory.food:
            items = c.items.values.where((e) => e.value.item is Consumable);
            break;

          case InventoryCategory.stuff:
            items = c.items.values.where((e) =>
                e.value is! MyWeapon &&
                e.value is! MyEquipable &&
                e.value.item is! Artifact &&
                e.value.item is! Consumable);
            break;
        }

        if (items.isEmpty) {
          return Center(
            key: Key(category.name),
            child: const Text('Empty'),
          );
        }

        int width = context.isMobile ? 80 + 4 : 100 + 8;
        int rows = constraints.maxWidth ~/ width;

        return Center(
          key: Key(category.name),
          child: ListView.builder(
            itemCount: (c.items.length / rows).floor() + 1,
            itemBuilder: (context, i) {
              int from = i * rows;
              int to = min((i + 1) * rows, c.items.length);

              return Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: c.items.values.toList().sublist(from, to).map((e) {
                    return WidgetButton(
                      onPressed: () =>
                          ItemView.show(context: context, item: e.value),
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
