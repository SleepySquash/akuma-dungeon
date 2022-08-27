import 'package:flutter/material.dart';

import '../controller.dart';
import '/ui/page/home/widget/stats.dart';

class ItemAttributesTab extends StatelessWidget {
  const ItemAttributesTab(this.c, {Key? key}) : super(key: key);

  final ItemController c;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('ItemAttributesTab'),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [StatsWidget()],
        ),
        const Spacer(),
      ],
    );
  }
}
