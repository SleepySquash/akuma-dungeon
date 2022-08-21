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

import 'dart:math';

import 'package:flutter/material.dart' hide Characters;
import 'package:get/get.dart';

import '/domain/model/character.dart';
import '/domain/model/character/all.dart';
import '/domain/model/rarity.dart';
import '/ui/page/home/page/character/view.dart';
import '/ui/widget/backdrop.dart';
import '/util/extensions.dart';
import 'controller.dart';

class PartyView extends StatelessWidget {
  const PartyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PartyController(Get.find(), Get.find()),
      builder: (PartyController c) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Party'),
          ),
          body: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(bottom: 4),
                child: Center(child: _top(c)),
              ),
              Expanded(child: _bottom(c)),
            ],
          ),
        );
      },
    );
  }

  Widget _top(PartyController c) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = 900;

      double? width, height;
      if (MediaQuery.of(context).size.width <
          MediaQuery.of(context).size.height) {
        width = min(constraints.maxWidth, 900) / 5;
      } else {
        height = MediaQuery.of(context).size.height / 4;
        maxWidth = height * 0.7 * 5;
      }

      return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (i) {
            Character? character;
            if ((c.player.value?.party.length ?? 0) > i) {
              character = c.player.value!.party[i];
            }

            return SizedBox(
              width: width,
              height: height,
              child: AspectRatio(
                aspectRatio: 0.7,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: character == null
                      ? const Icon(Icons.add)
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/character/${character.asset}.png',
                            ),
                          ],
                        ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  Widget _bottom(PartyController c) {
    List<Character> all() {
      return [
        ...c.characters.values.map((e) => e.character),
        ...Characters.all.where((e) => !c.contains(e.id)),
      ];
    }

    Widget _characters(Iterable<Character> filter) {
      return Container(
        margin: const EdgeInsets.all(2),
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: filter.map((e) {
                MyCharacter? owned = c.characters[e.id];
                return SizedBox(
                  width: constraints.maxWidth > 500
                      ? (500 / 3)
                      : constraints.maxWidth / 3,
                  child: AspectRatio(
                    aspectRatio: 0.7,
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            e.rarity.color,
                            e.rarity.color.darken(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => CharacterView.show(
                          context: context,
                          myCharacter: owned,
                          character: e,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Hero(
                              tag: e.id,
                              child: Image.asset(
                                'assets/character/${e.asset}.png',
                              ),
                            ),
                            if (owned == null) ...[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              const Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 48,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }),
      );
    }

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 56),
          child: ConditionalBackdropFilter(
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.4),
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  const Expanded(
                    child: TabBar(
                      unselectedLabelColor: Colors.black54,
                      labelColor: Colors.black,
                      tabs: [
                        Tab(
                          text: 'All',
                          icon: Icon(Icons.people_alt),
                          iconMargin: EdgeInsets.zero,
                        ),
                        Tab(
                          text: 'Tank',
                          icon: Icon(Icons.shield),
                          iconMargin: EdgeInsets.zero,
                        ),
                        Tab(
                          text: 'DPS',
                          icon: Icon(Icons.water_drop),
                          iconMargin: EdgeInsets.zero,
                        ),
                        Tab(
                          text: 'Support',
                          icon: Icon(Icons.local_hospital),
                          iconMargin: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(onPressed: () {}, child: const Text('Filter')),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _characters(all()),
              _characters(all().where((e) => e.role == Role.tank)),
              _characters(all().where((e) => e.role == Role.dps)),
              _characters(all().where((e) => e.role == Role.support)),
            ],
          ),
        ),
      ),
    );
  }
}
