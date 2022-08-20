// Copyright © 2022 NIKITA ISAENKO, <https://github.com/SleepySquash>
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU Affero General Public License v3.0 as published by the
// Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License v3.0 for
// more details.
//
// You should have received a copy of the GNU Affero General Public License v3.0
// along with this program. If not, see
// <https://www.gnu.org/licenses/agpl-3.0.html>.

import 'package:akuma/domain/model/skill.dart';

import 'item.dart';
import 'rarity.dart';

/// Role a certain [Character] has in the battle.
enum Role {
  /// Dealing damage.
  dps,

  /// Taking and reducing damage.
  tank,

  /// Healing.
  support,
}

/// Person in the [Player]'s party.
abstract class Character {
  /// [Role] this [Character] has.
  Role get role => Role.dps;

  /// Unique ID of this [Character].
  String get id;

  /// Visible name of this [Character].
  String get name => id;

  /// Optional path to the asset representing this [Character].
  String? get asset => id;

  /// [Rarity] of this [Character].
  Rarity get rarity => Rarity.useful;

  /// [Skill]s this [Character] possess.
  List<Skill> get skills => [];
}

class MyCharacter {
  MyCharacter({
    required this.character,
    this.artifacts = const [],
    List<Skill>? skills,
    this.affinity = 0,
  }) : skills = skills ?? character.skills;

  /// [Character] itself.
  final Character character;

  /// [Artifact]s equipped to this [Character].
  List<Artifact> artifacts;

  /// [Skill]s this [Character] possess.
  List<Skill> skills;

  /// Integer representation of how much this [character] loves or respects you.
  int affinity;
}
