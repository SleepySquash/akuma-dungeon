import 'package:akuma/ui/widget/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/util/platform_utils.dart';
import 'controller.dart';
import 'page/guild/view.dart';
import 'page/dash/view.dart';
import 'page/profile/view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashboardController(),
      builder: (DashboardController c) {
        return LayoutBuilder(builder: (context, constraints) {
          c.isMobile.value = context.isMobile;
          int _selectedIndex(MainTab value) {
            switch (value) {
              case MainTab.guild:
                return context.isMobile ? 0 : 1;

              case MainTab.dash:
                return context.isMobile ? 1 : 0;

              case MainTab.profile:
                return 2;
            }
          }

          void _pageChanged(int i) {
            switch (i) {
              case 0:
                c.selected.value =
                    context.isMobile ? MainTab.guild : MainTab.dash;
                break;

              case 1:
                c.selected.value =
                    context.isMobile ? MainTab.dash : MainTab.guild;
                break;

              case 2:
                c.selected.value = MainTab.profile;
                break;

              default:
                break;
            }
          }

          void _destinationSelected(int i) {
            switch (i) {
              case 0:
                c.pageController.jumpToPage(context.isMobile ? 0 : 0);
                break;

              case 1:
                c.pageController.jumpToPage(context.isMobile ? 1 : 1);
                break;

              case 2:
                c.pageController.jumpToPage(2);
                break;
            }
          }

          List<Widget> _pages() {
            if (context.isMobile) {
              return const [
                GuildView(key: Key('GuildView')),
                DashView(key: Key('DashView')),
                ProfileView(key: Key('ProfileView'))
              ];
            } else {
              return const [
                DashView(key: Key('DashView')),
                GuildView(key: Key('GuildView')),
                ProfileView(key: Key('ProfileView'))
              ];
            }
          }

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
                                  backgroundColor:
                                      Colors.white.withOpacity(0.4),
                                  selectedIndex:
                                      _selectedIndex(c.selected.value),
                                  onDestinationSelected: _destinationSelected,
                                  labelType: NavigationRailLabelType.selected,
                                  destinations: const [
                                    NavigationRailDestination(
                                      selectedIcon: Icon(Icons.home),
                                      icon: Icon(Icons.home_outlined),
                                      label: Text('Home'),
                                    ),
                                    NavigationRailDestination(
                                      selectedIcon: Icon(Icons.church),
                                      icon: Icon(Icons.church_outlined),
                                      label: Text('Guild'),
                                    ),
                                    NavigationRailDestination(
                                      selectedIcon: Icon(Icons.person),
                                      icon: Icon(Icons.person_outline),
                                      label: Text('Party'),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          Expanded(
                            child: PageView(
                              controller: c.pageController,
                              scrollDirection: context.isMobile
                                  ? Axis.horizontal
                                  : Axis.vertical,
                              onPageChanged: _pageChanged,
                              children: _pages(),
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
                            selectedIndex: _selectedIndex(c.selected.value),
                            onDestinationSelected: _destinationSelected,
                            destinations: const [
                              NavigationDestination(
                                selectedIcon: Icon(Icons.church),
                                icon: Icon(Icons.church_outlined),
                                label: 'Guild',
                              ),
                              NavigationDestination(
                                selectedIcon: Icon(Icons.home),
                                icon: Icon(Icons.home_outlined),
                                label: 'Home',
                              ),
                              NavigationDestination(
                                selectedIcon: Icon(Icons.person),
                                icon: Icon(Icons.person_outline),
                                label: 'Profile',
                              ),
                            ],
                          ),
                        );
                      }),
                  ],
                ),
              )
            ],
          );
        });
      },
    );
  }
}
