import '../data/get_sent_message.dart';

class GetSentMessagesResponse {
  String? code;
  List<GetSentMessages>? data;
  String? message;

  GetSentMessagesResponse({this.code, this.data, this.message});

  GetSentMessagesResponse.fromMap(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <GetSentMessages>[];
      json['data'].forEach((v) {
        data!.add(new GetSentMessages.fromMap(v));
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
