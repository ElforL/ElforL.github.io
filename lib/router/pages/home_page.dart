import 'package:flutter/material.dart';
import 'package:laith_shono/models/Project.dart';
import 'package:laith_shono/screens/home_screen.dart';

class HomePage extends Page {
  HomePage({
    required this.onProjectTab,
  }) : super(key: ValueKey('Home'));

  final void Function(Project) onProjectTab;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(builder: (context) => HomeScreen());
  }
}
