import '../data/get_message_body.dart';

class GetMessageBodyResponse {
  String? code;
  GetMessageBody? data;
  String? message;

  GetMessageBodyResponse({this.code, this.data, this.message});

  GetMessageBodyResponse.fromMap(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new GetMessageBody.fromMap(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}