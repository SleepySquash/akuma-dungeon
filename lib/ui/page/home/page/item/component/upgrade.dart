import 'package:flutter/material.dart';

import '../controller.dart';

class ItemUpgradeTab extends StatelessWidget {
  const ItemUpgradeTab(this.c, {Key? key}) : super(key: key);

  final ItemController c;

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key('ItemUpgradeTab'),
      child: Text('ItemUpgradeTab'),
    );
  }
}
