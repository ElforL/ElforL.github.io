import 'package:flutter/material.dart';
import 'package:laith_shono/models/Project.dart';
import 'package:laith_shono/screens/project_screen.dart';

class ProjectPage extends Page {
  final Project project;

  ProjectPage({
    required this.project,
  }) : super(key: ValueKey(project));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => ProjectScreen(
        key: ValueKey(project),
        project: project,
      ),
    );
  }
}
