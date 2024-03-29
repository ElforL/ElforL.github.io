import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laith_shono/main.dart';
import 'package:laith_shono/models/Project.dart';
import 'package:laith_shono/screens/home_screen_sections/Contact.dart';
import 'package:laith_shono/screens/home_screen_sections/Projects.dart';
import 'package:laith_shono/screens/home_screen_sections/landing.dart';
import 'package:laith_shono/screens/home_screen_sections/skills.dart';
import 'package:laith_shono/services/misc.dart';
import 'package:laith_shono/widgets/top_bar.dart';
import 'package:laith_shono/widgets/trigger_fab.dart';

class HomeScreen extends StatelessWidget {
  final fabKey = GlobalKey<TriggerFabState>();
  final projectsKey = GlobalKey();
  final skillsKey = GlobalKey();
  final contactKey = GlobalKey();

  /// Function to trigger when a ProjectTile is pressed.
  final void Function(Project) onProjectTab;

  final _scrollController = ScrollController();

  final scrollDuration = const Duration(milliseconds: 300);

  HomeScreen({Key? key, required this.onProjectTab}) : super(key: key) {
    _scrollController.addListener(() {
      final fabShown = fabKey.currentState?.isShown ?? false;

      if (_scrollController.offset > 200 && !fabShown) {
        fabKey.currentState?.setShown(true);
      } else if (_scrollController.offset <= 200 && fabShown) {
        fabKey.currentState?.setShown(false);
      }
    });
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
            physics: BouncingScrollPhysics(),
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: adaptivePadding(width)),
              child: Column(
                children: [
                  Landing(),
                  Skills(
                    key: skillsKey,
                  ),
                  Padding(
                    key: projectsKey,
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Projects(
                      projects: dbServices.projects,
                      onProjectTab: onProjectTab,
                    ),
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
