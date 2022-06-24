import 'package:flutter/cupertino.dart';
import 'package:laith_shono/models/Project.dart';

import 'elfor_configuration.dart';

class ElforRouterDelegate extends RouterDelegate<ElforConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  ElforRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  bool _show404 = false;
  bool? _loggedIn;
  Project? _selectedProject;

  set show404(bool value) {
    _show404 = value;
    if (value) {
      _selectedProject = null;
    }
    notifyListeners();
  }

  set loggedIn(bool? value) {
    if (_loggedIn == true && value == false) {
      // It is a logout!
      _clear();
    }

    _loggedIn = value;

    notifyListeners();
  }

  set selectedProject(Project? value) {
    _selectedProject = value;
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    List<Page> stack;
    if (_show404) {
      stack = _unknownStack;
    } else if (_loggedIn == null || _loggedIn == false) {
      stack = _loadingStack;
    } else {
      stack = _allGoodStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: stack,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (_selectedProject != null) _selectedProject = null;
        return true;
      },
    );
  }

  List<Page> get _unknownStack => [/* UnknownPage() */];

  List<Page> get _loadingStack {
    String? process;
    if (_loggedIn == null) {
      process = 'Checking login state...';
    } else if (!_loggedIn!) {
      process = 'Logging in as anonymous...';
    } else {
      process = "Fetching Data";
    }
    return [/* SplashPage(process: process) */];
  }

  List<Page> get _allGoodStack {
    return [
      /// HomePage(
      ///   onProjectTab: (Project project) => selectedProject = project,
      /// ),
      // if(_selectedProject != null) ProjectPage(project)
    ];
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    // TODO: implement setNewRoutePath
  }

  _clear() {
    _selectedProject = null;
    _show404 = false;
  }
}
