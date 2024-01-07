import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/widget/modal_popup.dart';
import 'controller.dart';

class BattlePassView extends StatelessWidget {
  const BattlePassView({super.key});

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(context: context, child: const BattlePassView());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BattlePassController(),
      builder: (BattlePassController c) {
        return const Text('Battle pass');
      },
    );
  }
}
