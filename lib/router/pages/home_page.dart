import 'package:flutter/material.dart';
import 'package:laith_shono/models/Project.dart';
import 'package:laith_shono/router/scroll_section.dart';
import 'package:laith_shono/screens/home_screen.dart';

class HomePage extends Page {
  HomePage({
    required this.onProjectTab,
    required this.scrollSectionNotifier,
  }) : super(key: ValueKey('Home'));

  final ValueNotifier<ScrollSection> scrollSectionNotifier;

  /// Function to trigger when a ProjectTile is pressed in the [HomeScreen]
  final void Function(Project) onProjectTab;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => HomeScreen(
        key: ValueKey('Home'),
        onProjectTab: onProjectTab,
        scrollSectionNotifier: scrollSectionNotifier,
      ),
    );
  }
}
