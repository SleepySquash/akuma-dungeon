import 'package:flutter/material.dart';

import '/ui/widget/backdrop.dart';

class LevelWidget extends StatelessWidget {
  const LevelWidget({
    Key? key,
    this.level,
    this.maxLevel,
  }) : super(key: key);

  final int? level;
  final int? maxLevel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: ConditionalBackdropFilter(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 160,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
          ),
          padding: const EdgeInsets.all(8),
          child: DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 18),
            child: Row(
              children: [
                const Text('Lv.'),
                const Spacer(),
                Text('$level/$maxLevel'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
