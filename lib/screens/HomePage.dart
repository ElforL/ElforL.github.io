import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/screens/HomePages/About.dart';
import 'package:portfolio/screens/HomePages/Contact.dart';
import 'package:portfolio/screens/HomePages/Projects.dart';
import 'package:portfolio/screens/HomePages/Tools.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatelessWidget {
  final projectsKey = GlobalKey();
  final toolsKey = GlobalKey();
  final contactKey = GlobalKey();
  static const githubPageURL = 'https://github.com/ElforL/ElforL.github.io';

  MyHomePage({Key key}) : super(key: key);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            About(
                // contactPress: (duration) => Scrollable.ensureVisible(
                //   contactKey.currentContext,
                //   duration: duration,
                // ),
                // projectsPress: (duration) => Scrollable.ensureVisible(
                //   projectsKey.currentContext,
                //   duration: duration,
                // ),
                // toolsPress: (duration) => Scrollable.ensureVisible(
                //   toolsKey.currentContext,
                //   duration: duration,
                // ),
                ),
            Padding(
              key: projectsKey,
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Projects(),
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
