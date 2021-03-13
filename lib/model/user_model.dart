import 'dart:convert';

class UserModel {
  String id, name, email, apiToken, token, sessionId, sessionName;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.apiToken,
      this.token,
      this.sessionId,
      this.sessionName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      Map<String, dynamic> user = json['user'];
      return UserModel(
        id: user['id'].toString() ?? "",
        name: user['name'] as String ?? "",
        email: user['email'] as String ?? "",
        apiToken: user['api_token'] as String ?? "",
        //apiToken: json['token'] as String ?? "",
        token: json['token'] as String ?? "",
        sessionId: json['sessid'] as String ?? "",
        sessionName: json['session_name'] as String ?? "",
      );
    } catch (err) {
      return null;
    }
  }

  String toJson() {
    return jsonEncode({
      "token": token,
      "sessid": sessionId,
      "session_name": sessionName,
      "user": {
        "id": id,
        "name": name,
        "email": email,
        "api_token": apiToken
      },
      "uid": id
    });
  }
}
