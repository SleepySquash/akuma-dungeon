import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/widget/modal_popup.dart';
import 'controller.dart';

class DailyView extends StatelessWidget {
  const DailyView({super.key});

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(context: context, child: const DailyView());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DailyController(),
      builder: (DailyController c) {
        return const Text('Daily');
      },
    );
  }
}
