import 'package:flutter/material.dart';

import '../controller.dart';

class ItemEnhanceTab extends StatelessWidget {
  const ItemEnhanceTab(this.c, {Key? key}) : super(key: key);

  final ItemController c;

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key('ItemEnhanceTab'),
      child: Text('ItemEnhanceTab'),
    );
  }
}
