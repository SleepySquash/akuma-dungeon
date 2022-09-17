import 'package:decimal/decimal.dart';

import '/domain/model/enemy.dart';
import '/domain/model/item/all.dart';
import '/domain/model/reward.dart';

abstract class VeggieEnemies {
  static List<Enemy> get all => [
        ...enemies,
        ...unique,
      ];

  static List<Enemy> get enemies => [
        ...f,
      ];

  static List<Enemy> get unique => [
        ...fPlus,
      ];

  static List<Enemy> get f => const [
        BroccoliEnemy(),
        CabbageEnemy(),
        CarrotEnemy(),
        ChiliEnemy(),
        CornEnemy(),
        CucumberEnemy(),
        PotatoEnemy(),
      ];

  static List<Enemy> get fPlus => const [
        OnionEnemy(),
      ];
}

abstract class Veggie extends Enemy {
  const Veggie();

  @override
  String get asset => 'veggies/$id';

  @override
  Decimal get hp => Decimal.fromInt(21);

  @override
  Decimal get exp => Decimal.fromInt(2);

  @override
  List<String>? get hitSounds => [
        'sound/veggie1.wav',
        'sound/veggie2.wav',
        'sound/crunch1.wav',
        'sound/crunch2.wav',
        'sound/crunch3.wav',
      ];

  @override
  List<String>? get slayedSounds => null;

  @override
  List<Reward> get drops => [
        ChanceItemReward(const Ruby(), 0.05),
      ];

  @override
  Decimal get damage => Decimal.zero;
}

class BroccoliEnemy extends Veggie {
  const BroccoliEnemy();

  @override
  String get id => 'Broccoli';
}

class CabbageEnemy extends Veggie {
  const CabbageEnemy();

  @override
  String get id => 'Cabbage';
}

class CarrotEnemy extends Veggie {
  const CarrotEnemy();

  @override
  String get id => 'Carrot';
}

class ChiliEnemy extends Veggie {
  const ChiliEnemy();

  @override
  String get id => 'Chili';
}

class CornEnemy extends Veggie {
  const CornEnemy();

  @override
  String get id => 'Corn';
}

class CucumberEnemy extends Veggie {
  const CucumberEnemy();

  @override
  String get id => 'Cucumber';
}

class PotatoEnemy extends Veggie {
  const PotatoEnemy();

  @override
  String get id => 'Potato';
}

class OnionEnemy extends Veggie {
  const OnionEnemy();

  @override
  String get id => 'Onion';

  @override
  Decimal get hp => Decimal.fromInt(140);
}
