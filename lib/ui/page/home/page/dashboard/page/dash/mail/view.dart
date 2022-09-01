import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/widget/modal_popup.dart';
import 'controller.dart';

class MailView extends StatelessWidget {
  const MailView({Key? key}) : super(key: key);

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(context: context, child: const MailView());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MailController(),
      builder: (MailController c) {
        return const Text('Mail');
      },
    );
  }
}
