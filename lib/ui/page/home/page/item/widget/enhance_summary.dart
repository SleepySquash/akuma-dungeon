import 'package:akuma/domain/model/item.dart';
import 'package:akuma/domain/model/rarity.dart';
import 'package:akuma/domain/model/stat.dart';
import 'package:akuma/domain/service/item.dart';
import 'package:akuma/theme.dart';
import 'package:akuma/ui/page/home/widget/wide_button.dart';
import 'package:akuma/ui/widget/modal_popup.dart';
import 'package:flutter/material.dart';

class EnhanceSummary extends StatelessWidget {
  const EnhanceSummary(
    this.item,
    this.result, {
    super.key,
  });

  final MyItem item;
  final EnhanceResult? result;

  static Future<T?> show<T>(
    BuildContext context,
    MyItem item,
    EnhanceResult? result,
  ) {
    return ModalPopup.show(
      context: context,
      child: EnhanceSummary(item, result),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stats() {
      if (result == null) {
        return [Container()];
      }

      StatTween? stat = result!.stat;
      List<StatTween> stats = result!.stats;
      List<Stat> additional = result!.additional;

      return [
        if (stat != null)
          DefaultTextStyle(
            style: const TextStyle(fontSize: 21, color: Colors.black),
            child: Row(
              children: [
                Text(stat.stat.type.localized),
                const Spacer(),
                if (stat.stat.amount != stat.amount)
                  Text('${stat.stat.amount} -> ${stat.amount}')
                else
                  Text('${stat.stat.amount}'),
              ],
            ),
          ),
        if (stat != null && (stats.isNotEmpty || additional.isNotEmpty))
          const Divider(),
        ...stats.map((e) {
          return DefaultTextStyle(
            style: const TextStyle(fontSize: 17, color: Colors.black),
            child: Row(
              children: [
                Text(e.stat.type.name),
                const Spacer(),
                if (e.stat.amount != e.amount)
                  Text('${e.stat.amount} -> ${e.amount}')
                else
                  Text('${e.stat.amount}'),
              ],
            ),
          );
        }),
        if ((stats.isNotEmpty || stat != null) && additional.isNotEmpty)
          const Divider(),
        ...additional.map((e) {
          return DefaultTextStyle(
            style: const TextStyle(fontSize: 17, color: Colors.black),
            child: Row(
              children: [
                Text(e.type.name),
                const Spacer(),
                const Text('NEW'),
              ],
            ),
          );
        }),
      ];
    }

    String? subtitle;
    if (item is MyWeapon) {
      subtitle = 'Lv. ${(item as MyWeapon).level + 1}';
    } else if (item is MyEquipable) {
      subtitle = 'Lv. ${(item as MyEquipable).level + 1}';
    } else if (item is MyArtifact) {
      subtitle = 'Lv. ${(item as MyArtifact).level + 1}';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Enhanced', style: TextStyle(fontSize: 32)),
        const SizedBox(height: 20),
        Container(
          width: 100,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (item.item.rarity.color).withOpacity(0.56),
            boxShadow: [
              CustomBoxShadow(
                blurRadius: 4,
                color: Colors.black.withOpacity(0.2),
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Image.asset('assets/item/${item.item.asset}.png'),
              ),
              Container(
                width: double.infinity,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Center(child: Text(subtitle ?? '')),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            children: stats(),
          ),
        ),
        const SizedBox(height: 20),
        WideButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Close'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
