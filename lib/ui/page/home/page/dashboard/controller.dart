import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/router.dart';
import '/util/platform_utils.dart';

enum MainTab {
  dash,
  guild,
  profile,
}

class DashboardController extends GetxController {
  late final PageController pageController;
  final Rx<MainTab> selected = Rx(MainTab.dash);

  late final RxBool isMobile;
  late final Worker _layoutWorker;

  @override
  void onInit() {
    isMobile = RxBool(router.context!.isMobile);
    pageController =
        PageController(initialPage: router.context!.isMobile ? 1 : 0);

    super.onInit();
  }

  @override
  void onReady() {
    _layoutWorker = ever(isMobile, (bool isMobile) {
      switch (selected.value) {
        case MainTab.dash:
          pageController.jumpToPage(isMobile ? 1 : 0);
          break;

        case MainTab.guild:
          pageController.jumpToPage(isMobile ? 0 : 1);
          break;

        case MainTab.profile:
          pageController.jumpToPage(2);
          break;
      }
    });

    super.onReady();
  }

  @override
  void onClose() {
    _layoutWorker.dispose();
    super.onClose();
  }
}
