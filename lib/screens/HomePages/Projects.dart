import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/models/Project.dart';
import 'package:portfolio/widgets/ProjectTile.dart';
import 'package:url_launcher/url_launcher.dart';

class Projects extends StatelessWidget {
  final List<Project> projects;

  const Projects({Key key, @required this.projects}) : super(key: key);

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
          padding: const EdgeInsets.only(bottom: 40),
          child: Text(
            'Projects',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          constraints: BoxConstraints(
            maxWidth: 1200,
          ),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (var project in projects)
                ProjectTile(
                  project: project,
                ),
            ],
          ),
        ),
        TextButton.icon(
          label: Text('More on my GitHub'),
          icon: Icon(Icons.arrow_right_rounded),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.grey),
          ),
          onPressed: () {
            _launchURL(dbServices.gitHubURL);
          },
        )
      ],
    );
  }
}
