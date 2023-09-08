import '../data/send_message.dart';

class SendMessageResponse {
  String? code;
  SendMessage? data;
  String? message;

  SendMessageResponse({this.code, this.data, this.message});

  SendMessageResponse.fromMap(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new SendMessage.fromMap(json['data']) : null;
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