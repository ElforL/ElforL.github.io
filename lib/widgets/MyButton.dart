import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({
    Key key,
    @required this.child,
    @required this.onPressed,
    @required this.label,
    this.hoverColor = Colors.white,
    this.childColor = Colors.white,
    this.childHoverColor = Colors.black,
    this.width,
  }) : super(key: key);

  final Widget child;
  final String label;
  final double width;
  final Function onPressed;
  final Color hoverColor;
  final Color childColor;
  final Color childHoverColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed) || states.contains(MaterialState.focused))
              return Colors.white.withOpacity(.4);
            return null; // Defer to the widget's default.
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) return hoverColor;
            return null; // Use the component's default.
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) return childHoverColor;
            return childColor; // Use the component's default.
          },
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 25,
                height: 25,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: child,
              ),
              Expanded(child: Center(child: Text(label))),
            ],
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
