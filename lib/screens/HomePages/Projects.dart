import 'package:flutter/material.dart';
import 'package:portfolio/models/Project.dart';
import 'package:portfolio/widgets/ProjectTile.dart';

class Projects extends StatelessWidget {
  final List<Project> projects;

  const Projects({Key key, @required this.projects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Text(
            'Projects',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        ConstrainedBox(
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
      ],
    );
  }
}
