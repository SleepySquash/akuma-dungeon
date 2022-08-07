import 'package:akuma/router.dart';
import 'package:akuma/ui/page/home/page/dungeon/controller.dart';
import 'package:flutter/material.dart';

class DungeonMenu extends StatelessWidget {
  const DungeonMenu(this.c, {Key? key}) : super(key: key);

  final DungeonController c;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        router.home();
        Navigator.of(context).pop();
      },
      child: const Text('Leave'),
    );
  }
}
