enum Flag {
  commissionUnlocked,
  dungeonCommissionsUnlocked,
  dungeonsUnlocked,
  goddessTowerUnlocked,
  locationsUnlocked,
  partyUnlocked,
  storeUnlocked,
}

// TODO: Codegen.
extension FlagsExtension on Map<Flag, bool> {
  bool get commissionUnlocked => _value(Flag.commissionUnlocked);
  bool get dungeonCommissionsUnlocked =>
      _value(Flag.dungeonCommissionsUnlocked);
  bool get dungeonsUnlocked => _value(Flag.dungeonsUnlocked);
  bool get goddessTowerUnlocked => _value(Flag.goddessTowerUnlocked);
  bool get locationsUnlocked => _value(Flag.locationsUnlocked);
  bool get partyUnlocked => _value(Flag.partyUnlocked);
  bool get storeUnlocked => _value(Flag.storeUnlocked);

  bool _value(Flag flag) => this[flag] ?? false;
}
