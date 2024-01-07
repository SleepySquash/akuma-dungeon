import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '/ui/widget/backdrop.dart';

class LevelWidget extends StatelessWidget {
  const LevelWidget({
    Key? key,
    this.exp,
    this.maxExp,
    required this.level,
    required this.maxLevel,
  }) : super(key: key);

  final int level;
  final int maxLevel;

  final Decimal? exp;
  final Decimal? maxExp;

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultTextStyle.merge(
                style: const TextStyle(fontSize: 18),
                child: Row(
                  children: [
                    const Text('Lv.'),
                    const Spacer(),
                    Text('${level + 1}/$maxLevel'),
                  ],
                ),
              ),
              if (exp != null)
                DefaultTextStyle.merge(
                  style: const TextStyle(fontSize: 13),
                  child: Row(
                    children: [
                      const Text('Exp.'),
                      const Spacer(),
                      Text('${exp?.toStringAsFixed(0)}'),
                      if (maxExp != null) Text('/$maxExp'),
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
