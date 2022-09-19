import 'package:decimal/decimal.dart';

import '../slime.dart';
import '/domain/model/item/all.dart';
import '/domain/model/reward.dart';

abstract class FSlime extends Slime {
  const FSlime();

  @override
  Decimal get hp => Decimal.fromInt(32);

  @override
  Decimal get exp => Decimal.one;

  @override
  Decimal get damage => Decimal.one;

  @override
  List<Reward> get drops => [
        ChanceItemReward(const Ruby(), 0.02),
        ChanceItemReward(const SlimeCondensateItem(), 0.15),
      ];
}

class GreenSlimeEnemy extends FSlime {
  const GreenSlimeEnemy();

  @override
  String get id => 'Green Slime';
}

class BlueSlimeEnemy extends FSlime {
  const BlueSlimeEnemy();

  @override
  String get id => 'Blue Slime';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(4);
}

class RedSlimeEnemy extends FSlime {
  const RedSlimeEnemy();

  @override
  String get id => 'Red Slime';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(7);
}

class CatSlimeEnemy extends FSlime {
  const CatSlimeEnemy();

  @override
  String get id => 'Cat Slime';

  @override
  Decimal get exp => Decimal.fromInt(2);

  @override
  Decimal get hp => super.hp + Decimal.fromInt(11);
}

class RedLongSlimeEnemy extends FSlime {
  const RedLongSlimeEnemy();

  @override
  String get id => 'Red Long Slime';

  @override
  Decimal get exp => Decimal.fromInt(5);

  @override
  Decimal get hp => super.hp + Decimal.fromInt(40);
}
