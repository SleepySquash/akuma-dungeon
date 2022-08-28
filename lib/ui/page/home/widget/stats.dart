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
    this.stats = const [],
  }) : super(key: key);

  final int? damage;
  final int? defense;
  final int? health;
  final int? critRate;
  final int? critDamage;
  final int? ultCharge;
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
                if (stats.isNotEmpty) const Divider(),
                if (stats.isNotEmpty)
                  ...stats.map((e) {
                    String? name;
                    String prefix = '+';
                    String postfix = '';

                    if (e is AtkStat) {
                      name = 'ATK';
                    } else if (e is DefStat) {
                      name = 'DEF';
                    } else if (e is HpStat) {
                      name = 'HP';
                    } else if (e is UltStat) {
                      name = 'ULT Rate';
                    } else if (e is AtkPercentStat) {
                      name = 'ATK';
                      postfix = '%';
                    } else if (e is DefPercentStat) {
                      name = 'DEF';
                      postfix = '%';
                    } else if (e is HpPercentStat) {
                      name = 'HP';
                      postfix = '%';
                    } else if (e is CritRateStat) {
                      name = 'Crit Rate';
                      postfix = '%';
                    } else if (e is CritDmgStat) {
                      name = 'Crit DMG';
                      postfix = '%';
                    } else if (e is UltPercentStat) {
                      name = 'ULT Rate';
                      postfix = '%';
                    }

                    return Row(
                      children: [
                        Text(name ?? '...'),
                        const Spacer(),
                        Text('$prefix${e.amount}$postfix'),
                      ],
                    );
                  }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
