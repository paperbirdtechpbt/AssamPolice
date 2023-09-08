import '../data/get_all_vdp_member.dart';

class GetAllVdpMemberResponse {
  String? code;
  List<GetAllVdpMember>? data;
  String? message;

  GetAllVdpMemberResponse({this.code, this.data, this.message});

  GetAllVdpMemberResponse.fromMap(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <GetAllVdpMember>[];
      json['data'].forEach((v) {
        data!.add(new GetAllVdpMember.fromMap(v));
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