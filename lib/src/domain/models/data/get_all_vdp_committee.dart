
class GetAllVDPCommittee {
  int? vdpId;
 String? vdpName;
 String? latitude;
 String? longitude;
 String? policeStation;
 String? district;
 String? status;

  GetAllVDPCommittee(
      {this.vdpId,
        this.vdpName,
        this.latitude,
        this.longitude,
        this.policeStation,
        this.district,
        this.status});

  GetAllVDPCommittee.fromMap(Map<String, dynamic> json) {
    vdpId = json['vdpId'];
    vdpName = json['vdpName'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    policeStation = json['policeStation'];
    district = json['district'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vdpId'] = this.vdpId;
    data['vdpName'] = this.vdpName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['policeStation'] = this.policeStation;
    data['district'] = this.district;
    data['status'] = this.status;
    return data;
  }
}

