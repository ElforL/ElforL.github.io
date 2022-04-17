import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laith_shono/main.dart';
import 'package:laith_shono/screens/HomePages/About.dart';
import 'package:laith_shono/screens/HomePages/Contact.dart';
import 'package:laith_shono/screens/HomePages/Projects.dart';
import 'package:laith_shono/screens/HomePages/Tools.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatelessWidget {
  final projectsKey = GlobalKey();
  final toolsKey = GlobalKey();
  final contactKey = GlobalKey();
  final githubPageURL = dbServices.gitHubURL;
  final linkedInURL = dbServices.linkedInURL;
  get siteMap => <String, GlobalKey>{
        'Projects': projectsKey,
        'Tools': toolsKey,
        'Contact': contactKey,
      };

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

  Widget _topBar(context) {
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
                  siteMap.keys.elementAt(i),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                onPressed: () {
                  Scrollable.ensureVisible(
                    siteMap.entries.elementAt(i).value.currentContext,
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
                                Scrollable.ensureVisible(
                                  siteMap.entries.elementAt(i).value.currentContext,
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
                  style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey.shade800),
                  recognizer: TapGestureRecognizer()..onTap = () => _launchURL(githubPageURL!),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
