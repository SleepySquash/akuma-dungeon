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
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show NotificationResponse;
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:media_kit/media_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

import 'domain/service/auth.dart';
import 'domain/service/notification.dart';
import 'l10n/l10n.dart';
import 'provider/hive/credentials.dart';
import 'router.dart';
import 'theme.dart';
import 'util/web/web.dart';

/// Entry point of this application.
void main() async {
  MediaKit.ensureInitialized();

  await _initHive();

  Get.put(NotificationService())
      .init(onNotificationResponse: onNotificationResponse);

  var authService = Get.put(AuthService(Get.find()));
  await authService.init();

  await L10n.init();

  router = RouterState(authService);

  runApp(const App());
}

/// Callback, triggered when an user taps on a notification.
///
/// Must be a top level function.
void onNotificationResponse(NotificationResponse response) {
  if (response.payload != null) {}
}

/// Implementation of this application.
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      routerDelegate: router.delegate,
      routeInformationParser: router.parser,
      routeInformationProvider: router.provider,
      onGenerateTitle: (context) => 'Akuma',
      theme: Themes.light(),
      darkTheme: Themes.dark(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Initializes a [Hive] storage and registers a [CredentialsHiveProvider] in
/// the [Get]'s context.
Future<void> _initHive() async {
  await Hive.initFlutter('hive');
  await Get.put(CredentialsHiveProvider()).init();
}

/// Extension adding an ability to clean [Hive].
extension HiveClean on HiveInterface {
  /// Cleans the [Hive] data stored at the provided [path] on non-web platforms
  /// and the whole `IndexedDB` on a web platform.
  Future<void> clean(String path) async {
    if (GetPlatform.isWeb) {
      await WebUtils.cleanIndexedDb();
    } else {
      try {
        await Hive.deleteFromDisk();
      } catch (_) {
        // No-op.
      }

      var documents = (await getApplicationDocumentsDirectory()).path;
      try {
        await Directory('$documents/$path').delete(recursive: true);
      } on FileSystemException {
        // No-op.
      }
    }
  }
}
