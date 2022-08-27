import 'package:flutter/material.dart';

import '../controller.dart';

class CharacterSkillsTab extends StatelessWidget {
  const CharacterSkillsTab(this.c, {Key? key}) : super(key: key);

  final CharacterController c;

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key('CharacterSkillsTab'),
      child: Text('Skill'),
    );
  }
}
