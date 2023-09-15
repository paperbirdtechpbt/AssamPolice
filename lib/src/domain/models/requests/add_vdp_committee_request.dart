class AddVdpCommitteeRequest{
  String? vdpName;
  String? latitude;
  String? longitude;
  int? policeStationId;
  int? districtId;
  String? status;
  String? createdBy;

  AddVdpCommitteeRequest(
      {this.vdpName,
      this.latitude,
      this.longitude,
      this.policeStationId,
      this.districtId,
      this.status,this.createdBy});
}