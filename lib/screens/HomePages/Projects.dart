import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portfolio/models/Project.dart';
import 'package:portfolio/widgets/ProjectTile.dart';
import 'package:flutter/services.dart' show rootBundle;

class Projects extends StatelessWidget {
  Future<List<Project>> loadProjects() async {
    var string = await rootBundle.loadString('assets/projects.json');
    var json = jsonDecode(string);
    return [for (var project in json) Project.fromJson(project)];
  }

  @override
  Widget build(BuildContext context) {
    List<Project> projects = [];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Text(
            'My Work',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 1200,
          ),
          child: FutureBuilder(
            future: loadProjects(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) return CircularProgressIndicator();
              projects = snapshot.data;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Text(
                      'Full Apps',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (var project in projects)
                        if (!project.isSmall)
                          ProjectTile(
                            project: project,
                          ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      'Fun Projects',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (var project in projects)
                        if (project.isSmall)
                          ProjectTile(
                            project: project,
                          ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
