import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:laith_shono/main.dart';
import 'package:laith_shono/models/Project.dart';
import 'package:laith_shono/router/scroll_section.dart';
import 'package:laith_shono/screens/home_screen_sections/Contact.dart';
import 'package:laith_shono/screens/home_screen_sections/Projects.dart';
import 'package:laith_shono/screens/home_screen_sections/landing.dart';
import 'package:laith_shono/screens/home_screen_sections/skills.dart';
import 'package:laith_shono/services/misc.dart';
import 'package:laith_shono/widgets/top_bar.dart';
import 'package:laith_shono/widgets/trigger_fab.dart';

class HomeScreen extends StatelessWidget {
  final fabKey = GlobalKey<TriggerFabState>();
  final landingKey = GlobalKey();
  final projectsKey = GlobalKey();
  final skillsKey = GlobalKey();
  final contactKey = GlobalKey();

  final ValueNotifier<ScrollSection> scrollSectionNotifier;

  /// Function to trigger when a ProjectTile is pressed.
  final void Function(Project) onProjectTab;

  final _scrollController = ScrollController();

  final scrollDuration = const Duration(milliseconds: 300);

  HomeScreen({
    Key? key,
    required this.onProjectTab,
    required this.scrollSectionNotifier,
  }) : super(key: key) {
    _scrollController.addListener(() {
      final fabShown = fabKey.currentState?.isShown ?? false;

      if (_scrollController.offset > 200 && !fabShown) {
        fabKey.currentState?.setShown(true);
      } else if (_scrollController.offset <= 200 && fabShown) {
        fabKey.currentState?.setShown(false);
      }
    });

    scrollSectionNotifier.addListener(() {
      final fromScroll = scrollSectionNotifier.value.selectionSource == SelectionSource.fromScroll;

      if (!fromScroll && _scrollController.hasClients) {
        _scrollToSection();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /// This map stores the text of the buttons as keys
    /// and a key for the widget it'll scroll to when the button is pressed
    var topBarButtons = <HomeSection, GlobalKey>{
      HomeSection.skills: skillsKey,
      HomeSection.projects: projectsKey,
      HomeSection.contact: contactKey,
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
          scrollSectionNotifier.value = ScrollSection(
            selectedSection: HomeSection.landing,
            selectionSource: SelectionSource.userClick,
          );
        },
      ),
      body: Stack(
        children: [
          NotificationListener(
            onNotification: (notification) {
              if (notification is UserScrollNotification) {
                _onUserScrolled(notification.metrics.pixels);
              }
              return true;
            },
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: adaptivePadding(width)),
                child: Column(
                  children: [
                    Landing(key: landingKey),
                    Skills(key: skillsKey),
                    Padding(
                      key: projectsKey,
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Projects(
                        projects: dbServices.projects,
                        onProjectTab: onProjectTab,
                      ),
                    ),
                    ContactPage(key: contactKey),
                  ],
                ),
              ),
            ),
          ),
          TopBar(
            topBarButtons: topBarButtons,
            scrollDuration: scrollDuration,
            scrollSectionNotifier: scrollSectionNotifier,
          ),
        ],
      ),
    );
  }

  void _onUserScrolled(double offset) {
    final landingHeight = landingKey.currentContext!.size!.height;
    final skillsHeight = skillsKey.currentContext!.size!.height;
    final projectsHeight = projectsKey.currentContext!.size!.height;

    HomeSection section;
    if (offset >= landingHeight + skillsHeight + projectsHeight) {
      section = HomeSection.contact;
    } else if (offset >= landingHeight + skillsHeight) {
      section = HomeSection.projects;
    } else if (offset >= landingHeight) {
      section = HomeSection.skills;
    } else {
      section = HomeSection.landing;
    }

    final newScrollSection = ScrollSection(
      selectedSection: section,
      selectionSource: SelectionSource.fromScroll,
    );
    if (newScrollSection != scrollSectionNotifier.value) {
      scrollSectionNotifier.value = newScrollSection;
    }
  }

  void _scrollToSection() {
    final chosenSection = scrollSectionNotifier.value.selectedSection;
    BuildContext? chosenContext;
    switch (chosenSection) {
      case HomeSection.landing:
        chosenContext = landingKey.currentContext;
        break;
      case HomeSection.skills:
        chosenContext = skillsKey.currentContext;
        break;
      case HomeSection.projects:
        chosenContext = projectsKey.currentContext;
        break;
      case HomeSection.contact:
        chosenContext = contactKey.currentContext;
        break;
    }

    if (chosenContext == null) return;

    print('Scrolling to $chosenSection');
    Scrollable.ensureVisible(chosenContext, duration: scrollDuration);
  }
}
