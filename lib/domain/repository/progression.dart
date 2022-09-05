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

import 'package:get/get.dart';

import '/domain/model/character.dart';
import '/domain/model/location.dart';
import '/domain/model/progression.dart';
import '/domain/repository/character.dart';

abstract class AbstractProgressionRepository {
  Rx<GameProgression> get progression;
  Rx<RxMyCharacter?> get secretary;
  Rx<MyLocation> get location;

  void setGoddessTower(int to);
  void setChapter(int to);
  void setSecretary(CharacterId? character);

  void setLocation(LocationId location);
  void setLocationControl(LocationId id, int to);
  void setLocationReputation(LocationId id, int to);
}