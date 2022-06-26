import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Skills extends StatelessWidget {
  const Skills({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final _skillsText1 =
        '${AppLocalizations.of(context)!.software_eng}        ${AppLocalizations.of(context)!.app_dev}        ${AppLocalizations.of(context)!.ui_design}.';
    final _skillsText2 =
        'Flutter,        Firebase,        Java,        C#,        Git,        Figma,        Cinema 4d,        Adobe Illustrator.';

    return Container(
      constraints: BoxConstraints(
        minHeight: height,
        minWidth: width,
      ),
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Row(
        children: [
          Expanded(
            // flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.skills,
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.education,
                  style: Theme.of(context).textTheme.headline4?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(height: 5),
                Text(
                  AppLocalizations.of(context)!.bsc_ITc,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.skills_n_tools,
                  style: Theme.of(context).textTheme.headline4?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(height: 5),
                Text(
                  _skillsText1,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(height: 5),
                Text(
                  _skillsText2,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.languages,
                  style: Theme.of(context).textTheme.headline4?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context).textTheme.subtitle2,
                    children: [
                      TextSpan(
                        text: ' - ' + AppLocalizations.of(context)!.fluent,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.english,
                    style: Theme.of(context).textTheme.subtitle2,
                    children: [
                      TextSpan(
                        text: ' - ' + AppLocalizations.of(context)!.excellent,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  ),
                ),
                if (width <= 770)
                  Container(
                    alignment: AlignmentDirectional.topEnd,
                    padding: const EdgeInsets.all(20),
                    child: SvgPicture.asset(
                      'assets/undraw/undraw_programming.svg',
                      height: 150,
                    ),
                  ),
              ],
            ),
          ),
          if (width > 770) ...[
            SizedBox(width: 50),
            Flexible(
              child: SvgPicture.asset(
                'assets/undraw/undraw_programming.svg',
                height: 350,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
