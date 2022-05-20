import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laith_shono/main.dart';
import 'package:laith_shono/services/misc.dart';

class TopBar extends StatelessWidget {
  TopBar({
    Key? key,
    required this.topBarButtons,
    required this.scrollDuration,
  }) : super(key: key);

  final Duration scrollDuration;

  final Map<String, GlobalKey> topBarButtons;
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
          ..._navButton(context),
        ],
      ),
    );
  }

  List<Widget> _navButton(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      return [
        for (var i = 0; i < topBarButtons.length; i++)
          TopBarNavButton(
            child: Text(
              topBarButtons.keys.elementAt(i).toString().toUpperCase(),
              style: Theme.of(context).textTheme.button?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.25,
                  ),
            ),
            onPressed: () {
              if (topBarButtons.entries.elementAt(i).value.currentContext != null)
                Scrollable.ensureVisible(
                  topBarButtons.entries.elementAt(i).value.currentContext!,
                  duration: scrollDuration,
                );
            },
          )
      ];
    } else {
      return [
        _mobileIconButton(context),
      ];
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
                            topBarButtons.keys.elementAt(i),
                            style: Theme.of(context).textTheme.subtitle1!.apply(color: Colors.black),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        if (topBarButtons.entries.elementAt(i).value.currentContext != null)
                          Scrollable.ensureVisible(
                            topBarButtons.entries.elementAt(i).value.currentContext!,
                            duration: scrollDuration,
                          );
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
