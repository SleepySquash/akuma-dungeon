import 'package:flutter/material.dart';

import '/ui/widget/backdrop.dart';

class LevelWidget extends StatelessWidget {
  const LevelWidget({
    Key? key,
    this.exp,
    required this.level,
    this.levels,
    required this.maxLevel,
  }) : super(key: key);

  final int level;
  final int maxLevel;

  final List<int>? levels;
  final int? exp;

  @override
  Widget build(BuildContext context) {
    int? currentExp = exp;
    int? nextExp;

    if (exp != null && levels != null) {
      if (level > 2) {
        currentExp = exp! - levels![level - 2];
      }

      if (level <= maxLevel) {
        nextExp = levels![level - 1];
      }
    }

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultTextStyle.merge(
                style: const TextStyle(fontSize: 18),
                child: Row(
                  children: [
                    const Text('Lv.'),
                    const Spacer(),
                    Text('$level/$maxLevel'),
                  ],
                ),
              ),
              if (currentExp != null)
                DefaultTextStyle.merge(
                  style: const TextStyle(fontSize: 13),
                  child: Row(
                    children: [
                      const Text('Exp.'),
                      const Spacer(),
                      Text('$currentExp'),
                      if (nextExp != null) Text('/$nextExp'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
