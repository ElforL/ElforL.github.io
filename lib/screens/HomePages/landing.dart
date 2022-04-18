import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
  Landing({Key? key}) : super(key: key);

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
                AppLocalizations.of(context)!.landing_hi,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              FittedBox(
                child: Text(
                  AppLocalizations.of(context)!.first_name,
                  style: Theme.of(context).textTheme.headline1!.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.landing_about,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
