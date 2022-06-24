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
  Project? _selectedProject;

  _init() async {
    await dbServices.load();

    initiated = dbServices.initiated;
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
    _selectedProject = value;
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    /// TODO Log current screen for Analytics
    /// use this 👇 to see if it should be in different place
    /// print('Building in delgate');

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
        if (_selectedProject != null) _selectedProject = null;
        return true;
      },
    );
  }

  List<Page> get _unknownStack => [UnknownPage()];

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
  Future<void> setNewRoutePath(configuration) async {
    // TODO: implement setNewRoutePath
  }

  _clear() {
    _selectedProject = null;
    _show404 = false;
  }
}
