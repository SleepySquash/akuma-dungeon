import '/domain/model/item/resource.dart';
import '/domain/model/reward.dart';
import '/domain/service/flag.dart';
import '/domain/service/item.dart';
import '/domain/service/location.dart';
import '/domain/service/player.dart';

extension ComputeRewardsExtension on List<Reward> {
  void compute({
    ItemService? itemService,
    PlayerService? playerService,
    LocationService? locationService,
    FlagService? flagService,
  }) {
    for (Reward r in this) {
      if (r is MoneyReward) {
        itemService?.add(Dogecoin(r.amount));
      } else if (r is ExpReward) {
        playerService?.addExperience(r.amount);
      } else if (r is ItemReward) {
        if (r.count != 0) {
          itemService?.add(r.item, r.count);
        }
      } else if (r is RankReward) {
        playerService?.addRank(r.amount);
      } else if (r is ControlReward) {
        locationService?.addControl(r.location, r.amount);
      } else if (r is ReputationReward) {
        locationService?.addReputation(r.location, r.amount);
      } else if (r is FlagReward) {
        flagService?.set(r.flag, r.value);
      }
    }
  }
}
