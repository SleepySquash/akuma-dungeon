import 'package:flutter/material.dart';

import '../controller.dart';

class ProfileSkillsTab extends StatelessWidget {
  const ProfileSkillsTab(this.c, {Key? key}) : super(key: key);

  final ProfileController c;

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key('ProfileSkillsTab'),
      child: Text('Skill'),
    );
  }
}
