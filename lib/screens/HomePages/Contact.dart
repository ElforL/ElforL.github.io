import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/main.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  ContactPage({Key? key}) : super(key: key);

  final emailAddress = dbServices.emailAddress;
  final githubURL = dbServices.gitHubURL;
  final stackOFURL = dbServices.stackOverflowURL;
  final linkedInURL = dbServices.linkedInURL;
  final cvURL = dbServices.cvURL;
  final buttonsWidth = 250.0;

  bool get _showCV => cvURL != null;

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
                  // TODO
                  icon: SvgPicture.asset(
                    'assets/linkedin-icon.svg',
                    color: Colors.white,
                  ),
                  onPressed: () => _launchURL(linkedInURL!),
                ),
                IconButton(
                  splashRadius: _splashRadius,
                  hoverColor: Colors.transparent,
                  // TODO
                  icon: SvgPicture.asset(
                    'assets/stackoverflow.svg',
                    color: Colors.white,
                  ),
                  onPressed: () => _launchURL(stackOFURL!),
                ),
                IconButton(
                  splashRadius: _splashRadius,
                  hoverColor: Colors.transparent,
                  // TODO
                  icon: SvgPicture.asset(
                    'assets/github-icon.svg',
                    color: Colors.white,
                  ),
                  onPressed: () => _launchURL(githubURL!),
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
                        _launchURL(cvURL!);
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
                  onPressed: () => _launchURL('mailto:$emailAddress'),
                ),
              ),
            ),
          ),
          GestureDetector(
            onLongPress: () => _copyEmailAddress(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SelectableText(
                emailAddress!,
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copyEmailAddress(BuildContext context) {
    Clipboard.setData(ClipboardData(text: emailAddress));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Email address copied.'),
        duration: Duration(seconds: 23),
      ),
    );
  }
}
