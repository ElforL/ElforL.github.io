class Project {
  String title;
  String description;
  String imagePath;
  String codeURL;
  String viewURL;
  bool isSmall;

  Project(this.title, this.imagePath, {this.isSmall = true, this.description, this.codeURL, this.viewURL});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      json['title'],
      json['image'],
      isSmall: json['isSmall'],
      description: json['description'],
      codeURL: json['codeURL'],
      viewURL: json['viewURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': imagePath,
      'isSmall': isSmall,
      'description': description,
      'codeURL': codeURL,
      'viewURL': viewURL,
    };
  }
}
