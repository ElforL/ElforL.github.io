import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Tools extends StatelessWidget {
  const Tools({Key key}) : super(key: key);

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
        Text(
          'Tools',
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
