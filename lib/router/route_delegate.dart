import 'package:flutter/cupertino.dart';
import 'package:laith_shono/models/Project.dart';
import 'package:laith_shono/services/firestore.dart';

import 'elfor_configuration.dart';
import 'pages/home_page.dart';
import 'pages/loading_page.dart';
import 'pages/project_page.dart';
import 'pages/unknown_page.dart';

class ElforRouterDelegate extends RouterDelegate<ElforConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  ElforRouterDelegate(this.dbServices) : _navigatorKey = GlobalKey<NavigatorState>() {
    heroController = HeroController();
    _init();
  }

  /// Needed for hero widgets to work
  late HeroController heroController;
  final FirestoreServices dbServices;

  bool _show404 = false;
  bool _initiated = false;

  /// This one is used for a project selected before db init
  ///
  /// if the app was on startup with a url to a project
  /// [setNewRoutePath] would try to set [_selectedProject] but can't because
  /// the projects aren't loaded yet, so it'll set it to null and if the project the user is looking for doesn't exist
  /// then it's a 404.
  ///
  /// [_selectedProjectTitle] fixes this by keeping track of the title of the selected project.
  /// in [_init] After [dbServices.load] is finished, it checks if [_selectedProjectTitle] is not null and looks for the project
  String? _selectedProjectTitle;
  Project? _selectedProject;

  _init() async {
    await dbServices.load();

    initiated = dbServices.initiated;

    /// Read the documentation of [_selectedProjectTitle] to understand why this is here
    if (_selectedProjectTitle != null) {
      final project = getProjectOfTitle(_selectedProjectTitle!);
      if (project != null) {
        selectedProject = project;
      } else {
        show404 = true;
        selectedProject = null;
      }
    }
  }

  set show404(bool value) {
    _show404 = value;
    if (value) {
      _selectedProject = null;
    }
    notifyListeners();
  }

  set initiated(bool value) {
    if (_initiated && !value) {
      // It is a logout!
      // Shouldn't happen tho
      _clear();
      debugPrint('⚠ User Logged out');
    }

    _initiated = value;

    notifyListeners();
  }

  set selectedProject(Project? value) {
    if (dbServices.initiated) {
      if (value != null) {
        show404 = !dbServices.projects.contains(value);
      } else {
        show404 = true;
      }
    }
    _selectedProject = value;
    _selectedProjectTitle = value?.title;
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    /// TODO Log current screen for Analytics
    /// use this 👇 to see if it should be in different place
    /// print('Building in delgate');
    /// suggest creating a class for analytics that keeps track of current screen to prevent spam

    List<Page> stack;
    if (_show404) {
      stack = _unknownStack;
    } else if (!_initiated) {
      stack = _loadingStack;
    } else {
      stack = _initiatedStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: stack,
      observers: [heroController],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (_selectedProject != null) selectedProject = null;
        return true;
      },
    );
  }

  List<Page> get _unknownStack => [
        UnknownPage(() {
          show404 = false;
          selectedProject = null;
        })
      ];

  List<Page> get _loadingStack => [LoadingPage()];

  List<Page> get _initiatedStack {
    return [
      HomePage(
        onProjectTab: (Project project) => selectedProject = project,
      ),
      if (_selectedProject != null) ProjectPage(project: _selectedProject!)
    ];
  }

  @override
  ElforConfiguration? get currentConfiguration {
    if (!_initiated) {
      return ElforConfiguration.loading();
    } else if (_show404) {
      return ElforConfiguration.unknown();
    } else if (_selectedProject == null) {
      return ElforConfiguration.home();
    } else if (_selectedProject != null) {
      return ElforConfiguration.project(_selectedProject!.title);
    } else {
      return null;
    }
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    if (configuration.isUnknown) {
      show404 = true;
    } else if (configuration.isHome) {
      show404 = false;
      selectedProject = null;
    } else if (configuration.isProjectPage) {
      show404 = false;
      selectedProject = getProjectOfTitle(configuration.selectedProjectTitle!);
      _selectedProjectTitle = configuration.selectedProjectTitle;
    } else {
      debugPrint("Couldn't set a new route for config $configuration");
    }
  }

  Project? getProjectOfTitle(String title) {
    try {
      return dbServices.projects.firstWhere((element) => element.title == title);
    } on StateError catch (_) {
      return null;
    }
  }

  _clear() {
    _selectedProject = null;
    _show404 = false;
  }
}
