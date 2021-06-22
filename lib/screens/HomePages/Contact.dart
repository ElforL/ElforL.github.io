import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  ContactPage({Key key}) : super(key: key);

  final emailAddress = 'elforDev@gmail.com';
  final githubURL = 'https://github.com/ElforL/';
  final stackOFURL = 'https://stackoverflow.com/users/12571630/elfor';
  final linkedInURL = 'https://www.linkedin.com/in/laith-shono-a88159214';
  final cv_url = 'https://www.linkedin.com/in/laith-shono-a88159214';
  final buttonsWidth = 250.0;

  final _showCV = false;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static const double _splashRadius = 0.001;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(40),
          child: Text(
            'Contact',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Column(
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
                  icon: Icon(AntDesign.linkedin_square),
                  onPressed: () => _launchURL(linkedInURL),
                ),
                IconButton(
                  splashRadius: _splashRadius,
                  hoverColor: Colors.transparent,
                  icon: Icon(FontAwesome.stack_overflow),
                  onPressed: () => _launchURL(stackOFURL),
                ),
                IconButton(
                  splashRadius: _splashRadius,
                  hoverColor: Colors.transparent,
                  icon: Icon(AntDesign.github),
                  onPressed: () => _launchURL(githubURL),
                ),
                if (_showCV)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.download),
                      label: Text('RESUME (CV)'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        foregroundColor: MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: () {
                        _launchURL(cv_url);
                      },
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            FittedBox(
              child: _emailButton(context),
            )
          ],
        )
      ],
    );
  }

  _emailButton(context) {
    double height = 49;

    BoxDecoration boxDecoration = BoxDecoration(
      border: Border.all(color: Colors.white, width: 0.5),
    );

    return Container(
      decoration: boxDecoration,
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: height,
            width: height,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.white, width: 0.5)),
            ),
            child: Center(
              child: FittedBox(
                child: IconButton(
                  splashRadius: 15,
                  icon: Icon(Icons.email),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: emailAddress));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Email address copied.'),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SelectableText(
              emailAddress,
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
