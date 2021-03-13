class MedModel {
  String uid, username, fullname;

  MedModel({this.uid, this.username, this.fullname});

  factory MedModel.fromJson(Map<String, dynamic> json) {
    try {
      return MedModel(
        uid: json['uid'].toString() ?? "",
        username: json['username'].toString() ?? "",
        fullname: json['fullname'].toString() ?? "",
      );
    } catch (err) {
      return null;
    }
  }
}