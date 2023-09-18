import '../data/get_user_list_tocc.dart';

class GetUserListTOCCResponse {
  String? code;
  List<GetUserListTOCC>? data;
  String? message;

  GetUserListTOCCResponse({this.code, this.data, this.message});

  GetUserListTOCCResponse.fromMap(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <GetUserListTOCC>[];
      json['data'].forEach((v) {
        data!.add(new GetUserListTOCC.fromMap(v));
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