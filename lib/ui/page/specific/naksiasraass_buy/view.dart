import 'package:akuma/domain/model/character.dart';
import 'package:akuma/domain/model/character/standard.dart';
import 'package:akuma/router.dart';
import 'package:akuma/ui/page/home/widget/wide_button.dart';
import 'package:akuma/ui/widget/backdrop.dart';
import 'package:akuma/ui/widget/button.dart';
import 'package:akuma/util/platform_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class NaksiasraassBuyView extends StatelessWidget {
  const NaksiasraassBuyView({Key? key}) : super(key: key);

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
          return const NaksiasraassBuyView();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: NaksiasraassBuyController(Get.find()),
      builder: (NaksiasraassBuyController c) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/background/location/old_house_zombie.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Image.asset(
                      'assets/character/Naksiasraass.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Flexible(child: Container(width: 450)),
              ],
            ),
            Row(
              children: [
                Flexible(child: Container(width: 450)),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Image.asset(
                      'assets/character/Beloukas.webp',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    WideButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        router.home();
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ConditionalBackdropFilter(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                const Text('Required'),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/item/resource/dogecoin.png',
                                      width: 20,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${c.amount}',
                                      style: TextStyle(
                                        color: c.money >= c.amount
                                            ? Colors.black
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        WideButton(
                          onPressed: c.money >= c.amount
                              ? () {
                                  // c.buy();
                                  // Navigator.of(context).pop(true);
                                }
                              : null,
                          child: const Text('Buy'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
