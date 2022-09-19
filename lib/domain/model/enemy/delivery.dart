import 'package:decimal/decimal.dart';

import '/domain/model/enemy.dart';
import '/domain/model/item/all.dart';
import '/domain/model/reward.dart';

abstract class DeliveryEnemies {
  static List<Enemy> get all => [...enemies, ...unique];

  static List<Enemy> get enemies => [...places, ...mans];

  static List<Enemy> get unique => const [SadDeliveryEnemy()];

  static List<Enemy> get places => const [
        Place1DeliveryEnemy(),
        Place2DeliveryEnemy(),
        Place3DeliveryEnemy(),
        Place4DeliveryEnemy(),
        Place5DeliveryEnemy(),
        Place6DeliveryEnemy(),
      ];

  static List<Enemy> get mans => const [
        Man1DeliveryEnemy(),
        Man2DeliveryEnemy(),
        Man3DeliveryEnemy(),
        Man4DeliveryEnemy(),
        Man5DeliveryEnemy(),
        Man6DeliveryEnemy(),
        Man7DeliveryEnemy(),
        Man8DeliveryEnemy(),
        Man9DeliveryEnemy(),
        StudentsDeliveryEnemy(),
      ];
}

abstract class DeliveryEnemy extends Enemy {
  const DeliveryEnemy();

  @override
  String get asset => 'delivery/$id';

  @override
  String get ext => '.jpg';

  @override
  Decimal get hp => Decimal.fromInt(12);

  @override
  Decimal get exp => Decimal.fromInt(1);

  @override
  List<String>? get hitSounds =>
      ['sound/crunch1.wav', 'sound/crunch2.wav', 'sound/crunch3.wav'];

  @override
  List<Reward> get drops => [
        ChanceItemReward(const Ruby(), 0.02),
      ];

  @override
  Decimal get damage => Decimal.zero;
}

abstract class PlaceDeliveryEnemy extends DeliveryEnemy {
  const PlaceDeliveryEnemy();

  @override
  Decimal get hp => Decimal.fromInt(21);

  @override
  List<String>? get slayedSounds => ['sound/shu-shu-equip.m4a'];
}

abstract class ManDeliveryEnemy extends DeliveryEnemy {
  const ManDeliveryEnemy();

  @override
  List<String>? get slayedSounds => [
        'sound/nice_one.mp3',
        'sound/mhm_cartoon.wav',
        'sound/nice_cartoon.wav',
        'sound/hajimemashite.mp3',
      ];
}

class Place1DeliveryEnemy extends PlaceDeliveryEnemy {
  const Place1DeliveryEnemy();

  @override
  String get id => 'Place1';
}

class Place2DeliveryEnemy extends PlaceDeliveryEnemy {
  const Place2DeliveryEnemy();

  @override
  String get id => 'Place2';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(1);
}

class Place3DeliveryEnemy extends PlaceDeliveryEnemy {
  const Place3DeliveryEnemy();

  @override
  String get id => 'Place3';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(2);
}

class Place4DeliveryEnemy extends PlaceDeliveryEnemy {
  const Place4DeliveryEnemy();

  @override
  String get id => 'Place4';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(3);
}

class Place5DeliveryEnemy extends PlaceDeliveryEnemy {
  const Place5DeliveryEnemy();

  @override
  String get id => 'Place5';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(4);
}

class Place6DeliveryEnemy extends PlaceDeliveryEnemy {
  const Place6DeliveryEnemy();

  @override
  String get id => 'Place6';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(5);
}

class Man1DeliveryEnemy extends ManDeliveryEnemy {
  const Man1DeliveryEnemy();

  @override
  String get id => 'Man1';
}

class Man2DeliveryEnemy extends ManDeliveryEnemy {
  const Man2DeliveryEnemy();

  @override
  String get id => 'Man2';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(1);
}

class Man3DeliveryEnemy extends ManDeliveryEnemy {
  const Man3DeliveryEnemy();

  @override
  String get id => 'Man3';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(2);
}

class Man4DeliveryEnemy extends ManDeliveryEnemy {
  const Man4DeliveryEnemy();

  @override
  String get id => 'Man4';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(3);
}

class Man5DeliveryEnemy extends ManDeliveryEnemy {
  const Man5DeliveryEnemy();

  @override
  String get id => 'Man5';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(4);
}

class Man6DeliveryEnemy extends ManDeliveryEnemy {
  const Man6DeliveryEnemy();

  @override
  String get id => 'Man6';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(5);
}

class Man7DeliveryEnemy extends ManDeliveryEnemy {
  const Man7DeliveryEnemy();

  @override
  String get id => 'Man7';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(6);
}

class Man8DeliveryEnemy extends ManDeliveryEnemy {
  const Man8DeliveryEnemy();

  @override
  String get id => 'Man8';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(1);
}

class Man9DeliveryEnemy extends ManDeliveryEnemy {
  const Man9DeliveryEnemy();

  @override
  String get id => 'Man9';
}

class StudentsDeliveryEnemy extends ManDeliveryEnemy {
  const StudentsDeliveryEnemy();

  @override
  String get id => 'Students';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(4);
}

class SadDeliveryEnemy extends ManDeliveryEnemy {
  const SadDeliveryEnemy();

  @override
  String get id => 'Sad';

  @override
  Decimal get hp => super.hp + Decimal.fromInt(10);
}
