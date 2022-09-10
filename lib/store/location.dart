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
import 'dart:math';

import 'package:akuma/domain/model/commission.dart';
import 'package:akuma/domain/model/impossible.dart';
import 'package:akuma/domain/model/task.dart';
import 'package:akuma/provider/hive/completed_task.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '/domain/model/location.dart';
import '/domain/model/location/all.dart';
import '/domain/repository/location.dart';
import '/provider/hive/location.dart';

class LocationRepository extends DisposableInterface
    implements AbstractLocationRepository {
  LocationRepository(
    this._locationsHive,
    this._locationHive,
    this._completedHiveProvider,
  );

  @override
  late final Rx<MyLocation> location;

  final CurrentLocationHiveProvider _locationHive;
  final LocationHiveProvider _locationsHive;
  final CompletedTaskHiveProvider _completedHiveProvider;

  StreamIterator<BoxEvent>? _locationSubscription;
  StreamIterator<BoxEvent>? _currentSubscription;

  @override
  void onInit() {
    LocationId? id = _locationHive.get();
    MyLocation? my = id == null ? null : _locationsHive.get(id);

    if (my != null) {
      for (MyCommission commission
          in List.from(my.commissions, growable: false)) {
        if (commission.task is Impossible) {
          my.commissions.remove(commission);
        }
      }

      location = Rx(my);
    } else {
      MyLocation initial = MyLocation(const AlorossLocation());
      location = Rx(initial);

      _locationHive.put(initial.id);
      _locationsHive.put(initial);
    }

    _initLocationSubscription();
    _initCurrentSubscription();

    super.onInit();
  }

  @override
  void onClose() {
    _locationSubscription?.cancel();
    _currentSubscription?.cancel();
    super.onClose();
  }

  @override
  void goTo(LocationId id) {
    _setLocation(id);
    _locationHive.put(id);
  }

  @override
  void addControl(LocationId id, int amount) {
    MyLocation? stored = _locationsHive.get(id);
    if (stored == null) {
      Location? location = Locations.get(id.val);
      if (location != null) {
        stored = MyLocation(location, control: max(0, amount));
        _locationsHive.put(stored);
      }
    } else {
      stored.control += amount;
      if (stored.control < 0) {
        stored.control = 0;
      }

      _locationsHive.put(stored);
    }
  }

  @override
  Future<void> addReputation(LocationId id, int amount) async {
    MyLocation? stored = _locationsHive.get(id);
    if (stored == null) {
      Location? location = Locations.get(id.val);
      if (location != null) {
        stored = MyLocation(location, reputation: max(0, amount));
        _locationsHive.put(stored);
      }
    } else {
      stored.reputation += amount;
      if (stored.reputation < 0) {
        stored.reputation = 0;
      }

      _locationsHive.put(stored);
    }
  }

  Future<void> _initLocationSubscription() async {
    _locationSubscription = StreamIterator(_locationsHive.boxEvents);
    while (await _locationSubscription!.moveNext()) {
      BoxEvent e = _locationSubscription!.current;
      if (e.deleted) {
        // No-op.
      } else if (location.value.id == e.value.id) {
        location.value = e.value;
        location.refresh();
      }
    }
  }

  @override
  void put(MyLocation location) => _locationsHive.put(location);

  @override
  Future<void> done(MyCommission commission) async {
    CompletedTask? task = await _completedHiveProvider.get(commission.id);

    if (task != null) {
      ++task.count;
    } else {
      task = CompletedTask(id: commission.id);
    }

    _completedHiveProvider.put(task);
  }

  Future<void> _initCurrentSubscription() async {
    _currentSubscription = StreamIterator(_locationHive.boxEvents);
    while (await _currentSubscription!.moveNext()) {
      BoxEvent e = _currentSubscription!.current;
      if (e.deleted) {
        throw Exception('Current `LocationId` should never get deleted.');
      } else if (e.value != location.value.id) {
        _setLocation(e.value);
      }
    }
  }

  void _setLocation(LocationId id) {
    MyLocation? my = _locationsHive.get(id);

    if (my != null) {
      for (MyCommission commission
          in List.from(my.commissions, growable: false)) {
        if (commission.task is Impossible) {
          my.commissions.remove(commission);
        }
      }

      location.value = my;
      location.refresh();
    } else {
      Location? place = Locations.get(id.val);
      if (place != null) {
        location.value = MyLocation(place);
        location.refresh();
      }
    }
  }
}
