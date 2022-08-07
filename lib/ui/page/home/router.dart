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

import '/router.dart';
import 'page/dashboard/view.dart';
import 'page/dungeon/view.dart';
import 'page/settings/view.dart';

/// [Routes.home] page [RouterDelegate] that builds the nested [Navigator].
///
/// [HomeRouterDelegate] doesn't parses any routes. Instead, it only uses the
/// [RouterState] passed to its constructor.
class HomeRouterDelegate extends RouterDelegate<RouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfiguration> {
  HomeRouterDelegate(this._state) {
    _state.addListener(notifyListeners);
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Router's application state that reflects the navigation.
  final RouterState _state;

  /// [Navigator]'s pages generation based on the [_state].
  List<Page<dynamic>> get _pages {
    /// [_NestedHomeView] is always included.
    List<Page<dynamic>> pages = [];

    for (String route in _state.routes) {
      if (route == Routes.home) {
        pages.add(const MaterialPage(
          key: ValueKey('DashboardPage'),
          name: Routes.home,
          child: DashboardView(),
        ));
      } else if (route == Routes.settings) {
        pages.add(const MaterialPage(
          key: ValueKey('SettingsPage'),
          name: Routes.settings,
          child: SettingsView(),
        ));
      } else if (route == Routes.dungeon) {
        pages.add(const MaterialPage(
          key: ValueKey('DungeonPage'),
          name: Routes.dungeon,
          child: DungeonView(),
        ));
      }
    }

    if (pages.isEmpty) {
      return [
        const MaterialPage(
          child: Scaffold(
            body: Center(child: Text('Not found :(')),
          ),
        )
      ];
    }

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _pages,
      onPopPage: (route, result) {
        _state.pop(route);
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) async {
    // This is not required for inner router delegate because it doesn't parse
    // routes.
    assert(false, 'unexpected setNewRoutePath() call');
  }
}
