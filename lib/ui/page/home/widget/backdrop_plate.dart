import 'package:akuma/ui/widget/backdrop.dart';
import 'package:flutter/material.dart';

class BackdropPlate extends StatelessWidget {
  const BackdropPlate({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: ConditionalBackdropFilter(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 240,
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