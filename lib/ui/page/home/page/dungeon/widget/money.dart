import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '/domain/model/item.dart';
import '/router.dart';
import '/ui/widget/button.dart';

class DroppedItem extends StatefulWidget {
  const DroppedItem(
    this.item, {
    Key? key,
    required this.from,
    this.onEnd,
  }) : super(key: key);

  final Offset from;
  final Item item;
  final void Function()? onEnd;

  @override
  State<DroppedItem> createState() => _DroppedItemState();
}

class _DroppedItemState extends State<DroppedItem> {
  late double _left;
  late double _bottom;

  double _scale = 0;

  Timer? _pickupTimer;

  @override
  void initState() {
    _left = widget.from.dx;
    _bottom = MediaQuery.of(router.context!).size.height - widget.from.dy;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero, () {
        if (mounted) {
          setState(() {
            _left += MediaQuery.of(router.context!).size.width /
                2 *
                (0.5 - Random().nextDouble());
            _bottom = 0;

            _scale = 1;
          });
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _pickupTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
        constraints: constraints,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(seconds: 2),
              left: min(max(_left, 40), constraints.maxWidth - 40),
              bottom: _bottom,
              curve: Curves.linearToEaseOut,
              onEnd: () {
                _pickupTimer = Timer(
                  const Duration(seconds: 2),
                  () {
                    setState(() {
                      _scale = 0;
                    });
                  },
                );
              },
              child: WidgetButton(
                child: FractionalTranslation(
                  translation: const Offset(-0.5, 0),
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: _scale,
                    curve: Curves.ease,
                    onEnd: () {
                      if (_pickupTimer != null) {
                        widget.onEnd?.call();
                      }
                    },
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child:
                          Image.asset('assets/item/${widget.item.asset}.png'),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
