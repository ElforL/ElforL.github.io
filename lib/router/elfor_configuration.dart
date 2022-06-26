import 'package:laith_shono/models/Project.dart';

class ElforConfiguration {
  final bool show404;
  final bool initiated;
  final String? selectedProjectTitle;

  ElforConfiguration(
    this.show404,
    this.initiated,
    this.selectedProjectTitle,
  );

  factory ElforConfiguration.loading() => ElforConfiguration(false, false, null);
  factory ElforConfiguration.home() => ElforConfiguration(false, true, null);
  factory ElforConfiguration.project(String projectTitle) => ElforConfiguration(false, true, projectTitle);
  factory ElforConfiguration.unknown() => ElforConfiguration(true, true, null);

  bool get isUnknown => show404;
  bool get isLoading => !show404 && !initiated;
  bool get isHome => !show404 && initiated && selectedProjectTitle == null;
  bool get isProjectPage => !show404 && initiated && selectedProjectTitle != null;
}
