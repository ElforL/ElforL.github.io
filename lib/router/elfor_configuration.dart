class ElforConfiguration {
  final bool show404;
  final bool initiated;
  final String? selectedProjectTitle;
  final String? langCode;

  ElforConfiguration(
    this.show404,
    this.initiated,
    this.selectedProjectTitle, [
    this.langCode,
  ]);

  factory ElforConfiguration.loading([String? langCode]) => ElforConfiguration(false, false, null, langCode);
  factory ElforConfiguration.home([String? langCode]) => ElforConfiguration(false, true, null, langCode);
  factory ElforConfiguration.project(String projectTitle, [String? langCode]) =>
      ElforConfiguration(false, true, projectTitle, langCode);
  factory ElforConfiguration.unknown([String? langCode]) => ElforConfiguration(true, true, null, langCode);

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
