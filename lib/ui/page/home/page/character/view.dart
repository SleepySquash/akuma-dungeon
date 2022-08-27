// Copyright © 2022 NIKITA ISAENKO, <https://github.com/SleepySquash>
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU Affero General Public License v3.0 as published by the
// Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License v3.0 for
// more details.
//
// You should have received a copy of the GNU Affero General Public License v3.0
// along with this program. If not, see
// <https://www.gnu.org/licenses/agpl-3.0.html>.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/character.dart';
import '/ui/page/home/widget/screen_switcher.dart';
import '/ui/widget/backdrop.dart';
import 'component/artifact.dart';
import 'component/attributes.dart';
import 'component/skill.dart';
import 'controller.dart';

class CharacterView extends StatefulWidget {
  const CharacterView({
    Key? key,
    this.bounds,
    this.character,
    this.myCharacter,
  }) : super(key: key);

  final Rect? bounds;
  final Character? character;
  final MyCharacter? myCharacter;

  /// Displays a dialog with the provided [character] above the current
  /// contents.
  static void show<T extends Object?>({
    required BuildContext context,
    Character? character,
    MyCharacter? myCharacter,
    Rect? bounds,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (BuildContext context, _, __) {
          return CharacterView(
            myCharacter: myCharacter,
            character: character,
          );
        },
      ),
    );
  }

  @override
  State<CharacterView> createState() => _CharacterViewState();
}

class _CharacterViewState extends State<CharacterView>
    with SingleTickerProviderStateMixin {
  /// [AnimationController] controlling the opening and closing animation.
  late final AnimationController _fading;

  /// Pops this [CharacterView] route off the [Navigator].
  void Function()? _pop;

  /// [Rect] of an [Object] to animate this [CharacterView] from/to.
  late Rect _bounds;

  /// Discard the first [LayoutBuilder] frame since no widget is drawn yet.
  bool _firstLayout = true;

  @override
  void initState() {
    _fading = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )
      ..addStatusListener(
        (status) {
          switch (status) {
            case AnimationStatus.reverse:
              _pop?.call();
              break;

            case AnimationStatus.dismissed:
            case AnimationStatus.forward:
            case AnimationStatus.completed:
              // No-op.
              break;
          }
        },
      )
      ..forward();

    _bounds = _calculatePosition() ?? Rect.zero;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_firstLayout) {
          _pop = Navigator.of(context).pop;
          _firstLayout = false;
        }

        var fade = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _fading,
          curve: const Interval(0, 0.3, curve: Curves.ease),
        ));

        return GetBuilder(
          init: CharacterController(
            character: widget.character,
            myCharacter: widget.myCharacter,
          ),
          builder: (CharacterController c) {
            return Stack(
              fit: StackFit.expand,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _dismiss,
                  child: AnimatedBuilder(
                    animation: _fading,
                    builder: (context, child) => ConditionalBackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 0.01 + 15 * _fading.value,
                        sigmaY: 0.01 + 15 * _fading.value,
                      ),
                      child: Container(),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _fading,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: fade,
                      child: Hero(
                        tag: widget.myCharacter?.character.id ??
                            widget.character?.id ??
                            '',
                        child: Image.asset(
                          'assets/character/${widget.myCharacter?.character.asset ?? widget.character?.asset}.png',
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _fading,
                  builder: (_, child) =>
                      Opacity(opacity: _fading.value, child: child!),
                  child: _screen(c),
                ),
                AnimatedBuilder(
                  animation: _fading,
                  builder: (_, child) =>
                      Opacity(opacity: _fading.value, child: child!),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16, right: 16),
                      child: FloatingActionButton(
                        mini: false,
                        onPressed: _dismiss,
                        child: const Icon(Icons.close_rounded),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _screen(CharacterController c) {
    return ScreenSwitcher(
      tabs: [
        Screen(
          desktop: const Text('Attributes'),
          mobile: const Icon(Icons.person),
          child: CharacterAttributesTab(c),
        ),
        if (c.myCharacter != null)
          Screen(
            desktop: const Text('Inventory'),
            mobile: const Icon(Icons.inventory),
            child: CharacterArtifactsTab(c),
          ),
        Screen(
          desktop: const Text('Skills'),
          mobile: const Icon(Icons.accessibility),
          child: CharacterSkillsTab(c),
        ),
      ],
    );
  }

  /// Starts a dismiss animation.
  void _dismiss() {
    _bounds = _calculatePosition() ?? _bounds;
    _fading.reverse();
  }

  /// Returns a [Rect] of an [Object] identified by the provided initial
  /// [GlobalKey].
  Rect? _calculatePosition() => widget.bounds;
}
