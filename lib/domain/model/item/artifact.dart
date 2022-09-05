import 'package:akuma/domain/model/stat.dart';

import '../item.dart';

abstract class InitiateArtifactSet extends Artifact {
  const InitiateArtifactSet(super.count);

  @override
  String? get set => 'Initiate';
}

class InitiateFeather extends InitiateArtifactSet {
  const InitiateFeather([super.count = 1]);

  @override
  String get id => 'initiate/feather';

  @override
  String get name => 'Flower of Life';

  @override
  List<Stat> get stats => [
        const HpStat(1),
      ];
}

class InitiateFlower extends InitiateArtifactSet {
  const InitiateFlower([super.count = 1]);

  @override
  String get id => 'initiate/flower';

  @override
  String get name => 'Flower of Life';

  @override
  List<Stat> get stats => [
        const AtkStat(1),
      ];
}
