import 'dart:async';

import 'package:akuma/domain/service/item.dart';
import 'package:akuma/domain/service/player.dart';
import 'package:akuma/util/log.dart';
import 'package:akuma/util/rewards.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:novel/novel.dart';

import '/domain/model/commission.dart';
import '/domain/model/location.dart';
import '/domain/model/task.dart';
import '/domain/repository/location.dart';
import '/router.dart';

class LocationService extends DisposableInterface {
  LocationService(
    this._locationRepository,
    this._itemService,
    this._playerService,
  );

  final AbstractLocationRepository _locationRepository;

  final ItemService _itemService;
  final PlayerService _playerService;

  Rx<MyLocation> get location => _locationRepository.location;

  @override
  void onInit() {
    _populateCommissions();
    super.onInit();
  }

  void goTo(Location to) {
    if (to.id != location.value.id.val) {
      _locationRepository.goTo(LocationId(to.id));
      _populateCommissions();
    }
  }

  void addControl(Location location, int amount) =>
      _locationRepository.addControl(LocationId(location.id), amount);
  void addReputation(Location location, int amount) =>
      _locationRepository.addReputation(LocationId(location.id), amount);

  void acceptCommission(MyCommission suggested) {
    MyLocation location = this.location.value;
    MyCommission? commission =
        location.commissions.firstWhereOrNull((e) => e.id == suggested.id);
    commission?.accepted = true;

    _locationRepository.put(location);
    this.location.refresh();
  }

  void failCommission(MyCommission suggested) {
    MyLocation location = this.location.value;
    MyCommission? commission =
        location.commissions.firstWhereOrNull((e) => e.id == suggested.id);

    if (commission != null) {
      if (!commission.isCompleted) {
        location.commissions.remove(commission);
        _timers.remove(commission.id)?.cancel();

        this.location.refresh();
        _locationRepository.put(location);
        _populateCommissions();
      }
    }
  }

  void finishCommission(MyCommission suggested) {
    MyLocation location = this.location.value;
    MyCommission? commission =
        location.commissions.firstWhereOrNull((e) => e.id == suggested.id);

    if (commission?.isCompleted == true) {
      commission!.task.rewards.compute(
        itemService: _itemService,
        locationService: this,
        playerService: _playerService,
      );

      location.commissions.remove(commission);
      _timers.remove(commission.id)?.cancel();

      this.location.refresh();
      _locationRepository.done(commission);
      _locationRepository.put(location);

      _populateCommissions();
    } else {
      if (commission == null) {
        Log.print('[LocationService] Trying to complete `null` commission.');
      } else {
        Log.print(
            '[LocationService] Trying to complete un-complete commission.');
      }
    }
  }

  void executeCommission(MyCommission suggested, {void Function()? onEnd}) {
    MyLocation location = this.location.value;
    MyCommission? commission =
        location.commissions.firstWhereOrNull((e) => e.id == suggested.id);

    if (commission?.isCompleted == true) {
      return;
    }

    if (commission != null) {
      void execute() {
        void next() {
          commission.progress++;
          _locationRepository.put(location);

          if (commission.isCompleted) {
            (onEnd ?? router.home).call();
            this.location.refresh();
            // generate new commission after timeout.
          } else {
            execute();
          }
        }

        int i = commission.progress;
        TaskStep step = commission.task.steps[i];
        if (step is NovelStep) {
          router.nowhere();
          Novel.show(context: router.context!, scenario: step.scenario)
              .then((_) => next());
        } else if (step is DungeonStep) {
          if (suggested.task is DungeonCommission) {
            router.entrance(
              step.settings,
              location.location.asset,
              onClear: () {
                router.nowhere();
                next();
              },
            );
          } else {
            router.dungeon(
              step.settings,
              onClear: () {
                router.nowhere();
                next();
              },
            );
          }
        }
      }

      execute();
    }
  }

  final Map<String, Timer> _timers = {};

  void _populateCommissions() {
    const Duration rewardTimeout = Duration(minutes: 1);
    const Duration nextCommissionTimeout = Duration(minutes: 1);

    MyLocation location = this.location.value;

    for (MyCommission commission
        in List.from(location.commissions, growable: false)) {
      if (commission.task.timeout != null) {
        Duration diff = DateTime.now().difference(commission.appearedAt);
        if (diff > commission.task.timeout!) {
          location.commissions.remove(commission);
        } else {
          _timers[commission.id] = Timer(
            commission.task.timeout! - diff,
            () => failCommission(commission),
          );
        }
      }
    }

    int dungeons = location.commissions
        .where((e) => !e.isCompleted && e.task is DungeonCommission)
        .length;
    const int maxDungeons = 2;

    for (int i = dungeons; i < maxDungeons; ++i) {
      Task? random = location.location.dungeons
          .where((e) =>
              location.commissions.firstWhereOrNull((m) => m.task.id == e.id) ==
              null)
          .sample(1)
          .firstOrNull;
      if (random != null) {
        location.commissions.add(MyCommission(task: random));
      }
    }

    int commissions = location.commissions
        .where((e) => !e.isCompleted && e.task is QuestCommission)
        .length;
    const int maxCommissions = 2;

    for (int i = commissions; i < maxCommissions; ++i) {
      Task? random = location.location.commissions
          .where((e) =>
              location.commissions.firstWhereOrNull((m) => m.task.id == e.id) ==
              null)
          .sample(1)
          .firstOrNull;
      if (random != null) {
        location.commissions.add(MyCommission(task: random));
      }
    }

    _locationRepository.put(location);
    this.location.refresh();
  }
}
