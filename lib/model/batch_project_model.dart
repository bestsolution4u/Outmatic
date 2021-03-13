class BatchProjectModel {
  String tid, name, projectID, status;

  BatchProjectModel({this.tid, this.name, this.projectID, this.status});

  factory BatchProjectModel.fromJson(Map<String, dynamic> json) {
    try {
      return BatchProjectModel(
        tid: json['tid'].toString() ?? "",
        name: json['name'].toString() ?? "",
        projectID: json['projectID'].toString() ?? "",
        status: json['status'].toString() ?? "",
      );
    } catch (err) {
      return null;
    }
  }
}