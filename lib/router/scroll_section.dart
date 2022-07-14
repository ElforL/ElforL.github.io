class ScrollSection {
  HomeSection selectedSection;
  SelectionSource selectionSource;

  ScrollSection({
    required this.selectedSection,
    required this.selectionSource,
  });

  @override
  bool operator ==(other) {
    return other is ScrollSection &&
        other.selectedSection == selectedSection &&
        other.selectionSource == selectionSource;
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedSection, selectionSource);
}

enum SelectionSource {
  fromScroll,
  userClick,
  fromUrl,
}

enum HomeSection {
  landing,
  skills,
  projects,
  contact;
  // blog,

  String toShortString() {
    return toString().split('.').last;
  }
}
