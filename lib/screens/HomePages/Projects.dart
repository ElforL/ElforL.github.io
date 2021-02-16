import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portfolio/models/Project.dart';
import 'package:portfolio/widgets/ProjectTile.dart';
import 'package:flutter/services.dart' show rootBundle;

class Projects extends StatelessWidget {
  List<Project> projects;

  Future<String> loadProjects() async {
    var string = await rootBundle.loadString('assets/projects.json');
    var json = jsonDecode(string);
  }

  @override
  Widget build(BuildContext context) {
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
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (var i = 0; i < 7; i++)
                      ProjectTile(
                        project: Project(
                          'Title of my project is so long like wth',
                          null,
                        ),
                      ),
                  ],
                );
              }),
        ),
      ],
    );
  }
}
