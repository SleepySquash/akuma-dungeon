import 'package:akuma/ui/widget/backdrop.dart';
import 'package:flutter/material.dart';

class BackdropPlate extends StatelessWidget {
  const BackdropPlate({
    Key? key,
    this.width = 240,
    required this.child,
  }) : super(key: key);

  final double? width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: ConditionalBackdropFilter(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
          ),
          padding: const EdgeInsets.all(8),
          child: DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 18),
            child: child,
          ),
        ),
      ),
    );
  }
}
