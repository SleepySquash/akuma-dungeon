import 'package:uuid/uuid.dart';

abstract class Enemy {
  Enemy({int? hp}) {
    this.hp = hp ?? maxHp;
  }

  final String id = const Uuid().v4();

  String get name => 'Enemy';

  String? get asset => null;

  int get maxHp => 10;

  int get exp => 1;
  int get money => 10;

  late int hp;
}
