import 'package:flutter/cupertino.dart';
import 'package:laith_shono/models/Project.dart';
import 'package:laith_shono/services/analytics_services.dart';
import 'package:laith_shono/services/firestore.dart';

import 'elfor_configuration.dart';
import 'pages/home_page.dart';
import 'pages/loading_page.dart';
import 'pages/project_page.dart';
import 'pages/unknown_page.dart';
import 'pages/error_page.dart';

class ElforRouterDelegate extends RouterDelegate<ElforConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  ElforRouterDelegate(this.dbServices, this.analyticsServices) : _navigatorKey = GlobalKey<NavigatorState>() {
    heroController = HeroController();
    _init();
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  /// Needed for hero widgets to work
  late HeroController heroController;
  final FirestoreServices dbServices;
  final AnalyticsServices analyticsServices;

  bool _show404 = false;
  bool _initiated = false;
  bool _show502 = false;

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

  String? _localeLangCode;

  String? get langCode => _localeLangCode;

  set langCode(String? newLang) {
    _localeLangCode = newLang;

    notifyListeners();
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
    if (value != null && dbServices.initiated) {
      show404 = !dbServices.projects.contains(value);
    }

    _selectedProject = value;
    _selectedProjectTitle = value?.title;
    notifyListeners();
  }

  _init() async {
    try {
      await dbServices.load();

      initiated = dbServices.initiated;

      /// Read the documentation of [_selectedProjectTitle] to understand why this is here
      if (_selectedProjectTitle != null) {
        final project = getProjectOfTitle(_selectedProjectTitle!);

        show404 = project == null;
        selectedProject = project;
      }
    } catch (e) {
      _show502 = true;
      notifyListeners();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Page> stack;

    if (_show502) {
      stack = _errorStack;
    } else if (_show404) {
      stack = _unknownStack;
    } else if (!_initiated) {
      stack = _loadingStack;
    } else {
      stack = _initiatedStack;
    }

    analyticsServices.updatePage(stack.last);

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

  List<Page> get _errorStack => [ErrorPage()];

  @override
  ElforConfiguration? get currentConfiguration {
    if (!_initiated) {
      return ElforConfiguration.loading(langCode);
    } else if (_show404) {
      return ElforConfiguration.unknown(langCode);
    } else if (_selectedProject == null) {
      return ElforConfiguration.home(langCode);
    } else if (_selectedProject != null) {
      return ElforConfiguration.project(_selectedProject!.title, langCode);
    } else {
      return null;
    }
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    langCode = configuration.langCode;

    if (configuration.isUnknown) {
      show404 = true;
    } else if (configuration.isHome) {
      show404 = false;
      selectedProject = null;
    } else if (configuration.isProjectPage) {
      var project = getProjectOfTitle(configuration.selectedProjectTitle!);
      if (dbServices.initiated) {
        selectedProject = project;
        show404 = project == null;
      } else {
        show404 = false;
        _selectedProjectTitle = configuration.selectedProjectTitle;
      }
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
