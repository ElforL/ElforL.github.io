import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:portfolio/widgets/MyButton.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key key}) : super(key: key);

  final emailAddress = 'elforDev@gmail.com';
  final githubURL = 'https://github.com/ElforL/';
  final stackOFURL = 'https://stackoverflow.com/users/12571630/elfor';
  final buttonsWidth = 250.0;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          children: [
            MyButton(
              child: Icon(Icons.email),
              label: 'Email',
              width: buttonsWidth,
              onPressed: () => _launchURL('mailto:$emailAddress'),
            ),
            SizedBox(height: 10),
            MyButton(
              child: Icon(AntDesign.github),
              label: 'Github',
              width: buttonsWidth,
              onPressed: () => _launchURL(githubURL),
            ),
            SizedBox(height: 10),
            MyButton(
              child: Icon(FontAwesome.stack_overflow),
              label: 'Stackoverflow',
              width: buttonsWidth,
              onPressed: () => _launchURL(stackOFURL),
            ),
          ],
        )
      ],
    );
  }
}
