import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laith_shono/main.dart';
import 'package:laith_shono/services/misc.dart';

class SocialsWrap extends StatelessWidget {
  SocialsWrap({Key? key}) : super(key: key);

  static const double _splashRadius = 0.001;

  @override
  Widget build(BuildContext context) {
    Future future;
    if (dbServices.urls == null) {
      future = dbServices.loadUrls(true);
    } else {
      future = Future.value(null);
    }

    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (dbServices.urls == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final emailAddress = dbServices.emailAddress;
          final githubURL = dbServices.gitHubURL;
          final stackOFURL = dbServices.stackOverflowURL;
          final linkedInURL = dbServices.linkedInURL;
          final cvURL = dbServices.cvURL;
          final _showCV = cvURL != null;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  IconButton(
                    splashRadius: _splashRadius,
                    hoverColor: Colors.transparent,
                    tooltip: AppLocalizations.of(context)!.linkedin,
                    icon: SvgPicture.asset(
                      'assets/linkedin-icon.svg',
                      color: Colors.white,
                    ),
                    onPressed: () => launchURL(linkedInURL!),
                  ),
                  IconButton(
                    splashRadius: _splashRadius,
                    hoverColor: Colors.transparent,
                    tooltip: AppLocalizations.of(context)!.stackoverflow,
                    icon: SvgPicture.asset(
                      'assets/stackoverflow.svg',
                      color: Colors.white,
                    ),
                    onPressed: () => launchURL(stackOFURL!),
                  ),
                  IconButton(
                    splashRadius: _splashRadius,
                    hoverColor: Colors.transparent,
                    tooltip: AppLocalizations.of(context)!.github,
                    icon: SvgPicture.asset(
                      'assets/github-icon.svg',
                      color: Colors.white,
                    ),
                    onPressed: () => launchURL(githubURL!),
                  ),
                  IconButton(
                    splashRadius: _splashRadius,
                    tooltip: AppLocalizations.of(context)!.email,
                    hoverColor: Colors.transparent,
                    icon: Icon(Icons.email),
                    onPressed: () => _copyEmailAddress(context, emailAddress!),
                  ),
                ],
              ),
            ],
          );
        });
  }

  void _copyEmailAddress(BuildContext context, String emailAddress) {
    Clipboard.setData(ClipboardData(text: emailAddress));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.email_copied + ': $emailAddress'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
