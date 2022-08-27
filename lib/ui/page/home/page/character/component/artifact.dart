import 'package:flutter/material.dart';

import '../controller.dart';

class CharacterArtifactsTab extends StatelessWidget {
  const CharacterArtifactsTab(this.c, {Key? key}) : super(key: key);

  final CharacterController c;

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key('CharacterArtifactsTab'),
      child: Text('Artifacts'),
    );
  }
}
