import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:get/get.dart';

import '/domain/model/commission.dart';
import '/domain/model/location.dart';
import '/domain/model/rank.dart';
import '/domain/model/task.dart';
import '/domain/repository/location.dart';
import '/domain/repository/task.dart';
import '/util/log.dart';
import '/util/rewards.dart';
import 'flag.dart';
import 'item.dart';
import 'player.dart';
import 'progression.dart';

class LocationService extends DisposableInterface {
  LocationService(
    this._locationRepository,
    this._flagService,
    this._itemService,
    this._playerService,
    this._progressionService,
    this._taskRepository,
  );

  final AbstractLocationRepository _locationRepository;
  final FlagService _flagService;
  final ItemService _itemService;
  final PlayerService _playerService;
  final ProgressionService _progressionService;
  final AbstractTaskRepository _taskRepository;

  late final Timer _fixedUpdate;
  final Map<String, Timer> _timers = {};

  Rx<MyLocation> get location => _locationRepository.location;

  @override
  void onInit() {
    _populateCommissions();

    _fixedUpdate = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _populateCommissions(),
    );

    super.onInit();
  }

  @override
  void onClose() {
    _fixedUpdate.cancel();
    for (Timer t in _timers.values) {
      t.cancel();
    }
    super.onClose();
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

  void removeCommission(MyCommission suggested) {
    MyLocation location = this.location.value;
    MyCommission? commission =
        location.commissions.firstWhereOrNull((e) => e.id == suggested.id);

    if (commission != null) {
      location.commissions.remove(commission);
      _timers.remove(commission.id)?.cancel();
      this.location.refresh();
      _locationRepository.put(location);
    }
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
        flagService: _flagService,
      );

      location.commissions.remove(commission);
      _timers.remove(commission.id)?.cancel();

      this.location.refresh();
      _locationRepository.done(commission);
      _locationRepository.put(location);

      if (commission.task is DungeonCommission) {
        _progressionService.addDungeonsCleared();
      } else {
        _progressionService.addQuestsDone();
      }

      _taskRepository.complete(commission.task);

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
    commission?.execute(
      save: () => _locationRepository.put(location),
      location: location.location,
    );
  }

  Future<void> _populateCommissions() async {
    MyLocation location = this.location.value;

    for (MyCommission commission
        in List.from(location.commissions, growable: false)) {
      bool met = await commission.task.criteriaMet(
        player: _playerService.player,
        progression: _progressionService.progression.value,
        isTaskCompleted: _taskRepository.isCompleted,
        getCompleted: _taskRepository.getCompleted,
      );

      if (!met) {
        failCommission(commission);
      } else if (commission.task.timeout != null) {
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

    bool empty = location.commissions.isEmpty;
    DateTime? withTimeout(Duration? timeout) {
      if (!empty || timeout == null) {
        return null;
      }

      int random = Random().nextInt(timeout.inSeconds ~/ 2);
      return DateTime.now().subtract(Duration(seconds: random));
    }

    int dungeons = location.commissions
        .where((e) => !e.isCompleted && e.task is DungeonCommission)
        .length;
    const int maxDungeons = 4;

    for (int i = dungeons; i < maxDungeons; ++i) {
      List<DungeonCommission> ranked = location.location.dungeons.where((e) {
        return location.commissions
                    .firstWhereOrNull((m) => m.task.id == e.id) ==
                null &&
            e.rank == _playerService.player.rank.toRank();
      }).toList();

      Task? random;
      if (ranked.isNotEmpty) {
        random = ranked.sample(1).first;
      } else {
        random = location.location.dungeons
            .where((e) =>
                location.commissions
                    .firstWhereOrNull((m) => m.task.id == e.id) ==
                null)
            .sample(1)
            .firstOrNull;
      }

      if (random != null) {
        location.commissions.add(MyCommission(
          task: random,
          appearedAt: withTimeout(random.timeout),
        ));
      }
    }

    for (QuestCommission c in location.location.commissions) {
      if (location.commissions.firstWhereOrNull((m) => m.id == c.id) == null) {
        bool met = await c.criteriaMet(
          player: _playerService.player,
          progression: _progressionService.progression.value,
          isTaskCompleted: _taskRepository.isCompleted,
          getCompleted: _taskRepository.getCompleted,
        );

        if (met) {
          location.commissions
              .add(MyCommission(task: c, appearedAt: withTimeout(c.timeout)));
        }
      }
    }

    // int commissions = location.commissions
    //     .where((e) => !e.isCompleted && e.task is QuestCommission)
    //     .length;
    // const int maxCommissions = 2;

    // for (int i = commissions; i < maxCommissions; ++i) {
    //   Task? random = location.location.commissions
    //       .where((e) =>
    //           location.commissions.firstWhereOrNull((m) => m.task.id == e.id) ==
    //           null)
    //       .sample(1)
    //       .firstOrNull;
    //   if (random != null) {
    // location.commissions.add(MyCommission(
    //   task: random,
    //   appearedAt: appearedAt(random.timeout),
    // ));
    //   }
    // }

    _locationRepository.put(location);
    this.location.refresh();
  }
}
