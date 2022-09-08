import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '/util/platform_utils.dart';

class Screen {
  const Screen({
    required this.child,
    this.desktop,
    this.mobile,
    this.onTap,
  });

  final Widget? desktop;
  final Widget? mobile;
  final Widget child;
  final void Function()? onTap;
}

class ScreenSwitcher extends StatefulWidget {
  const ScreenSwitcher({
    Key? key,
    required this.tabs,
    this.onSwitched,
  }) : super(key: key);

  final List<Screen> tabs;
  final void Function()? onSwitched;

  @override
  State<ScreenSwitcher> createState() => _ScreenSwitcherState();
}

class _ScreenSwitcherState extends State<ScreenSwitcher> {
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOutQuad,
          switchOutCurve: Curves.easeInQuad,
          transitionBuilder: (child, animation) => SlideTransition(
            position: Tween(begin: const Offset(0, -0.2), end: Offset.zero)
                .animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: widget.tabs[tab].child,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 64),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.tabs.length == 1
                  ? []
                  : widget.tabs.mapIndexed((i, e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: _SingleTab(
                          desktop: e.desktop,
                          mobile: e.mobile,
                          onTap: () {
                            widget.onSwitched?.call();
                            setState(() => tab = i);
                          },
                          selected: tab == i,
                        ),
                      );
                    }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _SingleTab extends StatelessWidget {
  const _SingleTab({
    Key? key,
    this.desktop,
    this.mobile,
    this.onTap,
    this.selected = false,
  }) : super(key: key);

  final Widget? desktop;
  final Widget? mobile;
  final void Function()? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      elevation: 4,
      shadowColor: Colors.black,
      color: selected ? Colors.blue : Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        child: SizedBox(
          width: context.isMobile ? 40 : 120,
          height: 40,
          child: Theme(
            data: ThemeData(
              iconTheme:
                  IconThemeData(color: selected ? Colors.white : Colors.blue),
            ),
            child: DefaultTextStyle.merge(
              style: TextStyle(color: selected ? Colors.white : null),
              child: Center(child: context.isMobile ? mobile : desktop),
            ),
          ),
        ),
      ),
    );
  }
}
