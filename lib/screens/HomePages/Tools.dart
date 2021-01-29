import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Tools extends StatelessWidget {
  const Tools({Key key, this.onBottomOverscroll, this.onTopOverscroll}) : super(key: key);

  final Function onBottomOverscroll;
  final Function onTopOverscroll;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is OverscrollNotification && notification.dragDetails != null) {
          if (notification.overscroll > 0 && onBottomOverscroll != null) {
            onBottomOverscroll();
          } else {
            if (onTopOverscroll != null) onTopOverscroll();
          }
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tools',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 40),
                ToolEntry(
                  logo: Image.asset('assets/flutter logo.png'),
                  description:
                      'Flutter is Google’s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.',
                  onLearnMore: () => _launchURL('https://flutter.dev/'),
                ),
                SizedBox(height: 20),
                ToolEntry(
                  logo: Image.asset('assets/firebase-logo.png'),
                  description:
                      'Firebase helps you build and run successful apps.\nBacked by Google and loved by app development teams - from startups to global enterprises.',
                  onLearnMore: () => _launchURL('https://firebase.google.com/'),
                ),
                SizedBox(height: 20),
                ToolEntry(
                  logo: Image.asset('assets/figma-logo.png'),
                  description:
                      'Figma is a vector graphics editor and prototyping tool which is primarily web-based, with additional offline features.',
                  onLearnMore: () => _launchURL('https://www.figma.com/about/'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ToolEntry extends StatelessWidget {
  const ToolEntry({Key key, @required this.logo, @required this.description, this.onLearnMore}) : super(key: key);

  final Widget logo;
  final String description;
  final Function onLearnMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 900),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 50,
              child: logo,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: 500,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  if (onLearnMore != null) ...[
                    SizedBox(height: 5),
                    TextButton(
                      child: Text('Learn more'),
                      onPressed: onLearnMore,
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
