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
  List<StatChance> get stat => [StatChance(Stat.atk(1))];
}

class InitiateFlower extends InitiateArtifactSet with Flower {
  const InitiateFlower([super.count = 1]);

  @override
  String get id => 'initiate/flower';

  @override
  String get name => 'Flower of Life';

  @override
  List<StatChance> get stat => [StatChance(Stat.hp(1))];
}

abstract class AdventurerArtifactSet extends Artifact with Flower {
  const AdventurerArtifactSet(super.count);

  @override
  Rarity get rarity => Rarity.useful;

  @override
  int get maxStats => 1;

  @override
  String? get set => 'Adventurer';
}

class AdventurerFeather extends InitiateArtifactSet with Feather {
  const AdventurerFeather([super.count = 1]);

  @override
  String get id => 'adventurer/feather';

  @override
  String get name => 'Adventurer\'s feather';

  @override
  List<StatChance> get stat => [StatChance(Stat.hp(2))];
}

class AdventurerFlower extends InitiateArtifactSet with Flower {
  const AdventurerFlower([super.count = 1]);

  @override
  String get id => 'adventurer/flower';

  @override
  String get name => 'Adventurer\'s flower';

  @override
  List<StatChance> get stat => [StatChance(Stat.atk(1))];
}

class AdventurerWatch extends InitiateArtifactSet with Watch {
  const AdventurerWatch([super.count = 1]);

  @override
  String get id => 'adventurer/watch';

  @override
  String get name => 'Adventurer\'s watch';

  @override
  List<StatChance> get stat => [StatChance(Stat.atk(1))];
}
