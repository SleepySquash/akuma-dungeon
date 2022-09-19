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

import '/domain/model/commission.dart';
import '/domain/model/item/all.dart';
import '/domain/model/location/all.dart';
import '/domain/model/rank.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';
import 'aloross/construction.dart';
import 'aloross/fields.dart';
import 'aloross/food_delivery.dart';
import 'aloross/merchant.dart';
import 'aloross/restaurant.dart';
import 'aloross/swamp.dart';

abstract class AlorossCommissions {
  static List<QuestCommission> get tasks => const [
        AlorossSlimeFieldsCommission(),
        AlorossSlimeFields2Commission(),
        AlorossMerchantForestCommission(),
        AlorossSlimeSwampCommission(),
        AlorossRestaurantCommission(),
        AlorossConstructionCommission(),
        AlorossFoodDeliveryCommission(),
      ];
}

abstract class AlorossCommission extends Task with QuestCommission {
  const AlorossCommission();

  @override
  String? get location => 'aloross';

  @override
  Rank get rank => Rank.F;

  @override
  List<TaskCriteria> get criteria => const [NotCompletedCriteria()];

  @override
  List<Reward> get rewards => const [
        MoneyReward(2000),
        ExpReward(250),
        ItemReward(Ruby(20)),
        RankReward(5),
        ReputationReward(AlorossLocation(), 3),
      ];
}
