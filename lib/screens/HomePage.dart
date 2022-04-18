import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laith_shono/main.dart';
import 'package:laith_shono/screens/HomePages/Contact.dart';
import 'package:laith_shono/screens/HomePages/Projects.dart';
import 'package:laith_shono/screens/HomePages/landing.dart';
import 'package:laith_shono/screens/HomePages/skills.dart';
import 'package:laith_shono/widgets/top_bar.dart';
import 'package:laith_shono/widgets/trigger_fab.dart';

class MyHomePage extends StatelessWidget {
  final fabKey = GlobalKey<TriggerFabState>();
  final projectsKey = GlobalKey();
  final skillsKey = GlobalKey();
  final contactKey = GlobalKey();

  final _scrollController = ScrollController();

  final scrollDuration = const Duration(milliseconds: 300);

  MyHomePage({Key? key}) : super(key: key) {
    _scrollController.addListener(() {
      final fabShown = fabKey.currentState?.isShown ?? false;

      if (_scrollController.offset > 200 && !fabShown) {
        fabKey.currentState?.setShown(true);
      } else if (_scrollController.offset <= 200 && fabShown) {
        fabKey.currentState?.setShown(false);
      }
    });
  }

  _adaptivePadding(double screenWidth) {
    if (screenWidth > 1200) {
      return 225;
    } else if (screenWidth > 850) {
      return 100;
    } else {
      return 50;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// This map stores the text of the buttons as keys
    /// and a key for the widget it'll scroll to when the button is pressed
    var topBarButtons = <String, GlobalKey>{
      AppLocalizations.of(context)!.skills: skillsKey,
      AppLocalizations.of(context)!.projects: projectsKey,
      AppLocalizations.of(context)!.contact: contactKey,
    };

    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: TriggerFab(
        child: Icon(Icons.keyboard_arrow_up_rounded),
        duration: Duration(milliseconds: 200),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        tooltip: AppLocalizations.of(context)!.scroll_to_top,
        key: fabKey,
        onPressed: () {
          _scrollController.animateTo(0, duration: scrollDuration, curve: Curves.linear);
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _adaptivePadding(width)),
              child: Column(
                children: [
                  Landing(),
                  Skills(
                    key: skillsKey,
                  ),
                  Padding(
                    key: projectsKey,
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Projects(projects: dbServices.projects),
                  ),
                  ContactPage(
                    key: contactKey,
                  ),
                ],
              ),
            ),
          ),
          TopBar(
            topBarButtons: topBarButtons,
            scrollDuration: scrollDuration,
          ),
        ],
      ),
    );
  }
}
