import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  _getage() {
    var birthdate = DateTime(2000, 5, 12);
    var today = DateTime.now();
    var isBefore = today.isBefore(DateTime(today.year, birthdate.month, birthdate.day));
    return today.year - birthdate.year - (isBefore ? 1 : 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
