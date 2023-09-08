import '../data/get_received_message.dart';

class GetReceivedMessagesResponse {
  String? code;
  List<GetReceivedMessages>? data;
  String? message;

  GetReceivedMessagesResponse({this.code, this.data, this.message});

  GetReceivedMessagesResponse.fromMap(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <GetReceivedMessages>[];
      json['data'].forEach((v) {
        data!.add(new GetReceivedMessages.fromMap(v));
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
