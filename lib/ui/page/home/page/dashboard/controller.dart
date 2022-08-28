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

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/service/task.dart';
import '/ui/worker/music.dart';

enum MainTab {
  dash,
  party,
  guild,
  store,
  profile,
}

class DashboardController extends GetxController {
  DashboardController(this._taskService, this._musicWorker);

  final PageController pageController = PageController();
  final Rx<MainTab> selected = Rx(MainTab.dash);

  final TaskService _taskService;
  final MusicWorker _musicWorker;

  RxInt get completedTasks => _taskService.completedTasks;

  final AssetSource _source =
      AssetSource('music/mixkit-driving-ambition-32.mp3');

  @override
  void onReady() {
    _musicWorker.play(_source);
    super.onReady();
  }

  @override
  void onClose() {
    _musicWorker.stop(_source);
    super.onClose();
  }
}
