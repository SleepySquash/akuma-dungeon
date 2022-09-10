import 'package:flutter/material.dart' show IconData, Icons;
import 'package:hive/hive.dart';

import '/domain/model_type_id.dart';
import '/util/new_type.dart';
import 'commission.dart';

part 'location.g.dart';

abstract class Location {
  const Location();

  String get id;

  String get name => id;
  String? get description => null;

  String get asset => id;

  IconData get icon => Icons.help;

  List<LocationFeature> get features => const [];

  List<QuestCommission> get commissions => const [];
  List<DungeonCommission> get dungeons => const [];
}

@HiveType(typeId: ModelTypeId.locationId)
class LocationId extends NewType<String> {
  const LocationId(String val) : super(val);
}

abstract class LocationFeature {
  const LocationFeature();
}

enum RealEstateType { apartment, villa }

class RealEstateFeature extends LocationFeature {
  const RealEstateFeature({this.type = RealEstateType.apartment});
  final RealEstateType type;
}

class AdventurerGuildFeature extends LocationFeature {
  const AdventurerGuildFeature();
}

class StoreFeature extends LocationFeature {
  const StoreFeature();
}

class MyLocation {
  MyLocation(
    this.location, {
    this.control = 0,
    this.reputation = 0,
    List<MyCommission>? commissions,
  })  : id = LocationId(location.id),
        commissions = commissions ?? List.empty(growable: true);

  final Location location;
  final LocationId id;
  int control;
  int reputation;

  List<MyCommission> commissions;

  bool get hasAdventurerGuild =>
      location.features.whereType<AdventurerGuildFeature>().isNotEmpty;
  bool get hasStore => location.features.whereType<StoreFeature>().isNotEmpty;
  bool get hasEstate =>
      location.features.whereType<RealEstateFeature>().isNotEmpty;
}
