import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/widget/modal_popup.dart';
import 'controller.dart';

class RoomView extends StatelessWidget {
  const RoomView({super.key});

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(context: context, child: const RoomView());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: RoomController(),
      builder: (RoomController c) {
        return const Text('Room');
      },
    );
  }
}
