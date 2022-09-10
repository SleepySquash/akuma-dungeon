import 'dart:math';

import 'item.dart';
import 'location.dart';

abstract class Reward {
  const Reward();
}

class MoneyReward extends Reward {
  const MoneyReward(this.amount);
  final int amount;
}

class ExpReward extends Reward {
  const ExpReward(this.amount);
  final int amount;
}

class ItemReward extends Reward {
  const ItemReward(this.item, [this.count = 1]);
  final Item item;
  final int count;
}

class MinMaxItemReward extends ItemReward {
  MinMaxItemReward(Item item, this.min, this.max)
      : super(item, min + Random().nextInt(1 + max - min));

  final int min;
  final int max;
}

class ChanceItemReward extends ItemReward {
  ChanceItemReward(Item item, this.chance)
      : super(item, Random().nextDouble() > chance ? 1 : 0);

  final double chance;
}

class RankReward extends Reward {
  const RankReward(this.amount);
  final int amount;
}

class ControlReward extends Reward {
  const ControlReward(this.location, this.amount);
  final Location location;
  final int amount;
}

class ReputationReward extends Reward {
  const ReputationReward(this.location, this.amount);
  final Location location;
  final int amount;
}
