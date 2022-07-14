import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laith_shono/main.dart';
import 'package:laith_shono/router/scroll_section.dart';
import 'package:laith_shono/services/misc.dart';

class TopBar extends StatelessWidget {
  TopBar({
    Key? key,
    required this.topBarButtons,
    required this.scrollDuration,
    required this.scrollSectionNotifier,
  }) : super(key: key);

  final ValueNotifier<ScrollSection> scrollSectionNotifier;
  final Duration scrollDuration;

  final Map<HomeSection, GlobalKey> topBarButtons;
  final githubPageURL = dbServices.gitHubURL;
  final linkedInURL = dbServices.linkedInURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // transform: GradientRotation(-1.5708),
          colors: [
            Theme.of(context).colorScheme.background,
            Theme.of(context).colorScheme.background.withAlpha(178),
            Theme.of(context).colorScheme.background.withAlpha(0),
          ],
          stops: [
            0,
            0.75,
            1,
          ],
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          _linkedInBtn(context),
          _gitHubBtn(context),
          Spacer(),
          _localeButton(context),
          ..._navButton(context),
        ],
      ),
    );
  }

  Widget _localeButton(BuildContext context) {
    final isEnglish = AppLocalizations.of(context)!.localeName == 'en';
    return IconButton(
      icon: Icon(Icons.translate_rounded),
      tooltip: isEnglish ? AppLocalizations.of(context)!.ar : AppLocalizations.of(context)!.en,
      onPressed: () {
        var newLang = isEnglish ? 'ar' : 'en';
        MyApp.of(context)?.currentLocale = Locale(newLang);
      },
    );
  }

  List<Widget> _navButton(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      return [
        for (var i = 0; i < topBarButtons.length; i++)
          TopBarNavButton(
            child: Text(
              _getTextFromHomeSection(context, topBarButtons.keys.elementAt(i)),
              style: Theme.of(context).textTheme.button?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.25,
                  ),
            ),
            onPressed: () => setSection(i),
          )
      ];
    } else {
      return [
        _mobileIconButton(context),
      ];
    }
  }

  String _getTextFromHomeSection(BuildContext context, HomeSection section) {
    switch (section) {
      case HomeSection.skills:
        return AppLocalizations.of(context)!.skills.toUpperCase();
      case HomeSection.projects:
        return AppLocalizations.of(context)!.projects.toUpperCase();
      case HomeSection.contact:
        return AppLocalizations.of(context)!.contact.toUpperCase();
      case HomeSection.landing:
        return '⬆';
    }
  }

  IconButton _mobileIconButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) {
            return Dialog(
              backgroundColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      color: Colors.black,
                      icon: Icon(Icons.close),
                    ),
                  ),
                  for (var i = 0; i < topBarButtons.length; i++)
                    ListTile(
                      title: Center(
                        child: FittedBox(
                          child: Text(
                            _getTextFromHomeSection(context, topBarButtons.keys.elementAt(i)),
                            style: Theme.of(context).textTheme.subtitle1!.apply(color: Colors.black),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        setSection(i);
                      },
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> setSection(int i) async {
    if (topBarButtons.entries.elementAt(i).value.currentContext != null) {
      scrollSectionNotifier.value = ScrollSection(
        selectedSection: topBarButtons.keys.elementAt(i),
        selectionSource: SelectionSource.userClick,
      );
    }
  }

  IconButton _gitHubBtn(BuildContext context) {
    return IconButton(
      splashRadius: 0.001,
      tooltip: AppLocalizations.of(context)!.github,
      hoverColor: Colors.transparent,
      icon: SvgPicture.asset(
        'assets/github-icon.svg',
        color: Colors.white,
      ),
      onPressed: () async {
        await launchURL(githubPageURL!);
        await FirebaseAnalytics.instance.logEvent(
          name: 'social_tap',
          parameters: {
            'social': 'GitHub',
          },
        );
      },
    );
  }

  IconButton _linkedInBtn(BuildContext context) {
    return IconButton(
      splashRadius: 0.001,
      tooltip: AppLocalizations.of(context)!.linkedin,
      hoverColor: Colors.transparent,
      icon: SvgPicture.asset(
        'assets/linkedin-icon.svg',
        color: Colors.white,
      ),
      onPressed: () async {
        await launchURL(linkedInURL!);
        await FirebaseAnalytics.instance.logEvent(
          name: 'social_tap',
          parameters: {
            'social': 'LinkedIn',
          },
        );
      },
    );
  }
}

class TopBarNavButton extends StatelessWidget {
  const TopBarNavButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: child,
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
    );
  }
}
