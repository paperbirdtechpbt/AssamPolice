import '../data/get_user_menu_option.dart';

class GetUserMenuOptionResponse {
  String? code;
  List<GetUserMenuOption>? data;
  String? message;

  GetUserMenuOptionResponse({this.code, this.data, this.message});

  GetUserMenuOptionResponse.fromMap(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <GetUserMenuOption>[];
      json['data'].forEach((v) {
        data!.add(new GetUserMenuOption.fromMap(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}