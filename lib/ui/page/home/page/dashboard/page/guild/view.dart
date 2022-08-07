import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class GuildView extends StatelessWidget {
  const GuildView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: GuildController(),
      builder: (GuildController c) {
        return Container();
      },
    );
  }
}
