import 'package:flutter/material.dart';

class About extends StatelessWidget {
  About({Key key}) : super(key: key);

  Widget _buildTopButton(Text text, {Function onPressed}) {
    return TextButton(
      child: text,
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    );
  }

  _textWidth(double screenWidth) {
    var out = screenWidth;
    if (screenWidth > 850) {
      out *= 0.25;
    } else if (screenWidth > 600) {
      out *= 0.15;
    } else {
      out *= 0.05;
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      constraints: BoxConstraints(minHeight: height),
      width: width,
      // padding: EdgeInsets.symmetric(horizontal: 300),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: _textWidth(width)),
          constraints: BoxConstraints(maxWidth: 450),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi there 👋, I'm",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              FittedBox(
                child: Text(
                  'Laith',
                  style: Theme.of(context).textTheme.headline1.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                "I build beautiful and powerful apps across various platforms and devices.",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
