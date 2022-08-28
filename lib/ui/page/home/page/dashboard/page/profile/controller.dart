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

import 'package:audioplayers/audioplayers.dart' show AssetSource;
import 'package:get/get.dart';

import '/domain/model/item.dart';
import '/domain/model/player.dart';
import '/domain/service/item.dart';
import '/domain/service/player.dart';
import '/ui/worker/music.dart';
import '/util/obs/obs.dart';

enum ProfileTab {
  attributes,
  inventory,
  constellation,
  skills,
}

class ProfileController extends GetxController {
  ProfileController(this._playerService, this._itemService, this._musicWorker);

  final Rx<ProfileTab> tab = Rx(ProfileTab.attributes);

  final PlayerService _playerService;
  final ItemService _itemService;
  final MusicWorker _musicWorker;

  Rx<Player?> get player => _playerService.player;
  RxObsMap<String, Rx<MyItem>> get items => _itemService.items;

  void equip(MyItem item) {
    _playerService.equip(item);
    _musicWorker.once(AssetSource('sound/shu-shu-equip.m4a'));
  }

  void unequip(MyItem item) => _playerService.unequip(item);
}
