import '../data/get_message_by_parent_id.dart';

class GetMessageByParentIdResponse {
  String? code;
  List<GetMessageByParentId>? data;
  String? message;

  GetMessageByParentIdResponse({this.code, this.data, this.message});

  GetMessageByParentIdResponse.fromMap(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <GetMessageByParentId>[];
      json['data'].forEach((v) {
        data!.add(new GetMessageByParentId.fromMap(v));
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
