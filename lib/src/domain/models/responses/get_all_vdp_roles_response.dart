import '../data/get_all_vdp_roles.dart';

class GetAllVdpRolesResponse {
  String? code;
  List<GetAllVdpRoles>? data;
  String? message;

  GetAllVdpRolesResponse({this.code, this.data, this.message});

  GetAllVdpRolesResponse.fromMap(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <GetAllVdpRoles>[];
      json['data'].forEach((v) {
        data!.add(new GetAllVdpRoles.fromMap(v));
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
