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

import 'dart:async' show Timer;
import 'dart:math';

import 'package:flutter/widgets.dart' show IconData;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '/util/obs/obs.dart';
import '/util/web/web.dart';

/// Service responsible for notifications management.
class NotificationService extends DisposableInterface {
  final RxObsList<LocalNotification> notifications = RxObsList();
  final RxObsList<LocalNotification> centered = RxObsList();
  final RxObsList<LocalNotification> additions = RxObsList();

  static const Duration notificationDuration = Duration(seconds: 5);

  final List<Timer> _timers = [];

  /// Instance of a [FlutterLocalNotificationsPlugin] used to send notifications
  /// on non-web platforms.
  FlutterLocalNotificationsPlugin? _plugin;

  /// Initializes this [NotificationService].
  ///
  /// Requests permission to send notifications if it hasn't been granted yet.
  ///
  /// Optional [onNotificationResponse] callback is called when user taps on a
  /// notification.
  ///
  /// Optional [onDidReceiveLocalNotification] callback is called
  /// when a notification is triggered while the app is in the foreground and is
  /// only applicable to iOS versions older than 10.
  Future<void> init({
    void Function(NotificationResponse)? onNotificationResponse,
    void Function(int, String?, String?, String?)?
        onDidReceiveLocalNotification,
  }) async {
    if (GetPlatform.isWeb) {
      // Permission request is happening in `index.html` via a script tag due to
      // a browser's policy to ask for notifications permission only after
      // user's interaction.
      WebUtils.onSelectNotification = onNotificationResponse;
    } else {
      if (_plugin == null) {
        tz.initializeTimeZones();

        _plugin = FlutterLocalNotificationsPlugin();
        await _plugin!.initialize(
          InitializationSettings(
            android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: DarwinInitializationSettings(
              onDidReceiveLocalNotification: onDidReceiveLocalNotification,
            ),
            macOS: const DarwinInitializationSettings(),
            linux:
                const LinuxInitializationSettings(defaultActionName: 'click'),
          ),
          onDidReceiveNotificationResponse: onNotificationResponse,
          onDidReceiveBackgroundNotificationResponse: onNotificationResponse,
        );
      }
    }
  }

  @override
  void onClose() {
    for (var t in _timers) {
      t.cancel();
    }

    super.onClose();
  }

  /// Shows a notification with a [title] and an optional [body] and [icon].
  ///
  /// Use [payload] to embed information into the notification.
  Future<void> show(
    String title, {
    String? body,
    String? payload,
    String? icon,
  }) async {
    if (GetPlatform.isWeb) {
      WebUtils.showNotification(
        title,
        body: body,
        lang: payload,
        icon: icon,
      ).onError((_, __) => false);
    } else {
      await _plugin?.show(
        Random().nextInt(1 << 31),
        title,
        body,
        const NotificationDetails(
          android:
              AndroidNotificationDetails('com.sleepysquash.akuma', 'akuma'),
        ),
        payload: payload,
      );
    }
  }

  Future<void> schedule(
    String title, {
    required Duration at,
    int id = 0,
    String? body,
    String? payload,
    String? icon,
  }) async {
    await _plugin?.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(at),
      const NotificationDetails(
        android: AndroidNotificationDetails('com.sleepysquash.akuma', 'akuma'),
      ),
      androidAllowWhileIdle: false,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancel(int id) async {
    await _plugin?.cancel(id);
  }

  void notify(LocalNotification notification) {
    Timer? timer;

    switch (notification.type) {
      case LocalNotificationType.common:
        notifications.add(notification);
        timer = Timer(notification.duration ?? notificationDuration, () {
          notifications.remove(notification);
          _timers.remove(timer);
        });
        break;

      case LocalNotificationType.centered:
        centered.add(notification);
        timer = Timer(notification.duration ?? notificationDuration, () {
          centered.remove(notification);
          _timers.remove(timer);
        });
        break;

      case LocalNotificationType.addition:
        additions.add(notification);
        timer = Timer(notification.duration ?? notificationDuration, () {
          additions.remove(notification);
          _timers.remove(timer);
        });
        break;
    }

    _timers.add(timer);
  }
}

enum LocalNotificationType {
  common,
  centered,
  addition,
}

class LocalNotification {
  const LocalNotification({
    this.title,
    this.subtitle,
    this.icon,
    this.type = LocalNotificationType.common,
    this.duration,
  });

  final String? title;
  final String? subtitle;
  final IconData? icon;
  final LocalNotificationType type;
  final Duration? duration;
}
