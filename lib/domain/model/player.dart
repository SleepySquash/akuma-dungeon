import 'package:akuma/domain/model/gender.dart';
import 'package:akuma/domain/model/race.dart';
import 'package:akuma/domain/model_type_id.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'player.g.dart';

@HiveType(typeId: ModelTypeId.player)
class Player {
  Player({
    this.name = 'Player',
    this.race = Race.ningen,
    this.gender = Gender.female,
    this.exp = 0,
    this.money = 0,
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final Race race;

  @HiveField(2)
  final Gender gender;

  @HiveField(3)
  int exp;

  @HiveField(4)
  int money;
}
