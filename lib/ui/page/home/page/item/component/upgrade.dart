import 'package:flutter/material.dart';

import '../controller.dart';

class ItemUpgradeTab extends StatelessWidget {
  const ItemUpgradeTab(this.c, {super.key});

  final ItemController c;

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key('ItemUpgradeTab'),
      child: Text('ItemUpgradeTab'),
    );
  }
}
