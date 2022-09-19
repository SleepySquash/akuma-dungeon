import 'package:decimal/decimal.dart';

import '../slime.dart';
import '/domain/model/item/all.dart';
import '/domain/model/reward.dart';

abstract class DSlime extends Slime {
  const DSlime();

  @override
  String get asset => 'slime/$id';

  @override
  Decimal get hp => Decimal.fromInt(2000);

  @override
  Decimal get exp => Decimal.fromInt(20);

  @override
  Decimal get damage => Decimal.fromInt(100);

  @override
  List<Reward> get drops => [
        ChanceItemReward(const Ruby(), 0.08),
        ChanceItemReward(const SlimeCondensateItem(), 0.3),
        ChanceItemReward(const SlimeSecretionsItem(), 0.1),
      ];
}

abstract class SlimeChan extends DSlime {
  const SlimeChan();

  @override
  List<String>? get hitSounds => [
        'voice/darknightprincess/ah.mp3',
        'voice/darknightprincess/oh.mp3',
        'voice/darknightprincess/woah.mp3',
      ];

  @override
  List<String>? get slayedSounds => null;
}

class CatSlimeChan extends SlimeChan {
  const CatSlimeChan();

  @override
  String get id => 'Cat Slime-chan';
}

class DirtSlimeChan extends SlimeChan {
  const DirtSlimeChan();

  @override
  String get id => 'Dirt Slime-chan';
}

class FlyingSlimeChan extends SlimeChan {
  const FlyingSlimeChan();

  @override
  String get id => 'Flying Slime-chan';
}

class IceSlimeChan extends SlimeChan {
  const IceSlimeChan();

  @override
  String get id => 'Ice Slime-chan';
}

class LavaSlimeChan extends SlimeChan {
  const LavaSlimeChan();

  @override
  String get id => 'Lava Slime-chan';
}
