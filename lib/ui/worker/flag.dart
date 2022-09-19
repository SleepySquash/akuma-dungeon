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
import 'package:get/get.dart';

import '/domain/model/flag.dart';
import '/util/message_popup.dart';
import '/domain/service/flag.dart';
import '/domain/service/notification.dart';
import '/util/obs/obs.dart';

class FlagWorker extends DisposableInterface {
  FlagWorker(
    this._flagService,
    this._notificationService,
  );

  final FlagService _flagService;
  final NotificationService _notificationService;

  final Map<Flag, bool> _values = {};

  StreamSubscription? _subscription;

  @override
  void onInit() {
    _values.addAll(_flagService.flags);

    _subscription = _flagService.flags.changes.listen((e) {
      switch (e.op) {
        case OperationKind.added:
          _values[e.key!] = e.value ?? false;
          if (e.value == true) {
            _notify(e.key!);
          }
          break;

        case OperationKind.removed:
          _values.remove(e.key);
          break;

        case OperationKind.updated:
          if (_values[e.key!] != e.value && e.value == true) {
            _notify(e.key!);
          }

          _values[e.key!] = e.value ?? false;
          break;
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  void _notify(Flag flag) {
    String title = '$flag';
    String description = 'Малаца';
    IconData? icon;

    switch (flag) {
      case Flag.commissionUnlocked:
        title = 'Поручения разблокированы';
        icon = Icons.task;
        description =
            'Теперь ты можешь:\n\n- принимать квесты;\n- сдавать квесты;\n- получать награды.';
        break;

      case Flag.dungeonCommissionsUnlocked:
        title = 'Поручения-данжы разблокированы';
        icon = Icons.task;
        description =
            'Теперь ты можешь:\n\n- закрывать данжи;\n- получать награды.';
        break;

      case Flag.dungeonsUnlocked:
        title = 'Подземелья разблокированы';
        icon = Icons.cabin;
        description =
            'Теперь ты можешь:\n\n- фармить ресурсы для прокачки;\n- фармить ресурсы для крафта;\n- фармить артефакты;\n- фармить реликвии.';
        break;

      case Flag.goddessTowerUnlocked:
        title = 'Башня Богини разблокирована';
        icon = Icons.cell_tower;
        description = 'Теперь ты можешь напасть на измерение Акумы.';
        break;

      case Flag.locationsUnlocked:
        title = 'Карта разблокирована';
        icon = Icons.map;
        description = 'Теперь ты можешь путешествовать по миру.';
        break;

      case Flag.partyUnlocked:
        title = 'Пати разблокирована';
        icon = Icons.people;
        description = 'Теперь ты можешь формировать свой отряд.';
        break;

      case Flag.storeUnlocked:
        title = 'Магазины разлокированы';
        icon = Icons.store;
        description =
            'Теперь ты можешь:\n\n- покупать оружие и броню;\n- продавать лут.';
        break;

      case Flag.gachaUnlocked:
        title = 'Рекрутинг разлокированы';
        icon = Icons.store;
        description = 'Теперь ты можешь искать новых персонажей в свою пати.';
        break;
    }

    MessagePopup.info(
      title: Text(title),
      icon: Icon(icon, size: 48),
      description: [
        Flexible(child: Text(description)),
      ],
    );

    // _notificationService.notify(
    //   LocalNotification(
    //     title: title,
    //     icon: icon,
    //     type: LocalNotificationType.common,
    //     duration: const Duration(seconds: 5),
    //   ),
    // );
  }
}
