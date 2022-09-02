import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/widget/modal_popup.dart';
import 'controller.dart';

class SocialView extends StatelessWidget {
  const SocialView({Key? key}) : super(key: key);

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(context: context, child: const SocialView());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SocialController(),
      builder: (SocialController c) {
        return const Text('Social');
      },
    );
  }
}
