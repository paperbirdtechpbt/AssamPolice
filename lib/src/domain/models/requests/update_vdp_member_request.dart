class UpdateVdpMemberRequest {
  int? vdpMemberId;
  int? vdpCommitteeId;
  int? vdpRoleId;
  String? name;
  String? mobileNumber;
  String? emailId;

  bool? status;
  String? createdBy;

  UpdateVdpMemberRequest(
      {
        this.vdpMemberId,
        this.vdpCommitteeId,
        this.vdpRoleId,
        this.name,
        this.mobileNumber,
        this.emailId,
        this.status,this.createdBy});
}