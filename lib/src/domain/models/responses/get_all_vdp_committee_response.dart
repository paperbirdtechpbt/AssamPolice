import '../data/get_all_vdp_committee.dart';

class GetAllVDPCommitteeResponse {
  String? code;
  List<GetAllVDPCommittee>? data;
  String? message;

  GetAllVDPCommitteeResponse({this.code, this.data, this.message});

  GetAllVDPCommitteeResponse.fromMap(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <GetAllVDPCommittee>[];
      json['data'].forEach((v) {
        data!.add(new GetAllVDPCommittee.fromMap(v));
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
