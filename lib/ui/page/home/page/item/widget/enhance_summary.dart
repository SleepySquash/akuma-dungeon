import 'package:akuma/domain/model/item.dart';
import 'package:akuma/domain/model/stat.dart';
import 'package:akuma/domain/service/item.dart';
import 'package:akuma/ui/page/home/widget/wide_button.dart';
import 'package:akuma/ui/widget/modal_popup.dart';
import 'package:flutter/material.dart';

class EnhanceSummary extends StatelessWidget {
  const EnhanceSummary(
    this.item,
    this.result, {
    Key? key,
  }) : super(key: key);

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
          Row(
            children: [
              Text(stat.stat.type.name),
              const Spacer(),
              if (stat.stat.amount != stat.amount)
                Text('${stat.stat.amount} -> ${stat.amount}')
              else
                Text('${stat.stat.amount}'),
            ],
          ),
        if (stat != null && (stats.isNotEmpty || additional.isNotEmpty))
          const Divider(),
        ...stats.map((e) {
          return Row(
            children: [
              Text(e.stat.type.name),
              const Spacer(),
              if (e.stat.amount != e.amount)
                Text('${e.stat.amount} -> ${e.amount}')
              else
                Text('${e.stat.amount}'),
            ],
          );
        }),
        if ((stats.isNotEmpty || stat != null) && additional.isNotEmpty)
          const Divider(),
        ...additional.map((e) {
          return Row(
            children: [
              Text(e.type.name),
              const Spacer(),
              const Text('NEW'),
            ],
          );
        }),
      ];
    }

    return Column(
      children: [
        Image.asset('assets/item/${item.item.asset}.png'),
        const Text('Enhance complete!'),
        ...stats(),
        WideButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
