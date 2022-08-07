import '../enemy.dart';

abstract class FieldEnemies {
  static List<Enemy> get enemies => [
        GreenSlimeEnemy(),
        BlueSlimeEnemy(),
        RedSlimeEnemy(),
        CatSlimeEnemy(),
      ];
}

class GreenSlimeEnemy extends Enemy {
  @override
  String get name => 'Green Slime';
}

class BlueSlimeEnemy extends Enemy {
  @override
  String get name => 'Blue Slime';

  @override
  int get maxHp => 14;
}

class RedSlimeEnemy extends Enemy {
  @override
  String get name => 'Red Slime';

  @override
  int get maxHp => 20;
}

class CatSlimeEnemy extends Enemy {
  @override
  String get name => 'Cat Slime';

  @override
  int get money => 16;

  @override
  int get exp => 2;

  @override
  int get maxHp => 30;
}
