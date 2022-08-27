import 'package:flutter/material.dart';

import '../controller.dart';
import '/ui/page/home/widget/stats.dart';

class CharacterAttributesTab extends StatelessWidget {
  const CharacterAttributesTab(this.c, {Key? key}) : super(key: key);

  final CharacterController c;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('CharacterAttributesTab'),
      children: [
        if (c.myCharacter != null)
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [StatsWidget()],
          ),
        const Spacer(),
      ],
    );
  }
}
