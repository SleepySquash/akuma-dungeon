import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/widget/modal_popup.dart';
import 'controller.dart';

class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({Key? key}) : super(key: key);

  static Future<T?> show<T>(BuildContext context) {
    return ModalPopup.show(
        context: context, child: const ProfileSettingsView());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileSettingsController(Get.find()),
      builder: (ProfileSettingsController c) {
        return ElevatedButton(onPressed: c.logout, child: const Text('Logout'));
      },
    );
  }
}
