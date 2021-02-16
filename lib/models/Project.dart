class Project {
  String title;
  String description;
  String imagePath;
  String codeURL;
  String viewURL;

  Project(this.title, this.imagePath, {this.description, this.codeURL, this.viewURL});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      json['title'],
      json['image'],
      description: json['description'],
      codeURL: json['codeURL'],
      viewURL: json['viewURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "image": imagePath,
      "codeURL": codeURL,
      "viewURL": viewURL,
    };
  }
}
