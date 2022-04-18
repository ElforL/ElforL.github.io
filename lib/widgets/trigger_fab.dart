import 'package:flutter/material.dart';

class TriggerFab extends StatefulWidget {
  const TriggerFab({
    Key? key,
    required this.child,
    required this.onPressed,
    this.duration = const Duration(),
    this.backgroundColor,
    this.foregroundColor,
    this.tooltip,
  }) : super(key: key);

  final void Function() onPressed;
  final Duration duration;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? tooltip;

  @override
  State<TriggerFab> createState() => TriggerFabState();
}

class TriggerFabState extends State<TriggerFab> {
  bool isShown = false;

  setShown(bool newVal) {
    setState(() {
      isShown = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isShown) {
      child = FloatingActionButton.small(
        backgroundColor: widget.backgroundColor,
        foregroundColor: widget.foregroundColor,
        tooltip: widget.tooltip,
        child: widget.child,
        onPressed: widget.onPressed,
      );
    } else {
      child = SizedBox();
    }

    return AnimatedSwitcher(
      duration: widget.duration,
      child: child,
    );
  }
}
