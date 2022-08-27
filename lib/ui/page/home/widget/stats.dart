import 'package:flutter/material.dart';

import '/ui/widget/backdrop.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({
    Key? key,
    this.damage,
    this.defense,
    this.health,
    this.critRate,
    this.critDamage,
    this.ultCharge,
  }) : super(key: key);

  final int? damage;
  final int? defense;
  final int? health;
  final int? critRate;
  final int? critDamage;
  final int? ultCharge;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
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
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('ATK'),
                    const Spacer(),
                    Text('${damage ?? 0}'),
                  ],
                ),
                Row(
                  children: [
                    const Text('DEF'),
                    const Spacer(),
                    Text('${defense ?? 0}'),
                  ],
                ),
                Row(
                  children: [
                    const Text('HP'),
                    const Spacer(),
                    Text('${health ?? 0}'),
                  ],
                ),
                Row(
                  children: [
                    const Text('CRIT DMG'),
                    const Spacer(),
                    Text('${critDamage ?? 0}%'),
                  ],
                ),
                Row(
                  children: [
                    const Text('CRIT Rate'),
                    const Spacer(),
                    Text('${critRate ?? 0}%'),
                  ],
                ),
                Row(
                  children: [
                    const Text('ULT Rate'),
                    const Spacer(),
                    Text('${ultCharge ?? 0}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
