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

import 'package:bordered_text/bordered_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/service/notification.dart';
import 'controller.dart';

class NotificationOverlayView extends StatelessWidget {
  const NotificationOverlayView({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: NotificationOverlayController(
        Get.find(),
        commonBuilder: (context, e, animation) => _common(e, animation),
        additionBuilder: (context, e, animation) => _addition(e, animation),
      ),
      builder: (NotificationOverlayController c) {
        return SafeArea(
          child: Stack(
            children: [
              child,
              IgnorePointer(
                child: Obx(() {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 10, bottom: 10),
                    child: AnimatedList(
                      key: c.commonKey,
                      shrinkWrap: true,
                      initialItemCount: c.common.length,
                      itemBuilder: (context, i, animation) {
                        return _common(c.common[i], animation);
                      },
                    ),
                  );
                }),
              ),
              IgnorePointer(
                child: Obx(() {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: AnimatedList(
                        key: c.additionsKey,
                        shrinkWrap: true,
                        initialItemCount: c.additions.length,
                        itemBuilder: (context, i, animation) {
                          return _addition(c.additions[i], animation);
                        },
                      ),
                    ),
                  );
                }),
              ),
              IgnorePointer(
                child: Obx(() {
                  LocalNotification? notification = c.centered.lastOrNull;
                  return AnimatedSwitcher(
                    duration: 300.milliseconds,
                    child: notification == null
                        ? Container()
                        : _centeredNotification(notification),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _common(LocalNotification item, Animation<double> animation) {
    return Align(
      alignment: Alignment.topRight,
      child: SlideTransition(
        position:
            Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.linearToEaseOut,
          ),
        ),
        child: Card(
          margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.icon != null) Icon(item.icon, size: 24),
                      if (item.icon != null && item.title != null)
                        const SizedBox(width: 5),
                      if (item.title != null) Text(item.title!),
                    ],
                  ),
                  if (item.subtitle != null) Text(item.subtitle!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _addition(LocalNotification item, Animation<double> animation) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SlideTransition(
        position:
            Tween(begin: const Offset(-1, 0), end: const Offset(0, 0)).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.linearToEaseOut,
          ),
        ),
        child: Card(
          margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.icon != null) Icon(item.icon, size: 24),
                      if (item.icon != null && item.title != null)
                        const SizedBox(width: 5),
                      if (item.title != null) Text(item.title!),
                    ],
                  ),
                  if (item.subtitle != null) Text(item.subtitle!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _centeredNotification(LocalNotification item) {
    return Align(
      key: Key('${item.title}${item.subtitle}'),
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.icon != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Icon(item.icon, size: 24),
              ),
            if (item.title != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: BorderedText(
                  child: Text(
                    item.title!,
                    style: const TextStyle(fontSize: 36, color: Colors.white),
                  ),
                ),
              ),
            if (item.subtitle != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: BorderedText(
                  child: Text(
                    item.subtitle!,
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
