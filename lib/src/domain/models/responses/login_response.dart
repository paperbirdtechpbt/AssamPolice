import '../data/user.dart';

class LoginResponse {
  LoginResponse({
    this.status,
    this.message,
    this.data,
  });

  LoginResponse.fromMap(Map<String, dynamic> json) {
    status = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? LoginData.fromMap(json['data']) : null;
  }

  String? status;
  String? message;
  LoginData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class LoginData {
  User? user;

  LoginData.fromMap(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromMap(json['user']) : null;
  }

  LoginData({
    this.user,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}
