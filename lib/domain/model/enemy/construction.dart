import 'package:decimal/decimal.dart';

import '/domain/model/enemy.dart';

abstract class ConstructionEnemies {
  static List<Enemy> get all => [...enemies, ...unique];

  static List<Enemy> get enemies => [...brick, ...bricks];

  static List<Enemy> get unique => const [];

  static List<Enemy> get brick => const [
        Brick1ConstructionEnemy(),
        Brick2ConstructionEnemy(),
        Brick3ConstructionEnemy(),
      ];

  static List<Enemy> get bricks => const [
        Bricks1ConstructionEnemy(),
        Bricks2ConstructionEnemy(),
        Bricks4ConstructionEnemy(),
        Bricks5ConstructionEnemy(),
        Bricks6ConstructionEnemy(),
      ];
}

abstract class ConstructionEnemy extends Enemy {
  const ConstructionEnemy();

  @override
  String get asset => 'construction/$id';

  @override
  Decimal get hp => Decimal.fromInt(8);

  @override
  Decimal get exp => Decimal.fromInt(1);

  @override
  List<String>? get hitSounds => [
        'sound/brick1.wav',
        'sound/brick2.wav',
        'sound/brick3.aiff',
        'sound/brick4.wav',
      ];

  @override
  Decimal get damage => Decimal.zero;
}

class Brick1ConstructionEnemy extends ConstructionEnemy {
  const Brick1ConstructionEnemy();

  @override
  String get id => 'Brick1';
}

class Brick2ConstructionEnemy extends ConstructionEnemy {
  const Brick2ConstructionEnemy();

  @override
  String get id => 'Brick2';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(1);
}

class Brick3ConstructionEnemy extends ConstructionEnemy {
  const Brick3ConstructionEnemy();

  @override
  String get id => 'Brick3';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(1);
}

class Bricks1ConstructionEnemy extends ConstructionEnemy {
  const Bricks1ConstructionEnemy();

  @override
  String get id => 'Bricks1';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(2);
}

class Bricks2ConstructionEnemy extends ConstructionEnemy {
  const Bricks2ConstructionEnemy();

  @override
  String get id => 'Bricks2';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(2);
}

class Bricks4ConstructionEnemy extends ConstructionEnemy {
  const Bricks4ConstructionEnemy();

  @override
  String get id => 'Bricks4';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(5);
}

class Bricks5ConstructionEnemy extends ConstructionEnemy {
  const Bricks5ConstructionEnemy();

  @override
  String get id => 'Bricks5';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(6);
}

class Bricks6ConstructionEnemy extends ConstructionEnemy {
  const Bricks6ConstructionEnemy();

  @override
  String get id => 'Bricks6';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(10);
}
