import 'dart:async';
import 'dart:math';

import 'package:akuma/domain/model/dungeon.dart';
import 'package:akuma/router.dart';
import 'package:akuma/ui/worker/music.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class DungeonEntranceView extends StatefulWidget {
  const DungeonEntranceView({
    Key? key,
    required this.settings,
    required this.asset,
    this.onClear,
  }) : super(key: key);

  final FutureOr<void> Function()? onClear;
  final DungeonSettings settings;
  final String asset;

  @override
  State<DungeonEntranceView> createState() => _DungeonEntranceViewState();
}

class _DungeonEntranceViewState extends State<DungeonEntranceView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.dismissed:
          case AnimationStatus.forward:
          case AnimationStatus.reverse:
            // No-op.
            break;

          case AnimationStatus.completed:
            router.dungeon(
              widget.settings,
              onClear: widget.onClear,
              transition: PageTransitionType.fade,
            );
            break;
        }
      })
      ..forward();

    MusicWorker music = Get.find();
    music.once('sound/portal.wav');

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return LayoutBuilder(builder: (context, constraints) {
          double size = min(constraints.biggest.shortestSide, 300);
          Animation<double> tween = Tween<double>(
            begin: 1,
            end: (constraints.biggest.longestSide * 2) / size,
          ).animate(CurvedAnimation(curve: Curves.ease, parent: _controller));

          return Stack(
            fit: StackFit.expand,
            children: [
              Transform.scale(
                scale: 1 +
                    0.3 *
                        CurvedAnimation(curve: Curves.ease, parent: _controller)
                            .value,
                child: Image.asset(
                  'assets/background/${widget.asset}.jpg',
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Transform.scale(
                  scale: tween.value,
                  child: SizedBox(
                    width: size,
                    height: size,
                    child: Image.asset('assets/sprite/portal.png'),
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
