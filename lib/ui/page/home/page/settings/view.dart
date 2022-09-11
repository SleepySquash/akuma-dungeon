// Copyright © 2022 IT ENGINEERING MANAGEMENT INC, <https://github.com/team113>
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

import 'package:akuma/domain/model/flag.dart';
import 'package:akuma/domain/model/item.dart';
import 'package:akuma/domain/model/item/all.dart';
import 'package:akuma/domain/service/flag.dart';
import 'package:akuma/domain/service/item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/l10n/l10n.dart';
import '/ui/widget/selector.dart';
import '/ui/widget/modal_popup.dart';
import '/util/platform_utils.dart';
import 'controller.dart';

/// View of the [Routes.settings] page.
class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(context: context, child: const SettingsView());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SettingsController(Get.find()),
      builder: (SettingsController c) {
        return ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              key: const Key('LanguageDropdown'),
              title: Text(
                '${L10n.chosen.value!.locale.countryCode}, ${L10n.chosen.value!.name}',
              ),
              onTap: () async {
                final TextStyle? thin =
                    context.textTheme.caption?.copyWith(color: Colors.black);
                await Selector.show<Language>(
                  context: context,
                  buttonKey: c.languageKey,
                  alignment: Alignment.bottomCenter,
                  items: L10n.languages,
                  initial: L10n.chosen.value!,
                  onSelected: (l) => L10n.set(l),
                  debounce: context.isMobile
                      ? const Duration(milliseconds: 500)
                      : null,
                  itemBuilder: (Language e) {
                    return Row(
                      key: Key(
                          'Language_${e.locale.languageCode}${e.locale.countryCode}'),
                      children: [
                        Text(
                          e.name,
                          style: thin?.copyWith(fontSize: 15),
                        ),
                        const Spacer(),
                        Text(
                          e.locale.languageCode.toUpperCase(),
                          style: thin?.copyWith(fontSize: 15),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              title: const Text('Music volume'),
              subtitle: Obx(() {
                return Slider(
                  value: c.settings.value?.musicVolume ?? 1,
                  onChanged: (d) => c.setMusicVolume(d),
                );
              }),
            ),
            ListTile(
              title: const Text('Sound volume'),
              subtitle: Obx(() {
                return Slider(
                  value: c.settings.value?.soundVolume ?? 1,
                  onChanged: (d) => c.setSoundVolume(d),
                );
              }),
            ),
            ListTile(
              title: const Text('Voice volume'),
              subtitle: Obx(() {
                return Slider(
                  value: c.settings.value?.voiceVolume ?? 1,
                  onChanged: (d) => c.setVoiceVolume(d),
                );
              }),
            ),
            const ListTile(title: Text('Developer')),
            ListTile(
              title: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.find<ItemService>().add(const AppleRedItem());
                    },
                    child: const Text('Add `RedApple`'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.find<ItemService>()
                          .take(ItemId(const AppleRedItem().id));
                    },
                    child: const Text('Take 1 `RedApple`'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FlagService s = Get.find<FlagService>();
                      s.set(Flag.storeUnlocked, true);
                      s.set(Flag.goddessTowerUnlocked, true);
                      s.set(Flag.locationsUnlocked, true);
                      s.set(Flag.dungeonsUnlocked, true);
                    },
                    child: const Text('Unlock everything'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FlagService s = Get.find<FlagService>();
                      s.set(Flag.storeUnlocked, false);
                      s.set(Flag.goddessTowerUnlocked, false);
                      s.set(Flag.locationsUnlocked, false);
                      s.set(Flag.dungeonsUnlocked, false);
                    },
                    child: const Text('Lock impossible'),
                  )
                ].map((e) => Expanded(child: e)).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
