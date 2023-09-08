class UpdateVdpCommitteeRequest{
  int? vdpId;
  String? vdpName;
  String? latitude;
  String? longitude;
  String? policeStation;
  String? district;
  String? status;

  UpdateVdpCommitteeRequest(
      {this.vdpName,
      this.vdpId,
        this.latitude,
        this.longitude,
        this.policeStation,
        this.district,
        this.status});
}