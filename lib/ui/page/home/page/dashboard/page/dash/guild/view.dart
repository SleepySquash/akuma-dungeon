import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/widget/modal_popup.dart';
import 'controller.dart';

class GuildView extends StatelessWidget {
  const GuildView({super.key});

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(context: context, child: const GuildView());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: GuildController(),
      builder: (GuildController c) {
        return const Text('Guild');
      },
    );
  }
}
