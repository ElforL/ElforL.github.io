import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laith_shono/services/misc.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({Key? key, required this.toHomePage}) : super(key: key);

  /// Function to trigger when the 'Go Home' button is pressed.
  final void Function() toHomePage;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    var image = SvgPicture.asset(
      'assets/undraw/undraw_lost.svg',
      height: 350,
    );

    Widget pageNotFoundText = Text(
      AppLocalizations.of(context)!.page_not_found,
      style: Theme.of(context).textTheme.headline1,
    );
    if (width <= 490) {
      pageNotFoundText = FittedBox(child: pageNotFoundText);
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
                          '404',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      pageNotFoundText,
                      SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!.e404_desc,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: 20),
                      OutlinedButton(
                        child: Text(AppLocalizations.of(context)!.go_home.toUpperCase()),
                        onPressed: toHomePage,
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
