class DeleteVdpCommitteeResponse {
  String? code;
  int? data;
  String? message;

  DeleteVdpCommitteeResponse({this.code, this.data, this.message});

  DeleteVdpCommitteeResponse.fromMap(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}