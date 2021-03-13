class ProjectItemModel {
  String title, description;

  ProjectItemModel({this.title, this.description});

  factory ProjectItemModel.fromJson(Map<String, dynamic> jsonItem) {
    try {
      return ProjectItemModel(
        title: jsonItem['title'].toString() ?? "",
        description: jsonItem['description'].toString() ?? "",
      );
    } catch (err) {
      return null;
    }
  }
}