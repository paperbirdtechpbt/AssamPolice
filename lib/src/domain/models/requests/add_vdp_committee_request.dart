class AddVdpCommitteeRequest{
  String? vdpName;
  String? latitude;
  String? longitude;
  String? policeStation;
  String? district;
  String? status;

  AddVdpCommitteeRequest(
      {this.vdpName,
      this.latitude,
      this.longitude,
      this.policeStation,
      this.district,
      this.status});
}