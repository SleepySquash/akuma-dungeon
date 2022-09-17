import 'package:decimal/decimal.dart';

import '/domain/model/item.dart';
import '/domain/model/rarity.dart';
import '/domain/model/stat.dart';

abstract class InitiateArtifactSet extends Artifact {
  const InitiateArtifactSet(super.count);

  @override
  int get maxStats => 0;

  @override
  String? get set => 'Initiate';
}

class InitiateFeather extends InitiateArtifactSet with Feather {
  const InitiateFeather([super.count = 1]);

  @override
  String get id => 'initiate/feather';

  @override
  String get name => 'Feather of Life';

  @override
  List<StatChance> get stat => [StatChance(Stat.atk(Decimal.fromInt(1)))];
}

class InitiateFlower extends InitiateArtifactSet with Flower {
  const InitiateFlower([super.count = 1]);

  @override
  String get id => 'initiate/flower';

  @override
  String get name => 'Flower of Life';

  @override
  List<StatChance> get stat => [StatChance(Stat.hp(Decimal.fromInt(1)))];
}

abstract class AdventurerArtifactSet extends Artifact {
  const AdventurerArtifactSet(super.count);

  @override
  Rarity get rarity => Rarity.useful;

  @override
  int get maxStats => 2;

  @override
  String? get set => 'Adventurer';
}

class AdventurerFeather extends AdventurerArtifactSet with Feather {
  const AdventurerFeather([super.count = 1]);

  @override
  String get id => 'adventurer/feather';

  @override
  String get name => 'Adventurer\'s feather';

  @override
  List<StatChance> get stat => [StatChance(Stat.atk(Decimal.fromInt(2)))];
}

class AdventurerFlower extends AdventurerArtifactSet with Flower {
  const AdventurerFlower([super.count = 1]);

  @override
  String get id => 'adventurer/flower';

  @override
  String get name => 'Adventurer\'s flower';

  @override
  List<StatChance> get stat => [StatChance(Stat.hp(Decimal.fromInt(2)))];
}

class AdventurerWatch extends AdventurerArtifactSet with Watch {
  const AdventurerWatch([super.count = 1]);

  @override
  String get id => 'adventurer/watch';

  @override
  String get name => 'Adventurer\'s watch';

  @override
  List<StatChance> get stat => [
        StatChance(Stat.atkPercent(Decimal.fromInt(1))),
        StatChance(Stat.hpPercent(Decimal.fromInt(1))),
        StatChance(Stat.defPercent(Decimal.fromInt(1))),
        StatChance(Stat.ultPercent(Decimal.fromInt(1))),
      ];
}
