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

import 'package:akuma/domain/model/gender.dart';
import 'package:akuma/domain/model/race.dart';
import 'package:flutter/widgets.dart';

class DummyCharacter extends StatelessWidget {
  const DummyCharacter({
    Key? key,
    this.race = Race.ningen,
    this.gender = Gender.female,
    this.alignment = Alignment.center,
    this.fit = BoxFit.fitHeight,
  }) : super(key: key);

  final Race race;
  final Gender gender;

  final AlignmentGeometry alignment;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    String asset;

    switch (race) {
      case Race.ningen:
        switch (gender) {
          case Gender.female:
            asset = 'Adela';
            break;
          case Gender.male:
            asset = 'Alex';
            break;
        }
        break;

      case Race.inu:
        switch (gender) {
          case Gender.female:
            asset = 'Li_Dailin';
            break;
          case Gender.male:
            asset = 'Camilo';
            break;
        }
        break;

      case Race.kitsune:
        switch (gender) {
          case Gender.female:
            asset = 'Dr._Nadja';
            break;
          case Gender.male:
            asset = 'Nathapon';
            break;
        }
        break;

      case Race.neko:
        switch (gender) {
          case Gender.female:
            asset = 'Emma';
            break;
          case Gender.male:
            asset = 'HyunWoo';
            break;
        }
        break;

      case Race.okami:
        switch (gender) {
          case Gender.female:
            asset = 'Chiara';
            break;
          case Gender.male:
            asset = 'Daniel';
            break;
        }
        break;

      case Race.tanuki:
        switch (gender) {
          case Gender.female:
            asset = 'Eleven';
            break;
          case Gender.male:
            asset = 'Yuki';
            break;
        }
        break;

      case Race.usagi:
        switch (gender) {
          case Gender.female:
            asset = 'Sua';
            break;
          case Gender.male:
            asset = 'Shoichi';
            break;
        }
        break;
    }

    return Image.asset(
      'assets/character/$asset.png',
      alignment: alignment,
      fit: fit,
    );
  }
}
