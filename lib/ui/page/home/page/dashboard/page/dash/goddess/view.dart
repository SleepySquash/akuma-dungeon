import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/dungeon.dart';
import '/router.dart';
import '/ui/widget/modal_popup.dart';
import 'controller.dart';

class GoddessView extends StatelessWidget {
  const GoddessView({Key? key}) : super(key: key);

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(context: context, child: const GoddessView());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: GoddessController(Get.find()),
      builder: (GoddessController c) {
        return Material(
          type: MaterialType.transparency,
          child: ListView(
            shrinkWrap: true,
            children: [
              const ListTile(title: Text('Путь к Богине')),
              ListTile(
                leading: const Icon(Icons.fort),
                title: const Text('Путь к Богине'),
                subtitle: const Text('Хватит обороняться, напади на монстров!'),
                trailing: Obx(() {
                  return Text(
                    '${c.progression.value.goddessTowerLevel}-й этаж',
                  );
                }),
                onTap: () {
                  router.dungeon(
                    InfiniteDungeon(
                      floor: c.progression.value.goddessTowerLevel,
                      onProgress: c.setGoddessTower,
                    ),
                  );
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
