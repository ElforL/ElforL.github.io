import 'package:laith_shono/models/Project.dart';

class ElforConfiguration {
  final bool _show404;
  final bool _initiated;
  final Project? _selectedProject;

  ElforConfiguration(
    this._show404,
    this._initiated,
    this._selectedProject,
  );

  factory ElforConfiguration.loading() => ElforConfiguration(false, false, null);
  factory ElforConfiguration.home() => ElforConfiguration(false, true, null);
  factory ElforConfiguration.project(Project project) => ElforConfiguration(false, true, project);
  factory ElforConfiguration.unknown() => ElforConfiguration(true, true, null);

  bool get isUnknown => _show404;
  bool get isLoading => !_show404 && !_initiated;
  bool get isHome => !_show404 && _initiated;
  bool get isProjectPage => !_show404 && _initiated && _selectedProject != null;
}
