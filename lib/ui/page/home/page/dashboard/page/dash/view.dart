import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/router.dart';
import 'controller.dart';

class DashView extends StatelessWidget {
  const DashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashController(Get.find()),
      builder: (DashController c) {
        return Center(
          child: TextButton(
            onPressed: router.dungeon,
            child: const Text('Play'),
          ),
        );
      },
    );
  }
}
