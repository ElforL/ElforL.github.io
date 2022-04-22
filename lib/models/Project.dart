import 'dart:convert';

class Project {
  String title;
  String description;
  List<Map<String, dynamic>> screenBlocks;
  String? imagePath;
  String? codeURL;
  String? viewURL;
  bool? isSmall;

  Project(
    this.title,
    this.imagePath,
    this.screenBlocks, {
    this.isSmall = true,
    required this.description,
    required this.codeURL,
    this.viewURL,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> blocks;
    try {
      blocks = List<Map<String, dynamic>>.from(jsonDecode(json['screenBlocks'] ?? '[]'));
    } catch (e) {
      blocks = [];
    }

    return Project(
      json['title'],
      json['image'],
      blocks,
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
      'screenBlocks': screenBlocks,
      'isSmall': isSmall,
      'description': description,
      'codeURL': codeURL,
      'viewURL': viewURL,
    };
  }
}
