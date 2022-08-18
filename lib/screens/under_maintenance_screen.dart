import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laith_shono/services/misc.dart';

class UnderMaintenanceScreen extends StatelessWidget {
  const UnderMaintenanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    var image = SvgPicture.asset(
      'assets/undraw/undraw_maintenance.svg',
      height: 350,
    );

    Widget underMaintenanceText = Text(
      AppLocalizations.of(context)!.under_maintenance,
      style: Theme.of(context).textTheme.headline1,
    );
    if (width <= 1470) {
      underMaintenanceText = FittedBox(child: underMaintenanceText);
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: adaptivePadding(width)),
            child: Row(
              children: [
                Expanded(
                  flex: width < 1500 ? 2 : 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (width <= 930) ...[
                        Container(
                          alignment: AlignmentDirectional.center,
                          child: image,
                        ),
                        SizedBox(height: 25),
                      ],
                      FittedBox(
                        child: Text(
                          '503',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      underMaintenanceText,
                      SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!.under_maintenance_desc,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                if (width > 930) ...[
                  SizedBox(width: 30),
                  Flexible(child: image),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
