import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/screens/HomePages/About.dart';
import 'package:portfolio/screens/HomePages/Contact.dart';
import 'package:portfolio/screens/HomePages/Projects.dart';
import 'package:portfolio/screens/HomePages/Tools.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatelessWidget {
  final projectsKey = GlobalKey();
  final toolsKey = GlobalKey();
  final contactKey = GlobalKey();
  final githubPageURL = dbServices.gitHubURL;

  MyHomePage({Key key}) : super(key: key);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildTopButton(Text text, {Function onPressed}) {
    return TextButton(
      child: text,
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    );
  }

  Widget _topBar(context) {
    final linkedInURL = dbServices.linkedInURL;
    const duration = Duration(milliseconds: 600);
    final siteMap = <String, GlobalKey>{
      'Projects': projectsKey,
      'Tools': toolsKey,
      'Contact': contactKey,
    };
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            splashRadius: 0.001,
            hoverColor: Colors.transparent,
            icon: Icon(AntDesign.linkedin_square),
            onPressed: () => _launchURL(linkedInURL),
          ),
          IconButton(
            splashRadius: 0.001,
            hoverColor: Colors.transparent,
            icon: Icon(AntDesign.github),
            onPressed: () => _launchURL(githubPageURL),
          ),
          Spacer(),
          for (var i = 0; i < siteMap.length; i++)
            _buildTopButton(
              Text(
                siteMap.keys.elementAt(i),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              onPressed: () {
                Scrollable.ensureVisible(
                  siteMap.entries.elementAt(i).value.currentContext,
                  duration: duration * (i > 0 ? 1.5 * i : 1),
                );
              },
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _topBar(context),
            About(),
            Padding(
              key: projectsKey,
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Projects(projects: dbServices.projects),
            ),
            Padding(
              key: toolsKey,
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Tools(),
            ),
            Padding(
              key: contactKey,
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: ContactPage(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 10),
              child: Text.rich(
                TextSpan(
                  text: 'Website source code available on GitHub',
                  style: Theme.of(context).textTheme.caption.copyWith(color: Colors.grey.shade800),
                  recognizer: TapGestureRecognizer()..onTap = () => _launchURL(githubPageURL),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
