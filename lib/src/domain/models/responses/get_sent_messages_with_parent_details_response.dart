import '../data/get_received_messages_with_parent_details.dart';
import '../data/get_sent_messages_with_parent_details.dart';

class GetSentMessagesWithParentDetailsResponse {
  String? code;
  List<GetSentMessagesWithParentDetails>? data;
  String? message;

  GetSentMessagesWithParentDetailsResponse(
      {this.code, this.data, this.message});

  GetSentMessagesWithParentDetailsResponse.fromMap(
      Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <GetSentMessagesWithParentDetails>[];
      json['data'].forEach((v) {
        data!.add(new GetSentMessagesWithParentDetails.fromMap(v));
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