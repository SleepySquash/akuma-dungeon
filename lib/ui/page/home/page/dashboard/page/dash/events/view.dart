import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/widget/modal_popup.dart';
import 'controller.dart';

class EventsView extends StatelessWidget {
  const EventsView({Key? key}) : super(key: key);

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(context: context, child: const EventsView());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: EventsController(),
      builder: (EventsController c) {
        return const Text('Events');
      },
    );
  }
}
