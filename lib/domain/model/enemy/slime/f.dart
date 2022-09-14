import '../slime.dart';
import '/domain/model/item/all.dart';
import '/domain/model/reward.dart';

abstract class FSlime extends Slime {
  const FSlime();

  @override
  int get hp => 10;

  @override
  int get exp => 1;

  @override
  double get damage => 1;

  @override
  List<Reward> get drops => [
        ChanceItemReward(const Ruby(), 0.02),
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
  int get hp => 14;
}

class RedSlimeEnemy extends FSlime {
  const RedSlimeEnemy();

  @override
  String get id => 'Red Slime';

  @override
  int get hp => 17;
}

class CatSlimeEnemy extends FSlime {
  const CatSlimeEnemy();

  @override
  String get id => 'Cat Slime';

  @override
  int get exp => 2;

  @override
  int get hp => 21;
}

class RedLongSlimeEnemy extends FSlime {
  const RedLongSlimeEnemy();

  @override
  String get id => 'Red Long Slime';

  @override
  int get exp => 5;

  @override
  int get hp => 50;
}
