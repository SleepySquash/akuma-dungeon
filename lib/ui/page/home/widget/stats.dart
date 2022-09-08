import 'package:flutter/material.dart';

import '/domain/model/stat.dart';
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
    this.stat,
    this.stats = const [],
  }) : super(key: key);

  final int? damage;
  final int? defense;
  final int? health;
  final int? critRate;
  final int? critDamage;
  final int? ultCharge;
  final Stat? stat;
  final List<Stat> stats;

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
            child: Column(
              children: [
                if (damage != null)
                  Row(
                    children: [
                      const Text('ATK'),
                      const Spacer(),
                      Text('${damage ?? 0}'),
                    ],
                  ),
                if (defense != null)
                  Row(
                    children: [
                      const Text('DEF'),
                      const Spacer(),
                      Text('${defense ?? 0}'),
                    ],
                  ),
                if (health != null)
                  Row(
                    children: [
                      const Text('HP'),
                      const Spacer(),
                      Text('${health ?? 0}'),
                    ],
                  ),
                if (critDamage != null)
                  Row(
                    children: [
                      const Text('CRIT DMG'),
                      const Spacer(),
                      Text('${critDamage ?? 0}%'),
                    ],
                  ),
                if (critRate != null)
                  Row(
                    children: [
                      const Text('CRIT Rate'),
                      const Spacer(),
                      Text('${critRate ?? 0}%'),
                    ],
                  ),
                if (ultCharge != null)
                  Row(
                    children: [
                      const Text('ULT Rate'),
                      const Spacer(),
                      Text('${ultCharge ?? 0}'),
                    ],
                  ),
                if (stat != null) _stat(stat!),
                if ((damage != null ||
                        defense != null ||
                        health != null ||
                        critRate != null ||
                        critDamage != null ||
                        ultCharge != null ||
                        stat != null) &&
                    (stats.isNotEmpty))
                  const Divider(),
                if (stats.isNotEmpty) ...stats.map(_stat),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _stat(Stat e) {
    String? name;
    String prefix = '+';
    String postfix = '';

    switch (e.type) {
      case StatType.atk:
        name = 'ATK';
        break;

      case StatType.atkPercent:
        name = 'ATK';
        postfix = '%';
        break;

      case StatType.critDamage:
        name = 'Crit DMG';
        postfix = '%';
        break;

      case StatType.critRate:
        name = 'Crit Rate';
        postfix = '%';
        break;

      case StatType.def:
        name = 'DEF';
        break;

      case StatType.defPercent:
        name = 'DEF';
        postfix = '%';
        break;

      case StatType.hp:
        name = 'HP';
        break;

      case StatType.hpPercent:
        name = 'HP';
        postfix = '%';
        break;

      case StatType.ult:
        name = 'ULT Rate';
        break;

      case StatType.ultPercent:
        name = 'ULT Rate';
        postfix = '%';
        break;
    }

    return Row(
      children: [
        Text(name),
        const Spacer(),
        Text('$prefix${e.amount}$postfix'),
      ],
    );
  }
}
