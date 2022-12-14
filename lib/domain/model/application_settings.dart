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

import 'package:hive/hive.dart';

import '/domain/model_type_id.dart';

part 'application_settings.g.dart';

/// Overall application settings used by the whole app.
@HiveType(typeId: ModelTypeId.applicationSettings)
class ApplicationSettings extends HiveObject {
  ApplicationSettings({
    this.locale,
    this.musicVolume,
    this.soundVolume,
    this.voiceVolume,
  });

  /// Preferred language to use in the application.
  @HiveField(0)
  String? locale;

  @HiveField(1)
  double? musicVolume;

  @HiveField(2)
  double? soundVolume;

  @HiveField(3)
  double? voiceVolume;
}
