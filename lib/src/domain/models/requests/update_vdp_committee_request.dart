class UpdateVdpCommitteeRequest{
  int? vdpId;
  String? vdpName;
  String? latitude;
  String? longitude;
  int? policeStationId;
  int? districtId;
  String? status;
  String? createdBy;

  UpdateVdpCommitteeRequest(
      {this.vdpName,
      this.vdpId,
        this.latitude,
        this.longitude,
        this.policeStationId,
        this.districtId,
        this.status,this.createdBy});
}