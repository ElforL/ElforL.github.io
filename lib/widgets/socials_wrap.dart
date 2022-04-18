import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laith_shono/main.dart';
import 'package:laith_shono/services/misc.dart';

class SocialsWrap extends StatelessWidget {
  SocialsWrap({Key? key}) : super(key: key);

  static const double _splashRadius = 0.001;

  final emailAddress = dbServices.emailAddress;
  final githubURL = dbServices.gitHubURL;
  final stackOFURL = dbServices.stackOverflowURL;
  final linkedInURL = dbServices.linkedInURL;
  final cvURL = dbServices.cvURL;
  bool get _showCV => cvURL != null;

  @override
  Widget build(BuildContext context) {
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
              icon: SvgPicture.asset(
                'assets/linkedin-icon.svg',
                color: Colors.white,
              ),
              onPressed: () => launchURL(linkedInURL!),
            ),
            IconButton(
              splashRadius: _splashRadius,
              hoverColor: Colors.transparent,
              icon: SvgPicture.asset(
                'assets/stackoverflow.svg',
                color: Colors.white,
              ),
              onPressed: () => launchURL(stackOFURL!),
            ),
            IconButton(
              splashRadius: _splashRadius,
              hoverColor: Colors.transparent,
              icon: SvgPicture.asset(
                'assets/github-icon.svg',
                color: Colors.white,
              ),
              onPressed: () => launchURL(githubURL!),
            ),
            IconButton(
              splashRadius: _splashRadius,
              hoverColor: Colors.transparent,
              icon: Icon(Icons.email),
              onPressed: () => _copyEmailAddress(context),
            ),
            // TODO cv
            // move to skills ?
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
                    launchURL(cvURL!);
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }

  void _copyEmailAddress(BuildContext context) {
    Clipboard.setData(ClipboardData(text: emailAddress));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // TODO localize
        content: Text('Email address copied: ${emailAddress}'),
        duration: Duration(seconds: 23),
      ),
    );
  }
}
