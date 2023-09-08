class GetAllVdpMember {
  int? vdpMemberId;
  String? vdpCommitteeName;
  String? role;
  int? vdpCommitteeId;
  int? vdpRoleId;
  String? name;
  String? mobileNumber;
  String? emailId;
  bool? status;

  GetAllVdpMember(
      {this.vdpMemberId,
        this.vdpCommitteeName,
        this.role,
        this.vdpCommitteeId,
        this.vdpRoleId,
        this.name,
        this.mobileNumber,
        this.emailId,
        this.status});

  GetAllVdpMember.fromMap(Map<String, dynamic> json) {
    vdpMemberId = json['vdpMemberId'];
    vdpCommitteeName = json['vdpCommitteeName'];
    role = json['role'];
    vdpCommitteeId = json['vdpCommitteeId'];
    vdpRoleId = json['vdpRoleId'];
    name = json['name'];
    mobileNumber = json['mobileNumber'];
    emailId = json['emailId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vdpMemberId'] = this.vdpMemberId;
    data['vdpCommitteeName'] = this.vdpCommitteeName;
    data['role'] = this.role;
    data['vdpCommitteeId'] = this.vdpCommitteeId;
    data['vdpRoleId'] = this.vdpRoleId;
    data['name'] = this.name;
    data['mobileNumber'] = this.mobileNumber;
    data['emailId'] = this.emailId;
    data['status'] = this.status;
    return data;
  }
}