import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laith_shono/main.dart';
import 'package:laith_shono/screens/HomePages/Contact.dart';
import 'package:laith_shono/screens/HomePages/Projects.dart';
import 'package:laith_shono/screens/HomePages/landing.dart';
import 'package:laith_shono/screens/HomePages/skills.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatelessWidget {
  final projectsKey = GlobalKey();
  final skillsKey = GlobalKey();
  final contactKey = GlobalKey();
  final githubPageURL = dbServices.gitHubURL;
  final linkedInURL = dbServices.linkedInURL;

  MyHomePage({Key? key}) : super(key: key);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildTopButton(Text text, {Function? onPressed}) {
    return TextButton(
      child: text,
      onPressed: onPressed as void Function()?,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    );
  }

  Widget _topBar(context, Map<String, GlobalKey> siteMap) {
    const duration = Duration(milliseconds: 600);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            splashRadius: 0.001,
            hoverColor: Colors.transparent,
            icon: SvgPicture.asset(
              'assets/linkedin-icon.svg',
              color: Colors.white,
            ),
            onPressed: () => _launchURL(linkedInURL!),
          ),
          IconButton(
            splashRadius: 0.001,
            hoverColor: Colors.transparent,
            icon: SvgPicture.asset(
              'assets/github-icon.svg',
              color: Colors.white,
            ),
            onPressed: () => _launchURL(githubPageURL!),
          ),
          Spacer(),
          if (MediaQuery.of(context).size.width > 600)
            for (var i = 0; i < siteMap.length; i++)
              _buildTopButton(
                Text(
                  siteMap.keys.elementAt(i).toString().toUpperCase(),
                  style: Theme.of(context).textTheme.button?.copyWith(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.25,
                      ),
                ),
                onPressed: () {
                  if (siteMap.entries.elementAt(i).value.currentContext != null)
                    Scrollable.ensureVisible(
                      siteMap.entries.elementAt(i).value.currentContext!,
                      duration: duration * (i > 0 ? 1.5 * i : 1),
                    );
                },
              )
          else
            IconButton(
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
                          for (var i = 0; i < siteMap.length; i++)
                            ListTile(
                              title: Center(
                                child: FittedBox(
                                  child: Text(
                                    siteMap.keys.elementAt(i),
                                    style: Theme.of(context).textTheme.subtitle1!.apply(color: Colors.black),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                if (siteMap.entries.elementAt(i).value.currentContext != null)
                                  Scrollable.ensureVisible(
                                    siteMap.entries.elementAt(i).value.currentContext!,
                                    duration: duration * (i > 0 ? 1.5 * i : 1),
                                  );
                              },
                            )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }

  _adaptivePadding(double screenWidth) {
    if (screenWidth > 1200) {
      return 225;
    } else if (screenWidth > 850) {
      return 100;
    } else {
      return 50;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// This map stores the text of the buttons as keys
    /// and a key for the widget it'll scroll to when the button is pressed
    var topBarButtons = <String, GlobalKey>{
      AppLocalizations.of(context)!.projects: projectsKey,
      AppLocalizations.of(context)!.skills: skillsKey,
      AppLocalizations.of(context)!.contact: contactKey,
    };

    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          _topBar(context, topBarButtons),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _adaptivePadding(width)),
              child: Column(
                children: [
                  Landing(),
                  Skills(),
                  Padding(
                    key: projectsKey,
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Projects(projects: dbServices.projects),
                  ),
                  ContactPage(
                    key: contactKey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
