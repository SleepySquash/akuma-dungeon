import 'package:akuma/domain/model/character.dart';
import 'package:akuma/domain/model/character/standard.dart';
import 'package:akuma/ui/page/home/widget/wide_button.dart';
import 'package:akuma/ui/widget/button.dart';
import 'package:akuma/util/platform_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class CharacterSelectionView extends StatelessWidget {
  const CharacterSelectionView({Key? key}) : super(key: key);

  static Future<T?> show<T extends Object?>(BuildContext context) {
    return Navigator.of(context).push(
      RawDialogRoute(
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: (context, animation, secondary, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
            child: child,
          );
        },
        pageBuilder: (BuildContext context, _, __) {
          return const CharacterSelectionView();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CharacterSelectionController(Get.find(), Get.find()),
      builder: (CharacterSelectionController c) {
        Widget selected(Character e) {
          return WidgetButton(
            onPressed: () => c.selected.value = e,
            child: Obx(() {
              return AnimatedContainer(
                duration: 300.milliseconds,
                width: double.infinity,
                height: double.infinity,
                color:
                    c.selected.value == e ? Colors.green : Colors.transparent,
                child: Image.asset('assets/character/${e.asset}.png'),
              );
            }),
          );
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/background/misc/sky.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Flex(
              direction: context.isMobile ? Axis.vertical : Axis.horizontal,
              children: c.characters
                  .map(
                    (e) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: selected(e),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Obx(() {
                  return WideButton(
                    onPressed: c.selected.value != null
                        ? () {
                            c.select();
                            Navigator.of(context).pop(c.selected.value);
                          }
                        : null,
                    child: const Text('Done'),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}
