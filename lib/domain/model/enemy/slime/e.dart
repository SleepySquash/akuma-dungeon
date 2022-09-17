import 'package:decimal/decimal.dart';

import '../slime.dart';
import '/domain/model/item/all.dart';
import '/domain/model/reward.dart';

abstract class ESlime extends Slime {
  const ESlime();

  @override
  Decimal get hp => Decimal.fromInt(100);

  @override
  Decimal get exp => Decimal.fromInt(3);

  @override
  Decimal get damage => Decimal.fromInt(10);

  @override
  List<Reward> get drops => [
        ChanceItemReward(const Ruby(), 0.04),
      ];
}

class ChickenSlime extends ESlime {
  const ChickenSlime();

  @override
  String get id => 'Chicken Slime';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(3);
}

class DendroSlime extends ESlime {
  const DendroSlime();

  @override
  String get id => 'Dendro Slime';
}

class DirtSlime extends ESlime {
  const DirtSlime();

  @override
  String get id => 'Dirt Slime';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(1);
}

class FireSlime extends ESlime {
  const FireSlime();

  @override
  String get id => 'Fire Slime';
}

class GemSlime extends ESlime {
  const GemSlime();

  @override
  String get id => 'Gem Slime';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(6);
}

class GoldSlime extends ESlime {
  const GoldSlime();

  @override
  String get id => 'Gold Slime';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(14);
}

class GooSlime extends ESlime {
  const GooSlime();

  @override
  String get id => 'Goo Slime';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(10);
}

class IceSlime extends ESlime {
  const IceSlime();

  @override
  String get id => 'Ice Slime';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(2);
}

class MoneySlime extends ESlime {
  const MoneySlime();

  @override
  String get id => 'Money Slime';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(24);
}

class PlanetSlime extends ESlime {
  const PlanetSlime();

  @override
  String get id => 'Planet Slime';
}

class SlimeGroup extends ESlime {
  const SlimeGroup();

  @override
  String get id => 'Slime Group';
}

class SparkSlime extends ESlime {
  const SparkSlime();

  @override
  String get id => 'Spark Slime';
}

class ThunderSlime extends ESlime {
  const ThunderSlime();

  @override
  String get id => 'Thunder Slime';
}

class OctopusSlime extends ESlime {
  const OctopusSlime();

  @override
  String get id => 'Octopus Slime';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(40);
}

class VenomSlime extends ESlime {
  const VenomSlime();

  @override
  String get id => 'Venom Slime';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(50);
}
