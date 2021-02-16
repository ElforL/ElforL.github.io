import 'package:flutter/material.dart';

class About extends StatelessWidget {
  About({Key key, this.projectsPress, this.toolsPress, this.contactPress}) : super(key: key);

  final Function projectsPress;
  final Function toolsPress;
  final Function contactPress;

  static const double topBarSpace = 20;

  _getage() {
    var birthdate = DateTime(2000, 5, 12);
    var today = DateTime.now();
    var isBefore = today.isBefore(DateTime(today.year, birthdate.month, birthdate.day));
    return today.year - birthdate.year - (isBefore ? 1 : 0);
  }

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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: topBarSpace),
                      child: _buildTopButton(Text('My Work'), onPressed: () => projectsPress()),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: topBarSpace),
                      child: _buildTopButton(Text('Tools'), onPressed: () => toolsPress()),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: topBarSpace),
                      child: _buildTopButton(Text('Contact'), onPressed: () => contactPress()),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Laith Shono',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 700),
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "I'm a ${_getage()} years old full-stack developer based in Riyadh, Saudi Arabia.\n" +
                        'I study Information Technology and Computing and have been coding for 6+ years.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
