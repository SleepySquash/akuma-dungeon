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

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/widget/backdrop.dart';
import '/util/platform_utils.dart';
import 'controller.dart';
import 'page/dash/view.dart';
import 'page/guild/view.dart';
import 'page/party/view.dart';
import 'page/profile/view.dart';
import 'page/store/view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashboardController(Get.find()),
      builder: (DashboardController c) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/background/room/renovation.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (!context.isMobile)
                          Obx(() {
                            return ConditionalBackdropFilter(
                              child: NavigationRail(
                                backgroundColor: Colors.white.withOpacity(0.4),
                                selectedIndex: c.selected.value.index,
                                onDestinationSelected: (i) =>
                                    c.pageController.jumpToPage(i),
                                labelType: NavigationRailLabelType.selected,
                                destinations: MainTab.values.map((e) {
                                  switch (e) {
                                    case MainTab.dash:
                                      return const NavigationRailDestination(
                                        selectedIcon: Icon(Icons.home),
                                        icon: Icon(Icons.home_outlined),
                                        label: Text('Home'),
                                      );

                                    case MainTab.party:
                                      return const NavigationRailDestination(
                                        selectedIcon: Icon(Icons.people),
                                        icon: Icon(Icons.people_outline),
                                        label: Text('Party'),
                                      );

                                    case MainTab.guild:
                                      return NavigationRailDestination(
                                        selectedIcon: Obx(() {
                                          return Badge(
                                            showBadge:
                                                c.completedTasks.value != 0,
                                            badgeContent: Text(
                                              '${c.completedTasks.value}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: const Icon(Icons.church),
                                          );
                                        }),
                                        icon: Obx(() {
                                          return Badge(
                                            showBadge:
                                                c.completedTasks.value != 0,
                                            badgeContent: Text(
                                              '${c.completedTasks.value}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.church_outlined,
                                            ),
                                          );
                                        }),
                                        label: const Text('Guild'),
                                      );

                                    case MainTab.store:
                                      return const NavigationRailDestination(
                                        selectedIcon: Icon(Icons.store),
                                        icon: Icon(Icons.store_outlined),
                                        label: Text('Store'),
                                      );

                                    case MainTab.profile:
                                      return const NavigationRailDestination(
                                        selectedIcon: Icon(Icons.person),
                                        icon: Icon(Icons.person_outline),
                                        label: Text('Me'),
                                      );
                                  }
                                }).toList(),
                              ),
                            );
                          }),
                        Expanded(
                          child: PageView(
                            controller: c.pageController,
                            scrollDirection: context.isMobile
                                ? Axis.horizontal
                                : Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            onPageChanged: (i) =>
                                c.selected.value = MainTab.values[i],
                            children: MainTab.values.map((e) {
                              switch (e) {
                                case MainTab.dash:
                                  return const DashView();

                                case MainTab.party:
                                  return const PartyView();

                                case MainTab.guild:
                                  return const GuildView();

                                case MainTab.store:
                                  return const StoreView();

                                case MainTab.profile:
                                  return const ProfileView();
                              }
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (context.isMobile)
                    Obx(() {
                      return ConditionalBackdropFilter(
                        child: NavigationBar(
                          labelBehavior: NavigationDestinationLabelBehavior
                              .onlyShowSelected,
                          backgroundColor: Colors.white.withOpacity(0.4),
                          selectedIndex: c.selected.value.index,
                          onDestinationSelected: (i) =>
                              c.pageController.jumpToPage(i),
                          destinations: MainTab.values.map((e) {
                            switch (e) {
                              case MainTab.dash:
                                return const NavigationDestination(
                                  selectedIcon: Icon(Icons.home),
                                  icon: Icon(Icons.home_outlined),
                                  label: 'Home',
                                );

                              case MainTab.party:
                                return const NavigationDestination(
                                  selectedIcon: Icon(Icons.people),
                                  icon: Icon(Icons.people_outline),
                                  label: 'Party',
                                );

                              case MainTab.guild:
                                return NavigationDestination(
                                  selectedIcon: Obx(() {
                                    return Badge(
                                      showBadge: c.completedTasks.value != 0,
                                      badgeContent: Text(
                                        '${c.completedTasks.value}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: const Icon(Icons.church),
                                    );
                                  }),
                                  icon: Obx(() {
                                    return Badge(
                                      showBadge: c.completedTasks.value != 0,
                                      badgeContent: Text(
                                        '${c.completedTasks.value}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.church_outlined,
                                      ),
                                    );
                                  }),
                                  label: 'Guild',
                                );

                              case MainTab.store:
                                return const NavigationDestination(
                                  selectedIcon: Icon(Icons.store),
                                  icon: Icon(Icons.store_outlined),
                                  label: 'Store',
                                );

                              case MainTab.profile:
                                return const NavigationDestination(
                                  selectedIcon: Icon(Icons.person),
                                  icon: Icon(Icons.person_outline),
                                  label: 'Me',
                                );
                            }
                          }).toList(),
                        ),
                      );
                    }),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
