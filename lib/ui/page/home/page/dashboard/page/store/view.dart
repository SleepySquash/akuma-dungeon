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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/service/gacha.dart';
import '/ui/widget/backdrop.dart';
import 'controller.dart';
import 'gacha/view.dart';

class StoreView extends StatelessWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StoreController(Get.find(), Get.find(), Get.find()),
      builder: (StoreController c) {
        return DefaultTabController(
          length: 4,
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
                      // Tab(
                      //   text: 'Featured',
                      //   icon: Icon(Icons.star),
                      //   iconMargin: EdgeInsets.zero,
                      // ),
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
                        text: 'Equipment',
                        icon: Icon(Icons.extension),
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        text: 'Items',
                        icon: Icon(Icons.warehouse),
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
                    children: [
                      // _featured(c, context),
                      _event(c, context),
                      _standard(c, context),
                      _equipment(c, context),
                      _items(c, context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
                  Expanded(child: Image.asset('assets/character/Arda.png')),
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

  Widget _equipment(StoreController c, BuildContext context) {
    return const Text('Equipment');
  }

  Widget _items(StoreController c, BuildContext context) {
    return const Text('Items');
  }

  Widget _tripleLayout({
    Widget? child1,
    Widget? child2,
    Widget? child3,
  }) {
    return LayoutBuilder(builder: (context, constraints) {
      Widget _container(Widget? child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.all(8.0),
          color: Colors.blue,
          child: child,
        );
      }

      if (constraints.maxWidth < 600) {
        return Column(
          children: [
            Expanded(flex: 2, child: _container(child1)),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(flex: 2, child: _container(child2)),
                  Expanded(flex: 1, child: _container(child3)),
                ],
              ),
            ),
          ],
        );
      }

      return Row(
        children: [
          Expanded(flex: 2, child: _container(child1)),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(flex: 2, child: _container(child2)),
                Expanded(flex: 1, child: _container(child3)),
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
