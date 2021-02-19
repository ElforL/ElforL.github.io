import 'package:flutter/material.dart';
import 'package:portfolio/screens/HomePages/About.dart';
import 'package:portfolio/screens/HomePages/Contact.dart';
import 'package:portfolio/screens/HomePages/Projects.dart';
import 'package:portfolio/screens/HomePages/Tools.dart';

class MyHomePage extends StatelessWidget {
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
                contactPress: (duration) => Scrollable.ensureVisible(
                  contactKey.currentContext,
                  duration: duration,
                ),
                projectsPress: (duration) => Scrollable.ensureVisible(
                  projectsKey.currentContext,
                  duration: duration,
                ),
                toolsPress: (duration) => Scrollable.ensureVisible(
                  toolsKey.currentContext,
                  duration: duration,
                ),
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
