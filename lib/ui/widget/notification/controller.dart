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

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '/domain/service/notification.dart';
import '/util/obs/obs.dart';

class NotificationOverlayController extends GetxController {
  NotificationOverlayController(
    this._notificationService, {
    required this.commonBuilder,
    required this.additionBuilder,
  });

  final GlobalKey<AnimatedListState> commonKey = GlobalKey<AnimatedListState>();
  final Widget Function(BuildContext, LocalNotification, Animation<double>)
      commonBuilder;

  final GlobalKey<AnimatedListState> additionsKey =
      GlobalKey<AnimatedListState>();
  final Widget Function(BuildContext, LocalNotification, Animation<double>)
      additionBuilder;

  final NotificationService _notificationService;

  StreamSubscription? _commonSubscription;
  StreamSubscription? _additionSubscription;

  RxObsList<LocalNotification> get common => _notificationService.notifications;
  RxObsList<LocalNotification> get centered => _notificationService.centered;
  RxObsList<LocalNotification> get additions => _notificationService.additions;

  @override
  void onInit() {
    _commonSubscription = common.changes.listen((e) {
      switch (e.op) {
        case OperationKind.added:
          commonKey.currentState?.insertItem(e.pos);
          break;

        case OperationKind.removed:
          commonKey.currentState?.removeItem(
            e.pos,
            (context, animation) =>
                commonBuilder(context, e.element, animation),
          );
          break;

        case OperationKind.updated:
          // No-op.
          break;
      }
    });

    _additionSubscription = additions.changes.listen((e) {
      switch (e.op) {
        case OperationKind.added:
          additionsKey.currentState?.insertItem(e.pos);
          break;

        case OperationKind.removed:
          additionsKey.currentState?.removeItem(
            e.pos,
            (context, animation) =>
                additionBuilder(context, e.element, animation),
          );
          break;

        case OperationKind.updated:
          // No-op.
          break;
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    _commonSubscription?.cancel();
    _additionSubscription?.cancel();
    super.onClose();
  }
}
