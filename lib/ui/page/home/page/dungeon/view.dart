import 'package:akuma/domain/model/enemy.dart';
import 'package:akuma/ui/page/home/page/dungeon/component/menu.dart';
import 'package:akuma/ui/widget/button.dart';
import 'package:akuma/ui/widget/dummy_character.dart';
import 'package:akuma/ui/widget/modal_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DungeonView extends StatelessWidget {
  const DungeonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DungeonController(Get.find()),
      builder: (DungeonController c) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/background/dungeon/fields.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                alignment: Alignment.center,
                children: [
                  _enemy(c),
                  Column(
                    children: [
                      _top(c, context),
                      Expanded(child: _middle(c, context)),
                      _bottom(c, context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _enemy(DungeonController c) {
    return Obx(() {
      Enemy? enemy = c.enemy.value;
      return AnimatedSwitcher(
        duration: 600.milliseconds,
        switchInCurve: Curves.easeOutQuad,
        switchOutCurve: Curves.easeInQuad,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: enemy != null
            ? WidgetButton(
                key: Key(c.enemy.value!.id),
                onPressed: c.hitEnemy,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Image.asset(
                    'assets/monster/${enemy.asset ?? enemy.name}.png',
                  ),
                ),
              )
            : Container(),
      );
    });
  }

  Widget _top(DungeonController c, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Obx(() {
                Enemy? enemy = c.enemy.value;
                if (enemy != null) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(enemy.name),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              minHeight: 20,
                              value: 1 - enemy.hp / enemy.maxHp,
                              backgroundColor: Colors.red,
                              color: Colors.grey,
                            ),
                          ),
                          Text('${enemy.hp}/${enemy.maxHp}'),
                        ],
                      )
                    ],
                  );
                }

                return Container();
              }),
            ),
          ),
        ),
        WidgetButton(
          onPressed: () => ModalPopup.show(
            context: context,
            child: DungeonMenu(c),
          ),
          child: const Icon(Icons.menu),
        ),
      ],
    );
  }

  Widget _middle(DungeonController c, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: const [Text('Skills...')],
        ),
        const Spacer(),
      ],
    );
  }

  Widget _bottom(DungeonController c, BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          WidgetButton(
            child: Container(
              margin: const EdgeInsets.only(left: 8, bottom: 0),
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth / 4,
                maxHeight: 200,
              ),
              width: 180,
              height: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: DummyCharacter(
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                        gender: c.player.value!.gender,
                        race: c.player.value!.race,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 100),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: const LinearProgressIndicator(
                                minHeight: 20,
                                value: 0.2,
                                backgroundColor: Colors.green,
                                color: Colors.grey,
                              ),
                            ),
                            const Text('8/10'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
