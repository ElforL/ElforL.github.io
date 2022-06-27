import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
  Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      constraints: BoxConstraints(minHeight: height),
      width: width,
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.landing_hi,
                style: Theme.of(context).textTheme.headline6,
              ),

              // When the screen width is < 360 the name letters starts to wrap so a fitted box will keep
              // the name as one line but shrinks it as the screen gets smaller
              FittedBox(
                child: Text(
                  AppLocalizations.of(context)!.first_name,
                  style: Theme.of(context).textTheme.headline1!.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ),

              Text(
                AppLocalizations.of(context)!.landing_about,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
