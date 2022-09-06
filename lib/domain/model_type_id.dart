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

/// Type ID's of all [Hive] models just to keep them in one place.
///
/// They should not change with time to not break on already stored data by
/// previous versions of application. Add new entries to the end.
class ModelTypeId {
  static const credentials = 0;
  static const applicationSettings = 1;
  static const player = 2;
  static const race = 3;
  static const gender = 4;
  static const item = 5;
  static const character = 6;
  static const task = 7;
  static const gameProgression = 8;
  static const skill = 9;
  static const taskQueue = 10;
  static const itemId = 11;
  static const characterId = 12;
  static const skillId = 13;
  static const locationId = 14;
  static const location = 15;
  static const statType = 16;
  static const stat = 17;
}
