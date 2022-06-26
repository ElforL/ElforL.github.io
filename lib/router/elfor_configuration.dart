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

  @override
  String toString() {
    if (isUnknown) {
      return 'ElforConfiguration(Unknown page)';
    } else if (isLoading) {
      return 'ElforConfiguration(Loading page)';
    } else if (isHome) {
      return 'ElforConfiguration(Home page)';
    } else if (isProjectPage) {
      return 'ElforConfiguration(Project page: $selectedProjectTitle)';
    } else {
      return 'ElforConfiguration(Unknown-state > 404:$show404, initiated:$initiated, selectedProjectTitle:$selectedProjectTitle)';
    }
  }
}
