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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/widget/backdrop.dart';
import 'controller.dart';

class StoreView extends StatelessWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StoreController(Get.find(), Get.find()),
      builder: (StoreController c) {
        return DefaultTabController(
          length: 5,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: const Size(double.infinity, 56),
              child: ConditionalBackdropFilter(
                child: AppBar(
                  backgroundColor: Colors.white.withOpacity(0.4),
                  automaticallyImplyLeading: false,
                  title: const TabBar(
                    unselectedLabelColor: Colors.black54,
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                        text: 'Featured',
                        icon: Icon(Icons.star),
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        text: 'Event',
                        icon: Icon(Icons.event),
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        text: 'Standard',
                        icon: Icon(Icons.face),
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        text: 'Equipment',
                        icon: Icon(Icons.extension),
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        text: 'Items',
                        icon: Icon(Icons.warehouse),
                        iconMargin: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: TabBarView(
                children: [
                  _featured(c),
                  _event(c),
                  _standard(c),
                  _equipment(c),
                  _items(c),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _featured(StoreController c) {
    return const Text('Featured');
  }

  Widget _event(StoreController c) {
    return const Text('Event');
  }

  Widget _standard(StoreController c) {
    return const Text('Standard');
  }

  Widget _equipment(StoreController c) {
    return const Text('Equipment');
  }

  Widget _items(StoreController c) {
    return const Text('Items');
  }
}
