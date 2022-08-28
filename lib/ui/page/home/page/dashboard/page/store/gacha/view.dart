import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '/domain/model/character.dart';
import '/domain/model/item.dart';
import '/domain/model/rarity.dart';
import '/domain/service/gacha.dart';
import 'controller.dart';

class GachaView extends StatelessWidget {
  GachaView({
    Key? key,
    this.type = GachaType.character,
    this.amount = 1,
  }) : super(key: key);

  final GachaType type;
  final int amount;

  final String _tag = const Uuid().v4();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      tag: _tag,
      init: GachaController(Get.find(), type: type, amount: amount),
      builder: (GachaController c) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/background/misc/sky.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Obx(() {
              Widget text;
              Rarity rarity = Rarity.common;
              Widget child;

              dynamic loot;

              if (c.index.value < c.loot.length) {
                loot = c.loot[c.index.value];
              }

              if (loot is Item) {
                child = Image.asset('assets/item/${loot.asset}.png');
                text = BorderedText(
                  child: Text(
                    loot.name,
                    style: TextStyle(
                      fontSize: 32,
                      color: loot.rarity.color,
                    ),
                  ),
                );
                rarity = loot.rarity;
              } else if (loot is Character) {
                child = Image.asset('assets/character/${loot.asset}.png');
                text = BorderedText(
                  child: Text(
                    loot.name,
                    style: TextStyle(
                      fontSize: 32,
                      color: loot.rarity.color,
                    ),
                  ),
                );
                rarity = loot.rarity;
              } else {
                child = const Text('Not found :(');
                text = const Text('Not found :(');
              }

              return GestureDetector(
                onTap: c.tapLocked.value
                    ? null
                    : () {
                        c.lockTap();
                        c.index.value++;
                        if (c.index.value >= c.loot.length) {
                          Navigator.of(context).pop();
                        }
                      },
                child: AnimatedSwitcher(
                  duration: 600.milliseconds,
                  switchInCurve: Curves.easeOutQuad,
                  switchOutCurve: Curves.easeInQuad,
                  transitionBuilder: (child, animation) => SlideTransition(
                    position:
                        Tween(begin: const Offset(0, -0.2), end: Offset.zero)
                            .animate(animation),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    key: Key(loot.hashCode.toString()),
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.transparent,
                      ),
                      Center(child: child),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 48,
                            right: 48,
                            left: 48,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              DefaultTextStyle.merge(
                                textAlign: TextAlign.end,
                                child: text,
                              ),
                              Text(rarity.name),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
