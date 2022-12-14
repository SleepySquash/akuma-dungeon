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

import 'package:decimal/decimal.dart';
import 'package:get/get.dart';

import '/domain/model/item.dart';
import '/domain/service/item.dart';
import '/domain/service/notification.dart';
import '/util/obs/obs.dart';

class ItemWorker extends DisposableInterface {
  ItemWorker(
    this._itemService,
    this._notificationService,
  );

  final ItemService _itemService;
  final NotificationService _notificationService;

  final Map<ItemId, Decimal> counts = {};

  StreamSubscription? _subscription;

  @override
  void onInit() {
    for (var entry in _itemService.items.entries) {
      counts[entry.key] = entry.value.value.count;
    }

    _subscription = _itemService.items.changes.listen((e) {
      switch (e.op) {
        case OperationKind.added:
          counts[e.key!] = e.value!.value.count;
          _notificationService.notify(
            LocalNotification(
              title: '${e.value?.value.count}x ${e.value?.value.item.name}',
              type: LocalNotificationType.addition,
            ),
          );
          break;

        case OperationKind.removed:
          counts.remove(e.key);
          _notificationService.notify(
            LocalNotification(
              title: '-${e.value?.value.count}x ${e.value?.value.item.name}',
              type: LocalNotificationType.addition,
            ),
          );
          break;

        case OperationKind.updated:
          Decimal prev = counts[e.key] ?? Decimal.zero;
          if (prev != e.value?.value.count) {
            counts[e.key!] = e.value!.value.count;
            _notificationService.notify(
              LocalNotification(
                title:
                    '${e.value!.value.count - prev}x ${e.value?.value.item.name}',
                type: LocalNotificationType.addition,
              ),
            );
          }
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
}
