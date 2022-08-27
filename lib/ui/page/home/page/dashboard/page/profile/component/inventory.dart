import 'package:flutter/material.dart';

import '../controller.dart';
import '/ui/widget/backdrop.dart';
import '/ui/widget/item_grid.dart';
import '/util/platform_utils.dart';

class ProfileInventoryTab extends StatelessWidget {
  const ProfileInventoryTab(this.c, {Key? key}) : super(key: key);

  final ProfileController c;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      key: const Key('ProfileInventoryTab'),
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
                    text: 'Weapon',
                    icon: Icon(Icons.swipe_rounded),
                  ),
                  Tab(
                    text: 'Equip',
                    icon: Icon(Icons.accessibility_new),
                  ),
                  Tab(
                    text: 'Artifact',
                    icon: Icon(Icons.dashboard),
                  ),
                  Tab(
                    text: 'Food',
                    icon: Icon(Icons.fastfood),
                  ),
                  Tab(
                    text: 'Staff',
                    icon: Icon(Icons.auto_awesome),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(right: context.isMobile ? 40 : 120),
            child: TabBarView(
              children: [
                ItemGrid(
                  category: InventoryCategory.weapon,
                  items: c.items.values,
                ),
                ItemGrid(
                  category: InventoryCategory.equip,
                  items: c.items.values,
                ),
                ItemGrid(
                  category: InventoryCategory.artifact,
                  items: c.items.values,
                ),
                ItemGrid(
                  category: InventoryCategory.food,
                  items: c.items.values,
                ),
                ItemGrid(
                  category: InventoryCategory.stuff,
                  items: c.items.values,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
