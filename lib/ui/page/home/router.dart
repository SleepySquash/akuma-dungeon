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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '/domain/model/dungeon.dart';
import '/router.dart';
import 'page/dashboard/view.dart';
import 'page/dungeon/entrance/view.dart';
import 'page/dungeon/view.dart';

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
      } else if (route == Routes.dungeon) {
        DungeonSettings? settings =
            _state.arguments?['args'] as DungeonSettings?;
        void Function()? onClear =
            _state.arguments?['onClear'] as FutureOr<void> Function()?;
        PageTransitionType? transition =
            _state.arguments?['transition'] as PageTransitionType?;

        if (settings == null) {
          pages.add(TransitionPage(
            child: Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: Center(
                child: Text(
                    '${_state.arguments} is not a subtype of DungeonSettings, as it must be'),
              ),
            ),
          ));
        } else {
          if (transition == null) {
            pages.add(MaterialPage(
              key: const ValueKey('DungeonPage'),
              name: Routes.dungeon,
              child: DungeonView(settings: settings, onClear: onClear),
            ));
          } else {
            pages.add(TransitionPage(
              key: const ValueKey('DungeonPage'),
              type: transition,
              name: Routes.dungeon,
              child: DungeonView(settings: settings, onClear: onClear),
            ));
          }
        }
      } else if (route == Routes.entrance) {
        DungeonSettings? settings =
            _state.arguments?['args'] as DungeonSettings?;
        String? asset = _state.arguments?['asset'] as String?;
        void Function()? onClear =
            _state.arguments?['onClear'] as FutureOr<void> Function()?;

        if (settings == null || asset == null) {
          pages.add(TransitionPage(
            child: Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: Center(
                child: Text(
                    '${_state.arguments} is not a subtype of DungeonSettings, as it must be'),
              ),
            ),
          ));
        } else {
          pages.add(TransitionPage(
            key: const ValueKey('EntrancePage'),
            name: Routes.entrance,
            child: DungeonEntranceView(
              settings: settings,
              asset: asset,
              onClear: onClear,
            ),
          ));
        }
      } else if (route == Routes.nowhere) {
        pages.add(TransitionPage(
          key: const ValueKey('NowherePage'),
          name: Routes.nowhere,
          child: Container(color: Colors.black),
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
    return HeroControllerScope(
      controller: HeroController(),
      child: Navigator(
        key: navigatorKey,
        pages: _pages,
        onPopPage: (route, result) {
          _state.pop(route);
          notifyListeners();
          return route.didPop(result);
        },
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) async {
    // This is not required for inner router delegate because it doesn't parse
    // routes.
    assert(false, 'unexpected setNewRoutePath() call');
  }
}

class TransitionPage<T> extends Page<T> {
  const TransitionPage({
    required this.child,
    this.type = PageTransitionType.fade,
    this.maintainState = true,
    this.fullscreenDialog = false,
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
  }) : super(
          key: key,
          name: name,
          arguments: arguments,
          restorationId: restorationId,
        );

  /// The content to be shown in the [Route] created by this page.
  final Widget child;

  /// {@macro flutter.widgets.ModalRoute.maintainState}
  final bool maintainState;

  /// {@macro flutter.widgets.PageRoute.fullscreenDialog}
  final bool fullscreenDialog;

  final PageTransitionType type;

  @override
  Route<T> createRoute(BuildContext context) {
    return PageTransition(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      curve: Curves.ease,
      type: type,
      settings: this,
      child: child,
    );
  }
}
