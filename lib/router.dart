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

import 'package:akuma/domain/repository/player.dart';
import 'package:akuma/domain/service/player.dart';
import 'package:akuma/provider/hive/player.dart';
import 'package:akuma/store/player.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'domain/model/player.dart';
import 'domain/repository/settings.dart';
import 'domain/service/auth.dart';
import 'provider/hive/application_settings.dart';
import 'store/settings.dart';
import 'ui/page/auth/view.dart';
import 'ui/page/home/router.dart';
import 'ui/page/home/view.dart';
import 'ui/page/introduction/view.dart';
import 'ui/widget/context_menu/overlay.dart';
import 'ui/widget/notification/view.dart';
import 'ui/worker/settings.dart';
import 'util/scoped_dependencies.dart';

/// Application's global router state.
late RouterState router;

/// Application routes names.
class Routes {
  static const auth = '/';
  static const home = '/';
  static const introduction = '/introduction';
  static const settings = '/settings';
  static const dungeon = '/dungeon';
}

/// Application's router state.
///
/// Any change requires [notifyListeners] to be invoked in order for the router
/// to update its state.
class RouterState extends ChangeNotifier {
  RouterState(this._auth) {
    delegate = AppRouterDelegate(this);
    parser = AppRouteInformationParser();
  }

  /// Application's [RouterDelegate].
  late final RouterDelegate<Object> delegate;

  /// Application's [RouteInformationParser].
  late final RouteInformationParser<Object> parser;

  /// Application's optional [RouteInformationProvider].
  ///
  /// [PlatformRouteInformationProvider] is used on null.
  RouteInformationProvider? provider;

  /// This router's global [BuildContext] to use in contextless scenarios.
  BuildContext? context;

  /// Reactive [AppLifecycleState].
  final Rx<AppLifecycleState> lifecycle =
      Rx<AppLifecycleState>(AppLifecycleState.resumed);

  /// Last [Offset] of the pointer determined in [MouseRegion].
  final Rx<Offset?> mousePosition = Rx<Offset?>(null);

  /// Reactive title prefix of the current browser tab.
  final RxnString prefix = RxnString(null);

  /// Dynamic arguments of this [RouterState].
  dynamic arguments;

  /// Auth service used to determine the auth status.
  final AuthService _auth;

  /// Routes history stack.
  List<String> _routes = [];

  /// Current route (last in the [routes] history).
  String get route => _routes.lastOrNull == null ? Routes.home : _routes.last;

  /// Route history stack.
  List<String> get routes => List.unmodifiable(_routes);

  /// Sets the current [route] to [to] if guard allows it.
  ///
  /// Clears the whole [routes] stack.
  void go(String to) {
    arguments = null;
    _routes = [_guarded(to)];
    notifyListeners();
  }

  /// Pushes [to] to the [routes] stack.
  void push(String to) {
    int pageIndex = _routes.indexWhere((e) => e == to);
    if (pageIndex != -1) {
      while (_routes.length - 1 > pageIndex) {
        pop();
      }
    } else {
      _routes.add(_guarded(to));
    }

    notifyListeners();
  }

  /// Removes the last route in the [routes] history.
  ///
  /// If [routes] contain only one record, then removes segments of that record
  /// by `/` if any, otherwise replaces it with [Routes.home].
  void pop([Route? route]) {
    if (_routes.isNotEmpty) {
      if (_routes.length == 1) {
        String name = route?.settings.name ?? _routes.first;
        if (_routes.first == name) {
          String last = _routes.last.split('/').last;
          _routes.last = _routes.last.replaceFirst('/$last', '');
          if (_routes.last == '') {
            _routes.last = Routes.home;
          }
        }
      } else {
        _routes.removeLast();
        if (_routes.isEmpty) {
          _routes.add(Routes.home);
        }
      }

      notifyListeners();
    }
  }

  /// Returns guarded route based on [_auth] status.
  ///
  /// - [Routes.home] is allowed always.
  /// - [Routes.login] is allowed to visit only on no auth status.
  /// - Any other page is allowed to visit only on success auth status.
  String _guarded(String to) {
    switch (to) {
      case Routes.home:
        return to;

      case Routes.introduction:
        return to;

      default:
        if (_auth.status.value.isSuccess) {
          return to;
        } else {
          return route;
        }
    }
  }
}

/// Application's route configuration used to determine the current router state
/// to parse from/to [RouteInformation].
class RouteConfiguration {
  RouteConfiguration(this.route, [this.loggedIn = true]);

  /// Current route as a [String] value.
  ///
  /// e.g. `/auth`, `/chat/0`, etc.
  final String route;

  /// Whether current user is logged in or not.
  bool loggedIn;
}

/// Parses the [RouteConfiguration] from/to [RouteInformation].
class AppRouteInformationParser
    extends RouteInformationParser<RouteConfiguration> {
  @override
  SynchronousFuture<RouteConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) =>
      SynchronousFuture(RouteConfiguration(routeInformation.location!));

  @override
  RouteInformation restoreRouteInformation(RouteConfiguration configuration) {
    String route = configuration.route;
    return RouteInformation(location: route);
  }
}

/// Application's router delegate that builds the root [Navigator] based on
/// the [_state].
class AppRouterDelegate extends RouterDelegate<RouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfiguration> {
  AppRouterDelegate(this._state) {
    _state.addListener(notifyListeners);
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Router's state used to determine current [Navigator]'s pages.
  final RouterState _state;

  @override
  Future<void> setInitialRoutePath(RouteConfiguration configuration) {
    Future.delayed(
        Duration.zero, () => _state.context = navigatorKey.currentContext);
    return setNewRoutePath(configuration);
  }

  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) async {
    _state._routes = [configuration.route];
    _state.notifyListeners();
  }

  @override
  RouteConfiguration get currentConfiguration =>
      RouteConfiguration(_state.route, _state._auth.status.value.isSuccess);

  /// [Navigator]'s pages generation based on the [_state].
  List<Page<dynamic>> get _pages {
    /// [Routes.home] or [Routes.auth] page is always included.
    List<Page<dynamic>> pages = [];

    if (_state._auth.status.value.isSuccess) {
      pages.add(MaterialPage(
        key: const ValueKey('HomePage'),
        name: Routes.home,
        child: HomeView(
          () async {
            ScopedDependencies deps = ScopedDependencies();

            await Future.wait([
              deps.put(PlayerHiveProvider()).init(),
              deps.put(ApplicationSettingsHiveProvider()).init(),
            ]);

            AbstractSettingsRepository settingsRepository =
                deps.put<AbstractSettingsRepository>(
              SettingsRepository(Get.find()),
            );

            // Should be initialized before any [L10n]-dependant entities as
            // it sets the stored [Language] from the [SettingsRepository].
            await deps.put(SettingsWorker(settingsRepository)).init();

            AbstractPlayerRepository playerRepository =
                deps.put<AbstractPlayerRepository>(
              PlayerRepository(
                Get.find(),
                initial: _state.arguments is Player ? _state.arguments : null,
              ),
            );
            deps.put(PlayerService(playerRepository));

            return deps;
          },
        ),
      ));
    } else if (_state.route == Routes.introduction) {
      pages.add(const MaterialPage(
        key: ValueKey('IntroductionPage'),
        name: Routes.introduction,
        child: IntroductionView(),
      ));
    } else {
      pages.add(const MaterialPage(
        key: ValueKey('AuthPage'),
        name: Routes.auth,
        child: AuthView(),
      ));
    }

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return ContextMenuOverlay(
      child: NotificationOverlayView(
        child: Navigator(
          key: navigatorKey,
          pages: _pages,
          onPopPage: (Route<dynamic> route, dynamic result) {
            final bool success = route.didPop(result);
            if (success) {
              _state.pop();
            }
            return success;
          },
        ),
      ),
    );
  }
}

/// [RouterState]'s extension shortcuts on [Routes] constants.
extension RouteLinks on RouterState {
  /// Changes router location to the [Routes.auth] page.
  void auth() => go(Routes.auth);

  /// Changes router location to the [Routes.home] page.
  void home({Player? player}) {
    go(Routes.home);
    arguments = player;
  }

  /// Changes router location to the [Routes.settings] page.
  void settings({bool push = true}) => (push ? this.push : go)(Routes.settings);

  /// Changes router location to the [Routes.introduction] page.
  void introduction() => go(Routes.introduction);

  /// Changes router location to the [Routes.dungeon] page.
  void dungeon() => go(Routes.dungeon);
}
