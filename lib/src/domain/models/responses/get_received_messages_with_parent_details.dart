import '../data/get_received_messages_with_parent_details.dart';

class GetReceivedMessagesWithParentDetailsResponse {
  String? code;
  List<GetReceivedMessagesWithParentDetails>? data;
  String? message;

  GetReceivedMessagesWithParentDetailsResponse(
      {this.code, this.data, this.message});

  GetReceivedMessagesWithParentDetailsResponse.fromMap(
      Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <GetReceivedMessagesWithParentDetails>[];
      json['data'].forEach((v) {
        data!.add(new GetReceivedMessagesWithParentDetails.fromMap(v));
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