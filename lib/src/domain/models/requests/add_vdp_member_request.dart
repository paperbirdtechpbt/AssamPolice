class AddVdpMemberRequest {
 int? vdpCommitteeId;
  int? vdpRoleId;
  String? name;
  String? mobileNumber;
  String? emailId;
 bool? status;

 AddVdpMemberRequest(
      {this.vdpCommitteeId,
      this.vdpRoleId,
      this.name,
      this.mobileNumber,
      this.emailId,
      this.status});
}