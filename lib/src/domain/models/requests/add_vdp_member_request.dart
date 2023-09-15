class AddVdpMemberRequest {
 int? vdpCommitteeId;
  int? vdpRoleId;
  String? name;
  String? mobileNumber;
  String? emailId;
 bool? status;
 String? createdBy;

 AddVdpMemberRequest(
      {this.vdpCommitteeId,
      this.vdpRoleId,
      this.name,
      this.mobileNumber,
      this.emailId,
      this.status,this.createdBy});
}