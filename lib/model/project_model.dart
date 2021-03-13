class ProjectModel {
  String id, name, projectId;

  ProjectModel({this.id, this.name, this.projectId});

  factory ProjectModel.fromJson(Map<String, dynamic> jsonItem) {
    try {
      return ProjectModel(
        id: jsonItem['id'].toString() ?? "",
        name: jsonItem['naam'].toString() ?? "",
        projectId: jsonItem['project_id'].toString() ?? "",
      );
    } catch (err) {
      return null;
    }
  }

  factory ProjectModel.fromJsonSearch(Map<String, dynamic> jsonItem) {
    try {
      return ProjectModel(
        id: jsonItem['tid'].toString() ?? "",
        name: jsonItem['name'].toString() ?? "",
        projectId: jsonItem['projectID'].toString() ?? "",
      );
    } catch (err) {
      return null;
    }
  }
}