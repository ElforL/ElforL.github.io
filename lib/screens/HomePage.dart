import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/screens/HomePages/About.dart';
import 'package:portfolio/screens/HomePages/Contact.dart';
import 'package:portfolio/screens/HomePages/Projects.dart';
import 'package:portfolio/screens/HomePages/Tools.dart';

class MyHomePage extends StatelessWidget {
  final _scrollController = ScrollController();

  final projectsKey = GlobalKey();
  final toolsKey = GlobalKey();
  final contactKey = GlobalKey();

  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              About(
                contactPress: () => Scrollable.ensureVisible(contactKey.currentContext),
                projectsPress: () => Scrollable.ensureVisible(projectsKey.currentContext),
                toolsPress: () => Scrollable.ensureVisible(toolsKey.currentContext),
              ),
              Padding(
                key: projectsKey,
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Projects(),
              ),
              Padding(
                key: toolsKey,
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Tools(),
              ),
              Padding(
                key: contactKey,
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: ContactPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
